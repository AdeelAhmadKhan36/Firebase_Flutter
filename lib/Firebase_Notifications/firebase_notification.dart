import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'notification_services.dart';
import 'package:http/http.dart'as http;

class FirebaseNotificatons extends StatefulWidget {
  const FirebaseNotificatons({super.key});

  @override
  State<FirebaseNotificatons> createState() => _FirebaseNotificatonsState();
}

class _FirebaseNotificatonsState extends State<FirebaseNotificatons> {

  NotificationServices notificationServices=NotificationServices();

  @override
  @override
  void initState() {
    super.initState();

    notificationServices.firebaseinit(context);
    // notificationServices.initLocalNotification(context,RemoteMessage()); // Pass null or the appropriate message here
    notificationServices.requestNotificationPermision();
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      print('Device Token');
      print("here is token value=$value");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Notifications',),
        centerTitle:true,
      ),

      body: Center(
        child: TextButton(
          onPressed: (){
            notificationServices.getDeviceToken().then((value)async{

              var data={
                'to':value.toString(),
                   'periority':'high',
                    'notification':{

                     'title':'Adeel',
                      'body':'Welcome to My Application'
                    }

              };
              await http.post(Uri.parse('http://fcm.googleapis.com/fcm/send'),


                  body:jsonEncode(data),
              headers:{

              'Content-Type':'application/json;charset=UTF-8',
              'Authorization':'AAAAMPkkvCw:APA91bGkAHret71FDuP8goZ5tDPu5eVTJ-DR3dp1ABRHoV04q9XUAgH4p8kfHn33YHOPKXX1hhZ4tT6rG6KVuvaysdvy4fKQF-YYSp5CmdERD62jipg6-mlOqFOBCWWnB4-GOiyZgfWH',
              }


              );


            });
            
          }, child: Text('Send Notification'),
        ),
      ),



    );
  }
}
