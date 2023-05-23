
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:necmoney/core/utils/data/profession.dart';
import 'package:necmoney/data/model/country_model.dart';
import 'package:necmoney/data/model/remitter_document_types_model.dart';
import 'package:necmoney/data/provider/api_provider.dart';
import 'package:necmoney/widgets/custom_typeheadfield.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/keys.dart';
import '../../../core/values/app_color.dart';
import '../../../widgets/date_picker.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/values/strings.dart';
import '../../../../data/model/save_profile_model.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_dropdown_search_field.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../controller/sender_detials_controller.dart';

// ignore: must_be_immutable
class SenderDetailsScreenFour extends StatelessWidget {
  final SenderDetailsController _senderDetailsController = Get.put(SenderDetailsController());
  final TextEditingController _documentIssuedcontroller = TextEditingController();

  final box = GetStorage();
  ApiProvider _apiProvider = ApiProvider();
    final _formKey =  GlobalKey<FormState>();
  SenderDetailsScreenFour({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(()=>CustomDropdownScarchField<RemitterDocumentTypesModel>(
                      showSearchBox: true,
                      searchhintText: "documenttype".tr,
                      onFind: (filter) async{
                         if(_senderDetailsController.localdocumentTypeList.isEmpty){
                           var response = await _apiProvider.getSingleData(
                          baseUrl: Strings.baseUrl,
                          url: Strings.remitterDocumentTypes + "${box.read(Keys.remitterTypeId)}",
                        );
                        
                          for(var i in response["remitterDocumentTypes"]){
                            _senderDetailsController.localdocumentTypeList.add(i);
                          }
                         }
                          var countries =  _senderDetailsController.localdocumentTypeList.where((element) => element.toString().contains(filter!.toLowerCase()));
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
                )),
                SizedBox(height: 16),
                Column(
                  children: [
                    Obx(()=> Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('issueDateAuthority'.tr,style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: (){
                        DatePicker.datePiker(
                            minimumYear: _senderDetailsController.documentTypeName.value == Keys.nationalIdCard ? int.parse("${DateTime.now().year - 60}") : int.parse("${DateTime.now().year - 10}"),
                            context: context,
                            initialDateTime: DateTime.now(),
                            maximumYear: DateTime.now().year,
                            onDateTimeChanged: (data)=> _senderDetailsController.getDateofBirth(data: data,formate: Strings.DocumentDateIssue),
                            onPressed: (){
                              Get.back();
                            }
                          );
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColor.kSeaGreenColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 1,  color: _senderDetailsController.documentDateIssueValidator.value.isEmpty ? AppColor.kSecondaryColor : AppColor.kGreenColor),
                                ),
                                // DateFormat('dd/MM/yyyy').format(data)
                                child: Center(
                                  child: _senderDetailsController.documentDateIssue.isNotEmpty ? Text('${DateFormat('dd/MM/yyyy').format(  DateTime.parse(_senderDetailsController.documentDateIssue.value))}',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ): Text('DD / MM / YYYY',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                              ),
                              SizedBox( height: 8),
                              _senderDetailsController.documentDateIssueValidator.value.isEmpty ? Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  "IsRequired".tr,
                                  style: TextStyle(color: AppColor.kSecondaryColor,fontSize: 10.sp),
                                ),
                              ): SizedBox(),
                             ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('expireDate'.tr,style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: (){
                          DatePicker.datePiker(
                            context: context,
                            minimumYear: _senderDetailsController.documentDateIssue.value.isEmpty ? 1800 :int.parse("${DateTime.parse("${_senderDetailsController.documentDateIssue.value}").year}"),
                            initialDateTime: DateTime.now(),
                            maximumYear: _senderDetailsController.documentDateIssue.value.isEmpty ? 2050 : DateTime.parse("${_senderDetailsController.documentDateIssue.value}").year + 10,
                            onDateTimeChanged: (value)=> _senderDetailsController.getDateofBirth(data: value, formate: Strings.DocumentDateExpire),
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
                                    // border: Border.all(width: 1,  color: _senderDetailsController.documentDateExpireValidator.value.isEmpty ? AppColor.kSecondaryColor : AppColor.kGreenColor),
                                    border: Border.all(width: 1,  color: AppColor.kGreenColor),
                                  ),
                                  child: Center(
                                    child: _senderDetailsController.documentDateExpire.isNotEmpty ? Text('${DateFormat('dd/MM/yyyy').format(DateTime.parse(_senderDetailsController.documentDateExpire.value))}',
                                      style: Theme.of(context).textTheme.titleMedium,
                                      ): Text('DD / MM / YYYY',
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                CustomDropdownScarchField(
                  showSearchBox: true,
                  items: professionName.values.toList(),   
                  onChanged: (value){
                    _senderDetailsController.professionController.text = value.toString();
                  },
                  searchhintText: "profession".tr,
                  hintText:  _senderDetailsController.professionController.text.isEmpty ?  "profession".tr : _senderDetailsController.professionController.text,
                  hintStyle: _senderDetailsController.professionController.text.isEmpty ? null : TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
                  validator: (value){
                    var data = _senderDetailsController.professionController.text.isEmpty ? value : _senderDetailsController.professionController.text;
                    if( data == null){
                      return "professionIsRequired".tr;
                    }
                    return null;
                  }
                ),
                SizedBox(height: 8),
                CustomTypeheadField<CountryModel>(
                  suggestionsCallback: (patten) async{
                    if(_senderDetailsController.localbirthCountryList2.isEmpty){
                      var response = await _apiProvider.getSingleData(
                      baseUrl: Strings.baseUrl,
                      url: Strings.issuedPlace,
                    );
                    for(var i in response["countries"]){
                        _senderDetailsController.localbirthCountryList2.add(i);
                      }
                    }
                    var countries =  _senderDetailsController.localbirthCountryList2.where((element) => element.toString().toLowerCase().contains(patten.toLowerCase()));
                    return  countries.map((e)=> CountryModel.fromJson(e)).toList();
                  },
                  itemBuilder: ( BuildContext context,CountryModel countryModel){
                    return ListTile(
                      title: Text("${countryModel.name}"),
                    );
                  }, 
                  onSuggestionSelected: (CountryModel countryModel){
                    _documentIssuedcontroller.text = countryModel.name.toString();
                    _senderDetailsController.documentissuePlaceController.text = countryModel.name.toString();
                    _senderDetailsController.documentissuePlaceId.value = countryModel.countryId.toString();
                  },
                  hintText:"documentIssuedPlace".tr,
                  controller: _documentIssuedcontroller,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Document issued place required";
                    }
                    return null;
                  }
                  ,
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: _senderDetailsController.documentauthorityController,
                  level: "Document Issuing Authority".tr,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value)=>Validator.validatorRetrun(value: value, errorText: "Document Issuing Authority".tr),
                ),             
                SizedBox(height: 16),
                SizedBox(height: 32,),
                Row(
                  children: [
                      CustomButton(
                          buttonLevel: "save".tr,
                          onPressed: (){
                            _senderDetailsController.documentDateIssueValidator.value  = _senderDetailsController.documentDateIssue.value;
                            // _senderDetailsController.documentDateExpireValidator.value  = _senderDetailsController.documentDateExpire.value;
                            if(_formKey.currentState!.validate()){
                                _formKey.currentState!.save();
                                    final  _remitter = RemitterModel( 
                                      remitterId: 0,                  
                                      code:"",
                                      name: _senderDetailsController.firstNameController.text,
                                      otherName:_senderDetailsController.otherNameController.text,
                                      remitterTypeId: int.parse("${box.read(Keys.remitterTypeId)}"),
                                      exchangeID: int.parse(_senderDetailsController.exchangeId.value),
                                      surname: _senderDetailsController.surNameController.text,
                                      businessName: "",
                                      birthCountry:  _senderDetailsController.birthCountryName.value,
                                      birthCountryId: int.parse(_senderDetailsController.birthCountryId.value),//
                                      birthCity: _senderDetailsController.birthCityController.text,
                                      birthProvince:"",
                                      birthDate : DateTime.parse(_senderDetailsController.birthdatePiked.value),
                                      profession: _senderDetailsController.professionController.text,
                                      designation:"",
                                      employer: "",
                                      nationality: _senderDetailsController.nationlity.value,
                                      nationalityCountryId: int.parse(_senderDetailsController.nationlityCountryId.value),
                                      sex: _senderDetailsController.userGender.value,
                                      maritualStatus: null,
                                      incomeSourceId: int.parse(_senderDetailsController.incomeSourceId.value),
                                      yearlyIncome:0,
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
                                      address2: _senderDetailsController.addressline2Controller.value.text,
                                      countryId: int.parse(box.read(Keys.senderFromCountryId).toString()),
                                      countryCode: box.read(Keys.sendFromCountryCode),
                                      countryName: box.read(Keys.senderFromCountryName),
                                      provinceCode:_senderDetailsController.provinccCodeController.text,
                                      province:_senderDetailsController.provinccnameController.text,
                                      zipCode: _senderDetailsController.zipPostalController.text,
                                      capCode:"",
                                      cityId: int.parse(box.read(Keys.cityId).toString()),
                                      cityCode: _senderDetailsController.cityCode.value,
                                      phoneNo:_senderDetailsController.PhoneNumberController.text,
                                      emailAddress :_senderDetailsController.emailController.text,
                                      docName: _senderDetailsController.documentTypeName.value,
                                      docId: int.parse( _senderDetailsController.documentTypeid.value),
                                      docCode:" ",
                                      documentNo:_senderDetailsController.documentNoController.text,
                                      docIssueDate:DateTime.parse(_senderDetailsController.documentDateIssue.value),
                                      docValidUpto:DateTime.parse(_senderDetailsController.documentDateExpire.value),
                                      docIssuePlace: _senderDetailsController.documentissuePlaceController.text,
                                      issuingAuthority:_senderDetailsController.documentauthorityController.text,
                                      docIssuePlaceIsCity:0,
                                      docIssuePlaceId: int.parse(_senderDetailsController.documentissuePlaceId.value),
                                      status: 1,
                                      renewalDate: DateTime(2098, 9, 7, 17, 30),
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
                                      sbSectorCode:""
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






