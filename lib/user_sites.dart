import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uncw_landmark_app/home_screen.dart';
import 'package:uncw_landmark_app/about_screen.dart';
import 'package:uncw_landmark_app/detailed_site_screen.dart';
import 'package:uncw_landmark_app/login_signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uncw_landmark_app/new_site.dart';
import 'FB/FBfunctions.dart';
import 'map_screen.dart';

class UserSitesScreen extends StatefulWidget {
  const UserSitesScreen({super.key});

  @override
  State<UserSitesScreen> createState() => _UserSitesScreenState();
}

class _UserSitesScreenState extends State<UserSitesScreen> {
  final siteRef = FirebaseFirestore.instance.collection('UserSites');
  var storageRef = FirebaseStorage.instance.ref();
  String? imageFile;

  @override
  void initState() {
    super.initState();

    // futureImages = FirebaseStorage.instance.ref('/images').listAll();
  }

  // void _getFileUrl(siteName) async {
  //   try {
  //     // We have to search all the files to see if the user
  //     // has a profile pic.
  //     ListResult result = await storageRef.child('images').listAll();
  //     for (Reference ref in result.items) {
  //       print(ref.name);
  //       // Leverage our naming schema from _getImage()
  //       if (ref.name.startsWith("$siteName")) {
  //         imageFile = await ref.getDownloadURL();
  //         setState(() {});
  //       }
  //     }
  //   } on FirebaseException catch (e) {
  //     // Caught an exception from Firebase.
  //     print("Couldn't download picture for that landmark.");
  //   }
  // }

  Future<String> downloadURL(String imgName) async {
    print(imgName);
    String downloadURL = await storageRef.child(imgName).getDownloadURL();

    return downloadURL;
  }

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
            leading: const Icon(Icons.school),
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
        title: const Text("User-Submitted Landmarks"),
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
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: GridTile(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //     constraints:
                              //         const BoxConstraints(maxHeight: 150),
                              //     child: Image.network(
                              //       storageRef
                              //           .child(
                              //               "${sites[index].get('reference')}")
                              //           .getDownloadURL(),
                              //       width: 250,
                              //     )),
                              FutureBuilder(
                                // future: downloadURL('Trask Coliseum .jpg'),
                                future:
                                    downloadURL(sites[index].get('reference')),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  print('Snapshot data: $snapshot.data');
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                    return Center(
                                        child: Container(
                                      constraints:
                                          const BoxConstraints(maxHeight: 150),
                                      child: Image.network(
                                        snapshot.data!,
                                        width: 125,
                                        height: 125,
                                      ),
                                    ));
                                  }
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      !snapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  }
                                  return Container();
                                },
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    "${sites[index].get('name')}",
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
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
                                              ? const Icon(
                                                  Icons.star,
                                                  color: Colors.teal,
                                                )
                                              : const Icon(
                                                  Icons.star_outline,
                                                  color: Colors.teal,
                                                ))
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
