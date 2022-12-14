import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uncw_landmark_app/map_screen.dart';
import 'package:uncw_landmark_app/user_sites.dart';
import 'login_signup_screen.dart';
import 'home_screen.dart';
import 'FB/FBfunctions.dart';
import 'new_site.dart';

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
              // Hamburger menu
              decoration: const BoxDecoration(color: Colors.tealAccent),
              child: FirebaseAuth.instance.currentUser == null
                  ? const Text("Choose one of the following pages:")
                  : Text(
                      "Welcome, ${FirebaseAuth.instance.currentUser?.email}"),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("UNCW Landmarks"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_filled),
              title: const Text("User Landmarks"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UserSitesScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text("Map Screen"),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MapScreen()));
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
                    leading: const Icon(Icons.add),
                    title: const Text("Add Landmark"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NewSiteScreen()));
                    },
                  )
                : Container(),
            FirebaseAuth.instance.currentUser != null
                ? ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text("Log Out"),
                    onTap: () {
                      // setState(() {
                      signOut();
                      // });

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
