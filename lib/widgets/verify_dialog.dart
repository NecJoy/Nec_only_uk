import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:get/get.dart';
import 'package:necmoney/modules/controller/signup_controller.dart';
import '../core/values/app_color.dart';


class VerifyDialog extends StatelessWidget {
  final VoidCallback? onActivationPressed;
  final VoidCallback? onResendActivationPressed;
  final Function(String)? onSubmit;
  VerifyDialog({
    Key? key, this.onActivationPressed, this.onResendActivationPressed, this.onSubmit
  }) : super(key: key);

  final SignUpController _signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))
      ),
      contentPadding: EdgeInsets.zero,
          content: Container(
            height: Get.height < 720 ? Get.height * 0.50 : Get.height * 0.40,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/icon/lock.png"),
                ),
                Text("verifyMobile".tr,style: Theme.of(context).textTheme.bodyMedium,),
                SizedBox(height: 4,),
                Text('enterTheCodeThatWeTextedTo'.tr,style: Theme.of(context).textTheme.bodyMedium,),
                SizedBox(height: 8,),
                Text("Number : ${_signUpController.phoneNumberController.text}",style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: 2,),
                Text("Email : ${_signUpController.emailController.text}",style: Theme.of(context).textTheme.titleSmall),
                Material(
                  child: OtpTextField(
                    numberOfFields: 4,
                    autoFocus: true,
                    borderColor: AppColor.kGreenColor,
                    focusedBorderColor: AppColor.kGreenColor,
                    showFieldAsBox: false,
                    borderWidth: 2.0,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                    },
                    //runs when every textfield is filled 
                    onSubmit: onSubmit,
                  ),
                ),
                SizedBox(height: 8,),
                Divider(
                  height: 0,
                  thickness: 0.5,
                  color: AppColor.kGreyColor,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: onActivationPressed,
                        child: Text('Activate account', style: TextStyle(color: Color.fromARGB(255, 112, 91, 91)),)
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 0,
                  thickness: 0.5,
                  color: AppColor.kGreyColor,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: onResendActivationPressed,
                        child: Text('resendTheCode'.tr, style: TextStyle(color: AppColor.kGreyColor),)
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
    );
  }
}
