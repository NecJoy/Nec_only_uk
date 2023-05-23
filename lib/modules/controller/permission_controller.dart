import 'package:get/get.dart';

class PrivacyPermissionController extends GetxController {

  var checkedTermsCondition = false;

  void checkTermsCondition(val){
    checkedTermsCondition = val;
    update();
  }

}