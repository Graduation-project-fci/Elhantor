import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class button extends StatefulWidget {




  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

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
    );
  }

  
}