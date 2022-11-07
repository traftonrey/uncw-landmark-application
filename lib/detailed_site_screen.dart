import 'package:flutter/material.dart';
import 'site_data.dart';

class DetailedSite extends StatelessWidget {
  const DetailedSite({this.site, super.key});

  final Site? site;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text(site!.name)),
        body: Center(
          child: Column(
            children: [
              Image.asset("assets/images/${site!.name}.jpg"),
              Text(site!.description),
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
