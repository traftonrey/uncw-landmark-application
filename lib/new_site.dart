import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uncw_landmark_app/FB/FBfunctions.dart';
import 'package:uncw_landmark_app/about_screen.dart';
import 'package:uncw_landmark_app/home_screen.dart';
import 'package:uncw_landmark_app/login_signup_screen.dart';
import 'package:uncw_landmark_app/map_screen.dart';
import 'package:uncw_landmark_app/user_sites.dart';

class NewSiteScreen extends StatefulWidget {
  const NewSiteScreen({super.key});

  @override
  State<NewSiteScreen> createState() => _NewSiteScreenState();
}

class _NewSiteScreenState extends State<NewSiteScreen> {
  // State variable that will refer to the profile image location.
  String? imageFile;
  // A reference to the Storage bucket for our project.
  var storageRef = FirebaseStorage.instance.ref();

  String? siteName;
  String? siteDescription;
  bool imgValidated = false;
  final _formKey = GlobalKey<FormState>();
  XFile? image;
  String? submitError;
  bool finished = false;

  @override
  void initState() {
    super.initState();
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
        title: const Text("Add Landmark"),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.grey[250],
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const Spacer(),
            // Display a placeholder or the selected image
            if (image == null) const Icon(Icons.image, size: 72),
            if (image != null)
              Image.file(
                File(image!.path),
                fit: BoxFit.cover,
                width: 250,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    // onPressed: () => _getImage(ImageSource.camera),
                    onPressed: () async {
                      image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      setState(() {});
                    },
                    child: const Text("Camera")),
                ElevatedButton(
                    onPressed: () async {
                      image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      setState(() {});
                    },
                    child: const Text("Gallery")),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                  decoration: const InputDecoration(hintText: "Site Name"),
                  onChanged: (value) => siteName = value,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter a title.';
                    }
                    if (value.length < 7) {
                      return 'Please enter a longer title.';
                    }
                    return null; // Returning null means "no issues"
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                  decoration:
                      const InputDecoration(hintText: "Landmark Description"),
                  onChanged: (value) => siteDescription = value,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter a description.';
                    }
                    if (value.length < 10) {
                      return 'Please enter a longer description.';
                    }
                    return null; // Returning null means "no issues"
                  }),
            ),
            const Spacer(flex: 12),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 100),
                    child: Text(
                      'Submit Landmark',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // This calls all validators() inside the form for us.
                      _createSite(siteName, siteDescription, image);
                      if (finished) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const UserSitesScreen()));
                      }
                    }
                  }),
            ),
            submitError == null
                ? Container()
                : Text(
                    submitError!,
                    style: const TextStyle(color: Colors.red),
                  ),
            const Spacer()
          ],
        ),
      ),
    );
  }

  _createSite(siteName, siteDescription, image) async {
    if (siteName == null) {
      submitError = 'Please enter a landmark name.';
      setState(() {});
      return;
    }
    if (siteDescription == null) {
      submitError = 'Please enter a landmark description.';
      setState(() {});
      return;
    }
    if (image == null) {
      submitError = 'Please take or upload an image of the landmark.';
      setState(() {});
      return;
    }
    if (image != null) {
      // Extract the image file extension
      String fileExtension = '';
      int period = image.path.lastIndexOf('.');
      if (period > -1) {
        fileExtension = image.path.substring(period);
      }
      // Specify the bucket location so that it will be something like
      // `<ourBucket>/images/AOBrzuwu9ZQO3kteja956exgf0U2.jpg`
      // ignore: unnecessary_brace_in_string_interps
      final siteImageRef = storageRef.child("images/${siteName}$fileExtension");
      try {
        // Upload the image file.
        await siteImageRef.putFile(File(image.path));
        // Get a public URL that we can download the image from.
        imageFile = await siteImageRef.getDownloadURL();
        setState(() {});
        // We should provide feedback to the user here.
        // ignore: unused_catch_clause
      } on FirebaseException catch (e) {
        // Caught an exception from Firebase.
        // print("Failed with error '${e.code}': ${e.message}");
      }
      // Adding new site to cloud firestore
      final data = {
        "name": siteName,
        "description": siteDescription,
        "reference": siteImageRef.fullPath,
        "favorited": [""]
      };

      db.collection("UserSites").doc(siteName).set(data);
      finished = true;
    }
  }
}
