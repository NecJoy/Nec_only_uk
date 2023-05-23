import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import './../../core/values/strings.dart';
import './../../data/model/update_password_model.dart';
import './../../data/provider/api_provider.dart';
import './../../routes/routes.dart';
import '../../core/utils/helpers.dart';

class UpdatePasswordController extends GetxController{
  final formmKey = GlobalKey<FormState>();
  final _apiService = ApiProvider();
  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var currentobscureText = true.obs;
  var newobscureText = true.obs;
  var confirmobscureText = true.obs;
  final box = GetStorage();
  
  Future updatePassword(UpdateMPasswordModel updateMPasswordModel)async{
    _apiService.postData(
      baseUrl: Strings.baseUrl, 
      url: Strings.updatePasswordUrl, 
      data: updateMPasswordModel.toJson()
    ).then((data){
      if(data != null){
        Helpers.showSnackBar(title: "Password Change", message: "${data["returnMessage"][0]}");
        Get.offAndToNamed(Routes.SIGNIN_SCREEN);
      }
    });
  }



}