// import 'package:flutter/material.dart';
// import 'site_data.dart';

// class DetailedSite extends StatelessWidget {
//   const DetailedSite({this.site, super.key});

//   final Site? site;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(site!.name),
//           backgroundColor: Colors.teal,
//         ),
//         backgroundColor: Colors.grey[250],
//         body: Center(
//           child: Column(
//             children: [
//               Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: Image.asset("assets/images/${site!.reference}.jpg",
//                           height: 400, width: 400))),
//               const SizedBox(height: 16),
//               Text(
//                 site!.description,
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text("Go Back"))
//             ],
//           ),
//         ));
//   }
// }
