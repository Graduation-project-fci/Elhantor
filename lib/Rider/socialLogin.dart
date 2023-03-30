import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class socialLogin extends StatelessWidget {
  final  Future<UserCredential?> onTap;

  const socialLogin( {Key? key,required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
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

            children: [
              ////google
              Expanded(

                child: ElevatedButton(
                  onPressed: ()=>{onTap},
                  child:Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),

                  child: Image(

                    image: AssetImage('assets/images/google.png',),
                    height: 25,

                  ),
     ),),),
              const SizedBox(width: 10,),


            ],
          ),
        ),
      ],
    );
  }

}