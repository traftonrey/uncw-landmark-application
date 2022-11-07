import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home_screen.dart';

void main() async {
  runApp(const MaterialApp(
    title: "Firebase Example",
    home: HomeScreen(),
  ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
