
import 'dart:math';


import 'package:firebase_03/Firebase%20Authontication/Newscreen.dart';
import 'package:firebase_03/Firebase%20Authontication/login_with_phoneno.dart';
import 'package:firebase_03/Firebase%20Authontication/signup.dart';
import 'package:firebase_03/Utalities/forgot_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../Utalities/utils.dart';
import 'Widgtes/Rounfbutton.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

   final _auth=FirebaseAuth.instance;
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login(){
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
      Utils().toastmessage(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Newscreen()));

      setState(() {
        loading=false;
      });

    }).onError((error, stackTrace){
      debugPrint(error.toString());
      Utils().toastmessage(error.toString());
      setState(() {
        loading=false;
      });
    });

  }



  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;

    },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurple,
          title: Text('Login'),
          centerTitle: true,
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'email',
                        helperText: 'email eg:Adeel@gamil.com',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value){
                        if(value!.isEmpty){

                          return 'Enter email';
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: passwordController,
                      obscureText:true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        helperText: 'Password eg: codem',
                        prefixIcon: Icon(Icons.password),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            RoundButton(
              loading:loading,
              title:'Login',
                  onTap: (){


                    if(_formKey.currentState!.validate()){
                      login();

                    }
                  },
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
              },
                  child: Text("Forgot Password?",style: TextStyle(decoration: TextDecoration.underline),)),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an Account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));


                },

                    child: Text("SignUp")),
              ],
            ),
            SizedBox(height:30),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginwithPhoneno()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                   height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border:Border.all(
                      color: Colors.black,
                    )
                  ),

                  child: Center(child: Text('Login with phone')),
                ),
              ),
            )
          ],

        ),
      ),
    );
  }
}
