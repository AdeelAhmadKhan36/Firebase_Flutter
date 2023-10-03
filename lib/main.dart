import 'package:firebase_03/Firebase%20Authontication/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async {
//Initialize Firbase for Androide Permission
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}
//This chunk of code is used for Firebase Notification
// @pragma('vm:entry-point')
// //Start Function
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
//   await Firebase.initializeApp();
//   print(message.notification!.title.toString());
//   print(message.notification!.body.toString());
//   print(message.data);
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: FirebaseNotificatons(),
      home: SplashScreen(),




    );
  }
}
