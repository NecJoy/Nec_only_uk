import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/log.dart';
import 'package:necmoney/modules/controller/version_controller.dart';
import 'package:flutter/services.dart';

import '../../../app.dart';
import '../../../data/service/database_service.dart';
import '../../../data/service/download_service.dart';
import '../../../data/service/local_notification_service.dart';
import '../../../data/service/push_notification_service.dart';
import 'core/values/app_color.dart';


Future<void> main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await init();
  runApp(MyApp());
  configLoading();
  customStatusBar();
  _getFirebaseToKen();
}

// LocationService _locationService = LocationService();
PushNotificationService _pushNotificationService = PushNotificationService();
LocalNotificationService _localNotificationService = LocalNotificationService();
final VersionController _controller = Get.put(VersionController());

Future _getFirebaseToKen () async{
   final fcmToken = await FirebaseMessaging.instance.getToken();
   Logger(key: "_getFirebaseToKen", value: fcmToken.toString());
}
Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _pushNotificationService.backGroundHandeler;
  // Init pdf dounloader
  await FlutterDownloader.initialize(
    debug: DownloadService.debug 
    // set false to disable printing logs to console
  );
  FlutterDownloader.registerCallback(DownloadService.downloadCallback);
  
  //Init local database
  await GetStorage.init();

  //sqfLite Database init
  DataBaseService.instance.database;

  if (Platform.isIOS) {
    //IOS check permission
    _pushNotificationService.permission;

  }
  //app version get
  _controller.getAppversion;
  // Init notification service
  _pushNotificationService.getNotification;
  // _pushNotificationService.backGroundHandeler;
 // FirebaseMessaging.onBackgroundMessage((message) => _pushNotificationService.firebaseMessagingBackgroundHandler(message));
  // Init Local Notification
  _localNotificationService.initialize;
}


void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false ;
}


void customStatusBar(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: AppColor.kPrimaryColor, // status bar color
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light
  ));
}


