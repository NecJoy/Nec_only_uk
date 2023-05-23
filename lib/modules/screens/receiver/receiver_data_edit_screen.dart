import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/model/bene_account_types_model.dart';
import '../../../modules/controller/relationship_controller.dart';
import '../../../data/model/payment_type_model.dart';
import '../../../core/utils/keys.dart';
import '../../../core/utils/validator.dart';
import '../../../core/values/app_color.dart';
import '../../../core/values/strings.dart';
import '../../../data/model/bank_name_list_model.dart';
import '../../../data/model/country_model.dart';
import '../../../data/model/get_bank_branches_model.dart';
import '../../../data/model/get_currencies_model.dart';
import '../../../data/model/get_subcompany_model.dart';
import '../../../data/model/relationship_model.dart';
import '../../../data/model/save_receiver_model.dart';
import '../../../data/model/subcompany_branch_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dropdown_search_field.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/custom_typeheadfield.dart';
import '../../controller/send_money_base_controller.dart';
import '../../controller/send_money_controller.dart';


class ReceiverEditScreen extends StatelessWidget {
  final box = GetStorage();
  final SendMoneyController _sendMoneyController = Get.put(SendMoneyController());
  final RelationshipController _relationshipController = Get.put(RelationshipController());
  final SendMoneyBaseController _sendMoneyBaseController = Get.put(SendMoneyBaseController());
  final formKey = GlobalKey<FormState>();
  final abankcityController = TextEditingController();
  final abankBranchController = TextEditingController();
  final ApiProvider _apiProvider = ApiProvider();
  ReceiverEditScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    abankBranchController.text = _sendMoneyController.bankAndWalletPayeeBankBranchName.value;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.kPrimaryColor,
        title: Text("editReceiver".tr,style: Theme.of(context).textTheme.displayMedium,),
        leading: IconButton(
        onPressed: (){
          Get.back();
        }, 
        icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back, color: AppColor.kWhiteColor),
      ),
        
      ),
      body: WillPopScope(
        onWillPop: () async{
          return true;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            reverse: false,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child:  Form(
                key: formKey,
                child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 70,
                              child: CustomTextField(
                                inputFormatters:[
                                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value)=>Validator.nameValidator(value: value, data: "firstNameIsRequired".tr),
                                controller: _sendMoneyController.firstNameController,
                                level: "firstName".tr,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),
                          Expanded(
                            child: SizedBox(
                              height: 70,
                              child: CustomTextField(
                                inputFormatters:[
                                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value)=>Validator.nameValidator(value: value, data: "lastNameIsRequired".tr),
                                controller: _sendMoneyController.lastNameController,
                                level: "lastName".tr,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4,),
                      
                      Obx(()=>CustomDropdownScarchField<RelationshipModel>(
                          showSearchBox: true,
                            searchhintText: "relationship".tr,
                            onFind: (String? filter) async{
                              var response = await _apiProvider.getSingleData(
                                baseUrl: Strings.baseUrl, 
                                url: Strings.relationshipUrl,
                              );
                              List c = [];
                              for(var i in response["relations"]){
                                c.add(i);
                              }
                              if(c.where((element) => element.toString().contains(_sendMoneyController.relationshipId.value.toString())).isNotEmpty){
                                 
                              }
                              var _c =  c.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                              return _c.map((e) => RelationshipModel.fromJson(e)).toList();
                            },
                            itemAsString: (RelationshipModel? u )=> u!.name.toString(),
                            // label: 'Relationship',
                            hintText: _relationshipController.relationshipname.isEmpty ? "selectRelationship".tr : _relationshipController.relationshipname.value,
                            hintStyle: _relationshipController.relationshipname.isEmpty ? null :TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w500),
                            onChanged: (RelationshipModel? data){
                              _sendMoneyController.relation.value = data!.name.toString();
                              _sendMoneyController.relationshipId.value = data.relationId.toString();
                            },
                            validator:(value) {
                              var data = _relationshipController.relationshipname.isEmpty ? value : _relationshipController.relationshipname.value;
                              if(data == null){
                                return "Relationship is required" .toString();
                              }
                              return null;
                            },
                        ),
                      ),
                      
                      SizedBox(height: 16,),
                      IgnorePointer(
                        child: CustomDropdownScarchField<PaymentTypeModel>(
                          showSearchBox: true,
                          onFind: (String? filter) async{
                              var response = await _apiProvider.getData(
                                baseUrl: Strings.baseUrl, 
                                url: Strings.paymentTypeUrl,
                              );
                              List c = [];
                              for(var i in response["paymentModes"]){ c.add(i);}
                              var _c =  c.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                              return _c.map((e) =>PaymentTypeModel.fromJson(e)).toList();
                          },
                          itemAsString: (PaymentTypeModel? u) => u!.description.toString(),
                          hintText: _sendMoneyController.modeName.isEmpty ? "paymentType".tr :_sendMoneyController.modeName.toString(),
                          hintStyle: _sendMoneyController.modeName.isEmpty ? null :TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w500),
                          onChanged: ( PaymentTypeModel? value){
                              _sendMoneyController.paymentModeId.value = value!.modeId.toString();
                              _sendMoneyController.modeName.value = value.description.toString();
                          },
                        ),
                      ),
                     SizedBox(height: 16,),
                      IgnorePointer(
                        ignoring: true,
                        child: CustomDropdownScarchField<CountryModel>(
                          showSearchBox: true,
                          onFind: (String? filter) async{
                              var response = await _apiProvider.getData(
                                baseUrl: Strings.baseUrl, 
                                url: Strings.getCountriesUrl + "ModeID=${_sendMoneyController.paymentModeId.value}"
                              );
                              List c = [];
                              for(var i in response["countries"]){c.add(i);}
                              var _c =  c.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                              return _c.map((e) => CountryModel.fromJson(e)).toList();
                          },
                          itemAsString: (CountryModel? u) => u!.name.toString(),
                          hintText: _sendMoneyController.countryName.isEmpty ? "searchCountry".tr : _sendMoneyController.countryName.toString(),
                          hintStyle: _sendMoneyController.countryName.isEmpty ? null :TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w500),
                          onChanged: (CountryModel? value){
                              _sendMoneyController.countryId.value = value!.countryId.toString();
                              _sendMoneyController.countryName.value = value.name.toString();
                          },
                        ),
                      ),
                      SizedBox(height: 16,),
                      IgnorePointer(
                        ignoring: true,
                        child: CustomDropdownScarchField<GetCurrenciesModel>(
                          showSearchBox: true,
                          onFind: (String? filter) async{
                              var response = await _apiProvider.getData(
                                baseUrl: Strings.baseUrl, 
                                url: Strings.getCurrenciesUrl + "CountryID=${_sendMoneyController.countryId.value}&ModeID=${_sendMoneyController.paymentModeId.value}"
                              );
                              List c = [];
                              for(var i in response["currencies"]){c.add(i);}
                              var _c =  c.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                              return _c.map((e) => GetCurrenciesModel.fromJson(e)).toList();
                          },
                          itemAsString: (GetCurrenciesModel? u) => u!.name.toString(),
                          hintText: _sendMoneyController.currencycontroller.text.isEmpty ? "selectCorrency".tr : _sendMoneyController.currencycontroller.text.toString(),
                          hintStyle: _sendMoneyController.currencycontroller.text.isEmpty ? null :TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w500),
                          onChanged: ( GetCurrenciesModel? value){
                              _sendMoneyController.currenciesId.value = value!.currencyId.toString();
                              _sendMoneyController.currencycontroller.text = value.name.toString();
                          },
                          isFilteredOnline: false,
                        ),
                      ),
                  
                    
                  if (box.read(Keys.benePayeeModeID).toString() == Keys.accountPayeeID || box.read(Keys.benePayeeModeID).toString() == Keys.mobileWalletID)...[
                      
                      
                      SizedBox(height: 16,),
                      IgnorePointer(
                        ignoring: true,
                        child: CustomDropdownScarchField<SubcompanyModel>(
                          showSearchBox: true,
                          onFind: (String? filter) async{
                            var response = await _apiProvider.getData(
                              baseUrl: Strings.baseUrl, 
                              url: Strings.getSubcompaniesUrl + "CountryID=${_sendMoneyController.countryId.value.toString()}&CurrencyID=${_sendMoneyController.currenciesId.value.toString()}&ModeID=${_sendMoneyController.paymentModeId.value.toString()}&City="
                            );
                            List c = [];
                            for(var i in response["subcompanies"]){c.add(i);}
                            var _c =  c.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                            return _c.map((e) => SubcompanyModel.fromJson(e)).toList();
                          },
                          itemAsString: (SubcompanyModel? u) => u!.name.toString(),
                          hintText: _sendMoneyController.bankandCompanyNamecontroller.text.isEmpty ? "selectSubCompany".tr : _sendMoneyController.bankandCompanyNamecontroller.text.toString(),
                          hintStyle: _sendMoneyController.bankandCompanyNamecontroller.text.isEmpty ? null :TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w500),
                          onChanged: (SubcompanyModel? value){
                            _sendMoneyController.subCompanyBranchID.value = value!.subcompanyId.toString();
                            _sendMoneyController.companyId.value = value.companyId.toString();
                            _sendMoneyController.bankandCompanyNamecontroller.text = value.name.toString();
                          },
                        ),
                      ),
                      SizedBox(height: 16,),
                      CustomTextField(
                        controller:_sendMoneyController.phoneNumberController,
                        hintText: "01xxxxxxx",
                        level: "phoneNumber".tr,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          LengthLimitingTextInputFormatter(15),
                        ],
                        validator: (value)=>Validator.textAreaValidator(value: value, errorText: "phoneNumber".tr),
                      ),
                      SizedBox(height: 16,),
                     CustomDropdownScarchField<BankNameModel>(
                       showSearchBox: true,
                       searchhintText: "bank".tr,
                       onFind: (String? fitter) async {
                         var response = await _apiProvider.getSingleData(
                           baseUrl: Strings.baseUrl,
                            url: box.read(Keys.beneBankID) != null  ? "GlobalService/GetSubcompanyBranches?bankID=${box.read(Keys.beneBankID)}&city=${box.read(Keys.subCompanyBankCity)}&companyID=${_sendMoneyController.companyId.value}&countryID=${_sendMoneyController.countryId.value}&modeID=${_sendMoneyController.paymentModeId.value}&selectBank=true&subcompanyID=${_sendMoneyController.subCompanyId.value}" :
                            "GlobalService/GetSubcompanyBranches?city=${box.read(Keys.subCompanyBankCity)}&companyID=${_sendMoneyController.companyId.value}&countryID=${_sendMoneyController.countryId.value}&modeID=${_sendMoneyController.paymentModeId.value}&selectBank=true&subcompanyID=${_sendMoneyController.subCompanyId.value}"
                         );
                         List c = [];
                         for(var bank in response["benefBanks"]){
                           c.add(bank);
                         }
                         var _c = c.where((element) => element.toString().toLowerCase().contains(fitter!.toLowerCase()));
                         return _c.map((e) => BankNameModel.fromJson(e)).toList();
                       },
                       itemAsString: (BankNameModel? u)=>u!.name.toString(),
                       hintText: _sendMoneyController.bankAndWalletPayeeBankName.value.isEmpty ? 'selectbank'.tr : _sendMoneyController.bankAndWalletPayeeBankName.value,
                       hintStyle: _sendMoneyController.bankAndWalletPayeeBankName.value.isEmpty ? null : TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
                       onChanged: (BankNameModel? v){
                         _sendMoneyController.bankAndWalletPayeebankId.value = v!.bankId.toString();
                         _sendMoneyController.bankAndWalletPayeeBankName.value = v.name.toString();
                         _sendMoneyController.bankCode.value = v.code1.toString();
                         _sendMoneyController.accountNumberController.clear();
                         _sendMoneyController.bankBranchName.value = "";
                         _sendMoneyController.branchCityName.value = "";
                         _sendMoneyController.fullBranchAddressController.clear();
                         _sendMoneyController.bankAndWalletPayeeBankBranchName.value = "";
                         abankcityController.clear();
                         abankBranchController.clear();
                       },
                        validator:(value){
                         var data = _sendMoneyController.bankAndWalletPayeeBankName.value.isEmpty ? value : _sendMoneyController.bankAndWalletPayeeBankName.value;
                         if(data == null){
                           return "bankIsRequired".tr;
                         }
                         return null;
                       },
                     ),
                      SizedBox(height: 16,),

                      if(box.read(Keys.benePayeeModeID).toString() == Keys.accountPayeeID)...[


                        CustomTypeheadField<BenefAccTypesModel>(
                          controller: _relationshipController.beneAccountTypesController,
                          hintText: "Select Account type",
                          noData: "Account type not found",
                          maxLines: 1,
                          suggestionsCallback: (pattern) async {
                            var response = await _apiProvider.getSingleData(
                              baseUrl: Strings.baseUrl,
                              url: box.read(Keys.beneBankID) != null ? "GlobalService/GetSubcompanyBranches?bankID=${box.read(Keys.beneBankID)}&city=${box.read(Keys.subCompanyBankCity)}&companyID=${_sendMoneyController.companyId.value}&countryID=${_sendMoneyController.countryId.value}&modeID=${_sendMoneyController.paymentModeId.value}&selectBank=true&subcompanyID=${_sendMoneyController.subCompanyId.value}" :
                                "GlobalService/GetSubcompanyBranches?city=${box.read(Keys.subCompanyBankCity)}&companyID=${_sendMoneyController.companyId.value}&countryID=${_sendMoneyController.countryId.value}&modeID=${_sendMoneyController.paymentModeId.value}&selectBank=true&subcompanyID=${_sendMoneyController.subCompanyId.value}"
                            );
                            List c =[];
                            for(var i in response["benefAccTypes"]){
                              c.add(i);
                            }
                            var _c = c.where((element) => element.toString().toLowerCase().contains(pattern.toLowerCase()));
                            return _c.map((e) => BenefAccTypesModel.fromJson(e)).toList();
                          },
                          itemBuilder: (BuildContext context, BenefAccTypesModel benefAccTypesModel ) {
                            return ListTile(
                              title: Text("${benefAccTypesModel.name}"),
                            );
                          },
                          onSuggestionSelected: (BenefAccTypesModel benefAccTypesModel) {
                            _relationshipController.beneAccountTypesController.text = benefAccTypesModel.name.toString();

                            _sendMoneyController.accountTypeId.value = benefAccTypesModel.accountTypeId.toString();
                            _sendMoneyController.accountCode.value = benefAccTypesModel.code1.toString();
                            
                          },
                          validator: (value){
                              if (value!.isEmpty) {
                                return 'Account type required';
                              }
                              return null;
                            },
                          ),
                      ],
                      SizedBox(height: 16,),
                      CustomTextField(
                        controller: _sendMoneyController.accountNumberController,
                        hintText: "0233141725987455",
                        level: "Account no".tr,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(30),
                        ],
                        validator: (value)=>Validator.textAreaValidator(value: value, errorText: "Account no is Required"),
                      ),
                      SizedBox(height: 16,),
                      CustomTypeheadField(
                        controller: abankcityController,
                        hintText: "Select Branch city",
                        noData: "Branch city not found",
                        maxLines: 1,
                        suggestionsCallback: (pattern) async {
                          var response = await _apiProvider.getSingleData(
                              baseUrl: Strings.baseUrl,
                              url: Strings.getBankCitiesUrl + "BankID=${_sendMoneyController.bankAndWalletPayeebankId}",
                            );
                            List c =[];
                            for(var i in response["bankCities"]){
                              c.add(i);
                            }
                            var _c = c.where((element) => element.toString().toLowerCase().contains(pattern.toLowerCase()));
                            return _c.map((e) => e.toString()).toList();
                        },
                        itemBuilder: (BuildContext context, city) {
                          return ListTile(
                            title: Text("${city}"),
                          );
                        },
                        onSuggestionSelected: (city) {
                            abankcityController.text = city.toString();
                           _sendMoneyController.branchCityName.value = city.toString();
                           abankBranchController.clear();
                        },
                        validator: (value){
                          if (value!.isEmpty) {
                              return 'branchcityRequired'.tr;
                          }
                          return null;
                        },
                    ),
                    SizedBox(height: 16),
                    CustomTypeheadField<BankBranchModel>(
                       controller: abankBranchController,
                        hintText: "Select Branch name",
                        noData: "Branch name not found",
                        maxLines: 1,
                        suggestionsCallback: (pattern) async {
                          var response = await _apiProvider.getSingleData(
                              baseUrl: Strings.baseUrl,
                              url: Strings.getBankBranchesUrl + "BankID=${_sendMoneyController.bankAndWalletPayeebankId}&City=${ _sendMoneyController.branchCityName.value}",
                            );
                            List c = [];
                            for(var i in response["bankBranches"]){
                              c.add(i);
                            }
                            var _c = c.where((element) => element.toString().toLowerCase().contains(pattern.toLowerCase()));
                            return _c.map((e) => BankBranchModel.fromJson(e)).toList();
                        },
                        itemBuilder: (BuildContext context, BankBranchModel bankBranchModel) {
                          return ListTile(
                            title: Text("${bankBranchModel.name}"),
                          );
                        },
                        onSuggestionSelected: (BankBranchModel data) {
                          abankBranchController.text = data.name.toString();
                          _sendMoneyController.fullBranchAddressController.text = data.address1.toString() + "${data.address2}";
                          _sendMoneyController.bankAndWalletPayeebankBranchId.value = data.bankBranchId.toString();
                          _sendMoneyController.bankBranchName.value =  data.name.toString();
                          _sendMoneyController.bankAndWalletPayeeBankBranchName.value = data.name.toString();
                          _sendMoneyController.branchCode.value = data.code1.toString();
                        },
                        validator: (value){
                          if (value!.isEmpty) {
                              return 'branchNameIsRequired'.tr;
                          }
                          return null;
                        },
                    ),
                    SizedBox(height: 16,),

                  ]else if (box.read(Keys.benePayeeModeID).toString() == Keys.cashPayeeID)...[
                      
                      
                      SizedBox(height: 16,),
                      IgnorePointer(
                        ignoring: true,
                        child: CustomDropdownScarchField(
                            showSearchBox: true,
                            onFind: (String? filter) async {
                              var response = await _apiProvider.getData(
                                  baseUrl: Strings.baseUrl, 
                                  url: Strings.getSubcompaniesCitysUrl + "CountryID=${_sendMoneyController.countryId.value}&CurrencyID=${_sendMoneyController.currenciesId.value}&ModeID=${_sendMoneyController.paymentModeId.value}"
                              );
                              return response["subcompaniesCities"];
                            },
                            hintText: _sendMoneyController.bankCity.value.isEmpty ? "ANY CITY" : _sendMoneyController.bankCity.toString(),
                            hintStyle: TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w500),
                            onChanged: (value){
                              _sendMoneyController.cashsubCompaniCityController.text =  value.toString().isEmpty ? "ANY CITY" : value.toString();
                            },
                        ),
                      ),
                      SizedBox(height: 16,),
                      IgnorePointer(
                        ignoring: true,
                        child: CustomDropdownScarchField<SubcompanyModel>(
                          showSearchBox: true,
                            onFind: (String? filter) async{
                              var response = await _apiProvider.getData(
                                baseUrl: Strings.baseUrl, 
                                url: Strings.getSubcompaniesUrl + "CountryID=${_sendMoneyController.countryId.value.toString()}&CurrencyID=${_sendMoneyController.currenciesId.value.toString()}&ModeID=${_sendMoneyController.paymentModeId.value.toString()}&City=${_sendMoneyController.cashsubCompaniCityController.text}"
                              );
                              List c = [];
                              for(var i in response["subcompanies"]){c.add(i);}
                              var _c =  c.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                              return _c.map((e) => SubcompanyModel.fromJson(e)).toList();
                            },
                            itemAsString: (SubcompanyModel? u) => u!.name.toString(),
                            // hintText: "Company",
                            hintText: _sendMoneyController.bankandCompanyNamecontroller.text.isEmpty ? "Select sub company" : _sendMoneyController.bankandCompanyNamecontroller.text.toString(),
                            hintStyle: _sendMoneyController.bankandCompanyNamecontroller.text.isEmpty ? null :TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w500),
                            //validator:(value)=> Validator.validatorRetrun(value: value, errorText: "Company"),
                            // label: 'Company'.tr,
                            onChanged: (SubcompanyModel? value){
                                _sendMoneyController.subCompanyId.value = value!.subcompanyId.toString();
                                _sendMoneyController.companyId.value = value.companyId.toString();
                                _sendMoneyController.bankandCompanyNamecontroller.text = value.name.toString();
                            },
                        ),
                      ),
                      SizedBox(height: 16,),
                      IgnorePointer(
                        ignoring: true,
                        child: CustomDropdownScarchField<SubcompanyBranchModel>(
                            showSearchBox: true ,
                            onFind: (filter) async{
                              var  response = await _apiProvider.getData(
                                baseUrl: Strings.baseUrl,
                                url: "GlobalService/GetSubcompanyBranches?city=${_sendMoneyController.cashsubCompaniCityController.text}&companyID=${_sendMoneyController.companyId.value}&countryID=${_sendMoneyController.countryId.value}&modeID=${_sendMoneyController.paymentModeId.value}&selectBank=false&subcompanyID=${_sendMoneyController.subCompanyId.value}"
                              );
                              List c = [];
                              for(var branch in response["subcompanyBranches"] ){c.add(branch);}
                              var _c = c.where((e) => e.toString().toLowerCase().contains(filter!.toLowerCase()));
                              return _c.map((e) => SubcompanyBranchModel.fromJson(e)).toList();
                            },
                            itemAsString: (SubcompanyBranchModel? u)=>u!.name.toString(),
                            // hintText: "Branch search".tr,
                            hintText: _sendMoneyController.cashPayeeBankBranchName.isEmpty ? "Select branch name" : _sendMoneyController.cashPayeeBankBranchName.value.toString(),
                            hintStyle: _sendMoneyController.cashPayeeBankBranchName.isEmpty ? null :TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w500),
                            validator:(value){
                              var data = _sendMoneyController.cashPayeeBankBranchName.isEmpty ? value : _sendMoneyController.cashPayeeBankBranchName.value;
                              if(data == null){
                                return "Branch name is required".toString();
                              }
                              return null;
                            },
                            onChanged: (SubcompanyBranchModel? data){
                              _sendMoneyController.cashPayeeBankBranchName.value = data!.name.toString();
                              _sendMoneyController.subCompanyBranchID.value = data.branchId.toString();
                            },
                        ),
                      ),
                      SizedBox(height: 16,),
                      CustomTextField(
                       controller: _sendMoneyController.phoneNumberController,
                        hintText: "01725987455",
                        level: "Phone number".tr,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          LengthLimitingTextInputFormatter(15),
                        ],
                        validator: (value)=>Validator.textAreaValidator(value: value, errorText: "Phone number"),
                      ),
                      SizedBox(height: 16,),
                  ],
                    Row(
                      children: [
                          CustomButton(
                            buttonLevel:"Save & continue".tr,
                            color: AppColor.kGreenColor,
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                formKey.currentState!.save();
                              if(box.read(Keys.benePayeeModeID).toString()  == Keys.accountPayeeID || box.read(Keys.benePayeeModeID).toString() == Keys.mobileWalletID){
                                final Beneficiary _receiverModelData = Beneficiary(
                                    beneficiaryId: int.parse(_sendMoneyController.beneficiaryID.value),
                                    remitterId: int.parse(box.read(Keys.remitterId).toString()),
                                    name: _sendMoneyController.firstNameController.text,
                                    surname: _sendMoneyController.lastNameController.text,
                                    countryId: int.parse(_sendMoneyController.countryId.value),
                                    subCompanyId: int.parse(_sendMoneyController.subCompanyId.value),
                                    currencyId: int.parse(_sendMoneyController.currenciesId.value),
                                    currencyName: _sendMoneyController.currencycontroller.text,
                                    currencyIsoCode: _sendMoneyController.currencyISOCode.value,
                                    companyId: int.parse(_sendMoneyController.companyId.value),
                                    modeId: int.parse(_sendMoneyController.paymentModeId.value),
                                    subCompanyBranchId: int.parse(box.read(Keys.subCompanyBranchID)),
                                    relationId: int.parse(_sendMoneyController.relationshipId.value),
                                    phoneNo: _sendMoneyController.phoneNumberController.text,
                                    birthDate: null,
                                    modeName: _sendMoneyController.modeName.value,
                                    emailAddress: null,
                                    zipCode: null,
                                    countryName: _sendMoneyController.countryName.value,
                                    address1: null,
                                    address2: null,
                                    addressLine: null,
                                    sex: null,
                                    nationality: _sendMoneyController.nationality.value,
                                    nationalityID: int.parse(_sendMoneyController.countryId.value),
                                    accountNo:  _sendMoneyController.accountNumberController.text,
                                    accountTypeId: box.read(Keys.benePayeeModeID).toString() == Keys.accountPayeeID ?  int.parse(_sendMoneyController.accountTypeId.value) : null,
                                    accountCode: box.read(Keys.benePayeeModeID).toString() == Keys.accountPayeeID ?  _sendMoneyController.accountCode.value : null,
                                    bankName: _sendMoneyController.bankAndWalletPayeeBankName.value,
                                    bankId: int.parse(_sendMoneyController.bankAndWalletPayeebankId.value),
                                    bankCode: _sendMoneyController.bankCode.value,
                                    bankBranchId: int.parse(_sendMoneyController.bankAndWalletPayeebankBranchId.value),
                                    bankBranchCode: _sendMoneyController.branchCode.value,
                                    bankBranchAddr: _sendMoneyController.fullBranchAddressController.text,
                                    bankCity: _sendMoneyController.branchCityName.value,
                                    bankBranchName: _sendMoneyController.bankAndWalletPayeeBankBranchName.value,
                                    subcompanyCity:  null,
                                    subCompanyName: _sendMoneyController.bankandCompanyNamecontroller.text, 
                                    subCompanyBranchName: null,
                                    beneficiaryBankName: _sendMoneyController.bankAndWalletPayeeBankName.value
                                );
                              _sendMoneyController.saveReceiverData(SaveReceiverModel(beneficiary: _receiverModelData));
                                _sendMoneyController.reciverEditpay = true;
                              }else{
                              final Beneficiary _receiverModelData = Beneficiary(                             
                                    beneficiaryId: int.parse(_sendMoneyController.beneficiaryID.value),
                                    remitterId: int.parse(box.read(Keys.remitterId).toString()),
                                    name: _sendMoneyController.firstNameController.text,
                                    surname: _sendMoneyController.lastNameController.text,
                                    countryId: int.parse(_sendMoneyController.countryId.value),
                                    subCompanyId: int.parse(_sendMoneyController.subCompanyId.value),
                                    currencyId: int.parse(_sendMoneyController.currenciesId.value),
                                    currencyName: _sendMoneyController.currencycontroller.text,
                                    currencyIsoCode: _sendMoneyController.currencyISOCode.value,
                                    companyId:int.parse(_sendMoneyController.companyId.value),
                                    modeId: int.parse(box.read(Keys.benePayeeModeID)),
                                    subCompanyBranchId: int.parse(box.read(Keys.subCompanyBranchID)),
                                    relationId: int.parse(_sendMoneyController.relationshipId.value),
                                    phoneNo: _sendMoneyController.phoneNumberController.text,
                                    birthDate: null,
                                    modeName: _sendMoneyController.modeName.value,
                                    emailAddress: null,
                                    zipCode: null,
                                    countryName:_sendMoneyController.countryName.value,
                                    address1: null,
                                    address2: null,
                                    addressLine: null,
                                    sex: null,
                                    nationality: _sendMoneyController.nationality.value,
                                    nationalityID: int.parse(_sendMoneyController.countryId.value),
                                    accountNo: null,
                                    bankName:  null,
                                    bankId: null,
                                    bankBranchId:  null,
                                    bankBranchCode: null,
                                    bankBranchAddr: null,
                                    bankCity: null,
                                    bankBranchName: null,
                                    subcompanyCity:  _sendMoneyController.cashsubCompaniCityController.text,
                                    subCompanyName: _sendMoneyController.bankandCompanyNamecontroller.text,
                                    subCompanyBranchName:  _sendMoneyController.cashPayeeBankBranchName.value,
                                    beneficiaryBankName:  null,
                              );
                              _sendMoneyController.saveReceiverData(SaveReceiverModel(beneficiary: _receiverModelData));
                               _sendMoneyController.reciverEditpay = true;
                              };
                              _sendMoneyBaseController.pageController =  PageController(viewportFraction: 1.0);
                              box.write(Keys.transaction, Strings.oldRecevierTransaction);
                              _sendMoneyController.oldreciver.value = true;
                              }
                            },
                          )
                        ],
                      ),
                    ],
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


