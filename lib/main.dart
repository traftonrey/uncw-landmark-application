import 'package:flutter/material.dart';
import 'package:uncw_landmark_app/about-screen.dart';

void main() {
  runApp(const MaterialApp(title: "UNCW Landmarks", home: HomeScreen()));
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
