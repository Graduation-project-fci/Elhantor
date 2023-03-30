import 'package:firedart/generated/google/type/latlng.pb.dart';


class Ride{
 late LatLng start_location;
 late LatLng end_location;
 late double rideAmount;
 late DateTime ridedate;
 late DateTime ride_end_time;
 late String driver_id;
 late String rider_id;

 late String status;
 late double distance;


 Ride({
required this.driver_id,
  required this.rider_id,
  required this.ridedate,
  required this.distance,
  this.rideAmount=0.0,
  this.status="ongoing"


  });

}
