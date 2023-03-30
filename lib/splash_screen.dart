
import 'dart:async';
import 'dart:math';

import 'package:HantoryGo/screens_drivers/map.dart';
import 'package:HantoryGo/screens_drivers/usertype.dart';
import 'package:flutter/material.dart';





// class SPlashScreen extends StatefulWidget {
//   const SPlashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SPlashScreen> createState() => _SPlashScreenState();
// }
//
// class _SPlashScreenState extends State<SPlashScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // Timer(Duration(seconds: 5),(){
//     //   Navigator.push(
//     //     context,
//     //     MaterialPageRoute(builder: (context) =>  UserType()),
//     //   );
//     // });
//   }
//   Widget build(BuildContext context) {
//     return const SafeArea(
//       child: SingleChildScrollView(
//         child: Scaffold(
//           backgroundColor: Color.fromARGB(255, 0, 0, 128),
//
//           body: SizedBox(
//             width: double.infinity,
//               height: double.infinity,
//             child: Center(
//               child: Image(
//                 image: AssetImage('assets/images/logo.png'),
//                   height: 360
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Rider/main_page.dart';
class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final user=FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Timer(Duration(seconds: 5),(){
       _checkCurrentUser();


 });
  }
  void _checkCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
      await _db.collection('driver').doc(user.uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        if (userData['role'] == 'driver') {
          // User is a driver, navigate to driver screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapPage()),
          );

        } else {
          // User is a rider, navigate to rider screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainPage(id: '${user.uid}',)),
          );


        }
      } else {
        // User data not found, navigate to sign in screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserType()),
        );

      }
    } else {
      // No current user, navigate to sign in screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserType()),
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Scaffold(

                  backgroundColor: Color.fromARGB(255, 0, 0, 128),

                  body: SizedBox(child: Center(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                  height: 600
              ),
            ),
                  )
                  );
            }


        )
    );
  }
}
/*

function add(x, y) {
  while (y != 0) {
    // carry contains the common set bits of x and y
    let carry = x & y;

    // sum of bits of x and y where at least one of the bits is not set
    x = x ^ y;

    // carry is shifted by one so that adding it to x gives the required sum
    y = carry << 1;
  }

  return x;
}

// example usage
console.log(add(5, 7));  // output: 12
//roadmap
Sure, here's a roadmap for learning how to upgrade an existing IoT system with Node.js and MQTT:

    Learn the basics of IoT: To upgrade an existing IoT system, you need to have a solid understanding of the fundamentals of IoT. This includes understanding how devices communicate, how data is transmitted and processed, and how to build scalable and reliable systems. You can start with resources like the IoT Fundamentals course from Cisco.

    Learn Node.js: Node.js is a popular JavaScript runtime that is used for building scalable server-side applications. To use Node.js for IoT development, you need to be comfortable with the basics of JavaScript, as well as with Node.js-specific concepts like event-driven programming and the Node.js runtime environment. You can start with resources like the Node.js documentation and the Node.js Beginner's Guide from W3Schools.

    Learn MQTT: MQTT is a lightweight messaging protocol that is commonly used in IoT systems to facilitate communication between devices. To use MQTT effectively, you need to understand the basics of message brokers, topics, and QoS (Quality of Service) levels. You can start with resources like the MQTT Essentials tutorial from HiveMQ.

    Build a basic IoT system with Node.js and MQTT: Once you have a solid understanding of the basics of IoT, Node.js, and MQTT, you can start building a basic IoT system using these technologies. Start with a simple project, like building a temperature monitoring system using a Raspberry Pi and an MQTT broker. This will give you hands-on experience with connecting devices to an MQTT broker, publishing and subscribing to topics, and processing data with Node.js.

    Upgrade an existing IoT system with Node.js and MQTT: Once you have built a basic IoT system, you can start thinking about how to upgrade an existing system with Node.js and MQTT. This might involve integrating Node.js into an existing system to improve performance or reliability, or using MQTT to facilitate communication between devices. Look for opportunities to leverage the strengths of Node.js and MQTT to build a more efficient and effective IoT system.

    Learn advanced topics: As you become more experienced with Node.js and MQTT, you can start exploring more advanced topics like security, scalability, and real-time data processing. These topics will help you build more complex and sophisticated IoT systems that can handle large volumes of data and support advanced features like real-time analytics and predictive maintenance.

I hope this roadmap helps you learn how to upgrade an existing IoT system with Node.js and MQTT. Good luck with your learning journey!

 */