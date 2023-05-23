import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/utils/helpers.dart';
import '../../../core/utils/keys.dart';
import '../../../core/values/app_color.dart';
import '../../../data/model/activation_model.dart';
import '../../../data/model/resend_activation_model.dart';
import '../../../modules/controller/otp_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/otp_screen_custom_shape.dart';

class OTPVerificationScreen extends StatelessWidget {
  final Function(String)? onSubmit;
  OTPVerificationScreen({Key? key ,this.onSubmit}) : super(key: key);
  final OTPController _otpController = Get.put(OTPController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.kWhiteColor,
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                     children: [
                        CustomPaint(
                          size: Size(Get.width, (Get.width * 0.6).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                          painter: RPSCustomPainter(),
                        ),
                        Positioned(
                          top: 40,
                          bottom: 20,
                          left: 15,
                          right: 15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "oTPVerification".tr,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 97, 74, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              SizedBox(height: 8,),
                              Expanded(
                                child: Text(
                                  "pleaseInputYourVerifiation".tr,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 48, 39, 17),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                     ],
                  ),
                ),
                Get.height <= 680 ? Container() : Expanded(
                  child: SvgPicture.asset("assets/logo/icon_image.svg",width: 200),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("alreadySendYouOneTimePasswordThis".tr + " ${box.read(Keys.email) == null ? box.read(Keys.loginId) : box.read(Keys.email)} " + "emailAndThis".tr + " ${box.read(Keys.phoneNumber)} " + "phone",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16,),
                      Material(
                        color: AppColor.kWhiteColor,
                        child: OtpTextField(
                          numberOfFields: 4,
                          autoFocus: true,
                          borderColor: AppColor.kGreenColor,
                          focusedBorderColor: AppColor.kGreenColor,
                          showFieldAsBox: true,
                          borderWidth: 2.0,
                          borderRadius: BorderRadius.circular(8),
                          filled: true,
                          fieldWidth: 50,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onCodeChanged: (String code) { 
                          },
                          onSubmit: (String verificationCode){
                            if(verificationCode.length < 4){
                              Helpers.dengerAlert(title: "error".tr, message: "invalidField".tr);
                            }else {
                            var activationModel = ActivationModel(
                              loginId: box.read(Keys.email),
                              birthDate: DateTime.parse(box.read(Keys.userBirthDate)),
                              authCode: verificationCode,
                            );
                            _otpController.accountActivation(activationModel); 
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 24,),
                      Row(
                        children: [
                          CustomButton(
                            buttonLevel: "resend".tr,
                            onPressed: (){
                              var resendActivationModel = ResendActivationModel(
                                loginId: box.read(Keys.email),
                                birthDate: DateTime.parse(box.read(Keys.userBirthDate))
                              );
                              _otpController.resendActivation(resendActivationModel);
                            },
                            color: AppColor.kGreenColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 16,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


