import 'package:firebase_03/Firebase%20Authontication/Widgtes/Rounfbutton.dart';
import 'package:firebase_03/Firebase%20Authontication/authorization/verify_code.dart';
import 'package:firebase_03/Utalities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class LoginwithPhoneno extends StatefulWidget {
  LoginwithPhoneno({super.key});


  @override
  State<LoginwithPhoneno> createState() => _LoginwithPhonenoState();
}

class _LoginwithPhonenoState extends State<LoginwithPhoneno> {

  final phoneNumberController=TextEditingController();
  bool loading=false;
  final auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Phone Number'),
      ),
      body: Column(
        children: [
          SizedBox(height:50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              controller:phoneNumberController,
             // keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '+92 -3465403476',

              ),

            ),
          ),
          SizedBox(height:80),
          RoundButton(title: 'Login with Phone',loading: loading, onTap: (){
            setState(() {
              loading=true;
            });

            auth.verifyPhoneNumber(
                 phoneNumber:phoneNumberController.text,
                verificationCompleted: (_){
                  setState(() {
                    loading=false;
                  });
                },
                verificationFailed: (e){
                  setState(() {
                    loading=false;
                  });
                   Utils().toastmessage(e.toString());
                },
                codeSent: (String verificationId, int?token){
                  setState(() {
                    loading=false;
                  });

                   Navigator.push(context, MaterialPageRoute(builder: (context)=>verification_code(verification_id: verificationId,)));
                },
                codeAutoRetrievalTimeout: (e){
                   Utils().toastmessage(toString());
                   setState(() {
                     loading=false;
                   });
                });

          }),
        ],
      ),
    );
  }
}
