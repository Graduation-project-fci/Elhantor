import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneVerificationPage extends StatefulWidget {
  @override
  _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  late String _verificationId;

  Future<void> _sendCodeToPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential phoneAuthCredential) {
      // This callback is triggered in two situations:
      // 1. Instant verification. In some cases, the phone number can be instantly
      //    verified without needing to send or enter a verification code.
      // 2. Auto-retrieval. On some devices, Google Play services can automatically
      //    detect the incoming verification SMS and perform verification without
      //    user action.
      print('Received phone auth credential: $phoneAuthCredential');
    };

    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException) {
      print('Phone verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };

    final PhoneCodeSent codeSent = (String verificationId, [int? forceResendingToken]) async {
      print('Code sent to ${_phoneController.text}');
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
      print('Phone code auto retrieval timeout');
      _verificationId = verificationId;
    };

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:"+201834323231",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      print('Error sending code to phone number: $e');
    }
  }
FirebaseAuth? x=FirebaseAuth.instance;
  Future<void> _submitCode() async {
    try {
      final AuthCredential credential = await PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: "123456"
      );


      // You can use the `credential` to sign in with the Firebase Authentication API.
      // For example, to sign in with Firebase using `signInWithCredential()`:

       await FirebaseAuth.instance.signInWithCredential(credential).then((value) async =>
       await FirebaseFirestore.instance.collection('Drivers').doc(value.user!.uid.toString()).set({
         'isPhoneNumberVerified':true
       })


       );
       await FirebaseAuth.instance.currentUser!.delete();

      print('Received phone auth credential: $credential');
    } catch (e) {
      print('Error submitting phone code: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone number (+country code)',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _sendCodeToPhoneNumber,
              child: Text('Send verification code'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Verification code',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitCode,
              child: Text('Submit verification code'),
            ),
          ],
        ),
      ),
    );
  }
}