import 'dart:math';
import 'package:firebase_03/Firebase%20Authontication/login.dart';
import 'package:firebase_03/Utalities/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Widgtes/Rounfbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool Loading=false;
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  //Firebase Authontications
  FirebaseAuth _auth=FirebaseAuth.instance;
  
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signup(){

    setState(() {
      Loading=true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) {

      setState(() {
        Loading=false;
      });

    }).onError((error, stackTrace) {
      Utils().toastmessage(error.toString());
      setState(() {
        Loading=false;
      });

    });
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: Text('SignUp'),
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
            title:'SignUp',
            loading: Loading,
                        onTap: (){
              if(_formKey.currentState!.validate()){
                signup();

              }
            },
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an Account?"),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              },

                  child: Text("Login")),
            ],
          )
        ],

      ),
    );
  }
}
