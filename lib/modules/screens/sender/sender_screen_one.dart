
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/utils/helpers.dart';
import '../../../core/utils/keys.dart';
import '../../../core/values/app_color.dart';
import '../../../core/values/strings.dart';
import '../../../data/model/source_of_income_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../modules/controller/sender_detials_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dropdown_search_field.dart';
import '../../../../core/utils/validator.dart';
import '../../../../data/model/country_model.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../widgets/custom_typeheadfield.dart';

class SenderDetailsScreenOne extends StatelessWidget {
  final SenderDetailsController  _senderDetailsController = Get.put(SenderDetailsController());
  final box = GetStorage();
  final ApiProvider _apiProvider = ApiProvider();
  SenderDetailsScreenOne({Key? key}) : super(key: key);
  final _formKey =  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // print(box.read(Keys.phoneNumber).toString().split("+44").last);
    _senderDetailsController.firstNameController.text =  box.read(Keys.name);
    _senderDetailsController.surNameController.text = box.read(Keys.surName);
    _senderDetailsController.emailController.text = box.read(Keys.email);
    _senderDetailsController.birthdatePiked.value = box.read(Keys.userBirthDate);
    _senderDetailsController.PhoneNumberController.text = box.read(Keys.phoneNumber).toString().split("${box.read(Keys.callingCode)}").last;
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  CustomTextField(
                    controller:_senderDetailsController.firstNameController,
                    level: "firstNameOrGivenName".tr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    validator: (_value)=>Validator.nameValidator(value: _value, data: "firstNameIsRequired".tr),
                  ),
                  SizedBox(height: 16,),
                  CustomTextField(
                    controller:_senderDetailsController.surNameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    level: "lastNameOrSureName".tr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_value)=>Validator.nameValidator(value: _value,data: "lastNameIsRequired".tr),
                  ),
                  SizedBox(height: 16,),
                  CustomTextField(
                    controller: _senderDetailsController.otherNameController,
                    level: "otherName".tr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: (_value)=>Validator.nameValidator(value: _value, data: 'enterYourOtherName'.tr),
                  ),
                  SizedBox(height: 16,),
                  CustomDropdownScarchField(
                    showSearchBox: false,
                    items: ["Male", "Female", "Other"],
                    onChanged: (value){
                      _senderDetailsController.userGender.value = value!.toString();
                    },
                    searchhintText: "gender".tr,
                    hintText: _senderDetailsController.userGender.value.isEmpty ?   "gender".tr : _senderDetailsController.userGender.value,
                    hintStyle: _senderDetailsController.userGender.value.isEmpty ? null : TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
                    validator: (value){
                      var data = _senderDetailsController.userGender.value.isEmpty ?  value : _senderDetailsController.userGender.value;
                      if(data == null){
                        return "genderIsRequired".tr;
                      }
                      return null;
                    }
                  ),
                  SizedBox(height: 8,),
                  CustomDropdownScarchField<CountryModel>(
                    showSearchBox: true,
                    onFind: (filter) async{
                      if(_senderDetailsController.localbirthCountryList2.isEmpty){
                        var response = await _apiProvider.getSingleData(
                          baseUrl: Strings.baseUrl,
                          // remitter country all setup is  getRemitterWithDependencies this api 
                          url: Strings.getRemitterWithDependencies,
                        );
                        List countryList = response["countries"];
                        for(var i = 0 ; i < countryList.length; i++){
                         _senderDetailsController.localbirthCountryList2.add(countryList[i]);
                        }
                        if(response["incomeSources"] != null){
                          List incomeSources = response["incomeSources"];
                          for(var i = 0; i <incomeSources.length; i++){
                            _senderDetailsController.localsourceOfIncomeList.add(incomeSources[i]);
                          }
                        }
                        if(response["cities"] != null){
                          List cities = response["cities"];
                          for(var i = 0; i < cities.length ; i++){
                            _senderDetailsController.localcityAddressLineList.add(cities[i]);
                          }
                        }
                        if(response["remitterDocumentTypes"] != null){
                          List remitterDocumentTypes = response["remitterDocumentTypes"];
                          for(var i = 0; i< remitterDocumentTypes.length; i++){
                            _senderDetailsController.localdocumentTypeList.add(remitterDocumentTypes[i]);
                        }
                        }
                       }
                        var countries =   _senderDetailsController.localbirthCountryList2..where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                        return  countries.map((e){
                          return  CountryModel.fromJson(e);
                        }).toList();
                    },
                    itemAsString: (CountryModel? u)=>u!.name.toString(),
                    // label: "birthCountry".tr,
                    searchhintText: "birthCountrys".tr,
                    hintText: _senderDetailsController.birthCountryName.value.isEmpty ?   "birthCountry".tr : _senderDetailsController.birthCountryName.value,
                    hintStyle: _senderDetailsController.birthCountryName.value.isEmpty ? null : TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
                    onChanged: (CountryModel? countryModel){
                      _senderDetailsController.birthCountryId.value = countryModel!.countryId.toString();
                      _senderDetailsController.birthCountryName.value = countryModel.name.toString();
                      _senderDetailsController.nationlity.value = countryModel.nationality.toString();
                      _senderDetailsController.nationlityCountryId.value = countryModel.countryId.toString();
                    },
                    validator: (CountryModel? value){
                      var data = _senderDetailsController.birthCountryName.value.isEmpty ? value : _senderDetailsController.birthCountryName.value;
                      if( data == null){
                       return "birthCountryIsRequired".tr.toString();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),
                  CustomTextField(
                    controller: _senderDetailsController.birthCityController,
                    level: "enterBirthCity".tr,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (data)=>Validator.validatorRetrun(value: data, errorText: "birthcity".tr),
                  ),
                  SizedBox(height: 16,),
                  Obx(()=>CustomDropdownScarchField<CountryModel>(
                      showSearchBox: true,
                      onFind: (filter) async{
                        var response = await _apiProvider.getSingleData(
                          baseUrl: Strings.baseUrl,
                          url: Strings.birthCountryUrl,
                        );
                          List countryList = [];
                          for(var i in response["countries"]){
                          countryList.add(i);
                          }
                          var countries =  countryList.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                          return  countries.map((e){
                            return  CountryModel.fromJson(e);
                          }).toList();
                      },
                      itemAsString: (CountryModel? u)=>u!.nationality.toString(),
                      // label: "nationality".tr,
                      searchhintText: "nationality".tr,
                      hintText: _senderDetailsController.nationlity.value.isEmpty ? "nationality".tr : _senderDetailsController.nationlity.value,
                      hintStyle:_senderDetailsController.nationlity.value.isNotEmpty ? TextStyle(color: AppColor.kBlackColor) : null,
                      validator: (CountryModel? value){
                         var data = _senderDetailsController.nationlity.value.isEmpty ? value : _senderDetailsController.nationlity.value;
                        if( data == null){
                         return "nationalityIsRequired".tr;
                        }
                        return null;
                      },
                      onChanged: (CountryModel? data ){
                        _senderDetailsController.nationlity.value = data!.nationality.toString();
                        _senderDetailsController.nationlityCountryId.value = data.countryId.toString();
                      },
                    ),
                  ),
                  SizedBox(height: 16,),
                  CustomTypeheadField<IncomeSourceModel>(
                  controller: _senderDetailsController.incomeSourceNameController,
                  onTap: (){
                    _senderDetailsController.incomeSourceNameController.clear();
                  },
                  suggestionsCallback: (String patten) async{
                   if(_senderDetailsController.localsourceOfIncomeList.isEmpty){
                      var response = await _apiProvider.getSingleData(
                        baseUrl: Strings.baseUrl,
                        url: Strings.incomeSources,
                      );
                      List incomeSources = response["incomeSources"];
                      for(var i = 0; i< incomeSources.length; i++){
                        _senderDetailsController.localsourceOfIncomeList.add(incomeSources[i]);
                      }
                   }
                    var countries =  _senderDetailsController.localsourceOfIncomeList.where((element) => element.toString().toLowerCase().contains(patten.toLowerCase()));
                    return  countries.map((e){
                      return  IncomeSourceModel.fromJson(e);
                    }).toList();

                  },
                  itemBuilder: ( BuildContext context , IncomeSourceModel suburbZoneModel){
                      return ListTile(
                        title: Text("${suburbZoneModel.name}"),
                      );
                  }, 
                  onSuggestionSelected: (IncomeSourceModel data){
                    _senderDetailsController.incomeSourceId.value = data.sourceId.toString();
                    _senderDetailsController.exchangeId.value =  data.exchangeId.toString();
                    _senderDetailsController.incomeSourceNameController.text = data.name.toString();
                  }, 
                  hintText: "sourceOfIncome".tr,
                  validator: (value){
                    if(value!.isEmpty){
                        return "Source Of Income is required";
                    }
                    return null;
                  },
                ),
                  SizedBox(height: 32,),
                  Row(
                    children: [
                      CustomButton(
                        buttonLevel: "continue".tr,
                        onPressed: (){
                          Helpers.keyboardhide();
                          _senderDetailsController.genderValidator.value = _senderDetailsController.groupGender.value;
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();
                            _senderDetailsController.NavigateSteep();
                          }
                        },
                        color: AppColor.kGreenColor,
                      )
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


