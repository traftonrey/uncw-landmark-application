import 'package:flutter/material.dart';
import 'package:uncw_landmark_app/about_screen.dart';
import 'package:uncw_landmark_app/detailed_site_screen.dart';
import 'site_data.dart';
import 'home_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.tealAccent),
            child: Text("Choose one of the following pages:"),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home Screen"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About Screen"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AboutScreen()));
            },
          )
        ],
      )),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.grey[250],
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
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
                    builder: (context) => const AboutScreen(),
                  ),
                );
              },
              child: const Text("Go to About Screen"),
            ),
            const SizedBox(height: 16),
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
