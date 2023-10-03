import 'package:firebase_03/Firebase%20Authontication/postph_screen.dart';
import 'package:firebase_03/Utalities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgtes/Rounfbutton.dart';
class verification_code extends StatefulWidget {

  final String verification_id;
  const verification_code({super.key, required this.verification_id});

  @override
  State<verification_code> createState() => _verification_codeState();
}

class _verification_codeState extends State<verification_code> {

  final verificationCodeController=TextEditingController();
  bool loading=false;
  final auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Code'),
      ),
      body: Column(
        children: [
          SizedBox(height:50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              controller:verificationCodeController,
              // keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Please provide 6 digit code',

              ),

            ),
          ),
          SizedBox(height:80),
          RoundButton(title: 'Click to verify',loading: loading, onTap: () async {
            setState(() {
              loading=true;
            });

            final credential=PhoneAuthProvider.credential(
                verificationId: widget.verification_id,
                smsCode:verificationCodeController.text.toString(),
            );
            try{
              await auth.signInWithCredential(credential);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Postscreen()));

            }catch(e)
            {
              setState(() {
                loading=true;
              });
              Utils().toastmessage(e.toString());

            }


          }),
        ],
      ),

    );
  }
}
