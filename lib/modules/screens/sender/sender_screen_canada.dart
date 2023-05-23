import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/widgets/custom_appbar.dart';


import '../../../core/utils/keys.dart';
import '../../../core/utils/validator.dart';
import '../../../core/values/app_color.dart';
import '../../../core/values/strings.dart';
import '../../../data/model/city_model.dart';
import '../../../data/model/remitter_document_types_model.dart';
import '../../../data/model/save_profile_model.dart';
import '../../../data/model/source_of_income_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dropdown_search_field.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/custom_typeheadfield.dart';
import '../../controller/sender_address_controller.dart';
import '../../controller/sender_detials_controller.dart';

class SenderInfoScreenCanada extends StatelessWidget {
    SenderInfoScreenCanada({ Key? key }) : super(key: key);
  final SenderDetailsController  _senderDetailsController = Get.put(SenderDetailsController());
  final SenderAddressController _senderAddressController = Get.put(SenderAddressController());
  final box = GetStorage();
  final ApiProvider _apiProvider = ApiProvider();
  final _formKey =  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     _senderDetailsController.PhoneNumberController.text = box.read(Keys.phoneNumber).toString().split("${box.read(Keys.callingCode)}").last;
    return  Scaffold(
      appBar: CustomAppBar(
        title: "Sender details",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                CustomTextField(
                  controller: _senderDetailsController.PhoneNumberController,
                  level: "phoneNumber".tr,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value)=>Validator.phonenumberValidator(value: value, data: "fieldIsRequired".tr),
                 ),
                SizedBox(height: 15,),
                CustomDropdownScarchField<CityModel>(
                    showSearchBox: true,
                    onFind: (filter) async{
                      var response = await _apiProvider.getSingleData(
                        baseUrl: Strings.baseUrl,
                        url: "GlobalService/GetCities?Filter=${box.read(Keys.senderFromCountryName)}&CountryId= ${box.read(Keys.senderFromCountryId)}",
                      );
                        List countryList = [];
                        for(var i in response["cities"]){
                        countryList.add(i);
                        }
                        var countries =  countryList.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                        return  countries.map((e){
                          return  CityModel.fromJson(e);
                        }).toList();
                    },
                    searchhintText: "yourCity".tr,
                    itemAsString: (CityModel? u)=>u!.name.toString(),
                    hintText: "selectYourCity".tr,
                    label: "yourCity".tr,
                    onChanged: ( CityModel? data){
                      _senderAddressController.cityController.value.text = data!.name.toString();
                      _senderAddressController.cityId.value = data.cityId.toString();
                      box.write(Keys.cityId, data.cityId.toString());
                      box.write(Keys.cityCode, data.code1.toString());
                    },
                  ),
                  SizedBox(height: 16,),
                  CustomTextField(
                    controller: _senderDetailsController.zipPostalController,
                    level: "zipPostalCode".tr,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (value)=>Validator.validatorRetrun(value: value, errorText: "zipPostalCode".tr),
                  ),
                  SizedBox(height: 16,),
                  CustomTextField(
                    controller: _senderDetailsController.addressline1Controller.value,
                    level: "addressline".tr,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (value)=>Validator.validatorRetrun(value: value, errorText: "addressline".tr),
                  ),
                  SizedBox(height: 16,),
        
                  Obx(()=>CustomDropdownScarchField<RemitterDocumentTypesModel>(
                        showSearchBox: true,
                        searchhintText: "documenttype".tr,
                        onFind: (filter) async{
                          var response = await _apiProvider.getSingleData(
                            baseUrl: Strings.baseUrl,
                            url: Strings.remitterDocumentTypes + "${box.read(Keys.remitterTypeId)}",
                          );
                          List documentTypesList = [];
                            for(var i in response["remitterDocumentTypes"]){
                              documentTypesList.add(i);
                            }
                            var countries =  documentTypesList.where((element) => element.toString().contains(filter!.toLowerCase()));
                            return  countries.map((e){
                              return  RemitterDocumentTypesModel.fromJson(e);
                            }).toList();
                        },
                        itemAsString: (RemitterDocumentTypesModel? u)=> u!.name.toString(),
                        // label: "documentTypes".tr,
                        validator: (RemitterDocumentTypesModel? value){
                          var data = _senderDetailsController.documentTypeName.value.isEmpty ? value : _senderDetailsController.documentTypeName.value;
                          if(data == null){
                            return "documentTypesIsRequired".tr.toString();
                          }
                          return null;
                        },
                        hintText:  _senderDetailsController.documentTypeid.value.isEmpty ? "documentTypes".tr : _senderDetailsController.documentTypeName.value,
                        hintStyle: _senderDetailsController.documentTypeid.value.isEmpty ? null : TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
                        onChanged: (RemitterDocumentTypesModel? document){
                          _senderDetailsController.documentTypeName.value = document!.name.toString();
                          _senderDetailsController.documentTypeid.value = document.documentId.toString();
                          box.write(Keys.documnetTypeName, document.name.toString());
                          box.write(Keys.documentTypeid, document.documentId.toString());
                          _senderDetailsController.documentDateIssue.value = "";
                          _senderDetailsController.documentDateExpire.value = "";
                          _senderDetailsController.documentNoController.clear();
                        },
                      ),
                    ),
                    SizedBox(height: 16,),
                    Obx(()=>CustomTextField(
                      controller: _senderDetailsController.documentNoController,
                      level: _senderDetailsController.documentTypeid.value.toString().isEmpty ? "documentNumber".tr : 
                      "${_senderDetailsController.documentTypeName.value.capitalizeFirst} number" ,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value)=> Validator.validatorRetrun(value: value, errorText: "documentNumber".tr),
                    )
                  ),
                  SizedBox(height: 8,),
                  CustomTypeheadField<IncomeSourceModel>(
                  controller: _senderDetailsController.incomeSourceNameController,
                  onTap: (){
                    _senderDetailsController.incomeSourceNameController.clear();
                  },
                  suggestionsCallback: (String patten) async{
                    var response = await _apiProvider.getSingleData(
                      baseUrl: Strings.baseUrl,
                      url: Strings.incomeSources,
                    );
                    List countryList = [];
                    for(var i in response["incomeSources"]){
                      countryList.add(i);
                    }
                    var countries =  countryList.where((element) => element.toString().toLowerCase().contains(patten.toLowerCase()));
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
                SizedBox(height: 32.0,),
                 Row(
                  children: [
                    CustomButton(
                      buttonLevel: "save".tr,
                      onPressed: (){
                        _senderDetailsController.documentDateIssueValidator.value  = _senderDetailsController.documentDateIssue.value;
                        if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                          final  _remitter = RemitterModel( 
                            remitterId: 0,                  
                            code:"",
                            name: box.read(Keys.name),
                            otherName: "",
                            remitterTypeId: int.parse("${box.read(Keys.remitterTypeId)}"),
                            exchangeID: box.read(Keys.exchangeId),
                            surname: box.read(Keys.surName),
                            businessName: "",
                            birthCountry: "",
                            birthCountryId: 0,
                            birthCity: "",
                            birthProvince:"",
                            birthDate : DateTime.parse(box.read(Keys.userBirthDate).toString()),
                            profession: "",
                            designation:"",
                            employer: "",
                            nationality: "",
                            nationalityCountryId: 0,
                            sex: "",
                            maritualStatus: "",
                            incomeSourceId: int.parse(_senderDetailsController.incomeSourceId.value),
                            yearlyIncome: 0,
                            hasTaxInpsNo: false,
                            taxInpsNo:"",
                            taxRate:0,
                            fiscalCode: " ",
                            fatherSurname:"",
                            fatherName:"",
                            motherSurname:"",
                            motherName:"",
                            pep: false,
                            roadType:"",
                            address1: _senderDetailsController.addressline1Controller.value.text,
                            address2:  _senderDetailsController.addressline1Controller.value.text,
                            countryId: int.parse(box.read(Keys.senderFromCountryId).toString()),
                            countryCode: box.read(Keys.sendFromCountryCode),
                            countryName: box.read(Keys.senderFromCountryName),
                            provinceCode:"",
                            province: "",
                            zipCode: _senderDetailsController.zipPostalController.text,
                            capCode:"",
                            cityId: int.parse("${box.read(Keys.cityId)}"),
                            cityCode: "${_senderAddressController.cityController.value.text}",
                            phoneNo: _senderDetailsController.PhoneNumberController.text,
                            emailAddress : box.read(Keys.email),
                            docName: _senderDetailsController.documentTypeName.value,
                            docId: int.parse("${box.read(Keys.documentTypeid)}"),
                            docCode:" ",
                            documentNo:_senderDetailsController.documentNoController.text,
                            docIssueDate: null,
                            docValidUpto: null,
                            docIssuePlace: "",
                            issuingAuthority: "",
                            docIssuePlaceIsCity:0,
                            docIssuePlaceId: null,
                            status: 1,
                            renewalDate: null,
                            behaviorClassId:0,
                            behaviorClassValue:0,
                            tpLinkId:0,
                            tpLinkCode :"",
                            tpFiscalCode:"",
                            subGroupId:0,
                            subGroupCode:"",
                            sectorId:0,
                            sectorCode:"",
                            sbSectorId:0,
                            sbSectorCode: ""
                          );
                          _senderDetailsController.createRemitter(SaveProfileModel(remitter: _remitter));
                          _senderDetailsController.updateProfile.value = false;
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

    );
  }
}