import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/utils/keys.dart';
import '../../../data/model/resend_activation_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../modules/controller/otp_controller.dart';
import '../../../routes/routes.dart';
import '../../core/utils/country_flag.dart';
import '../../core/utils/helpers.dart';
import '../../core/values/strings.dart';
import '../../data/model/signup_model.dart';

class SignUpController extends GetxController{
    final _apiProvider = ApiProvider();
    OTPController _otpController = Get.put(OTPController());
    var formKey = GlobalKey<FormState>();
    var checkedTermsCondition = false;
    var otp = "".obs;
    var clientId = false.obs;
    var countryId = "".obs;
    var birthdatePiked = "".obs;
    var isoCode = <String>[].obs;
    var isoCountryCode = "".obs;
    var countryName = "".obs;
    var userCountry = "".obs;
    var fromCountries = [].obs;   
    var birthdateValidator = "dd/MM/yyyy".obs;
    var callingCode = "".obs; 
    var countryFlag = "".obs;
    var selectedCountryIndex = 0.obs;
    var selectIsoCode = "".obs;
    var onChangeValue = "".obs;
    var newPasswordObscureText = true.obs;
    var confirmPasswordObscureText = true.obs;
    var nameController = TextEditingController();
    var surNameController = TextEditingController();
    var phoneNumberController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController().obs;
    var clientIdController = TextEditingController();
    var userId = "".obs;
    var confiromPasswordController  = TextEditingController();
    final box = GetStorage();


  Future signUp (SignUpModel signuUpModel) async{
    _apiProvider.postData(
      baseUrl: Strings.baseUrl,
      url: Strings.registerUrl,
      data: signuUpModel.toJson(),
    ).then((data){
      
      box.remove(Keys.clientID);
      if(data != null){
        SignUpModel? signUp;
        if(data["returnStatus"] == false){
          signUp = SignUpModel.fromJson(data["body"]);
        }else {
          signUp = SignUpModel.fromJson(data);
        }
        box.write(Keys.name, signUp.name);
        box.write(Keys.email, signUp.email);
        box.write(Keys.userBirthDate, signUp.birthDate.toString());
        box.write(Keys.phoneNumber, signUp.mobileNo);
        box.write(Keys.surName, signUp.surName);
        if((signUp.email != null && signUp.mobileNo != null) || data["returnStatus"] == false){
          if(data["message"].toString().split(",")[0].contains(Strings.activated)){
            Helpers.showSnackBar(message: data["message"].toString().split(",")[1], title: data["message"].toString().split(",")[0]);
            Get.offAllNamed(Routes.SIGNIN_SCREEN);
          }
          if(!data["message"].toString().split(",")[0].contains(Strings.activated)){
            if(data["returnStatus"] == false){
              Future.delayed(Duration(milliseconds: 700)).then((value){
                var resendActivationModel = ResendActivationModel(
                  loginId: box.read(Keys.email),
                  birthDate: DateTime.parse(box.read(Keys.userBirthDate))
                );
                _otpController.resendActivation(resendActivationModel);
              });
            }
            Get.offAndToNamed(Routes.OTP_VERIFICATION_SCREEN);
          }
        }
      }
    });
  }


 String showPhoneNumberFieldLabel(_countryCode){
   switch(_countryCode) { 
      case "+44": {
        return "7123456789";
      } 
      case "+1": {
        return "6135550172";
      } 
      
      case "+39": {
         return "3399957495";
      } 
      default: {
        return "01NNNNNNNN";
      } 
   } 

  }


  String diplayHintText(){
    String? hintText =  countryName.value;
    if(countryflag.containsKey(hintText.toUpperCase()) && countryName.isNotEmpty){
     return hintText;
    }else{
     return "Select from country";
    }
  }


  // Future getFromCountry()async{
  //   var response = await _apiProvider.getData(
  //     baseUrl: Strings.baseUrl, 
  //     url: Strings.countryUrl
  //   );
  //   var data = response;
  //   if(data != null){
  //     for (var country in data["countries"]) {
  //       fromCountries.add(CountryModel.fromJson(country));
  //     }
  //   }
  // }


  void checkTermsCondition(val){
    checkedTermsCondition = val;
    update();
  }

  void clientIdNEC(val){
    clientId.value = val;
    print("DATA$clientId");
    update();
  }


  Future getDateofBirth(data)async{
    birthdatePiked.value =  data.toString(); // DateFormat('dd/MM/yyyy').format(data);
    if(birthdatePiked.value.isNotEmpty) {
      birthdateValidator.value  =birthdatePiked.value;
    }
  }





  var pageController = PageController().obs;
  RxInt indexnumber = 0.obs;
  void NavigateSteep(){
    pageController.value.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn
    );

  }


  // @override
  // void onReady() {
  //   getFromCountry();
  //   super.onReady();
  // }
  
}

