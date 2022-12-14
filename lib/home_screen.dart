import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uncw_landmark_app/about_screen.dart';
import 'package:uncw_landmark_app/detailed_site_screen.dart';
import 'package:uncw_landmark_app/login_signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uncw_landmark_app/new_site.dart';
import 'package:uncw_landmark_app/user_sites.dart';
import 'FB/FBfunctions.dart';
import 'map_screen.dart';
import 'package:rotating_icon_button/rotating_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final siteRef = FirebaseFirestore.instance.collection('Sites');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            // Hamburger menu
            decoration: const BoxDecoration(color: Colors.tealAccent),
            child: FirebaseAuth.instance.currentUser == null
                ? const Text("Choose one of the following pages:")
                : Text("Welcome, ${FirebaseAuth.instance.currentUser?.email}"),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("UNCW Landmarks"),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AboutScreen()));
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
                    setState(() {
                      signOut();
                    });

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  },
                )
              : Container(),
        ],
      )),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.grey[250],
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: siteRef.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No data to show!"));
            }
            var sites = snapshot.data!.docs;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: sites.length,
              itemBuilder: ((context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailedSite(site: sites[index])));
                    },
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: GridTile(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  constraints:
                                      const BoxConstraints(maxHeight: 150),
                                  child: Image.asset(
                                    "${sites[index].get('reference')}",
                                    width: 250,
                                  )),
                              Row(
                                children: [
                                  Text(
                                    "${sites[index].get('name')}",
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  FirebaseAuth.instance.currentUser != null
                                      ? GestureDetector(
                                          onTap: () {
                                            QueryDocumentSnapshot site =
                                                sites[index];
                                            List<dynamic> hasFavorited =
                                                site.get('favorited');

                                            if (!hasFavorited.remove(
                                                FirebaseAuth.instance
                                                    .currentUser?.uid)) {
                                              hasFavorited.add(FirebaseAuth
                                                  .instance.currentUser?.uid);
                                            }
                                            siteRef.doc(site.id).update(
                                                {'favorited': hasFavorited});
                                          },
                                          child: (sites[index].get('favorited'))
                                                  .contains(FirebaseAuth
                                                      .instance
                                                      .currentUser
                                                      ?.uid)
                                              ? RotatingIconButton(
                                                  onTap: (() {
                                                    QueryDocumentSnapshot site =
                                                        sites[index];
                                                    List<dynamic> hasFavorited =
                                                        site.get('favorited');

                                                    if (!hasFavorited.remove(
                                                        FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.uid)) {
                                                      hasFavorited.add(
                                                          FirebaseAuth
                                                              .instance
                                                              .currentUser
                                                              ?.uid);
                                                    }
                                                    siteRef
                                                        .doc(site.id)
                                                        .update({
                                                      'favorited': hasFavorited
                                                    });
                                                  }),
                                                  borderRadius: 4.0,
                                                  rotateType: RotateType.semi,
                                                  clockwise: false,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 10,
                                                    horizontal: 5,
                                                  ),
                                                  child: const Icon(
                                                    Icons.star,
                                                    color: Colors.teal,
                                                  ),
                                                )
                                              : RotatingIconButton(
                                                  onTap: (() {
                                                    QueryDocumentSnapshot site =
                                                        sites[index];
                                                    List<dynamic> hasFavorited =
                                                        site.get('favorited');

                                                    if (!hasFavorited.remove(
                                                        FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.uid)) {
                                                      hasFavorited.add(
                                                          FirebaseAuth
                                                              .instance
                                                              .currentUser
                                                              ?.uid);
                                                    }
                                                    siteRef
                                                        .doc(site.id)
                                                        .update({
                                                      'favorited': hasFavorited
                                                    });
                                                  }),
                                                  borderRadius: 4.0,
                                                  rotateType: RotateType.semi,
                                                  clockwise: false,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 10,
                                                    horizontal: 5,
                                                  ),
                                                  child: const Icon(
                                                    Icons.star_outline,
                                                    color: Colors.teal,
                                                  )))
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            );
          }),
    );
  }
}
