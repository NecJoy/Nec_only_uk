

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/log.dart';
import 'package:necmoney/core/utils/session_timer.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/helpers.dart';
import '../../../core/utils/keys.dart';
import '../../../core/utils/validator.dart';
import '../../../core/values/app_color.dart';
import '../../../data/model/signin_model.dart';
import '../../../modules/controller/signin_controller.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({
    Key? key,
  }) : super(key: key);

  final SignInController _signInController = Get.put(SignInController());
  final SessionTimerController _sessionTimerController = Get.put(SessionTimerController());

  final _formKey = GlobalKey<FormState>();

  final box = GetStorage();
 
  
  @override
  Widget build(BuildContext context) {
    _sessionTimerController.checkSession = false;
    return WillPopScope(
      onWillPop: () async {
        if (_signInController.logout) {
          await SystemNavigator.pop();
          return false;
        }
        return true;
      },  
      child: Scaffold(
        backgroundColor: AppColor.kWhiteColor,
        // appBar: _signInController.logout == true ? AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: AppColor.kWhiteColor,
        //   elevation: 0,
        // ) : CustomAppBar(
        //   backgroundColor: AppColor.kWhiteColor,
        //   iconColor: AppColor.kPrimaryColor,
        // ),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Helpers.hasToken ? SizedBox(height: 34 ) : SizedBox(),
                        Text("welcomeback".tr,style: Theme.of(context).textTheme.headlineMedium,),
                        Helpers.hasToken ? SizedBox(height: Get.width * 0.30) : SizedBox( height: Get.width * 0.15),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _signInController.emailControlller,
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                level: "email".tr,
                                //autofillHints: [AutofillHints.email],
                                validator: (value) => Validator.emailValidator(value!),
                                hintText: "enterYourEmail".tr,
                              ),
                              SizedBox(height: 16,),
                              Obx(() => CustomTextField(
                                controller: _signInController.passwordController,
                                obscureText: _signInController.obscuredText.value,
                                keyboardType: TextInputType.text,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                level: "password".tr,
                                //autofillHints: [AutofillHints.password],
                                validator: (value) => Validator.signInPasswordFieldValidator(value!),
                                hintText: "enterYourPassword".tr,
                                onChanged: (_value){
                                  box.write(Keys.password, _value);
                                },
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _signInController.obscuredText.value =  !_signInController.obscuredText.value;
                                  },
                                  child: Icon(
                                    _signInController.obscuredText.value ? Icons.visibility_off : Icons.visibility,
                                    color: AppColor.kGreyColor,
                                  ),
                                ),
                               ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.FORGOT_PASSWORD);
                                  },
                                  child: Text(
                                    'forgotPassword'.tr,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16,),
                              Row(
                                children: [
                                  CustomButton(
                                    buttonLevel: "logIn".tr,
                                    color: AppColor.kPrimaryColor,
                                    onPressed: () async {
                                      final _signInModel = SignInModel(
                                        loginId: _signInController.emailControlller.text,
                                        password: _signInController.passwordController.value.text,
                                        tryCount: _signInController.tryCount.value +=1,
                                      );
                                      if(_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        box.write(Keys.password, _signInController.passwordController.text);
                                        box.write(Keys.email,  _signInController.emailControlller.text);
                                        _signInController.signIn(signInModel: _signInModel);
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Column(
                               children: [
                                SizedBox(
                                  height: 32,
                                ),
                                Text(
                                  'logInWithBiometrics'.tr,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(height: 16),
                                InkWell(
                                  onTap: () {
                                    _signInController.loginWithBiometrics();
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/logo/biometric_icon.png",
                                    width: 20.w,
                                    height: 10.h,
                                  ),
                                ),
                               ]
                              ),
                              SizedBox(height: 32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'dontHaveAnAccount'.tr, style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.SIGNUP_SCREEN_ONE);
                                    },
                                    child: Text('createAccount'.tr, style: Theme.of(context).textTheme.headlineSmall),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}


