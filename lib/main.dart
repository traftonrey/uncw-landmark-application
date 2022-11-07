import 'package:flutter/material.dart';
import 'package:uncw_landmark_app/about_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_signup_screen.dart';

void main() async {
  runApp(const MaterialApp(
    title: "Firebase Example",
    home: LoginScreen(),
  ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
