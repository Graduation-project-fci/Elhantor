import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final MapController _marker = MapController();
  late LatLng _currentLocation = LatLng(0, 0);
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentLocation = LatLng(
          currentLocation.latitude,
          currentLocation.longitude,
        );
        _addMarkerAtUserLocation();
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }


  void _addMarkerAtUserLocation() {
    // Create a marker at the user's location
    final marker = Marker(
      point: _currentLocation,
      builder: (ctx) => Icon(Icons.location_on,color: Colors.red,size: 40,),
    );

    // Update the FlutterMap widget with the new marker
    setState(() {
      _markers.clear();
      _markers.add(marker);
      _marker.move(_currentLocation, 16);
    });
  }

  bool _isOnline = false;
  String status = "Offline";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 128),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(_isOnline ? 'Online' : 'Offline', style: TextStyle(fontSize: 16)),
            SizedBox(width: 10),
            Switch(
              value: _isOnline,
              onChanged: (value) {
                setState(() {
                  _isOnline = value;
                  status = value ? 'Online' : 'Offline';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You are $status now'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: FlutterMap(
        mapController: _marker,
        options: MapOptions(
          center: _currentLocation,
          zoom: 16.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: _markers,
          ),
        ],
      ),
    );
  }

}
