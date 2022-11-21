import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uncw_landmark_app/login_signup_screen.dart';
import 'home_screen.dart';
import 'FB/FBfunctions.dart';

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
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.tealAccent),
              child: FirebaseAuth.instance.currentUser == null
                  ? const Text("Choose one of the following pages:")
                  : Text(
                      "Welcome, ${FirebaseAuth.instance.currentUser?.email}"),
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
            ),
            FirebaseAuth.instance.currentUser == null
                ? ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text("Sign Up"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                    },
                  )
                : Container(),
            FirebaseAuth.instance.currentUser == null
                ? ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text("Sign In"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                  )
                : Container(),
            FirebaseAuth.instance.currentUser != null
                ? ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text("Log Out"),
                    onTap: () {
                      signOut();

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                  )
                : Container(),
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
