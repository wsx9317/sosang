// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:simple_web_camera/simple_web_camera.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   String result = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 var res = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const SimpleWebCameraPage(appBarTitle: "Take a Picture", centerTitle: true),
//                   ),
//                 );
//                 setState(() {
//                   if (res is String) {
//                     result = res;
//                   }
//                 });
//               },
//               child: const Text("Take a picture"),
//             ),
//             const SizedBox(height: 16),
//             const Text("Picture taken:"),
//             if (result.isNotEmpty)
//               Center(
//                 child: SizedBox(
//                   width: 200, // Example width
//                   height: 200, // Example height
//                   child: Image.memory(
//                     base64Decode(result),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
