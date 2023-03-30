import 'package:firedart/firedart.dart';
import 'package:firedart/generated/google/type/latlng.pb.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class Driver{
  late String name;
  late String email;
  late String personal_photo;
  late bool active;
  late bool available;
  late String ssn;
  late String ssn_photo;
  late String phone;
  late bool isPhoneNumberVerified;


  late double rating;
  Driver({
    required this.name,
    required this.email,
    this.personal_photo='',
    this.active=false,
    this.available=true,
    required this.ssn,
    required this.ssn_photo,

    this.rating=0,
    required this.phone,
    this.isPhoneNumberVerified=false,


});

}