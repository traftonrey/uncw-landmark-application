import 'package:flutter/material.dart';
import 'package:uncw_landmark_app/about_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'loginscreen.dart';
import 'site_data.dart';

void main() async {
  runApp(const MaterialApp(title: "Firebase Example", home: LoginScreen()));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AboutScreen(),
                ),
              );
            },
            child: const Text("Go to About Screen"),
          ),
        ],
      ),
    );
  }
}
