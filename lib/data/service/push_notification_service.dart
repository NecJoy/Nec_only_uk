
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:necmoney/data/model/push_notification_model.dart';
import 'package:necmoney/data/service/database_service.dart';
import '../../data/service/local_notification_service.dart';
import '../../routes/routes.dart';




class PushNotificationService {
final List fcmMessage = [];
void get getNotification => _getNotification();
void get permission => _permission();
void get backGroundHandeler => _onBackGroundMassage;
Random _random  = Random();

 Future<void> _backgroundHandler(RemoteMessage message) async {
    print(message.data.toString());
    print(message.notification!.title);
 }

 Future _onBackGroundMassage()async{
  return FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
 }

  String? _getImageUrl(RemoteMessage message) {
    if (Platform.isIOS && message.notification!.apple != null) return message.notification!.apple?.imageUrl;
    if (Platform.isAndroid && message.notification!.android != null) return message.notification!.android?.imageUrl;
    return null;
  }

  Future<void> _getNotification()async{
    // This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          final storageMap = <String, dynamic>{};
          storageMap["id"] = _random.nextInt(1000);// For unique id 
          storageMap["title"] = message.notification!.title;
          storageMap["body"] = message.notification!.body;
          storageMap["sendTime"] = DateTime.now().toString();
          storageMap["imageUrl"] = _getImageUrl(message);
          DataBaseService.instance.addUnReadFCM(PushNotificationModel.fromJson(storageMap));
          Get.toNamed(Routes.NOTIFICATION_SCREEN);
        }
      },
    );



    // This method only  call when App in forground it mean app must be opened
  FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          final storageMap = <String, dynamic>{};
          storageMap["id"] = _random.nextInt(1000);// For unique id 
          storageMap["title"] = message.notification!.title;
          storageMap["body"] = message.notification!.body;
          storageMap["sendTime"] = DateTime.now().toString();
          storageMap["imageUrl"] = _getImageUrl(message);
          DataBaseService.instance.addUnReadFCM(PushNotificationModel.fromJson(storageMap));
          Get.toNamed(Routes.NOTIFICATION_SCREEN);
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
    
    // This method only call when App in background and not terminated(not closed)
  FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        final storageMap = <String, dynamic>{};
        storageMap["id"] = _random.nextInt(1000);// For unique id 
        storageMap["title"] = message.notification!.title;
        storageMap["body"] = message.notification!.body;
        storageMap["sendTime"] = DateTime.now().toString();
        storageMap["imageUrl"] = _getImageUrl(message);
        DataBaseService.instance.addUnReadFCM(PushNotificationModel.fromJson(storageMap));
        if (message.notification != null) {
          Get.toNamed(Routes.NOTIFICATION_SCREEN);
        }
      },
    );

}

Future<void> _permission() async {
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional) {
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // headsup notification in IOS
      badge: true,
      sound: true,
    );
  } else {
    //close the app
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

}

