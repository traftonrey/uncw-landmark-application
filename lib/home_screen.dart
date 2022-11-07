import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uncw_landmark_app/about_screen.dart';
import 'package:uncw_landmark_app/detailed_site_screen.dart';
import 'site_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // childAspectRatio: MediaQuery.of(context).size.width /
                //     (MediaQuery.of(context).size.height / 4),
              ),
              itemBuilder: ((context, index) {
                return MyCard(sites[index]);
              }),
              itemCount: sites.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutScreen(),
                  ),
                );
              },
              child: const Text("Go to About Screen"),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard(this.site, {super.key});

  final Site site;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailedSite(site: site))),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  constraints: const BoxConstraints(maxHeight: 150),
                  child: Image.asset(
                    "assets/images/${site.reference}.jpg",
                    width: 250,
                  )),
              Text(
                site.name,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                site.description,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
