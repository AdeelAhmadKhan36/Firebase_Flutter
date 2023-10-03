import 'package:firebase_03/Firebase%20Authontication/login.dart';
import 'package:firebase_03/Utalities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Newscreen extends StatefulWidget {
  const Newscreen({super.key});

  @override
  State<Newscreen> createState() => _NewscreenState();
}

class _NewscreenState extends State<Newscreen> {

  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Myscreen'),
        actions: [
          IconButton(onPressed: (){

            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
            }).onError((error, stackTrace){
              Utils().toastmessage(error.toString());
            });
          }, icon:Icon(Icons.logout),),
        ],
      ),
    );
  }
}
