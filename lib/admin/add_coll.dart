// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class FirestoreService {
//   final CollectionReference categoriesCollection =
//       FirebaseFirestore.instance.collection('categories');
//
//   Future<void> uploadCategory(String categoryName) async {
//     try {
//       await categoriesCollection.add({'name': categoryName});
//     } catch (e) {
//       print('Error uploading category: $e');
//     }
//   }
// }
//
// class Reading extends StatefulWidget {
//   final ColorScheme dync;
//   final FirestoreService firestoreService;
//
//   Reading({required this.dync, required this.firestoreService});
//
//   @override
//   State<Reading> createState() => _ReadingState();
// }
//
// class _ReadingState extends State<Reading> {
//   // progress prog = progress();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: widget.dync.primaryContainer,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ClipPath(
//             clipper: TopheadCLipper(),
//             child: Container(
//               child: Center(
//                 child: Text(
//                   "Reading",
//                   style: TextStyle(
//                       color: widget.dync.secondaryContainer,
//                       fontSize: 34,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               color: widget.dync.primary,
//               height: MediaQuery.of(context).size.height / 3.5,
//             ),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height / 1.5,
//             child: ListView.builder(
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () async {
//                     if (index <= prog.progress_get()[0] / 6) {
//                       await widget.firestoreService
//                           .uploadCategory(categories[index]);
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => IndProgress(
//                           data: categories[index],
//                           dync: widget.dync,
//                         ),
//                       ));
//                     }
//                   },
//                   child: !(index <= prog.progress_get()[0] / 6)
//                       ? Stack(
//                           children: [
//                             Container(
//                               margin: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                   color: widget.dync.background,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(30))),
//                               width: double.infinity,
//                               height: MediaQuery.of(context).size.height / 10,
//                               child: Center(
//                                 child: Text(
//                                   categories[index],
//                                   style: TextStyle(
//                                       color: widget.dync.secondary,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 17),
//                                 ),
//                               ),
//                             ),
//                             Opacity(
//                               opacity: 0.9,
//                               child: Container(
//                                 margin: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     color: widget.dync.primary,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10))),
//                                 width: double.infinity,
//                                 height: MediaQuery.of(context).size.height / 10,
//                                 child: Center(child: Icon(Icons.lock)),
//                               ),
//                             ),
//                           ],
//                         )
//                       : Container(
//                           margin: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               color: widget.dync.primary,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10))),
//                           width: double.infinity,
//                           height: MediaQuery.of(context).size.height / 10,
//                           child: Center(
//                             child: Text(
//                               categories[index],
//                               style: TextStyle(
//                                   color: widget.dync.secondaryContainer,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20),
//                             ),
//                           ),
//                         ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Rest of the code...
//
// List<String> categories = [
//   "Vocabulary",
//   "Phrases and Expressions",
//   "Grammar",
//   "Dialogues and Conversations",
//   "Cultural Insights",
// ];
