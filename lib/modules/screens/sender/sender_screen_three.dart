import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:necmoney/data/model/city_model.dart';
import 'package:necmoney/data/provider/api_provider.dart';

import '../../../core/utils/keys.dart';
import '../../../core/values/app_color.dart';
import '../../../modules/controller/sender_address_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/values/strings.dart';
import '../../../../data/model/address_model.dart';
import '../../../../widgets/custom_dropdown_search_field.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../controller/sender_city_controller.dart';
import '../../controller/sender_detials_controller.dart';

class SenderDetailsScreenThree extends StatelessWidget {
  final SenderDetailsController  _senderDetailsController = Get.put(SenderDetailsController());
  final _senderAddressController = Get.put(SenderAddressController());
  final _senderCityController = Get.put(SenderCityController());
  final box = GetStorage();
  final ApiProvider _apiProvider = ApiProvider();
  final _formKey =  GlobalKey<FormState>();
 SenderDetailsScreenThree({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(box.read(Keys.registerCountry) == Keys.unitedKingdom )...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('senderAddress'.tr,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Obx(()=> TextButton(
                            onPressed: (){
                              _senderAddressController.isManual.value =! _senderAddressController.isManual.value;
                              _senderAddressController.cityController.value.clear();
                              _senderDetailsController.addressline1Controller.value.clear();
                              _senderDetailsController.addressline2Controller.value.clear();
                            }, 
                            child: _senderAddressController.isManual.value ? Text("enterManual".tr) : Text("findAddress".tr)
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Obx(() => _senderAddressController.isManual.value ? TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _senderAddressController.searchAddressController.value,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                            hintText: 'enterYourPostcode'.tr,
                            fillColor: AppColor.kSeaGreenColor,
                            suffixIcon: Icon(Icons.search,color: AppColor.kBlackColor,),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.kGreenColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.kGreenColor),
                            ),
                            focusedErrorBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.kGreenColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.kSecondaryColor),
                            ),
                          )
                        ),
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
                            title: Text("${address.line1!}, ${address.townOrCity}, ${_senderDetailsController.zipPostalController.text.toUpperCase()}, ${address.country}"),
                          );
                        },
                        errorBuilder: (context, suggestion){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text("pleaseEnterValidPostCode".tr)),
                          );
                        },
                        onSuggestionSelected: (Address address) {
                          _senderAddressController.cityController.value.text = address.townOrCity!;
                          _senderDetailsController.addressline1Controller.value.text = "${address.line1}" ;
                          _senderDetailsController.addressline2Controller.value.text = "${address.line2} ${address.district}";
                          _senderCityController.getCityId(data: address.townOrCity.toString());
                          _senderDetailsController.cityCode.value = address.townOrCity.toString();
                        
                        },
                    ) : CustomTextField(
                          readOnly: _senderAddressController.isManual.value,
                          controller:_senderDetailsController.zipPostalController,
                          autovalidateMode: AutovalidateMode.disabled,
                          level: 'pleaseEnterValidPostCode'.tr,
                          hintText: 'E12XXX',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)=>Validator.validatorRetrun(value: value, errorText: "postCode".tr),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Obx(()=> _senderAddressController.isManual.value ? CustomTextField(
                        readOnly: _senderAddressController.isManual.value,
                        controller: _senderAddressController.cityController.value,
                        autovalidateMode: AutovalidateMode.disabled,
                        level: 'yourCity'.tr,
                        // hintText: 'Dhaka',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value)=>Validator.validatorRetrun(value: value, errorText: "yourCity".tr),
                    ):CustomDropdownScarchField<CityModel>(
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
                           _senderDetailsController.cityCode.value = data.code1.toString();
                          box.write(Keys.cityId, data.cityId.toString());
                        },
                        // validator: (value)=> Validator.validatorRetrun(value: value, errorText: "yourCity".tr),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Row(
                      children: [
                        // Text("${_senderDetailsController.addressline1Controller.value.text.isEmpty}"),
                        Expanded(
                          child: SizedBox(
                            height: 70,
                            child: Obx(() => CustomTextField(
                                readOnly: _senderAddressController.isManual.value,
                                controller: _senderDetailsController.addressline1Controller.value,
                                autovalidateMode: AutovalidateMode.disabled,
                                level: 'Address line one',
                                hintText: 'streetAddress'.tr,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value)=>Validator.addressValidator(value,data: "houseNoNameIsRequired".tr),
                              ),
                            ),
                          ),
                        ),
                      ],
                  ),
                  Obx(()=>Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: CustomTextField(
                          readOnly: _senderAddressController.isManual.value,
                          controller: _senderDetailsController.addressline2Controller.value,
                          autovalidateMode: AutovalidateMode.disabled,
                          level: 'Address line two',
                          hintText: 'streetAddress'.tr,
                          keyboardType: TextInputType.text,
                          validator: (value)=>Validator.validatorRetrun(value: value, errorText: "streetAddress".tr),
                        ),
                      ),
                  ),
                  SizedBox(height: 32,),
                ]else...[
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
                      _senderDetailsController.cityCode.value = data.code1.toString();
                      box.write(Keys.cityId, data.cityId.toString());
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
                  SizedBox(height: 32,),
                  CustomTextField(
                    controller: _senderDetailsController.addressline2Controller.value,
                    level: "Address line two".tr,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.disabled,
                   // validator: (value)=>Validator.validatorRetrun(value: value, errorText: "addressline".tr),
                  ),
                ],
                Row(
                  children: [
                    CustomButton(
                      buttonLevel: "continue".tr,
                      onPressed: (){
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
    );
  }
}


