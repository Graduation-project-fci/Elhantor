import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_project/screens_drivers/loginscreen.dart';
import 'package:new_project/screens_drivers/signup.dart';

import 'firebase_options.dart';

import './screens_drivers/profile.dart';
import './screens_drivers/map.dart';

import 'package:new_project/services/Authenticate/authenticate.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    home: Map(),
    routes: {
      '/login': (context) => const loginscreen(),
      '/home': (context) => const EditProfile(),
    },
  ));
}
