
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necmoney/core/utils/helpers.dart';
import '../../../core/values/strings.dart';
import '../../../data/model/reset_password_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../routes/routes.dart';

class ResetPasswordController extends GetxController{
  final _apiProvider = ApiProvider();
  
  final TextEditingController emailControlller = TextEditingController();

  Future resetPassword(ResetPasswordModel resetPasswordModel)async{
    _apiProvider.postData(
      baseUrl: Strings.baseUrl, 
      url: Strings.resetPasswordUrl, 
      data: resetPasswordModel.toJson()
    ).then((data){
      if(data != null){
        Helpers.showSnackBar(
          title: "Success",
          message: "Password was sent to your  email"
        );
        Future.delayed(Duration(milliseconds: 400)).then((value){
          Get.toNamed(Routes.SIGNIN_SCREEN);
        });
      }
    });
  }


  
}