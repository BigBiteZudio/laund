// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:whatsapp_unilink/whatsapp_unilink.dart';
//
// class WhatsAppDemo extends StatefulWidget {
//   @override
//   _WhatsAppDemoState createState() => _WhatsAppDemoState();
// }
//
// class _WhatsAppDemoState extends State<WhatsAppDemo> {
//   void _openWhatsApp() async {
//     final link = WhatsAppUnilink(
//       phoneNumber: '919360209794',  // Replace with the phone number you want to chat with
//       text: "Hello! How are you?",  // Initial message text
//     );
//
//     // Attempt to launch the WhatsApp link
//     await launch('$link');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _openWhatsApp,
//           child: Text("Chat"),
//         ),
//       ),
//     );
//   }
// }
