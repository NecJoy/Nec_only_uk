import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:necmoney/modules/controller/reset_password_controller.dart';
import 'package:necmoney/modules/controller/signup_controller.dart';
import 'package:sizer/sizer.dart';
import '../../../core/utils/validator.dart';
import '../../../core/values/app_color.dart';
import '../../../data/model/reset_password_model.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/date_picker.dart';


class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({ Key? key }) : super(key: key);
  final ResetPasswordController _resetPasswordController = Get.put(ResetPasswordController());
  final SignUpController _signUpController = Get.put(SignUpController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: CustomAppBar(title: 'resetPassword'.tr,),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("pleaseEnterYourLoginEmail".tr,style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 32),
            Text( "email".tr,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium), 
            SizedBox(height: 8),
            CustomTextField(
              autofocus: true,
              controller: _resetPasswordController.emailControlller,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validator.emailValidator(value!),
              hintText: "enterYourEmail".tr,
            ),
            SizedBox(height: 8),
            Text( "dateofbirth".tr,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 8), 
            GestureDetector(
              onTap: (){
              DatePicker.datePiker(
                minimumYear: 1900,
                  context: context,
                  initialDateTime: DateTime(DateTime.now().year - 18),
                  onDateTimeChanged: (value)=> _signUpController.getDateofBirth(value),
                  maximumYear: DateTime(DateTime.now().year - 18).year,
                  onPressed: (){
                    Get.back();
                  }
                );
              },
              child: Obx(()=>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColor.kSeaGreenColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1,  color: _signUpController.birthdateValidator.value.isEmpty ? AppColor.kSecondaryColor : AppColor.kGreenColor),
                      ),
                      child: Center(
                        child: _signUpController.birthdatePiked.isNotEmpty ? Text('${DateFormat('dd/MM/yyyy').format(DateTime.parse(_signUpController.birthdatePiked.value))}',
                          style: Theme.of(context).textTheme.titleMedium,
                          ): Text('DD / MM / YYYY',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                    SizedBox( height: 8),
                    _signUpController.birthdateValidator.value.isEmpty ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "dateOfBirthIsRequired".tr,
                        style: TextStyle(color: AppColor.kSecondaryColor,fontSize: 10.sp),
                      ),
                    ): SizedBox(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                CustomButton(
                  buttonLevel: 'resetPassword'.tr,
                  color: AppColor.kPrimaryColor,
                  onPressed:  _signUpController.birthdatePiked.isNotEmpty && _resetPasswordController.emailControlller.text.isNotEmpty ? (){
                    final resetPasswordModel = ResetPasswordModel(
                      loginId: _resetPasswordController.emailControlller.text,
                      birthDate: DateTime.parse(_signUpController.birthdatePiked.value),
                    );
                    _resetPasswordController.resetPassword(resetPasswordModel);
                  } : null,
                ),
             ],
            ),
          ],
        ),
      ),
    );
  }
}



