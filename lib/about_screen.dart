import 'package:flutter/material.dart';
import 'package:uncw_landmark_app/main.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Text(
                "This app was created by Andrew Bracero and Trafton Reynolds",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))));
  }
}
