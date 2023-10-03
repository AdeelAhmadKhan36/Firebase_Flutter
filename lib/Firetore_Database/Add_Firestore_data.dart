import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_03/Firebase%20Authontication/Widgtes/Rounfbutton.dart';
import 'package:firebase_03/Utalities/utils.dart';
class AddFireStore extends StatefulWidget {
  const AddFireStore({super.key});

  @override
  State<AddFireStore> createState() => _AddFireStoreState();
}

class _AddFireStoreState extends State<AddFireStore> {

  bool loading=false;
  final postcontroller=TextEditingController();
  //Creating databaserefererence of FireStoreCollection with the name User
  final firestore=FirebaseFirestore.instance.collection('User');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insert Data in FireStore",),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            TextFormField(
              controller: postcontroller,
              decoration: const InputDecoration(
                hintText: "What comes in your mind",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20,),
            RoundButton(title: "Post",
                loading: loading,
                onTap: (){
                  setState(() {
                    loading=true;
                  });
//Creating FireStore Documment here.
                  //as document needed id
                  String id=DateTime.now().microsecondsSinceEpoch.toString();
                  firestore.doc(id).set(
                  {
                   'title':postcontroller.text.toString(),
                   'id':id

                  }
                ).then((value){

                     Utils().toastmessage('Data Posted Sucessfully');
                     setState(() {
                       loading=false;
                     });

                }).onError((error, stackTrace){
                  Utils().toastmessage(error.toString());
                  setState(() {
                    loading=false;
                  });
                });


                }),
          ],
        ),
      ),
    );
  }

//Here we will create the dialog box to edit and update values

}

