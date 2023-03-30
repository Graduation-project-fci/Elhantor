import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:location/location.dart';
import 'package:new_project/models/driver.dart';
import 'package:new_project/models/complaiments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_project/models/ride.dart';

class Driver_Process {
  late Driver driver;
  late Complaiments complaiments;
  CollectionReference drivers = FirebaseFirestore.instance.collection(
      'Drivers');

  //1-add driver to database
  Future<void> addDriver(Driver driver, String id, GeoPoint location) async {
    await FirebaseFirestore.instance
        .collection('Drivers')
        .where('email', isEqualTo: driver.email)
        .get()
        .then((value) => print(value.docs.first)).catchError((error) =>
    {
      drivers.doc(id).set({

        'name': driver.name,
        'email': driver.email,
        'phone': driver.phone,
        'personal_photo': driver.personal_photo,
        'ssn': driver.ssn,
        'ssn_photo': driver.ssn_photo,
        'available': driver.available,
        'active': driver.active,
        'current_location': location,

        'isPhoneNumberVerified': driver.isPhoneNumberVerified
      }).then((value) => print('Driver has been added...')).catchError((
          error) => print('Driver has not beed added $error'))
    });
  }

//2-verify driver phone number
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> setPhoneNumberVerified(String phoneNumber, String docId) async {
    return drivers.doc(docId).update({'isPhoneNumberVerified': true}).
    then((value) => print('phone number verified')).catchError((e) =>
        print('$e'));
  }



//3-make profile for driver
  updateDriverProfile(
      {required String name, required String email, required String personal_photo, required String id}) async {
    final _driver = FirebaseFirestore.instance.collection('Drivers');

    await _driver.doc(id).update(
        {'name': name, 'email': email, 'personal_photo': personal_photo})
        .onError((error, stackTrace) => print('failed to update $error'));
  }


//4-set driver active or not active in the app
  Future<void> activateDriver(
      {required String id, required bool isActive}) async {

    final _driver = FirebaseFirestore.instance.collection('Drivers');

    await _driver.doc(id).update({'active': isActive}).onError((error,
        stackTrace) => print('failed to update $error'));
  }


// 5-set driver available or not available to users
  driverAvailable(String id, bool isAvailable) async {
    final _driver = FirebaseFirestore.instance.collection('Drivers');

    await _driver.doc(id).update({'active': isAvailable}).onError((error,
        stackTrace) => print('failed to update $error'));
  }

//6-accept or cancel request
  cancelTrip({required String trip_id}) async {
    await FirebaseFirestore.instance.collection('Rides').doc(trip_id).
    update({'status': 'Cancelled'})
        .then((value) => print('updated'))
        .catchError((e) => print('$e'));
  }

  acceptRequest({required String rider_id,required String driver_id, String paymentMethpode='Cash'}) async {
    await FirebaseFirestore.instance.collection('Request').doc(rider_id).
    update({'payment_methode': 'cash','driver_id':driver_id,'status':'accepted'})
        .then((value) => print('updated'))
        .catchError((e) => print('$e'));
  }
  refuseRequest({required String rider_id,required String driver_id}) async {
    await FirebaseFirestore.instance.collection('Request').doc(rider_id).
    update({'driver_id':driver_id,'status':'refused'})
        .then((value) => print('updated'))
        .catchError((e) => print('$e'));
  }





//7-Make or delete a compliment
  makeComliment({required Complaiments com ,required String id,required ComplimentRiderType C}) async {
    final compliment = FirebaseFirestore.instance.collection('complaiments');
    await  compliment.doc(id).set({
      'from': com.from,
      'againest': com.againest,
      'Description': com.description,
      'type':C.toString(),
      'timestamp': DateTime.now(),
    }).then((value) => print('compliment added')).catchError((e) =>
        print('$e'));
  }



//8-block a specific user or unblock
  block( String userIdToBlock) async {
    String currentUserId = FirebaseAuth.instance!.currentUser!.uid;

    // Add the user ID to the "blockedUsers" collection
    await FirebaseFirestore.instance
        .collection('Riders')
        .doc(currentUserId)
        .collection('blockedUsers')
        .doc(userIdToBlock)
        .set({});
  }

  unblock( String blocked_person_id) async {
    String currentUserId = FirebaseAuth.instance!.currentUser!.uid;
    await FirebaseFirestore.instance.collection('Drivers').doc(currentUserId!)
        .collection('blockedUsers').doc(blocked_person_id)
        .delete();
  }
}

enum ComplimentRiderType {
  safeDriving,
  friendlyService,
  cleanVehicle,
}



