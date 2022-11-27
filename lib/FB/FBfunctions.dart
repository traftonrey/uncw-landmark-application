// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var db = FirebaseFirestore.instance;
List<QueryDocumentSnapshot> searchResults = [];
final siteRef = FirebaseFirestore.instance.collection("Sites");

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

Future<void> userSetup() async {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({
    'uid': FirebaseAuth.instance.currentUser!.uid,
    'email': FirebaseAuth.instance.currentUser!.email,
    'favorites': [],
    'firstName': '',
    'lastName': ''
  });
  return;
}

// Future<void> getData() async {
//   QuerySnapshot snapshot = await siteRef.get();
//   final allDocs = snapshot.docs.map((doc) => doc.data()).toList();
// }

class UserModel {
  UserModel(
      {required this.uid,
      required this.email,
      required this.favorites,
      required this.firstName,
      required this.lastName});

  final String uid;
  final String email;
  List<String> favorites;
  final String firstName;
  final String lastName;

  Map<String, Object?> toMap() {
    return {
      'uid': uid,
      'email': email,
      'favorites': favorites,
      'firstName': firstName,
      'lastName': lastName
    };
  }
}

class Site {
  Site(
      {required this.name,
      required this.description,
      required this.favorited,
      required this.reference});

  final String name;
  final String description;
  List<String> favorited;
  final String reference;

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'description': description,
      'favorites': favorited,
      'reference': reference,
    };
  }
}
