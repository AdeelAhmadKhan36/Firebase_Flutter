
import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'Message_Screen.dart';

class NotificationServices {

  //Adding firebase messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

  void requestNotificationPermision() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Permission");
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Provisional Permission");
    }
    else {
      print("Permision Denied");
    }
  }




  void initLocalNotification (BuildContext context, RemoteMessage message)async{
    var androidInitializationSettings=const AndroidInitializationSettings('@mipmap/ice_launcher');
    //for ios icon Setting
    var iosInitializationSettings=const DarwinInitializationSettings();
    var initializationSetting=InitializationSettings(
      android:androidInitializationSettings,
      iOS: iosInitializationSettings
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload){
       handleMessage(context, message) ;

      }

    );

  }


  void firebaseinit(BuildContext context){
    FirebaseMessaging.onMessage.listen((message) {
      //When message Recieve here from InitLocationPlugin then how we will show it
     if(kDebugMode) {
       print(message.notification!.title.toString());
       print(message.notification!.body.toString());
       print(message.data.toString());
       print(message.data['Type']);
       print(message.data['Id']);


     }
     if(Platform.isAndroid)
{
     initLocalNotification(context , message);
     showNotification(message);

    }
     else{
       showNotification(message);
     }
    }
     );
  }
  //Another Function Here use to show notifications form local Plugin
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      'Highly Important Notifications',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: channel.description.toString(),
      icon: '@mipmap/ic_launcher', // Replace with your small icon name
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      showWhen: true,
    );
    const DarwinNotificationDetails darwinNotificationDetails=DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true
    );
    NotificationDetails notificationDetails=NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero,(){
      _flutterLocalNotificationsPlugin.show(
          1,
          message.notification!.title.toString(),
          message.notification!.body.toString(),

          notificationDetails);
    });


  }
  Future<String>getDeviceToken()async{
    String? token=await messaging.getToken();
    return token!;
  }

  void isTokenRefresh(){
    messaging.onTokenRefresh.listen((event) {

      event.toString();
      print('Token Refreshed Sucessfully');
    });
  }

  void handleMessage(BuildContext context,RemoteMessage message){
    if(message.data['Type']=='Msg'){
      Navigator.push(context, MaterialPageRoute(builder:(context)=>Messaging(
        Id: message.data['Id']
      )));
    }
  }

  //When Application is running in Background
    //Here we have two cases 1)When App is Terminated 2) App Running in Background

Future<void>setUpInteractMessage(BuildContext context)async{
    RemoteMessage? initialMessage=await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage!=null){
      handleMessage(context,initialMessage);
    }
    //When Application is in Backgorund

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    handleMessage(context, event);
  });



}


}