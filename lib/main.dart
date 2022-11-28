import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uncw_landmark_app/login_signup_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(
      title: "UNCW Map and Points of Interest", home: LoginScreen()));
}
