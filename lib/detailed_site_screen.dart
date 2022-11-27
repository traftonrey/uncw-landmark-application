import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailedSite extends StatelessWidget {
  const DetailedSite({this.site, super.key});

  final DocumentSnapshot? site;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(site!.get('name')),
          backgroundColor: Colors.teal,
        ),
        backgroundColor: Colors.grey[250],
        body: Center(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(site!.get('reference'),
                          height: 400, width: 400))),
              const SizedBox(height: 16),
              Text(
                site!.get('description'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Go Back"))
            ],
          ),
        ));
  }
}
