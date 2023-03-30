import 'package:HantoryGo/screens_drivers/verificationCode.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignInWithPhonePage extends StatefulWidget {
  @override
  _SignInWithPhonePageState createState() => _SignInWithPhonePageState();
}

class _SignInWithPhonePageState extends State<SignInWithPhonePage> {
  final TextEditingController _smsCodeController = TextEditingController();
  String? _verificationId;
  String? _phoneNumber;
  bool isCodesent=false;

  Future<void> _verifyPhoneNumber() async {
    try {
      final phoneNumber = _phoneNumber!;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          // navigate to home page

        },
        verificationFailed: (FirebaseAuthException e) {
          // handle verification failed error
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            isCodesent=true;

          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Page1(verificationId: _verificationId!),

                ));
            
          });
        },
        timeout: Duration(seconds: 60),
      );
    } catch (e) {
      // handle verify phone number error
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An Error occurred Please try again'),
        duration: Duration(seconds: 2),
      ));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image(
                    image: AssetImage('assets/images/hantour.png'),
                    height: 150),
              ),
              Text('Phone Number'),
              InternationalPhoneNumberInput(
                onInputChanged: (phoneNumber) {
                  setState(() {
                    _phoneNumber = phoneNumber.phoneNumber;

                    print(phoneNumber);
                  });
                },
                inputDecoration: InputDecoration(
                  hintText: 'Enter phone number',
                ),
              ),
              SizedBox(height: 35,child: Text(''),),
              InkWell(
                onTap: () async {
                  await _verifyPhoneNumber();


                },
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 128),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        )
                      ]
                  ),
                  child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
