import 'package:HantoryGo/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../phoneVerificationPage.dart';



class Page1 extends StatefulWidget {


  final String verificationId;


  const Page1({super.key,required this.verificationId});

  @override
  _Page1State createState() => _Page1State();
}



class _Page1State extends State<Page1> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;


  @override
  void dispose() {

    super.dispose();
  }
  String? _verificationId;
  Future<void> _signInWithPhoneNumber(String? verificationId,String smsCode) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId:verificationId!,
        smsCode: smsCode,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // navigate to home page
    } catch (e) {
      // handle sign in with phone number error
    }
  }


  void _submitOTP() async{
    final form = _formKey.currentState;
    if (form!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await _signInWithPhoneNumber(this.widget.verificationId,_otpController.text);
      // TODO: Add code to verify OTP with backend
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SplashScreen()

          ));




  }


}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _verificationId==null?Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter the OTP code',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: _otpController,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  activeFillColor: Colors.transparent,
                  inactiveFillColor: Colors.transparent,
                  selectedFillColor: Colors.transparent,
                  selectedColor: Theme.of(context).primaryColor,
                  activeColor: Theme.of(context).primaryColor,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {},
                onCompleted: (value) {
                  _submitOTP();
                },
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                  onPressed: _isLoading ? null : _submitOTP,
                  child: _isLoading ? CircularProgressIndicator() : Text('Verify'),
                ),
              ),
            ],
          ),
        ),
      ),
    ):CircularProgressIndicator();
    throw UnimplementedError();
  }
}
