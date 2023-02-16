import 'package:flutter/material.dart';
import 'package:new_project/screens_drivers/loginscreen.dart';
import 'package:new_project/services/Authenticate/authenticate.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var fullname, username, password, SSN;
  final _auth=Auth();
  TextEditingController control = new TextEditingController();
  TextEditingController control2 = new TextEditingController();
  GlobalKey<FormState> gg = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 50),
          child: Form(
            // autovalidateMode: AutovalidateMode.always,
            key: gg,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //////////////////////////////////// header and logo
                Container(
                  padding: EdgeInsets.all(10),
                  // ignore: prefer_const_constructors
                  child: Text("Sign Up",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24)),
                ),
                Container(
                  width: 100,
                  height: 3,
                  color: Colors.orangeAccent,
                ),
                Container(
                  padding: EdgeInsets.only(top: 15, left: 30, right: 30),
                  child: TextFormField(
                    onSaved: (text) {
                      fullname = text;
                    },
                    validator: (value){
                      if(value!.trim().isEmpty){
                        return 'Full Name Can not be Empty.';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    // cursorColor: Colors.white,
                    decoration: InputDecoration(
                        filled: true,
                        label: const Text("Full Name"),
                        labelStyle: const TextStyle(color: Colors.white),
                        // fillColor: Colors.blueGrey,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        )),
                        focusedBorder: OutlineInputBorder(
                            // ignore: prefer_const_constructors
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
                  child: TextFormField(
                    onSaved: ((newValue) {
                      username = newValue;
                    }),
                    validator: (value){
                      final emailValid=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if(emailValid==false){
                        return 'Invalid Email address';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    // obscureText: true,
                    // obscuringCharacter: '*',
                    decoration: InputDecoration(

                        filled: true,

                        label: const Text("Email"),
                        labelStyle: const TextStyle(color: Colors.white),

                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15, left: 30, right: 30),
                  child: TextFormField(
                    onSaved: (newValue) {
                      password = newValue;
                    },
                    // autovalidateMode: AutovalidateMode.always,
                    controller: control,
                    validator: (value) {
                      if (value!.length<6 && value.isNotEmpty) {
                        return 'Please enter Password contains at least 6 characters ';
                      }if(value.isEmpty){
                        return 'Password can not be empty..';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),

                    decoration: InputDecoration(
                        filled: true,
                        suffixIcon: Icon(Icons.remove_red_eye_outlined),
                        label: Text("Password"),
                        labelStyle: TextStyle(color: Colors.white),
                        // fillColor: Colors.blueGrey,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Container(
                  //  autovalidateMode: AutovalidateMode.always,
                  padding: EdgeInsets.only(top: 15, left: 30, right: 30),
                  child: TextFormField(
                    controller: control2,
                    keyboardType: TextInputType.visiblePassword,

                    maxLength: 14,

                    style: TextStyle(color: Colors.white),
                   validator: (value){
                      if(value!.isEmpty){
                        return 'Please Confirm the password';
                      }if(value!.isNotEmpty && value!=control.text){
                        return 'confirm password does not match with password';
                      }
                      return null;
                   },
                    decoration: InputDecoration(
                        filled: true,
                        suffixIcon: Icon(Icons.remove_red_eye_outlined),
                        label: Text("Confirm Password"),
                        labelStyle: TextStyle(color: Colors.white),
                        // fillColor: Colors.blueGrey,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 15, left: 30, right: 30),
                    child: TextFormField(
                      onSaved: ((newValue) {
                        SSN = newValue;
                      }),
                      validator: (value){
                        if(value!.isEmpty){return 'SSN can not be empty';}
                        if(value!.isNotEmpty && value!.length<14){return 'SSN can not be smaller than 14 digits';}
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      // cursorColor: Colors.white,
                      maxLength: 14,
                      decoration: InputDecoration(
                          filled: true,
                          label: Text("Social Security Number (14 digit)"),
                          labelStyle: TextStyle(color: Colors.white),
                          // fillColor: Colors.blueGrey,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10))),
                    )),

                Container(
                  padding: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            Navigator.of(context).pushNamed("login");
                          },
                          child: Text("    Log in   ")),
                      Container(
                        width: 30,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () async {
                            var data = gg.currentState;
                            if (data!.validate()) {
                              data.save();
                              await _auth.register(username, password);

                            }
                          },
                          child: Text("Create Account")),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.orange,
                    ))
              ],
            )),
          ),
        ));
  }
}
