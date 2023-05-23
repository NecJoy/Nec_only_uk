
// ignore_for_file: unused_field
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:necmoney/data/service/remitter_type.dart';

import '../../../core/utils/country_flag.dart';
import '../../../core/utils/keys.dart';
import '../../../core/utils/validator.dart';
import '../../../core/values/app_color.dart';
import '../../../core/values/strings.dart';
import '../../../data/model/country_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../modules/controller/sender_detials_controller.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dropdown_search_field.dart';
import '../../../widgets/custom_textfield.dart';
import '../../controller/signup_controller.dart';

class SignUpScreenOne extends StatelessWidget {
  SignUpScreenOne({Key? key}) : super(key: key);
  final formkey = GlobalKey<FormState>();
  final SignUpController _signUpController = Get.put(SignUpController());
  final SenderDetailsController _senderDetailsController = Get.put(SenderDetailsController());

  final ApiProvider _apiProvider = ApiProvider();
  final box = GetStorage();
  List countryList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: CustomAppBar(
        iconColor: AppColor.kGreenColor,
        backgroundColor: AppColor.kWhiteColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('letsGetStarted'.tr,style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(height: Get.height * 0.20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('sendingFrom'.tr,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: 4),
                        CustomDropdownScarchField<CountryModel>(
                          loadingBuilder:  (BuildContext context, s){
                            return Center(child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(color: AppColor.kPrimaryColor, backgroundColor: AppColor.kWhiteColor,),
                                SizedBox(height: 16,),
                                Text("Data Loading...")
                              ],
                            ));
                          },
                          showSearchBox: true,
                          searchhintText: "country".tr,
                          onFind: (filter) async{
                            if(countryList.isEmpty){
                              var getresponce = await http.get(Uri.parse("${Strings.baseUrl}" + "/" + "${Strings.countryUrl}"));
                              if (getresponce.statusCode == 200){
                                var responce = jsonDecode(getresponce.body);
                                for(var i in responce["countries"]){
                                countryList.add(i);
                                _signUpController.isoCode.add(i["isoCode"]);
                              }
                              }
                            }
                            var countries =  countryList.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                              return  countries.map((e){
                                return  CountryModel.fromJson(e);
                            }).toList();
                          },
                          itemAsString: (CountryModel? u)=>u!.name.toString(),
                          hintText: "selectFromCountry".tr,
                          validator: (CountryModel? value){
                            if(value == null){
                            return "fromCountryIsRequired".tr.toString();
                            }
                            return null;
                          },
                          onChanged: (CountryModel? countryModel){
                            box.write(Keys.registerCountry, countryModel!.countryId.toString());
                            _signUpController.countryId.value  = countryModel.countryId.toString();
                            _signUpController.countryFlag.value = countryflag.keys.contains("${countryModel.name}") == false ? countryflag["DEMO"] :  countryflag["${countryModel.name}"];
                            _signUpController.selectIsoCode.value = countryModel.isoCode.toString();
                             box.write(Keys.senderFromCountryId, countryModel.countryId.toString());
                             box.write(Keys.senderFromCountryName,countryModel.name.toString());
                             box.write(Keys.sendFromCountryCode, countryModel.codeName.toString());
                             box.write(Keys.callingCode, countryModel.callingCode);
                             box.write(Keys.remitterTypeId, RemitterTypesList["${countryModel.countryId}"]);
                            _senderDetailsController.senderFromCountryName.value = countryModel.name.toString();
                            _senderDetailsController.sendFromCountryCode.value = countryModel.codeName.toString();
                          },
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: AppColor.kWhiteColor,
                                radius: 10,
                                child: Obx(()=>
                                  ClipRRect(
                                    child: _signUpController.countryFlag.value.isNotEmpty ? SvgPicture.asset(_signUpController.countryFlag.value) : Icon(Icons.flag),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                              ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('firstNameOrGivenName'.tr,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 4),
                  CustomTextField(
                    controller: _signUpController.nameController,
                    hintText:"firstNameOrGivenName".tr,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_value)=>Validator.nameValidator(value: _value, data: "firstNameIsRequired".tr),
                  ),
                  SizedBox(height: 8),
                  Text('lastNameOrSureName'.tr,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 4),
                  CustomTextField(
                    controller: _signUpController.surNameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    hintText:"lastNameOrSureName".tr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_value)=>Validator.nameValidator(value: _value,data: "lastNameIsRequired".tr),
                  ),
                  SizedBox( height: Get.height * 0.10),
                  Column(
                    children: [
                      Row(
                        children: [
                          CustomButton(
                            buttonLevel: "continue".tr,
                            color: AppColor.kPrimaryColor,
                            onPressed: (){
                             if(formkey.currentState!.validate()){
                                formkey.currentState!.save();
                                Get.toNamed(Routes.SIGNUP_SCREEN_TWO);
                               
                             }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
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
        ),
      ),
    );
  }
}



