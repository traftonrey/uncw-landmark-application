import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uncw_landmark_app/about_screen.dart';
import 'package:uncw_landmark_app/detailed_site_screen.dart';
import 'package:uncw_landmark_app/login_signup_screen.dart';
import 'site_data.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final siteRef = FirebaseFirestore.instance.collection('Sites');
  Future<void> getData() async {
    QuerySnapshot snapshot = await siteRef.get();
    final allDocs = snapshot.docs.map((doc) => doc.data()).toList();
  }

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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About Screen"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AboutScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("Sign Up"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignUpScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("Sign In"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
            ),
          ],
        )),
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: Colors.teal,
        ),
        backgroundColor: Colors.grey[250],
        // body: SingleChildScrollView(
        body: StreamBuilder(
            stream: siteRef.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Text("No data to show!");
              }
              var sites = snapshot.data!.docs;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: ((context, index) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                constraints:
                                    const BoxConstraints(maxHeight: 150),
                                child: Image.asset(
                                  snapshot
                                      .data()
                                      .documents[index]
                                      .get('reference'),
                                  width: 250,
                                )),
                            Text(
                              snapshot.data().documents[index].get('name'),
                              // "${sites[index].get('name')}",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              snapshot
                                  .data()
                                  .documents[index]
                                  .get('description'),
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    )),
                shrinkWrap: true,
                itemCount: sites.length,
                scrollDirection: Axis.vertical,
              );
            }));
  }
}
    
              
              // scrollDirection: Axis.vertical,
              // shrinkWrap: true,
            // ),
            // const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => const AboutScreen(),
            //       ),
            //     );
            //   },
            //   child: const Text("Go to About Screen"),
            // ),
            // const SizedBox(height: 16),
//           ],
//       ),
//       ),
//     );
//   }
// }

// class MyCard extends StatelessWidget {
//   MyCard({super.key});

//   final sites = FirebaseFirestore.instance.collection('Sites');

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
      
      
//       onTap: () => Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => DetailedSite(site: site))),
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(4),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                   constraints: const BoxConstraints(maxHeight: 150),
//                   child: Image.asset(
//                     "${sites[index].get('reference')}",
//                     width: 250,
//                   )),
//               Text(
//                 "${sites[index].get('"
//                 style: TextStyle(
//                     color: Colors.grey[700],
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 site.description,
//                 style: const TextStyle(
//                     color: Colors.grey,
//                     fontSize: 10,
//                     fontWeight: FontWeight.normal),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PeopleList extends StatelessWidget {
//   PeopleList({super.key});

//   // Reference to the Firestore "People" collection
//   final sitesRef = FirebaseFirestore.instance.collection('People');

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: sitesRef.snapshots(), //.snapshots() gives us a Stream
//       builder: (context, snapshot) {
//         // Make sure that the snapshot has data with it.
//         // There may be no data while the network connection is initializing.
//         // And sometimes the data is empty, like and empty street.
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Text("No data to show!");
//         }

//         // Here is the list of Documents from the Sites collection.
//         var siteDocs = snapshot.data!.docs;
//         // Use a GridView.builder to generate a Gridview
//         // to display the Sites collection
//         return GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//           itemCount: siteDocs.length,
//           itemBuilder: ((context, index) => Card(
//               child: ListTile(
//                   title: Text(
//                       "${personDocs[index].get('first')} ${personDocs[index].get('last')}"),
//                  ))),
//         );
//       },
//     );
//   }
//}



// TRIED TO CREATE AN OBJECT OF DOCUMENT

// class SiteList extends StatelessWidget {
//   SiteList({super.key});

//   // Reference to the Firestore "People" collection
//   final siteRef = FirebaseFirestore.instance.collection('Sites');

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: siteRef.snapshots(), //.snapshots() gives us a Stream
//         builder: (context, snapshot) {
//           // Make sure that the snapshot has data with it.
//           // There may be no data while the network connection is initializing.
//           // And sometimes the data is empty, like and empty street.
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Text("No data to show!");
//           }
//           // Here is the list of Documents from the Sites collection.
//           var siteDocs = snapshot.data!.docs;
//         });
//   }
// }
