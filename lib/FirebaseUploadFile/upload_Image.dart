import 'dart:io';

import 'package:firebase_03/Firebase%20Authontication/Widgtes/Rounfbutton.dart';
import 'package:firebase_03/Utalities/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  bool loading=false;
  //Using image picker library Access your images
  File? _image;
  final picker=ImagePicker();
  //Creating firebase storage refrence
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef=FirebaseDatabase.instance.ref('New Post');


  //This picker will allow through which we access the Gallery
  Future getImageGallery()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);//Here you can set image quality
    setState(() {
      if(pickedFile!=null){
        _image=File(pickedFile.path);

      }else{
        print('No file has been picked');
      }


    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image'),),
      body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: (){
                getImageGallery();

              }
              ,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)

                ),
                //Gallery is Accessed and now here we will show image
                child: Center(
                    child:_image!=null?Image.file(_image!.absolute): Icon(Icons.image_rounded)),
              ),
            ),
          ),
          SizedBox(height: 20,),
          RoundButton(title: 'Upload', onTap:() async{
            //Create url and then store that in the data base
            setState(() {
              loading=true;
            });

            firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('/Adeel Ahmad'+'1234');
            firebase_storage.UploadTask uploadtask=ref.putFile(_image!.absolute);

            Future.value(uploadtask).then((value) async {
              var newUrl = await ref.getDownloadURL();
              databaseRef.child('1').set({
                'id': '1234',
                'title': newUrl.toString()
              }).then((value) {
                setState(() {
                  loading = false;
                });
                Utils().toastmessage('Uploaded');
              }).onError((error, stackTrace) {
                setState(() {
                  loading = false;
                });
              });
            }).onError((error, stackTrace) {
              Utils().toastmessage(error.toString());
              
              setState(() {
                loading=false;
              });
            });






          })
        ],
      ),
    );
  }
}
