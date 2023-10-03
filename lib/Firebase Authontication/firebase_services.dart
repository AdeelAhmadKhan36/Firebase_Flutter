
import 'dart:async';
import 'package:firebase_03/Firebase%20Authontication/Newscreen.dart';
import 'package:firebase_03/Firebase%20Authontication/login.dart';
import 'package:firebase_03/FirebaseUploadFile/upload_Image.dart';
import 'package:firebase_03/Firetore_Database/firestore_listscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashServies {



  void islogin(BuildContext context){

  final auth = FirebaseAuth.instance;
  final user = auth.currentUser;

  if (user != null){

  Timer(Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageUpload())));


  }else{

    Timer(Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Login())));
  }

  }
}
