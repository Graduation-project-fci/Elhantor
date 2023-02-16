// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_project/screens_drivers/signup.dart';
import 'package:new_project/services/Authenticate/authenticate.dart' as Auth;
class loginscreen extends StatefulWidget {
  const loginscreen({super.key});


  @override
  State<loginscreen> createState() => _loginscreenState();
}

bool isObsecurepassword=false;

class _loginscreenState extends State<loginscreen> {
  TextEditingController title = new TextEditingController();
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  var myEmail,myPassword;
  GlobalKey<FormState> fomstate=new GlobalKey<FormState>();
  final _auth=Auth.Auth();
  @override
  void initState() {
    // TODO: implement initState
    _auth.signout();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Form(
            key:fomstate ,
            child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

            Container(
              padding: const EdgeInsets.all(10),
              child: const Text("Sign In",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24)),
            ),
            Container(
              width: 100,
              height: 3,
              color: Colors.deepOrange,
            ),
            Container(
              padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
              child: buildTextField('Email', 'Enter Your Email...', false,user),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, left: 30, right: 30),
              child:buildTextField('password', 'placeholder', true,pass),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {

                          if (fomstate.currentState!.validate()) {
                            fomstate.currentState!.save();
                            String? result=await _auth.LoginWithEmailAndPassword(user.text, pass.text) as String?;
                            if(result==''){
                              ScaffoldMessenger.of(context).showSnackBar(

                                 SnackBar(content: Text('logged in succesfully')),


                              );
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(

                                SnackBar(content: Text('${result}')),


                              );
                            }



                            print(result);

                          }

                      },

                      child: const Text("    Log in   ")),
                  Container(
                    width: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        _auth.signInWithGoogle(); ///////////////////
                      },
                      child: const Text("  Sign Up  ")),
                ],
              ),
            ),

        ],
      ),
          )),
    );
  }
  String? validMail(String? value){

    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    if(emailValid==false){
      return 'Invalid Email address';
    }
    return null;
  }
  String? validPassword(String? value){
    if (value!.length<6 && value.isNotEmpty) {
      return 'Please enter Password contains at least 6 characters ';
    }if(value.isEmpty){
      return 'Please enter some text';
    }
    return null;
  }


  Widget buildTextField( String labelText, String placeholder, bool isPassword,TextEditingController Controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextFormField(

        validator:  (isPassword==true)?validPassword:validMail,
        onSaved:(newValue) => {
          setState((){
            if(isPassword==true){
              myPassword=newValue;
            }else{
              myEmail=newValue;
            }
          })


        },

        obscureText: isPassword ? isObsecurepassword : false,
        controller: Controller,
        decoration: InputDecoration(
            hoverColor: Colors.deepOrange,
            suffixIcon: isPassword
                ? IconButton(
                onPressed: () {
                  setState(() {
                    isObsecurepassword = !isObsecurepassword;
                  });

                },

                icon: Icon(
                  isObsecurepassword
                      ? (Icons.visibility_off)
                      : (Icons.visibility),
                  color: Colors.grey,
                ))
                : null,
            contentPadding: const EdgeInsets.only(bottom: 5),



            label: (labelText!=null)? Text('${labelText}'):Text('label'),
            labelStyle: const TextStyle(color: Colors.white),



            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),


      ),

    );
  }
}


