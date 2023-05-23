import 'package:get/get.dart';
class Validator{

  static String? passwordValidator(value){
    if(value!.isEmpty){
      return 'passwordIsRequired'.tr;
    }else if(value.length <= 3){
      return '''passwordMustConsistof4Characters'''.tr;
    }
    return null;
  }


  static String? signInPasswordFieldValidator(value){
    if(value!.isEmpty){
      return 'passwordIsRequired'.tr;
    }
    return null;
  }


  static String? confirmPasswordValidator(value, password, confrimPassword ){
    if(value!.isEmpty){
      return 'confrimPasswordIsRequired'.tr;
    }else if(password != confrimPassword){
      return "yourPasswordNotMatch".tr;
    }
    return null;
  }


  static String? emailValidator(value){
    if(value!.isEmpty){
      return 'emailIsRequired'.tr;
    }else if(!GetUtils.isEmail(value)){
      return 'emailisNotValid'.tr;
    }
    return null;
  }

  static  nameValidator ({required dynamic  value, required String data}){
    if(value!.isEmpty){
      return data;
    }else if(RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)){
      return "pleaseEnterValidName".tr;
    }else{
      return null;
    }
  }

  static  countryValidator ({required dynamic  value, required String data}){
    if(value!.isEmpty){
      return data;
    }else if(RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)){
      return "pleaseSelectSendignFromCounrty".tr;
    }else{
      return null;
    }
  }
  static  professionValidator (value ){
    if(value!.isEmpty){
      return 'professionIsRequired'.tr;
    }else{
      return null;
    }
  }
  static  validatorRetrun ({required dynamic value, required String? errorText } ){
    if(value!.isEmpty){
      return '$errorText is required'.tr;
    }else{
      return null;
    }
  }
  static  textAreaValidator ({required dynamic value, required String? errorText }){
    if(value!.isEmpty){
      return '$errorText is required'.tr;
    }else{
      return null;
    }
  }

  static dropdownSearchValidator({dynamic value, required String selectedValue, required String errorMessage }){
    if(value!.isEmpty){
      return errorMessage;
    }else if(value == selectedValue){
      return errorMessage;
    }else{
      return null;
    }
  }

  static addressValidator(value,{String? data}){
    if(value!.isEmpty){
      return data;
    }else{
      return null;
    }

  }

  static phonenumberValidator ({required dynamic value , required String data}){
    if(value!.isEmpty){
      return data;
    }else{
      return null;
    }

  }

  static checkRateValidator ({required dynamic value ,required String? data}){
    if(value!.isEmpty){
      return data;
    }else{
      return null;
    }
  }
}


