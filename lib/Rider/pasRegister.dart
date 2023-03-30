import 'package:flutter/material.dart';

class pasRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          title: Container(
            padding: EdgeInsets.only(top: 35),
            child: Text(
              'Welcome!',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF000080),
        ),
      ),
      body: SingleChildScrollView(
        child:
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    filled: true,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    filled: true,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    filled: true,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    filled: true,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    filled: true,
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF000080),
                    textStyle: TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                ),
                TextButton(
                  child: Text(
                    'Already have an account? Sign in',
                    style: TextStyle(
                      color: Color(0xFF000080),
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
      ),
    );
  }
}
