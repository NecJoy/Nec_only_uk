

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:get/get.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:necmoney/core/utils/keys.dart';
import 'package:necmoney/data/model/signin_model.dart';
import 'package:open_settings/open_settings.dart';
import '../../modules/controller/signin_controller.dart';
import '../../core/utils/log.dart';

class LocalAuthService {
  static final _auth = LocalAuthentication();
  final SignInController _signInController = Get.put(SignInController(), tag: "LocalService");
  final box = GetStorage();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (err) {
     // Logger(key: "Get biometric type", value: err);
      return <BiometricType>[];
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    final isAvailable = await hasBiometrics();
    bool authenticated = false;
    //Logger(key: "Device feature Availablity", value: isAvailable);
    if (!isAvailable){
      Get.snackbar("Local authenticate", "Sorry! This feature is not available in your device");
     return false;
    }

    try {
      authenticated =  await _auth.authenticate(
        localizedReason: 'Scan Biometrics to Authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true
      );
      if(authenticated){
        final signInModel = SignInModel(
          loginId: box.read(Keys.loginId),
          password: box.read(Keys.password),
          tryCount: _signInController.tryCount.value +=1,
        );
        _signInController.signIn(signInModel: signInModel);
      }
      return authenticated;

    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable || e.code == auth_error.notEnrolled) {
        //Logger(key: "local auth error", value: e.code);
        OpenSettings.openMainSetting();
      }
      return false;
    }
  }
} 