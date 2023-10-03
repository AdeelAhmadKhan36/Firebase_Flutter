
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_03/Firebase%20Authontication/CrudOperations/add_post.dart";
import "package:firebase_03/Firetore_Database/Add_Firestore_data.dart";
import "package:firebase_03/Utalities/utils.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_database/firebase_database.dart";
import "package:firebase_database/ui/firebase_animated_list.dart";
import "package:flutter/material.dart";

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {


  final auth=FirebaseAuth.instance;
  final editController=TextEditingController();
  //Retreiving Data from fireatore
  final firestore=FirebaseFirestore.instance.collection('User').snapshots();
  CollectionReference ref=FirebaseFirestore.instance.collection('User');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FireStore Screen"),
        backgroundColor: Colors.deepPurple,
      ),
      body:  Column(
        children: [
          //Using Stream builder to fetch
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot>snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return CircularProgressIndicator();


                }if(snapshot.hasError){
                  return Text('Error Occured');

                }

                return Expanded(

                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder:(context,index){

                        return ListTile(
                          title: Text(snapshot.data!.docs[index]["title"].toString()),
                          subtitle: Text(snapshot.data!.docs[index]["id"].toString()),
                          trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert_outlined),
                              itemBuilder: (context)=>[
                                PopupMenuItem(
                                    value:1,
                                    child: ListTile(


                              onTap: (){
                                        ref.doc(snapshot.data!.docs[index]['id'].toString()).update(
                                            {
                                              'title':'Data is Updated'

                                            }).then((value){
                                              Utils().toastmessage("Data is Updated");
                                        }).onError((error, stackTrace){
                                          Utils().toastmessage(error.toString());
                                        });
                                      },
                                      leading: Icon(Icons.edit),
                                      title: Text("Update"),
                                    )),
                                PopupMenuItem(
                                    value:1,
                                    child: ListTile(
                                      //Put delete Opetion here
                                      onTap: (){
                                        Navigator.pop(context);
                                        // ref.child(snapshot.child('id').value.toString()).remove();
                                        ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                                      },

                                      leading: Icon(Icons.delete),
                                      title: Text("Delete"),
                                    )),
                                //after this go to addpost screen

                              ]
                          ),



                        );
                      }
                  ),



                );

          })
          
          
          ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddFireStore()));

        },
        child: const Icon(Icons.add),
      ),

    );
  }
  Future<void> showMyDialog (String title,String id)async{
    editController.text=title;
    return showDialog(
      context:context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update'),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(
                hintText: '',
              ),
            ),
          ),
          actions: [
            TextButton(onPressed:(){
              Navigator.pop(context);
            },

                child: Text('Cencel')),
            TextButton(onPressed:(){
              Navigator.pop(context);
              //Here we will update the value
              ref.doc(id).update({
                'title':editController.text.toLowerCase()

              }).then((value){
                Utils().toastmessage('Data Updated Sucessfully');
              }).onError((error, stackTrace) {

                Utils().toastmessage(error.toString());
              });
            },

                child: Text('Update'))


          ],
        );
      },

    );
  }
}
