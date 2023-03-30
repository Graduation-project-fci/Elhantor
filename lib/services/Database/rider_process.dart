import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_project/models/request.dart';

import 'package:new_project/models/rider.dart';
import 'package:location/location.dart';
import 'package:new_project/models/review.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/complaiments.dart';
class Rider_process{
  late Rider rider;
  final riders = FirebaseFirestore.instance.collection(
      'Riders');
//1-add Rider to database
  Future<void> addRider(Rider rider, String id, GeoPoint location) async {
    await FirebaseFirestore.instance
        .collection('Riders')
        .where('email', isEqualTo: rider.email)
        .get()
        .then((value) => print(value.docs.first)).catchError((error) =>
    {
      riders.doc(id).set({

        'name': rider.name,
        'email': rider.email,
        'phone': rider.phone,
        'personal_photo': rider.personal_photo,


        'current_location': location,


      }).then((value) => print('Driver has been added...')).catchError((
          error) => print('Driver has not beed added $error'))
    });
  }
//2-create or update profile
  updateDriverProfile(
      {required Rider rider,required String id}) async {
    final _driver = FirebaseFirestore.instance.collection('Drivers');

    await _driver.doc(id).update(
        {'name': rider.name, 'email': rider.email, 'personal_photo': rider.personal_photo,'phone':rider.phone})
        .onError((error, stackTrace) => print('failed to update $error'));
  }

//3-search for drivers
searchForDriver(){

}
isDriverAvailable(String driver_id)async{
    try{
      return await  FirebaseFirestore.instance.collection('Drivers').doc(driver_id).get({'available'} as GetOptions?);

    }catch(e){
      print(e);
  }
}
//4-make request to some driver
makeRequest({required Request req})async{
  await FirebaseFirestore.instance.collection('Request').doc(req.driver_id).
  set({'payment_methode': req.payment_methode,'driver_id':req.driver_id,'status':'no response','rider_id':req.rider_id})
      .then((value) => print('updated'))
      .catchError((e) => print('$e'));
}
//5-start trip
  startTrip({required String rider_id,required String driver_id,required String request_id}) async {
    await FirebaseFirestore.instance.collection('Rides').doc(request_id).
    set({'status': 'ongoing', 'start_date': DateTime.now(),'driverid':driver_id}).then((
        value) => print('updated')).catchError((e) => print('$e'));
  }
//6-cancel trip
  cancelTrip({required String trip_id}) async {
    await FirebaseFirestore.instance.collection('Rides').doc(trip_id).
    update({'status': 'Cancelled'})
        .then((value) => print('updated'))
        .catchError((e) => print('$e'));
  }
//7-end trip
  endTrip({required String trip_id,required String price}) async {
    await FirebaseFirestore.instance.collection('Rides').doc(trip_id).
    update({'status': 'completed', 'end_date': DateTime.now(),'rideAmount':price}).then((
        value) => print('updated')).catchError((e) => print('$e'));
  }

//8-review the driver after trip ends
makeReview(Review review)async{
    await FirebaseFirestore.instance.collection('Reviews').doc(review.ride_id).

    set({'comment':review.comment,
      'rating':review.rating,
      'rideId':review.ride_id

    }).then((value) => print('success')).catchError((e)=>print('error:$e'));

}
//9-block some driver
  Future<void> blockUser(String userIdToBlock) async {
    // Get the current user ID
    String currentUserId = FirebaseAuth.instance!.currentUser!.uid;

    // Add the user ID to the "blockedUsers" collection
    await FirebaseFirestore.instance
        .collection('Riders')
        .doc(currentUserId)
        .collection('blockedUsers')
        .doc(userIdToBlock)
        .set({});


  }
//10-unblock some driver
  unblock( String blocked_person_id) async {
    String currentUserId = FirebaseAuth.instance!.currentUser!.uid;
    await FirebaseFirestore.instance.collection('Riders').doc(currentUserId!)
        .collection('blockedUsers').doc(blocked_person_id)
        .delete();
  }
//11-make a compliment
  makeComliment({required Complaiments com ,required String id,required ComplimentDriverType c }) async {
    final compliment = FirebaseFirestore.instance.collection('complaiments');
    await  compliment.doc(id).set({
      'from': com.from,
      'againest': com.againest,
      'Description': com.description,
      'type':c.toString(),
      'timestamp': DateTime.now(),
    }).then((value) => print('compliment added')).catchError((e) =>
        print('$e'));
  }



}
enum ComplimentDriverType {
  safeDriving,
  friendlyService,
  cleanVehicle,
}