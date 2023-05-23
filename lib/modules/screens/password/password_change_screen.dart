
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/widgets/custom_appbar.dart';
import 'package:necmoney/widgets/custom_button.dart';

import '../../../core/utils/helpers.dart';
import '../../../core/utils/validator.dart';
import '../../../core/values/app_color.dart';
import '../../../data/model/update_password_model.dart';
import '../../../widgets/custom_textfield.dart';
import '../../controller/update_password_controller.dart';
class UpdatePasswordScreen extends StatelessWidget {
  final UpdatePasswordController _updatePasswordController = Get.put(UpdatePasswordController());
  final box = GetStorage();
 UpdatePasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // _updatePasswordController.currentPasswordController.text = box.read(Keys.password).toString() != "null" ? box.read(Keys.password) : "";
    return Scaffold(
    appBar: CustomAppBar(
      title: "Change Password",
      backgroundColor: AppColor.kPrimaryColor,
    ),
      body: SafeArea(
        minimum: EdgeInsets.all(15),
        child: Form(
          key: _updatePasswordController.formmKey,
          child: Column(
            children: [
              Obx(()=>CustomTextField(
                  autofocus: true,
                  controller: _updatePasswordController.currentPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => Validator.passwordValidator(value),
                  hintText: "Current password".tr,
                  level:"Current password",
                  obscureText: _updatePasswordController.currentobscureText.value,
                    suffixIcon: GestureDetector(
                      onTap: () {
                       _updatePasswordController.currentobscureText.value =! _updatePasswordController.currentobscureText.value;
                      },
                      child: Icon(
                        _updatePasswordController.currentobscureText.value ? Icons.visibility_off : Icons.visibility,
                        color: AppColor.kGreyColor,
                      ),
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Obx(()=> CustomTextField(
                  autofocus: true,
                  controller: _updatePasswordController.newPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => Validator.passwordValidator(value),
                  hintText: "New password".tr,
                  level: "New password",
                  obscureText: _updatePasswordController.newobscureText.value,
                  suffixIcon: GestureDetector(
                    onTap: () {
                     _updatePasswordController.newobscureText.value =! _updatePasswordController.newobscureText.value;
                    },
                    child: Icon(
                      _updatePasswordController.newobscureText.value ? Icons.visibility_off : Icons.visibility,
                      color: AppColor.kGreyColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Obx(()=> CustomTextField(
                  autofocus: true,
                  controller: _updatePasswordController.confirmPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value)=> Validator.confirmPasswordValidator(value, _updatePasswordController.newPasswordController.value.text, _updatePasswordController.confirmPasswordController.value.text),
                  hintText: "Confirm password".tr,
                  level: "Confirm password",
                  obscureText: _updatePasswordController.confirmobscureText.value,
                    suffixIcon: GestureDetector(
                      onTap: () {
                       _updatePasswordController.confirmobscureText.value =! _updatePasswordController.confirmobscureText.value;
                      },
                      child: Icon(
                        _updatePasswordController.confirmobscureText.value ? Icons.visibility_off : Icons.visibility,
                        color: AppColor.kGreyColor,
                      ),
                    ),
                ),
              ),
              SizedBox(height: 16,),
              Row(
                  children: [
                    CustomButton(
                      buttonLevel: 'resetPassword'.tr,
                      color: AppColor.kPrimaryColor,
                      onPressed: (){
                        if(_updatePasswordController.formmKey.currentState!.validate()){
                            _updatePasswordController.formmKey.currentState!.save();
                            if(_updatePasswordController.currentPasswordController.text == _updatePasswordController.confirmPasswordController.text){
                              Helpers.dengerAlert(title: "Password Change", message: "Please enter new password");
                            }else{
                              final updateMPasswordModel = UpdateMPasswordModel(
                                oldPassword:  _updatePasswordController.currentPasswordController.value.text,
                                password: _updatePasswordController.newPasswordController.value.text,
                                confirmPassword: _updatePasswordController.confirmPasswordController.value.text
                              );
                              _updatePasswordController.updatePassword(updateMPasswordModel);
                            }
                        }
                      },
                    ),
                 ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
