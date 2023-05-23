

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/helpers.dart';
import '../../../core/utils/keys.dart';
import '../../../core/utils/validator.dart';
import '../../../core/values/app_color.dart';
import '../../../data/model/signup_model.dart';
import '../../../modules/controller/signup_controller.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_phone_number_field.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/date_picker.dart';

class SignUpScreenTwo extends StatelessWidget {

  final SignUpController _signUpController = Get.put(SignUpController());
  final box = GetStorage();
  
 
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: CustomAppBar(
        backgroundColor: AppColor.kWhiteColor,
        iconColor: AppColor.kGreenColor,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _signUpController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('phoneNumber'.tr,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: 8),
                      CustomPhoneNumberField(                     
                        autofocus: false,
                        flag: _signUpController.countryFlag.value,
                        hintText: "enterYourNumber".tr,
                        onChanged: (data){
                          _signUpController.phoneNumberController.text = data.number;
                          //_signUpController.callingCode.value = data.countryCode;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          LengthLimitingTextInputFormatter(15),
                          //   MaskTextInputFormatter(
                          //   mask: '#### ######', 
                          //   //filter: { "#": RegExp(r'[0-9]') },
                          //   type: MaskAutoCompletionType.lazy
                          // ),
                          // if(box.read(Keys.callingCode).toString() == "+44")...[
                          //    FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                          // ]
                            
                        ],
                        countryIsoCode: _signUpController.isoCode,
                        initialCountryCode: _signUpController.selectIsoCode.value,
                        label: Text(_signUpController.showPhoneNumberFieldLabel(box.read(Keys.callingCode))),
                      ),
                      SizedBox(height: 5,),
                      Text('emailAddress'.tr,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: 8),         
                      CustomTextField(
                        controller: _signUpController.emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value)=> Validator.emailValidator(value),
                        hintText: 'emailAddress'.tr,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 8,),
                      Text('newPassword'.tr,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: 4),         
                      Obx(()=> CustomTextField(
                          controller: _signUpController.passwordController.value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(8),
                          ],
                          hintText: 'newPassword'.tr,
                          validator: (value)=> Validator.passwordValidator(value),
                          keyboardType: TextInputType.emailAddress,
                          obscureText: _signUpController.newPasswordObscureText.value,
                          onChanged: (_value){
                            box.write(Keys.password, _value);
                          },
                          suffixIcon: GestureDetector(
                            onTap: (){
                              _signUpController.newPasswordObscureText.value = !_signUpController.newPasswordObscureText.value;
                            },
                            child: Icon( _signUpController.newPasswordObscureText.value ? Icons.visibility_off:Icons.visibility, color: AppColor.kBlackColor,),
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text('confirmPassword'.tr,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: 4),         
                      Obx(()=> CustomTextField(
                        hintText: 'confirmPassword'.tr,
                        controller:_signUpController.confiromPasswordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8),
                        ],
                        validator: (value)=> Validator.confirmPasswordValidator(value,_signUpController.passwordController.value.text, _signUpController.confiromPasswordController.text),
                    
                        keyboardType: TextInputType.emailAddress,
                        obscureText: _signUpController.confirmPasswordObscureText.value,
                        suffixIcon: GestureDetector(
                          onTap: (){
                            _signUpController.confirmPasswordObscureText.value = !_signUpController.confirmPasswordObscureText.value;
                          },
                          child: Icon( _signUpController.confirmPasswordObscureText.value ? Icons.visibility_off : Icons.visibility, color: AppColor.kBlackColor,),
                          ),
                      ),
                      ),
                      SizedBox(height: 8,),
                      Text( "dateOfBirth".tr,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: 4), 
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
                              // FocusScope.of(context).unfocus();
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
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<SignUpController>(
                    builder: (_){
                      return Checkbox(
                      activeColor: AppColor.kPrimaryColor,
                      value: _signUpController.checkedTermsCondition,
                      onChanged: (newValue){
                        _signUpController.checkTermsCondition(newValue);
                        if(_signUpController.checkedTermsCondition){
                          FocusScope.of(context).unfocus();
                        }
                      }
                    );
                   }
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'iAcecpetThe'.tr, style: Theme.of(context).textTheme.bodyMedium),
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Get.toNamed(Routes.TERMS_CONDITIONS);
                            },
                            text: 'termsAndCondition'.tr,
                            style: TextStyle(
                              fontSize:12.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.kBlueColor
                              ),
                          ),
                          TextSpan(text:'and'.tr),
                          TextSpan(
                             recognizer: TapGestureRecognizer()..onTap = () {
                              Get.toNamed(Routes.PRIVACY_POLICY_SCREEN);
                            },
                            text: 'privecyPolicy'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.kBlueColor,
                              fontSize:12.sp,
                            ),
                          ),
                          TextSpan(text: 'findOutNewService'.tr,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  CustomButton(
                      buttonLevel: 'continue'.tr,
                      color: AppColor.kPrimaryColor,
                      onPressed: (){
                        _signUpController.birthdateValidator.value = _signUpController.birthdatePiked.value;
                        if(_signUpController.formKey.currentState!.validate()){
                          _signUpController.formKey.currentState!.save();
                          if(_signUpController.checkedTermsCondition == false){
                            Helpers.dengerAlert(
                              title : "tremsandCondition".tr, 
                              message: "pleaseAcceptedTheTremsAndCondition".tr
                            );
                            return;
                          }
                          final _signUp = SignUpModel(
                            loginId: _signUpController.emailController.text,
                            name: _signUpController.nameController.text,
                            surName: _signUpController.surNameController.text,
                            birthDate: DateTime.parse(_signUpController.birthdatePiked.value),
                            email: _signUpController.emailController.text,
                            mobileNo: _signUpController.phoneNumberController.text,
                            callingCode:  box.read(Keys.callingCode),
                            phoneNoFormat: null,
                            hasClientId: _signUpController.clientId.value,
                            clientId: _signUpController.clientIdController.text,
                            password: _signUpController.passwordController.value.text,
                            confirmPassword: _signUpController.confiromPasswordController.text,
                            countryId: int.parse(_signUpController.countryId.value),
                            allowNotification: true,
                          );
                          _signUpController.signUp(_signUp);
                        }
                      },
                    ),
                  ],
                ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('alreadyHaveAnAccount'.tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: (){
                      Get.toNamed(Routes.SIGNIN_SCREEN);
                    }, 
                    child: Text('logIn'.tr, style: Theme.of(context).textTheme.headlineSmall),
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
