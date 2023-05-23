import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/keys.dart';
import '../../../core/values/app_color.dart';
import '../../../widgets/custom_button.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/validator.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../controller/sender_detials_controller.dart';


class SenderDetailsScreenTwo extends StatelessWidget {
  final SenderDetailsController  _senderDetailsController = Get.put(SenderDetailsController());
  final box = GetStorage();
  SenderDetailsScreenTwo({Key? key}) : super(key: key);
  final _formKey =  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child:Column(
                children: [
                      SizedBox(height: 16,),
                      CustomTextField(
                        controller: _senderDetailsController.PhoneNumberController,
                        level: "phoneNumber".tr,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value)=>Validator.phonenumberValidator(value: value, data: "fieldIsRequired".tr),
                      ),
                      SizedBox(height: 16,),
                      CustomTextField(
                        controller: _senderDetailsController.emailController,
                        level: "emailAddress".tr,
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value)=>Validator.emailValidator(value),
                      ),
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('dateofbirth'.tr,style: Theme.of(context).textTheme.titleLarge),
                          SizedBox(height: 8),
                          Obx(()=>
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                Container(
                                  width: Get.width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColor.kSeaGreenColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(width: 1,  color: _senderDetailsController.birthdateValidator.value.isEmpty ? AppColor.kSecondaryColor : AppColor.kGreenColor),
                                  ),
                                  child: Center(
                                    child: _senderDetailsController.birthdatePiked.isNotEmpty ? Text('${DateFormat('dd/MM/yyyy').format(DateTime.parse(_senderDetailsController.birthdatePiked.value))}',
                                      style: Theme.of(context).textTheme.titleMedium,
                                      ) : Text('DD / MM / YYYY',
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ),
                                ),
                               ],
                             ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16,),
                      box.read(Keys.registerCountry) == Keys.italy ? CustomTextField(
                          controller: _senderDetailsController.fiscalCodeController,
                          level: "fiscalCode".tr,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value)=>Validator.validatorRetrun(value: value, errorText: "fiscalCode".tr),
                      ) : SizedBox(),
                      SizedBox(height: 16,),
                    Row(
                    children: [
                      CustomButton(
                        buttonLevel: "continue".tr,
                        onPressed: (){
                          Helpers.keyboardhide();
                          _senderDetailsController.birthdateValidator.value  = _senderDetailsController.birthdatePiked.value;
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();
                            _senderDetailsController.NavigateSteep();
                          }
                        },
                        color: AppColor.kGreenColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

