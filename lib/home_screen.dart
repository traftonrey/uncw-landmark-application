import 'package:flutter/material.dart';
import 'package:uncw_landmark_app/about_screen.dart';
import 'site_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        children: [
          // GridView.builder(
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2),
          //   itemBuilder: (BuildContext context, int index) {
          //     return MyCard(sites[index]);
          //   },
          // ),
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
    );
  }
}

// class MyCard extends StatelessWidget {
//   const MyCard(this.site, {super.key});

//   final Site site;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => DetailScreen(site: site))),
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(4),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Image.asset(name),
//               Text("Yo"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
