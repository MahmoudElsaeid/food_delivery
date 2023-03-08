import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NotificationHelper{

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin )async {

    var androidInitialize = AndroidInitializationSettings('notification_icon');
    var iosInitialize = IOSInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iosInitialize);

    flutterLocalNotificationsPlugin.initialize(initializationsSettings, onSelectNotification: (String? payload) {
      try {
        if (payload != null && payload.isNotEmpty) {

            } else {
          //Get.toNamed(RouteHelper.getNotificationRoute);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString);
        }
      }
      return;
    });

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      sound: true,
      badge: true,
      alert: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      print('--------onMessage--------');
      print('onMessage: ${message.notification?.title}/${message.notification?.body}/'
          '${message.notification?.titleLocKey}');

      NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin,);
      if(Get.find<AuthController>().userLoggedIn()){

      }
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onOpenApp: ${message.notification?.title}/${message.notification?.body}/'
          '${message.notification?.titleLocKey}');

      try{
        if(message.notification?.titleLocKey != null){

        }else{

        }
      }catch(e){
        print(e.toString());
      }
    });

  }

  static Future<void> showNotification(RemoteMessage msg, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      msg.notification!.body!,
      htmlFormatBigText: true,
      contentTitle: msg.notification!.title!,
      htmlFormatContentTitle: true,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    'channel_id_1', 'dbfood', importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidNotificationDetails,
      iOS: const IOSNotificationDetails()
    );
    await fln.show(0, msg.notification!.title!, msg.notification!.body, platformChannelSpecifics);


  }
}