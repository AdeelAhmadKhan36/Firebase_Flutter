
import "package:firebase_03/Firebase%20Authontication/CrudOperations/add_post.dart";
import "package:firebase_03/Utalities/utils.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_database/firebase_database.dart";
import "package:firebase_database/ui/firebase_animated_list.dart";
import "package:flutter/material.dart";

class Postscreen extends StatefulWidget {
  const Postscreen({super.key});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {


  final auth=FirebaseAuth.instance;
  //Here ref of that node will be provided from where you want to fetch data,
  final ref=FirebaseDatabase.instance.ref('New Post');
  final searchFilter=TextEditingController();
  final editController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wellcome to Post Screen"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: StreamBuilder(
          //     //Now reapeat the same process as there in the Animatedlist ,just pass the refrence
          //     stream: ref.onValue,
          //
          //
          //       builder: (context,AsyncSnapshot<DatabaseEvent>snapshot){
          //
          //       if(!snapshot.hasData){
          //         return SingleChildScrollView();
          //       }else {
          //         Map<dynamic, dynamic>map = snapshot.data!.snapshot
          //             .value as dynamic;
          //         List<dynamic>list = [];
          //         list.clear();
          //         list = map.values.toList();
          //
          //         return ListView.builder(
          //             itemCount: snapshot.data!.snapshot.children.length,
          //             itemBuilder: (context, index) {
          //               return  ListTile(
          //                 title: Text(list[index]['title']),
          //                 subtitle: Text(list[index]['id']),
          //
          //               );
          //             });
          //       }
          //
          //
          //   }
          //   ),
          // ),
          // Divider(
          //   thickness: 10,
          //   color: Colors.deepPurple,
          // ),
          //Here Filtering Operation will be perform
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: 'Search here',
                border:OutlineInputBorder(),
              ),
              //When value change then rebuild the widgte again.
              onChanged: (String value){
                setState(() {

                });

              },
            ),
          ),


          Expanded(
            child: FirebaseAnimatedList(
            query: ref,
            defaultChild: Text('Loading'),
            itemBuilder: (context,snapshot,animation,index){


              final title=snapshot.child('title').value.toString();
              if(searchFilter.text.isEmpty){
                return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString()),
                  trailing: PopupMenuButton(
                    icon: Icon(Icons.more_vert_outlined),
                    itemBuilder: (context)=>[
                      PopupMenuItem(
                          value:1,
                          child: ListTile(
                            onTap: (){
                              Navigator.pop(context);
                              showMyDialog(title, snapshot.child('title').value.toString());
                            },
                            leading: Icon(Icons.edit),
                            title: Text("Edit"),
                          )),
                      PopupMenuItem(
                          value:1,
                          child: ListTile(
                            //Put delete Opetion here
                            onTap: (){
                              Navigator.pop(context);
                              ref.child(snapshot.child('id').value.toString()).remove();
                            },

                            leading: Icon(Icons.delete),
                            title: Text("Delete"),
                          )),
                      //after this go to addpost screen

                    ]
                  )
                );

              }else if(title.toLowerCase().contains(searchFilter.text.toLowerCase().toString())){
                //here we will use A condition
                return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                );

              }else{
                return Container();
              }


            }
            ),
          ),



        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Addpost()));

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
              ref.child(id).update({
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
