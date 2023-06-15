
// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/session_timer.dart';
import 'package:necmoney/core/values/strings.dart';
import 'package:necmoney/data/provider/api_provider.dart';
import 'package:necmoney/modules/controller/version_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../core/languages/translation.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/keys.dart';
import '../../../routes/pages.dart';
import '../../../routes/routes.dart';
import 'core/utils/log.dart';

class MyApp extends StatefulWidget {
 MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final box = GetStorage();
  final VersionController _versionController = Get.put(VersionController());
  final SessionTimerController _sessionTimerController = Get.put(SessionTimerController());
  ApiProvider _apiProvider = ApiProvider();

    @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(_sessionTimerController.checkSession == true){
       if(state == AppLifecycleState.resumed){
         _apiProvider.getData(baseUrl: Strings.baseUrl , url: Strings.displayRateUrl);
       }
      //Logger(key: "App State", value: state);
    }
    // Logger(key: "_sessionTimerController.checkSession", value: _sessionTimerController.checkSession );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType){
        return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nec Moeny',
        locale: Get.deviceLocale,
        translations: AppTranslations(),
        fallbackLocale: Locale('en', 'UK'), 
        theme:AppTheme.lighTheme(),
        builder: EasyLoading.init(),
        initialRoute: GetStorage().read(Keys.token) != null ? Routes.SIGNIN_SCREEN  :  box.read(Keys.checkBoxVelue).toString() != "agree" ? Routes.PRIVACY_PERMISSION : Routes.ONBOARD_SCREEN,
        getPages: AppScreens.screens,
        onInit: (){
          _versionController.getRemoteConfigVersion();
        },
       );
      },
    );
  }
}






