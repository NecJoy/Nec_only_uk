
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/session_timer.dart';
import 'package:necmoney/modules/controller/exchange_isocode_controller.dart';
import 'package:necmoney/modules/controller/get_remitter_controller.dart';
import 'package:necmoney/modules/controller/sender_detials_controller.dart';
import 'package:necmoney/modules/controller/version_controller.dart';




import '../../../data/model/signin_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../modules/controller/home_controller.dart';
import '../../../routes/routes.dart';
import '../../core/utils/helpers.dart';
import '../../core/utils/keys.dart';
import '../../core/values/strings.dart';
import '../../data/model/resend_activation_model.dart';
import '../../data/service/local_auth_service.dart';
import '../../data/service/remitter_type.dart';

class SignInController extends GetxController{

  var _apiProvider = ApiProvider();
  TextEditingController emailControlller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final HomeController _homeController = Get.put(HomeController());
  final ExchangeLCIsoCode _exchangeLCIsoCode =  Get.put(ExchangeLCIsoCode());
  final VersionController controller = Get.put(VersionController());
  final GetRemitterInfo _getRemitterInfo = Get.put(GetRemitterInfo());
  final SenderDetailsController  _senderDetailsController = Get.put(SenderDetailsController());
  final SessionTimerController _sessionTimerController = Get.put(SessionTimerController());
  var obscuredText = true.obs;
  final box = GetStorage();
  var tryCount = 0.obs;
  late final LocalAuthService  _localAuthService;
  bool logout = false;


  Future signIn({
    required SignInModel signInModel,
  })async{
    _apiProvider.postData(
      baseUrl: Strings.baseUrl, 
      url: Strings.loginUrl, 
      data: signInModel.toJson(),
    ).then((data) {
      SignInModel? signInModel;
      if(data != null){
        _sessionTimerController.checkSession = true;
        box.write(Keys.countryID, data["countryID"]);
        if(data['message'].toString().contains(Strings.unAssigned)){
          signInModel = SignInModel.fromJson(data["body"]);
        }else {
          signInModel = SignInModel.fromJson(data);
        }
        if(data["body"] != null && data['message'].toString().contains(Strings.unAssigned)){
          Get.offAllNamed(Routes.OTP_VERIFICATION_SCREEN);
          var resendActivationModel = ResendActivationModel(
            loginId: box.read(Keys.email),
            birthDate: DateTime.parse(box.read(Keys.userBirthDate))
          );
        _apiProvider.postData(
            baseUrl: Strings.baseUrl,
            url: Strings.resendActivationUrl,
            data: resendActivationModel.toJson(),
          );
        }
        if(data['message'].toString().contains(Strings.unAssigned) == false){
          box.write(Keys.token, data['sessionId']);
          box.write(Keys.loginId, data["loginID"]);
          box.write(Keys.bithDate, data["birthDate"]);
          box.write(Keys.userId, data["userID"]);
          box.write(Keys.userName, data["userName"]);
          if(signInModel.loginId  != null){
            if(data["remitterID"] == null){
              box.write(Keys.remitterTypeId, RemitterTypesList["${data["countryID"]}"]);
              box.write(Keys.registerCountry, data["countryID"].toString());
              box.write(Keys.name, data["name"]);
              box.write(Keys.email, data["email"]);
              box.write(Keys.exchangeId, data["exchangeID"]);
              box.write(Keys.userBirthDate, data["birthDate"].toString());
              box.write(Keys.phoneNumber, data["mobileNo"].toString().split("${box.read(Keys.callingCode)}").last);
              box.write(Keys.surName, data["surName"]);
              box.write(Keys.senderFromCountryId, data["countryID"]);
              box.write(Keys.remitterId, data["remitterID"]);
              _exchangeLCIsoCode.getexchangeCode();
              _senderDetailsController.senderDetailsPageController = PageController(viewportFraction: 1.0,initialPage: 0);
              Get.toNamed(Routes.BASE_NAV_LAYOUT);
            }else {
              box.write(Keys.remitterTypeId, RemitterTypesList["${data["countryID"]}"]);
              box.write(Keys.registerCountry, data["countryID"].toString());
              box.write(Keys.senderFromCountryId, data["countryID"]);
              box.write(Keys.clientID, data["clientID"]);
              box.write(Keys.remitterId, data["remitterID"]);
              box.write(Keys.countryID, data["countryID"]);
              _homeController.calculateLenght();
               _exchangeLCIsoCode.getexchangeCode();
               _getRemitterInfo.getRemitterDetailsForPayment(box.read(Keys.remitterId).toString());
              Get.toNamed(Routes.BASE_NAV_LAYOUT);
            }
          }
        }
      }
    });
  }


  Future loginWithBiometrics()async{
    if(Helpers.hasToken){
      _localAuthService.authenticateWithBiometrics();
    }else {
      Helpers.dengerAlert(title: "Login Error", message: "Please login with email and password in first time.");
    }
  }

  @override
  void onReady() {
    _localAuthService = LocalAuthService();
    super.onReady();
  }

@override
  void onInit() {
    emailControlller.text = box.read(Keys.email).toString() != "null" ? box.read(Keys.email) : "";
    passwordController.text = box.read(Keys.password).toString() != "null" ? box.read(Keys.password) : "";
    if(Helpers.hasToken) Future.delayed(Duration(milliseconds: 500)).then((value) => loginWithBiometrics());
    super.onInit();
  }

}

