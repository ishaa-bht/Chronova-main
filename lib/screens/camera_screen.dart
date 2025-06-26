// import 'package:chronova/screens/screen_ar.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class CameraScreen extends StatelessWidget {
//   const CameraScreen({Key? key}) : super(key: key);
//
//   final String unityIntentUrl = 'intent://#Intent;component=com.SyntaxError.Chronova_test1/com.unity3d.player.UnityPlayerGameActivity;package=com.SyntaxError.Chronova_test1;end';
//
//   Future<void> _launchUnityApp() async {
//     final Uri uri = Uri.parse(unityIntentUrl);
//
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       debugPrint('Could not launch Unity app');
//       // Optionally, handle the fallback here (e.g., open Play Store or show a message)
//     }
//   }
//
//   @override
//   Future<Widget> build(BuildContext context) async {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Camera Screen')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const SimpleARScreen()),
//           )
//           ,
//           child: const Text('Open Chronova Unity App'),
//         ),
//       ),
//     );
//   }
// }
