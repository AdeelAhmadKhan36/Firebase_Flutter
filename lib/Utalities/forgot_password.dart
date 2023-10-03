

import 'package:firebase_03/Firebase%20Authontication/Widgtes/Rounfbutton.dart';
import 'package:firebase_03/Utalities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController=TextEditingController();
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgotten Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),

            ),
          ),
          SizedBox(height: 30,),
          RoundButton(title: 'Forgot Password', onTap: (){
            auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {

              Utils().toastmessage('Password sent on your email please check');
            }).onError((error, stackTrace){
              Utils().toastmessage(error.toString());
            });

          })
        ],
      ),
    );
  }
}
