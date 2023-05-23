
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:necmoney/data/model/city_model.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/validator.dart';
import '../../../../core/values/app_color.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_dropdown_search_field.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../core/utils/keys.dart';
import '../../../core/values/strings.dart';
import '../../../data/model/address_model.dart';
import '../../../data/model/country_model.dart';
import '../../../data/model/remitter_document_types_model.dart';
import '../../../data/model/save_profile_model.dart';
import '../../../data/model/source_of_income_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../modules/controller/sender_detials_controller.dart';
import '../../../widgets/custom_typeheadfield.dart';
import '../../../widgets/date_picker.dart';
import '../../controller/sender_address_controller.dart';

// ignore: must_be_immutable
class SenderDetailsUpdateScreen extends StatelessWidget {
  SenderDetailsUpdateScreen({ Key? key }) : super(key: key);
  final SenderDetailsController _senderDetailsController = Get.put(SenderDetailsController());
  final _senderAddressController = Get.put(SenderAddressController());
  final ApiProvider _apiProvider = ApiProvider();
  var client = http.Client();  
  final box = GetStorage();
  final _formKey =  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: CustomAppBar(title: "personalData".tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("senderdetails".tr,style: Theme.of(context).textTheme.displaySmall),
                SizedBox(height: 12),
                AbsorbPointer(
                  absorbing: true,
                  child: CustomTextField(
                    controller:_senderDetailsController.residanceTypeController,
                    level: "residanceType".tr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // validator: (_value)=>Validator.nameValidator(value: _value, data: "IsRequired".tr),
                  ),
                ),
                SizedBox(height: 12),
                CustomTextField(
                  controller:_senderDetailsController.firstNameController,
                  level: "firstNameOrGivenName".tr,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_value)=>Validator.nameValidator(value: _value, data: "firstNameIsRequired".tr),
                ),
                SizedBox(height: 12),
                CustomTextField(
                  controller:_senderDetailsController.surNameController,
                  level: "lastNameOrSureName".tr,
                   autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_value)=>Validator.nameValidator(value: _value,data: "lastNameIsRequired".tr),
                ),
                if(_senderDetailsController.otherNameController.text.isNotEmpty)...[
                 SizedBox(height: 12),
                  CustomTextField(
                    controller: _senderDetailsController.otherNameController,
                    level: "otherName".tr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // validator: (_value)=>Validator.nameValidator(value: _value, data: 'enterYourOtherName'.tr),
                  ),
                ],
                SizedBox(height: 12),
                CustomTextField(
                  readOnly: _senderDetailsController.emailController.text.isEmpty ? false : true,
                  controller: _senderDetailsController.emailController,
                  level: "Email address".tr,
                   autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (_value)=>Validator.nameValidator(value: _value, data: 'enterYourOtherName'.tr),
                ),

                if( _senderDetailsController.birthCountryController.text.isNotEmpty)... [
                  SizedBox(height: 12),
                  Text("Birth country",style: TextStyle(color: AppColor.kGreyColor.withOpacity(0.9),fontSize: 12),),
                  SizedBox(height: 4,),
                  CustomDropdownScarchField<CountryModel>( 
                    showSearchBox: true,
                    onFind: (String? filter) async{
                      var response = await _apiProvider.getSingleData(
                        baseUrl: Strings.baseUrl, 
                        url: "GlobalService/GetCountriesByModeID?ModeID=1",
                      );
                      List c = [];
                      for(var i in response["countries"]){
                        c.add(i);
                      }
                      var _c =  c.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                      return _c.map((e) => CountryModel.fromJson(e)).toList();
                    },
                    itemAsString: (CountryModel? u) => u!.name.toString(),
                    onChanged: (CountryModel? data) {
                      _senderDetailsController.birthCountryId.value = data!.countryId.toString();
                      _senderDetailsController.birthCountryName.value = data.name.toString();
                      _senderDetailsController.nationlityCountryId.value = data.countryId.toString();
                    },
                    hintText: _senderDetailsController.birthCountryController.text,
                    // label: "Birth Country".tr,
                    searchhintText: "country".tr,
                    hintStyle: TextStyle(color: AppColor.kBlackColor),
                    validator: (value){
                    var  values =  value != null ? value.name : _senderDetailsController.birthCountryController.text;
                    if(values == null){
                        return "birthCountryIsRequired".tr;
                    }
                    return null;
                    }
                  ),
                  SizedBox(height: 12,),
                ],
                _senderDetailsController.birthCityController.text.isNotEmpty ? CustomTextField(
                  controller:_senderDetailsController.birthCityController,
                  level: "birthCity".tr,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_value)=>Validator.nameValidator(value: _value, data: "birthCityIsRequired".tr),
                ) : SizedBox(),
                SizedBox(height: 12,),
                _senderDetailsController.nationallityController.text.isNotEmpty ? CustomTextField(
                  controller:_senderDetailsController.nationallityController,
                  level: "nationality".tr,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_value)=>Validator.nameValidator(value: _value, data: "nationalityIsRequired".tr),
                ) : SizedBox(),
                // SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('dateofbirth'.tr,style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 4),
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
                                  ): Text('DD / MM / YYYY',
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
                SizedBox(height: 12,),
                CustomDropdownScarchField( 
                  showSearchBox: false,
                  items: ["Male", "Female", "UnKnow"],
                  onChanged: (value){
                    _senderDetailsController.userGender.value = value!.toString();
                  },
                  label: "gender".tr,
                  selectedItem: _senderDetailsController.userGender.value,
                  validator: (value){
                    var  values  = _senderDetailsController.userGender.value.isEmail ? value : _senderDetailsController.userGender.value;
                    if( values == null){
                      return "genderIsRequired";
                    }
                    return null;
                  }
                ),

                if(_senderDetailsController.fiscalCodeController.text.isNotEmpty)...[
                SizedBox(height: 12,),
                 Obx(()=>
                  _senderDetailsController.remeitterTypeName.value.isEmpty ? SizedBox() : CustomTextField(
                    controller: _senderDetailsController.fiscalCodeController,
                    level: "fiscalCode".tr,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value)=>Validator.professionValidator(value),
                    ),
                  ),
                ],
                SizedBox(height: 12,),
                Text('Source Of Income'.tr,style: Theme.of(context).textTheme.titleLarge),
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
                SizedBox(height: 12,),
                CustomTextField(
                  controller: _senderDetailsController.PhoneNumberController,
                  level: "phoneNumber".tr,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value)=>Validator.phonenumberValidator(value: value, data: "numbeIsRequired".tr),
                ),
                SizedBox(height: 8,),
                Text("City address line",style: TextStyle(color: AppColor.kGreyColor.withOpacity(0.9),fontSize: 12),),
                SizedBox(height: 4,),
                CustomTypeheadField<CityModel>(
                  controller: _senderDetailsController.cityController,
                  hintText: "City name",
                  maxLines: 1,
                  onTap: (){
                    if(_senderDetailsController.cityController.text.isNotEmpty){
                      _senderDetailsController.cityController.clear();
                    }
                  },
                  suggestionsCallback: (String? pattern) async {
                      var response = await _apiProvider.getSingleData(
                        baseUrl: Strings.baseUrl, 
                        url: "GlobalService/GetCities?Filter=${box.read(Keys.senderFromCountryName)}&CountryId= ${box.read(Keys.senderFromCountryId)}",
                      );
                      List c = [];
                      for(var i in response["cities"]){
                        c.add(i);
                      }
                      var _c =  c.where((element) => element.toString().toLowerCase().contains(pattern!.toLowerCase()));
                      return _c.map((e) => CityModel.fromJson(e)).toList();
                  },
                  itemBuilder: (BuildContext context, CityModel getCurrenciesModel) {
                    return ListTile(
                      title: Text("${getCurrenciesModel.name}"),
                    );
                  },
                  onSuggestionSelected: (CityModel? data) {
                  _senderDetailsController.cityId.value = data!.cityId.toString();
                  _senderDetailsController.cityController.text = data.name.toString();
                  _senderDetailsController.cityName.value = data.code1.toString();
                  },
                  validator: (value){
                    if (value!.isEmpty) {
                        return 'Please select city';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                if(int.parse(box.read(Keys.senderFromCountryId)) == Keys.unitedKingdomCounryID)...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('senderAddress'.tr,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Obx(()=> TextButton(
                          onPressed: (){
                            _senderAddressController.isManual.value =! _senderAddressController.isManual.value;
                            _senderDetailsController.addressline1Controller.value.clear();
                            _senderDetailsController.addressline2Controller.value.clear();
                          }, 
                          child: _senderAddressController.isManual.value ? Text("enterManual".tr) : Text("findAddress".tr)
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Obx(() => _senderAddressController.isManual.value ? CustomTypeheadField(
                      controller: _senderDetailsController.zipPostalController,
                      hintText: "enterYourPostcode".tr,
                      suggestionsCallback: (pattern) async {
                        var response = await http.get(
                          Uri.parse("${Strings.addressBaseUrl}/$pattern?api-key=${Strings.addressApiKey}&expand=true")
                        );
                        AddressModel addressModel = AddressModel.fromJson(jsonDecode(response.body));
                          List<Address>? _data = addressModel.addresses;
                          _senderDetailsController.zipPostalController.text = pattern;
                          return _data! ;
                      },
                      itemBuilder: (context, Address address) {
                        return ListTile(
                          title: Text("${address.line1!},${address.line2}${address.line3}${address.line4}${address.district}, ${address.townOrCity} ${ _senderDetailsController.zipPostalController.text.toUpperCase()}, ${address.country}"),
                        );
                      },
                      onSuggestionSelected: (Address address) {
                        print(address.townOrCity);
                        _senderDetailsController.addressline1Controller.value.text = "${address.line1}" ;
                        _senderDetailsController.addressline2Controller.value.text = "${address.line2} ${address.district}";
                      },
                    ) : CustomTextField(
                          readOnly: _senderAddressController.isManual.value,
                          controller: _senderDetailsController.zipPostalController,
                          autovalidateMode: AutovalidateMode.disabled,
                          level: 'pleaseEnterValidPostCode'.tr,
                          hintText: 'E12XXX',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)=>Validator.validatorRetrun(value: value, errorText: "postCode".tr),
                      ),
                    ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => CustomTextField(
                            readOnly: _senderAddressController.isManual.value,
                            controller: _senderDetailsController.addressline1Controller.value,
                            autovalidateMode: AutovalidateMode.disabled,
                            level: 'Address line one'.tr,
                            hintText: 'Address line one',
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            keyboardType: TextInputType.emailAddress,
                            validator: (value)=>Validator.addressValidator(value,data: "Address line one is required".tr),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Obx(()=>Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: CustomTextField(
                          readOnly:  _senderAddressController.isManual.value,
                          controller: _senderDetailsController.addressline2Controller.value,
                          autovalidateMode: AutovalidateMode.disabled,
                          level: 'Address line two(optional)'.tr,
                          hintText: 'Address line two'.tr,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                         
                        ),
                      ),
                  ),
                  SizedBox(height: 8,),
                ]else...[
                  CustomTextField(
                    controller: _senderDetailsController.zipPostalController,
                    level: "zipPostalCode".tr,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value == null){
                        return "zipPostalCodeIsRequired".tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  CustomTextField(
                    controller: _senderDetailsController.addressline1Controller.value,
                    level: "Address Line".tr,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50)
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value == null){
                        return "addressLineIsRequired".tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),
                  CustomTextField(
                    controller: _senderDetailsController.addressline2Controller.value,
                    level: "Address line two".tr,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50)
                    ],
                  ),

                ],
                SizedBox(height: 8,),
                Text("Document types",style: TextStyle(color: AppColor.kGreyColor.withOpacity(0.9),fontSize: 12),),
                SizedBox(height: 4,),
                CustomDropdownScarchField<RemitterDocumentTypesModel>(
                    showSearchBox: true,
                    onFind: (filter) async{
                      var response = await _apiProvider.getSingleData(
                        baseUrl: Strings.baseUrl,
                        url: Strings.remitterDocumentTypes + "${box.read(Keys.remitterTypeId)}",
                      );
                        List documentTypesList = [];
                        for(var i in response["remitterDocumentTypes"]){
                          documentTypesList.add(i);
                        }
                        var countries =  documentTypesList.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                        return  countries.map((e){
                          return  RemitterDocumentTypesModel.fromJson(e);
                        }).toList();
                    },
                    itemAsString: (RemitterDocumentTypesModel? u)=> u!.name.toString(),
                    // label: "Document Types".tr,
                    searchhintText: "documentTypes".tr,
                    hintText: "${_senderDetailsController.documentTypeName.value}",
                     hintStyle: _senderDetailsController.documentTypeName.isEmpty ? null :TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
                    validator: (RemitterDocumentTypesModel? value){
                      var data = value != null ? value : _senderDetailsController.documentTypeName.value;
                      if(data.toString().isEmpty){
                       return "documentTypesIsRequired".tr.toString();
                      }
                      return null;
                    },
                    onChanged: (RemitterDocumentTypesModel? document){
                      _senderDetailsController.documentTypeName.value = document!.name.toString().toLowerCase();
                      _senderDetailsController.documentTypeid.value = document.documentId.toString();
                      box.write(Keys.documnetTypeName, document.name.toString());
                      if(int.parse(box.read(Keys.senderFromCountryId).toString()) == Keys.unitedKingdomCounryID){
                        _senderDetailsController.documentDateIssue.value = "";
                        _senderDetailsController.documentDateExpire.value = "";
                      }
                      _senderDetailsController.documentNoController.clear();
                    },
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: CustomTextField(
                  controller: _senderDetailsController.documentNoController,
                  level: "documentNo".tr,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value == null){
                      return "documentNoIsRequired".tr;
                    }
                    return null;
                  },
                  ),
                ),
                SizedBox(height: 12,),
                if(_senderDetailsController.documentDateIssue.value != "null" && _senderDetailsController.documentDateExpire.value != "null")...[
                  Row(
                    children: [
                      Obx(()=> Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('issueDate'.tr,style: Theme.of(context).textTheme.titleLarge),
                              SizedBox(height: 12),
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
                                      SizedBox( height: 12),
                                      _senderDetailsController.documentDateIssueValidator.value.isEmpty ? Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Text(
                                          "isRequired".tr,
                                          style: TextStyle(color: AppColor.kSecondaryColor,fontSize: 10.sp),
                                        ),
                                      ): SizedBox(),
                                    ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('expireDate'.tr,style: Theme.of(context).textTheme.titleLarge),
                            SizedBox(height: 12),
                            GestureDetector(
                              onTap: (){
                              DatePicker.datePiker(
                                context: context,
                                minimumYear: int.parse("${DateTime.parse("${_senderDetailsController.documentDateIssue.value}").year}"),
                                initialDateTime: DateTime.now(),
                                maximumYear: DateTime.parse("${_senderDetailsController.documentDateIssue.value}").year + 10,
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
                                          border: Border.all(width: 1,  color: _senderDetailsController.documentDateExpireValidator.value.isEmpty ? AppColor.kSecondaryColor : AppColor.kGreenColor),
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
                                      SizedBox( height: 12),
                                      _senderDetailsController.documentDateExpireValidator.value.isEmpty ? Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Text(
                                          "isRequiredexpireDate".tr,
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
                    ],
                  ),
                ],
                SizedBox(height: 12),
                if(_senderDetailsController.professionController.text.isNotEmpty)...[
                  CustomTextField(
                    controller: _senderDetailsController.professionController,
                    level: "Profession".tr,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value)=>Validator.validatorRetrun(value: value, errorText: "Profession".tr),
                  ),
                  SizedBox(height: 12),
                ],
                if(_senderDetailsController.documentauthorityController.text.isNotEmpty)...[
                  CustomTextField(
                    controller: _senderDetailsController.documentauthorityController,
                    level: "Document Issuing Authority".tr,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value)=>Validator.validatorRetrun(value: value, errorText: "Document Issuing Authority".tr),
                  ),
                  SizedBox(height: 12,),
                ],
                if(_senderDetailsController.documentissuePlaceController.text.isNotEmpty)...[
                  CustomTextField(
                    controller: _senderDetailsController.documentissuePlaceController,
                    level: "documentIssuedPlace".tr,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value)=>Validator.validatorRetrun(value: value, errorText: "documentIssuedPlace".tr),
                  ),
                ],
                SizedBox(height: 16,),
                Row(
                  children: [
                    CustomButton(
                      buttonLevel: 'update&Save'.tr,
                      color: AppColor.kPrimaryColor,
                      onPressed: () async{
                        _senderDetailsController.birthdateValidator.value  = _senderDetailsController.birthdatePiked.value;
                        _senderDetailsController.documentDateIssueValidator.value  = _senderDetailsController.documentDateIssue.value;
                        _senderDetailsController.documentDateExpireValidator.value  = _senderDetailsController.documentDateExpire.value;
                        _senderDetailsController.genderValidator.value = _senderDetailsController.groupGender.value;
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          final  _remitterUpdate = RemitterModel(  
                            remitterId: int.parse(box.read(Keys.remitterId).toString()),                  
                            code: "${box.read(Keys.clientID)}",
                            name: _senderDetailsController.firstNameController.text,
                            otherName:_senderDetailsController.otherNameController.text,
                            remitterTypeId: int.parse("${box.read(Keys.remitterTypeId)}"),
                            exchangeID: int.parse(_senderDetailsController.exchangeId.value),
                            surname: _senderDetailsController.surNameController.text,
                            businessName: "",
                            birthCountry:  _senderDetailsController.birthCountryName.value,
                            birthCountryId: _senderDetailsController.birthCountryId.value != "null" ? int.parse(_senderDetailsController.birthCountryId.value) : 0,
                            birthCity: _senderDetailsController.birthCityController.text,
                            birthProvince:"",
                            birthDate : DateTime.parse(_senderDetailsController.birthdatePiked.value),
                            profession: _senderDetailsController.professionController.text,
                            designation:"",
                            employer: "",
                            nationality: _senderDetailsController.nationlity.value,
                            nationalityCountryId: _senderDetailsController.nationlityCountryId.value != "null" ? int.parse(_senderDetailsController.nationlityCountryId.value) : 0,
                            sex: _senderDetailsController.userGender.value,
                            maritualStatus: null,
                            incomeSourceId: _senderDetailsController.incomeSourceId.value != "null" ? int.parse(_senderDetailsController.incomeSourceId.value) : 0,
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
                            emailAddress: _senderDetailsController.emailController.text,
                            address1:  _senderDetailsController.addressline1Controller.value.text,
                            address2: _senderDetailsController.addressline2Controller.value.text,
                            countryId: int.parse(box.read(Keys.senderFromCountryId)),
                            countryCode: _senderDetailsController.sendFromCountryCode.value,
                            countryName: _senderDetailsController.senderFromCountryName.value,
                            provinceCode:_senderDetailsController.provinccCodeController.text,
                            province:_senderDetailsController.provinccnameController.text,
                            zipCode:  _senderDetailsController.zipPostalController.text,
                            capCode:"",
                            cityId: int.parse(_senderDetailsController.cityId.value),
                            cityCode: _senderDetailsController.cityController.text,
                            phoneNo:_senderDetailsController.PhoneNumberController.text,
                            docName: _senderDetailsController.documentTypeName.value,
                            docId: int.parse(_senderDetailsController.documentTypeid.value),
                            docCode:" ",
                            documentNo:_senderDetailsController.documentNoController.text,
                            docIssueDate: _senderDetailsController.documentDateIssue.value != "null" ? DateTime.parse(_senderDetailsController.documentDateIssue.value) : null,
                            docValidUpto: _senderDetailsController.documentDateExpire.value != "null" ? DateTime.parse(_senderDetailsController.documentDateExpire.value) : null,
                            docIssuePlace: _senderDetailsController.documentissuePlaceController.text,
                            issuingAuthority: _senderDetailsController.documentauthorityController.text,
                            docIssuePlaceIsCity:0,
                            docIssuePlaceId:0,
                            status: 1,
                            renewalDate: null, // Disscuss with authority
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
                          SaveProfileModel updateProfile = SaveProfileModel(remitter: _remitterUpdate); 
                          _senderDetailsController.createRemitter(updateProfile);
                          _senderDetailsController.updateProfile.value = true;
                        }
                      }
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