import 'package:flutter/material.dart';
import 'home_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("About Us"),
          backgroundColor: Colors.teal,
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.tealAccent),
              child: Text("Choose one of the following pages:"),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home Screen"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About Screen"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AboutScreen()));
              },
            )
          ],
        )),
        body: const Center(
            child: Text(
                "This app was created by Andrew Bracero and Trafton Reynolds",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))));
  }
}
