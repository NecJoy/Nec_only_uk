

import 'dart:convert';
import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/helpers.dart';
import 'package:necmoney/core/utils/keys.dart';
import 'package:necmoney/core/utils/log.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;


class VersionController extends GetxController {
var updateVersion = "".obs;
var clickUpdate = false.obs;
var updateLodder = "".obs;
var count = 0.obs;
void get getAppversion => _getAppversion();
var client = http.Client();
final GetStorage box = GetStorage();
//void get getRemoteConfigVersion => _getRemoteConfigVersion();

  Future<void> _getAppversion () async{
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    box.write(Keys.nowAppVersion, _packageInfo.version.toString());
  }

  Future _checkAppleStore({String? currentVersion, String? packageName}) async {
    var errorMsg = "";
    var uri = Uri.https("itunes.apple.com", "/lookup", {"bundleId": "$packageName"});
    try {
      final response = await http.get(uri);
      Logger(key: "APPVersion Url ", value: response.request);
      if (response.statusCode != 200) {
        errorMsg =  "Can't find an app in the Apple Store with the id: $packageName";
        Logger(key: "errorMsg", value: errorMsg);
      } else {
        final jsonObj = jsonDecode(response.body);
        final List results = jsonObj['results'];
        
        if (results.isEmpty) {
          errorMsg = "Can't find an app in the Apple Store with the id: $packageName";
          Logger(key: "errorMsg", value: errorMsg);
        } else {
          var newVersion = jsonObj['results'][0]['version'];
          var url = jsonObj['results'][0]['trackViewUrl'];
          if(newVersion.toString() != box.read(Keys.nowAppVersion).toString()){
            Helpers.launchURL(url.toString());
          }
          Logger(key: "newVersion ", value: "${newVersion}");
        }
      }
    } catch (e) {
      errorMsg = "$e";
    }
  }



  Future<void> getRemoteConfigVersion () async {
    if(Platform.isAndroid){
      FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
      _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(minutes: 1),
      minimumFetchInterval: Duration(minutes: 4),),);
      await _remoteConfig.fetchAndActivate();
      dynamic permission = _remoteConfig.getBool("permission");
      String version =  _remoteConfig.getString("androidUpdate");
      Logger(key: "version", value: version + "To" + box.read(Keys.nowAppVersion).toString());
      if(version.contains(box.read(Keys.nowAppVersion).toString()) != true && permission == true){
        Helpers.launchURL("https://play.google.com/store/apps/details?id=com.necmoney.necmoneyapp");
      }
    }else {
      _checkAppleStore(currentVersion: Keys.nowAppVersion, packageName: Keys.iosPackageName );
    }
  }

}



