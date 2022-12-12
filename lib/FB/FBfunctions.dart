// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

var db = FirebaseFirestore.instance;
List<QueryDocumentSnapshot> searchResults = [];
final siteRef = FirebaseFirestore.instance.collection("Sites");
List<String> userFavorites = [];

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
    'firstName': '',
    'lastName': ''
  });
  return;
}

class UserModel {
  UserModel(
      {required this.uid,
      required this.email,
      required this.firstName,
      required this.lastName});

  final String uid;
  final String email;
  final String firstName;
  final String lastName;

  Map<String, Object?> toMap() {
    return {
      'uid': uid,
      'email': email,
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
