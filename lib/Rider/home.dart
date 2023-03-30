// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
//
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Map with Polylines',
//       home: MapScreen(),
//     );
//   }
// }
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   final Map<String, LatLng> _destinations = {
//     'destination1': LatLng(25.71458539666381, 32.64800711551569),
//     'destination2': LatLng(25.719418459860464, 32.65710516827001),
//   };
//
//   List<LatLng> _points = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _addPolyline();
//   }
//
//   void _addPolyline() {
//     _points = [_destinations['destination1']!, _destinations['destination2']!];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: SingleChildScrollView(
//         child: FlutterMap(
//
//           options: MapOptions(
//             center: _destinations['destination1'],
//             zoom: 16.0,
//
//
//           ),
//           layers: [
//             TileLayerOptions(
//               urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//               subdomains: ['a', 'b', 'c'],
//             ),
//             PolylineLayerOptions(
//               polylines: [
//                 Polyline(
//                   points: _points,
//                   color: Colors.indigo,
//                   strokeWidth: 4.0,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:http/http.dart' as http;
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Rider Home Screen',
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _sourceController = TextEditingController();
//   final TextEditingController _destinationController = TextEditingController();
//
//    LatLng _sourceLocation=LatLng(25.2323, 23.12);
//    LatLng _destinationLocation=LatLng(26.2323, 24.3434);
//
//   List<LatLng> _polygonPoints = [];
//
//   MapController _mapController = MapController();
//
//   Future<void> _onSourceLocationSelected() async {
//     try {
//       final List<Location> locations = await locationFromAddress(_sourceController.text);
//       if (locations.isNotEmpty) {
//         setState(() {
//           _sourceLocation = LatLng(locations.first.latitude, locations.first.longitude);
//         });
//
//         if (_sourceLocation != null && _destinationLocation != null) {
//           _drawPolygon();
//         }
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Error'),
//             content: Text('No location found for the entered address.'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       print(e);
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('An error occurred while fetching the location.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   Future<void> _onDestinationLocationSelected() async {
//     try {
//       final List<Location> locations = await locationFromAddress(_destinationController.text);
//       if (locations.isNotEmpty) {
//         setState(() {
//           _destinationLocation = LatLng(locations.first.latitude, locations.first.longitude);
//         });
//
//         if (_sourceLocation != null && _destinationLocation != null) {
//           _drawPolygon();
//         }
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Error'),
//             content: Text('No location found for the entered address.'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       print(e);
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('An error occurred while fetching the location.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   void _drawPolygon() {
//     _polygonPoints = [
//       _sourceLocation,
//       LatLng(
//         (_sourceLocation.latitude + _destinationLocation.latitude) / 2,
//         (_sourceLocation.longitude + _destinationLocation.longitude) / 2,
//       ),
//       _destinationLocation,
//     ];
//
//     _mapController.move(_sourceLocation, 13);
//
//     setState(() {});
//
//     // Wait for the map to be ready before drawing the polygon
//     Future.delayed(Duration(milliseconds: 500), () {
//       final polygon = Polygon(
//         points: _polygonPoints,
//         color: Colors.blue.withOpacity(0.5),
//         borderColor: Colors.blue,
//         borderStrokeWidth: 3,
//       );
//
//       setState(() {
//         _polygonLayerOptions = PolygonLayerOptions(polygons: [polygon]);
//       });
//     });
//   }
//
//   late PolygonLayerOptions _polygonLayerOptions;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _polygonLayerOptions = PolygonLayerOptions(polygons: []);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rider Home Screen'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 TypeAheadFormField(
//                   textFieldConfiguration: TextFieldConfiguration(
//                     decoration: InputDecoration(
//                       labelText: 'Search',
//                       hintText: 'Type a place name',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   suggestionsCallback: (String pattern) async {
//                     return await getSuggestions(pattern) as List<String>;
//
//                   },
//                   itemBuilder: (context, String suggestion) {
//                     return ListTile(
//                       title: Text(suggestion),
//                     );
//                   },
//                   onSuggestionSelected: (String suggestion) {
//                     // Do something when a suggestion is selected
//                   },
//                 ),
//
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: _destinationController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter destination location',
//                     suffixIcon: IconButton(
//                       icon: Icon(Icons.search),
//                       onPressed: _onDestinationLocationSelected,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: FlutterMap(
//               mapController: _mapController,
//               options: MapOptions(
//                 center: LatLng(0, 0),
//                 zoom: 13.0,
//               ),
//               layers: [
//                 TileLayerOptions(
//                   urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                   subdomains: ['a', 'b', 'c'],
//                 ),
//                 if (_sourceLocation != null && _destinationLocation != null)
//                   PolylineLayerOptions(
//                     polylines: [
//                       Polyline(
//                         points: [_sourceLocation, _destinationLocation],
//                         strokeWidth: 3.0,
//                         color: Colors.red,
//                       ),
//                     ],
//                   ),
//                 if (_polygonLayerOptions != null) _polygonLayerOptions,
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   } Future<List> getSuggestions(String query) async {
//     String url =
//         'https://api.maptiler.com/maps/streets/search?text=$query&key=ClwPTx75gU6WA1Z0yDs5';
//     http.Response response = await http.get(Uri.parse(url));
//     print(response.body);
//     if (response.statusCode == 200) {
//       print(response.body);
//       List<dynamic> places = json.decode(response.body);
//       List suggestions =
//       places.map((place) => place['name']).toList();
//       return suggestions;
//     } else {
//       throw Exception('Failed to get suggestions');
//     }
//   }
//
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class PlaceAutocomplete extends StatefulWidget {
//   @override
//   _PlaceAutocompleteState createState() => _PlaceAutocompleteState();
// }
//
// class _PlaceAutocompleteState extends State<PlaceAutocomplete> {
//   TextEditingController _searchController = TextEditingController();
//   List<String> _places = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body:  Column(
//             children: [
//               TextField(
//                 controller: _searchController,
//                 onChanged: _onSearchChanged,
//                 decoration: InputDecoration(
//                   hintText: 'Search places...',
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _places.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(_places[index]),
//                       onTap: () => _onPlaceSelected(_places[index]),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           );
//
//   }
//
//   void _onSearchChanged(String query) async {
//     try {
//       if (query.isEmpty) {
//         setState(() => _places = []);
//         return;
//       }
//
//       final uri = Uri.https(
//         'nominatim.openstreetmap.org',
//         '/search',
//         {'q': query, 'format': 'json', 'addressdetails': '1', 'limit': '5'},
//       );
//
//       final response = await http.get(uri);
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final places = List.generate(
//           data.length,
//               (index) => data[index]['display_name'],
//         ).cast<String>();
//         setState(() => _places = places);
//       } else {
//         throw Exception('Failed to search places');
//       }
//     } catch (e) {
//       throw Exception('Failed to search places: $e');
//     }
//   }
//
//   void _onPlaceSelected(String place) {
//     _searchController.text = place;
//     setState(() => _places = []);
//   }
// }


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _startSearchFieldController = TextEditingController();
  final _endSearchFieldController = TextEditingController();

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String apiKey = 'AIzaSyCibbLQJBOc-jrJpqbOp5SXKH3Y--zIBJQ';
    googlePlace = GooglePlace(apiKey);
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _startSearchFieldController,
              autofocus: false,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  hintText: 'Starting Point',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 24),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  if (value.isNotEmpty) {
                    //places api
                    autoCompleteSearch(value);
                  } else {
                    //clear out the results
                  }
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: _endSearchFieldController,
              autofocus: false,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  hintText: 'End Point',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 24),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  if (value.isNotEmpty) {
                    //places api
                    autoCompleteSearch(value);
                  } else {
                    //clear out the results
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}