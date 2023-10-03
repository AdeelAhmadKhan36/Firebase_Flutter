import 'package:firebase_03/Firebase%20Authontication/Widgtes/Rounfbutton.dart';
import 'package:firebase_03/Utalities/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {

  bool loading=false;
  final postcontroller=TextEditingController();
  //Creating database in the Firebase with the name of post
  final databaseRef=FirebaseDatabase.instance.ref('New Post');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insert Data in Firebase",),
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
              //As we want to perform crude operations so for this we need same id to do sowe have make it same

              String id=DateTime.now().microsecondsSinceEpoch.toString();


              databaseRef.child(id).set({
                'title':postcontroller.text.toString(),
                'id':id
                   // 'id':        DateTime.now().microsecondsSinceEpoch.toString()
              }).then((value){
                     Utils().toastmessage('Posted Sucessfully');
                     setState(() {
                       loading=false;
                     });
              }).onError((error, stackTrace) {
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
