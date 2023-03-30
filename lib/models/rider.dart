import 'package:firedart/generated/google/type/latlng.pb.dart';

class Rider{
  late String name;
  late String email;
  late String personal_photo;



  late String phone;


  Rider({
    required this.name,
    required this.email,
    this.personal_photo='',
    


    required this.phone,

  });

}