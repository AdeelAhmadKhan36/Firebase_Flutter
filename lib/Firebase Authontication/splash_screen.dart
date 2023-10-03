import 'package:firebase_03/Firebase%20Authontication/firebase_services.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServies splashServies=SplashServies();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServies.islogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcom to SplashScreen',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
