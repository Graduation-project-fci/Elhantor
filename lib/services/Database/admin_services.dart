import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Admin {
// Ban user function with duration in hours
  Future<void> banUser(
      {required String userIdToBan, int durationInHours = 0}) async {
    // Calculate the timestamp when the ban will end
    DateTime banEnd = DateTime.now().add(Duration(hours: durationInHours));

    // Add the user ID and timestamp to the "bannedUsers" collection
    await FirebaseFirestore.instance
        .collection('admin')
        .doc('bannedUsers')
        .collection('users')
        .doc(userIdToBan)
        .set({'banEnd': banEnd});


  }

// Check if a user is banned
  Future<bool> isUserBanned(String userId) async {
    // Get the current timestamp
    DateTime now = DateTime.now();

    // Check if the user ID is in the "bannedUsers" collection
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('admin')
        .doc('bannedUsers')
        .collection('users')
        .doc(userId)
        .get();

    if (snapshot.exists) {
      // Get the ban end timestamp
      DateTime banEnd = snapshot.get('banEnd').toDate();

      // Check if the ban has ended
      if (banEnd.isAfter(now)) {
        // The user is still banned
        return true;
      } else {
        // The ban has ended, remove the user from the bannedUsers collection
        await snapshot.reference.delete();
      }
    }

    // The user is not banned
    return false;
  }
}