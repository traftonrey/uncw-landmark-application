import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DetailedUserSite extends StatefulWidget {
  const DetailedUserSite({super.key, this.site});
  final DocumentSnapshot? site;
  @override
  State<DetailedUserSite> createState() => _DetailedUserSiteState();
}

class _DetailedUserSiteState extends State<DetailedUserSite> {
  var storageRef = FirebaseStorage.instance.ref();

  Future<String> downloadURL(String imgName) async {
    String downloadURL = await storageRef.child(imgName).getDownloadURL();

    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.site!.get('name')),
          backgroundColor: Colors.teal,
        ),
        backgroundColor: Colors.grey[250],
        body: Center(
          child: Column(
            children: [
              FutureBuilder(
                future: downloadURL(widget.site!.get('reference')),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Padding(
                        padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              snapshot.data!,
                              height: 400,
                              width: 400,
                            )));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 16),
              Text(
                widget.site!.get('description'),
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
