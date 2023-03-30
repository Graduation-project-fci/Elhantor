import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _loginUser(String email, String password) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() {
        _isLoading = false;
      });
      _showSnackBar("Login successful");
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar("Login failed: ${e.message}");
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar("An error occurred: $e");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ));


  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        key: _scaffoldKey,

        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter an email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _loginUser(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                    }
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading=false;
  Future<void> _loginUser(String email, String password) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() {
        _isLoading = false;
      });
      _showSnackBar("Login successful");
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar("Login failed: ${e.message}");
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar("An error occurred: $e");
    }
  }
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ));


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body:
        SingleChildScrollView(
          child: SafeArea(child:Container(
            width: double.infinity,
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Container(alignment: Alignment.center,
                  child: const Image(image: AssetImage('assets/images/hantour.png'),
                    height: 150,),
                  ),
                  const SizedBox(height: 15),
              Container(
                height: 55,
                padding: const EdgeInsets.only(top: 3,left: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 7,
                    )
                  ],
                ),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){return 'Please Enter an Email';}
                  },

                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                      hintText: 'Enter Email',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(0),
                      hintStyle: const TextStyle(
                        height: 1,
                      )
                  ),

                ),
              ),
                  SizedBox(height: 15,),
                  Container(
                    height: 55,
                    padding: const EdgeInsets.only(top: 3,left: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 7,
                        )
                      ],
                    ),
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){return 'Please Enter an Email';}
                      },
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Enter Password',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(0),
                          hintStyle: const TextStyle(
                            height: 1,
                          )
                      ),

                    ),
                  ),
                  SizedBox(height: 25,),
                  _isLoading
                      ? CircularProgressIndicator()
                      : Container(
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
                        child: InkWell(
                            onTap: () {


                              if (_formKey.currentState!.validate()) {
                                _loginUser(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                              }


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
                            )
                      ),






              ), Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          '- Or Sign In With -',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Container(
                          width: MediaQuery.of(context).size.width ,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ////google



                                Center(


                                  child: SignInButton(


                                    Buttons.Google,
                                    text: "Sign in with Google",
                                    onPressed: () {},

                                  ),)])),
                      const SizedBox(width: 10,),



                    ],

                  ),
            ]),
          ) ,),


        ),

    ),bottomNavigationBar:Container(
      height: 50,
      color: Colors.white,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account? ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          InkWell(
            onTap: (){

            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),

            ),
          ),
        ],
      ),
    ) ,);
  }
}










