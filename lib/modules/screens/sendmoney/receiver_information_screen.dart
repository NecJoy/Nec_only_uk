// ignore_for_file: unused_field, invalid_use_of_protected_member, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/helpers.dart';
import '../../../core/utils/country_flag.dart';
import '../../../core/utils/keys.dart';
import '../../../core/values/app_color.dart';
import '../../../core/utils/number_validator.dart';
import '../../../core/values/strings.dart';
import '../../../data/model/bank_name_list_model.dart';
import '../../../data/model/get_bank_branches_model.dart';
import '../../../data/model/relationship_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../modules/controller/get_dealing_rate_controller.dart';
import '../../../modules/controller/get_subcompanies_branches_controller.dart';
import '../../../modules/controller/send_money_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../core/utils/validator.dart';
import '../../../data/model/save_receiver_model.dart';
import '../../../widgets/custom_dropdown_search_field.dart';
import '../../../widgets/custom_phone_number_field.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/custom_typeheadfield.dart';
import '../../controller/payment_mode_controller.dart';
import '../../controller/send_money_base_controller.dart';

class ReciverInformationScreen extends StatelessWidget {
   ReciverInformationScreen({Key? key}) : super(key: key);
  final box = GetStorage();
  final _formScreentwo = GlobalKey<FormState>();
  final SendMoneyController _sendMoneyController = Get.put(SendMoneyController());
  final GetSubCompaniesBranchesController _getSubCompaniesBranchesController = Get.put(GetSubCompaniesBranchesController());
  final PaymentTypeController _paymentModeController = Get.put(PaymentTypeController());
  final GetDealingRateContoller _getDealingRateContoller = Get.put(GetDealingRateContoller());
  final SendMoneyBaseController _sendMoneyBaseController = Get.put(SendMoneyBaseController());
  final ApiProvider _apiProvider = ApiProvider();
  final List benefAccTypes = [];
  List<BankNameModel> benefBanks = <BankNameModel>[];


  @override
  Widget build(BuildContext context) {
  benefBanks = [];
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formScreentwo,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('receiverInfo'.tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 8),
                    Text('fillInTheDetailsOfYourRecevierInfromation'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(height: 8,),
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
                CustomDropdownScarchField<RelationshipModel>(
                  showSearchBox: true,
                  searchhintText: "relationship".tr,
                    onFind: (String? filter) async{
                      if(_sendMoneyController.storeRelationshipList.value.isEmpty){
                        var response = await _apiProvider.getSingleData(
                          baseUrl: Strings.baseUrl, 
                          url: Strings.relationshipUrl,
                        );
                        for(var i in response["relations"]){
                          _sendMoneyController.storeRelationshipList.value.add(i);
                        }
                      }
                   
                      var _c =  _sendMoneyController.storeRelationshipList.value.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                      return _c.map((e) => RelationshipModel.fromJson(e)).toList();
                    },
                    itemAsString: (RelationshipModel? u )=> u!.name.toString(),
                   
        
                    hintText: _sendMoneyController.relation.value.isEmpty ?  "selectYourRelationship".tr : _sendMoneyController.relation.value,
                    hintStyle:_sendMoneyController.relation.value.isEmpty ? null :TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
                    onChanged: (RelationshipModel? data){
                      _sendMoneyController.relation.value = data!.name.toString();
                      _sendMoneyController.relationshipId.value = data.relationId.toString();
                    },
                    validator:(value) {
                      var data = _sendMoneyController.relation.value.isEmpty ? value : _sendMoneyController.relation.value;
                      if(data == null){
                        return "relationshipIsRequired".tr.toString();
                      }
                      return null;
                    },
                ),
                SizedBox(height: 16),
                if(_sendMoneyController.subCompanyId.value.toString() != Keys.BkashSubCompanyID)...[
                  Text('Receiver Phone number',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                ]else...[
                  Text('bKash Wallet Number',
                  style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                SizedBox(height: 8,),
                  CustomPhoneNumberField (  
                    controller: _sendMoneyController.phoneNumberController,                   
                    autofocus: false,
                    flag: flagWithCountry.showflagWithCountry(_sendMoneyController.countryId.value),
                    hintText: "${_sendMoneyController.hintextNumberFormat.value}",
                    onChanged: (data){
                       _sendMoneyController.phoneNumber.value = data.number;
                    },
                    countryIsoCode:[_sendMoneyController.isoCode.value],
                  ),
                  if(box.read(Keys.benePayeeModeID) == Keys.mobileWalletID)...[
                    if(_sendMoneyController.subCompanyId.value.toString() != Keys.BkashSubCompanyID)...[
                      SizedBox(height: 8),
                      Obx(()=>Text("${_sendMoneyController.subCompanyWalletName.value.toString().replaceAll(RegExp( r'[^\w\s][dbbl)]+'), "")}",style: Theme.of(context).textTheme.bodyMedium,),),
                      SizedBox(height: 8,),
                      CustomTextField(
                        controller:  _sendMoneyController.walletNumberController,
                        hintText: "01300000000",
                        level: "walletNumber".tr,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          LengthLimitingTextInputFormatter(25),
                        ],
                        validator: (value)=> AccoutNumberValidator.ValidatorFormate(value , 6),
                      ),
                    ],
                    SizedBox(height: 16,),
                    Obx(()=> IgnorePointer(
                        ignoring: false,
                        child: CustomDropdownScarchField<BankBranchModel>(
                          onFind: (filtter) async {
                            var response = await _apiProvider.getSingleData(
                              baseUrl: Strings.baseUrl,
                              url: Strings.getBankBranchesUrl + "BankID=${_sendMoneyController.bankAndWalletPayeebankId}&City=${ _sendMoneyController.branchCityName.value}",
                            );
                            List c = [];
                            for(var i in response["bankBranches"]){
                              c.add(i);
                            }
                            var _c = c.where((element) => element.toString().toLowerCase().contains(filtter!.toLowerCase()));
                            return _c.map((e) => BankBranchModel.fromJson(e)).toList();
                          },
                          itemAsString: (BankBranchModel? u)=> u!.name.toString(),
                          showSearchBox: true,
                          hintText: _sendMoneyController.bankAndWalletPayeeBankBranchName.value.isEmpty ?  "branchName".tr : _sendMoneyController.bankAndWalletPayeeBankBranchName.value,
                          hintStyle: _sendMoneyController.bankAndWalletPayeeBankBranchName.value.isEmpty ? null : TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
                          validator:(BankBranchModel? value){
                            var data  = _sendMoneyController.bankAndWalletPayeeBankBranchName.value.isEmpty ? value : _sendMoneyController.bankAndWalletPayeeBankBranchName.value;
                            if(data == null){
                              return "branchNameIsRequired".tr;
                            }
                            return null;
                          },
                          // label: 'branchName'.tr,
                          searchhintText: "branchName".tr,
                          onChanged: (BankBranchModel? data ){
                            _sendMoneyController.fullBranchAddressController.text = data!.fullAddress!;
                            _sendMoneyController.bankAndWalletPayeebankBranchId.value = data.bankBranchId.toString();
                             _sendMoneyController.branchCode.value = data.code1.toString();
                            _sendMoneyController.bankAndWalletPayeeBankBranchName.value = data.name.toString();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                  if(box.read(Keys.benePayeeModeID) == Keys.accountPayeeID)...[
                    SizedBox(height: 16),
                    CustomDropdownScarchField<BankNameModel>(
                      showSearchBox: true,
                      searchhintText: "bank".tr,
                      onFind: (String? fitter) async {
                        if(benefBanks.isEmpty){
                          var response = await _apiProvider.getSingleData(
                            baseUrl: Strings.baseUrl,
                            url: box.read(Keys.beneBankID) != "null" ? "GlobalService/GetSubcompanyBranches?bankID=${box.read(Keys.beneBankID)}&city=${box.read(Keys.subCompanyBankCity)}&companyID=${_sendMoneyController.companyId.value}&countryID=${_sendMoneyController.countryId.value}&modeID=${_sendMoneyController.paymentModeId.value}&selectBank=true&subcompanyID=${_sendMoneyController.subCompanyId.value}" :
                            "GlobalService/GetSubcompanyBranches?city=${box.read(Keys.subCompanyBankCity)}&companyID=${_sendMoneyController.companyId.value}&countryID=${_sendMoneyController.countryId.value}&modeID=${_sendMoneyController.paymentModeId.value}&selectBank=true&subcompanyID=${_sendMoneyController.subCompanyId.value}"
                          );
                          benefAccTypes.add(response["benefAccTypes"]);
                          for(var bank in response["benefBanks"]){
                           benefBanks.add(BankNameModel.fromJson(bank));
                          }
                        }
                        List<BankNameModel> _c = benefBanks.where((element) => element.name.toString().toLowerCase().contains(fitter!.toLowerCase())).toList();
                        return _c;
                      },
                      itemAsString: (BankNameModel? u)=> u!.name.toString(),
                      hintText: _sendMoneyController.bankAndWalletPayeeBankName.value.isEmpty ? 'selectbank'.tr : _sendMoneyController.bankAndWalletPayeeBankName.value,
                      hintStyle: _sendMoneyController.bankAndWalletPayeeBankName.value.isEmpty ? null : TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
                      onChanged: (BankNameModel? v){
                        _sendMoneyController.bankAndWalletPayeebankId.value = v!.bankId.toString();
                        _sendMoneyController.bankAndWalletPayeeBankName.value = v.name.toString();
                        _sendMoneyController.bankCode.value = v.code1.toString();
                        _sendMoneyController.accountNumberController.clear();
                        _sendMoneyController.bankBranchCityController.clear();
                        _sendMoneyController.bankBranchNameController.clear();
                        if(benefAccTypes.isNotEmpty){
                          _sendMoneyController.autoGetAccountType();
                        }
                      },
                       validator:(value){
                        var data = _sendMoneyController.bankAndWalletPayeeBankName.value.isEmpty ? value : _sendMoneyController.bankAndWalletPayeeBankName.value;
                        if(data == null){
                          return "bankIsRequired".tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),       
                    Obx(() =>  CustomTextField(
                      controller: _sendMoneyController.accountNumberController,
                      hintText: _sendMoneyController.countryId.value == "179" ? "PK36SCBL0000001123456702" : "0233141725987455",
                      level: _sendMoneyController.countryId.value == "179" ? "ibanNumber".tr : "enterBankAccountNumber".tr,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      validator: (value) => AccoutNumberValidator.ValidatorFormate(value , 10),
                      ),
                    ),
                       
                    SizedBox(height: 16),

                    Obx(()=>( IgnorePointer(
                        ignoring: _sendMoneyController.bankAndWalletPayeebankId.value.isEmpty ?  true : false,
                        child: CustomTypeheadField(
                            controller: _sendMoneyController.bankBranchCityController,
                            hintText: "Select Branch city",
                            noData: "Branch city not found",
                            maxLines: 1,
                            suggestionsCallback: (pattern) async {
                              var response = await _apiProvider.getSingleData(
                                  baseUrl: Strings.baseUrl,
                                  url: Strings.getBankCitiesUrl + "BankID=${_sendMoneyController.bankAndWalletPayeebankId.value}",
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
                               _sendMoneyController.branchCityName.value = city.toString();
                               _sendMoneyController.bankBranchCityController.text = city.toString();
                                _sendMoneyController.bankBranchNameController.clear();
                            },
                            validator: (value){
                              if (value!.isEmpty) {
                                  return 'branchcityRequired'.tr;
                              }
                              return null;
                            },
                        ),
                      )),
                    ),
                    SizedBox(height: 16),
                    Obx(()=>( IgnorePointer(
                        ignoring: _sendMoneyController.branchCityName.value.isEmpty ?  true : false,
                        child: CustomTypeheadField<BankBranchModel>(
                            controller: _sendMoneyController.bankBranchNameController,
                            hintText: "Select Branch name",
                            noData: "Branch name not found",
                            maxLines: 1,
                            suggestionsCallback: (pattern) async {
                              var response = await _apiProvider.getSingleData(
                                  baseUrl: Strings.baseUrl,
                                  url: Strings.getBankBranchesUrl + "BankID=${_sendMoneyController.bankAndWalletPayeebankId.value}&City=${ _sendMoneyController.branchCityName.value}",
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
                              _sendMoneyController.bankBranchNameController.text = data.name.toString();
                              _sendMoneyController.fullBranchAddressController.text = data.address1.toString() + " ${data.address2.toString()}";
                              _sendMoneyController.bankAndWalletPayeebankBranchId.value = data.bankBranchId.toString();
                              _sendMoneyController.branchCode.value = data.code1.toString();
                              _sendMoneyController.bankAndWalletPayeeBankBranchName.value = data.name.toString();
                            },
                            validator: (value){
                              if (value!.isEmpty) {
                                  return 'branchNameIsRequired'.tr;
                              }
                              return null;
                            },
                        ),
                      )),
                    ),
                    SizedBox(height: 16),
                ],
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      CustomButton(
                        buttonLevel: "continue".tr,
                        color: AppColor.kGreenColor,
                        onPressed: (){
                          if(_formScreentwo.currentState!.validate()){
                            _formScreentwo.currentState!.save();
                            Helpers.keyboardhide();
                            if(box.read(Keys.benePayeeModeID) == Keys.cashPayeeID ){
                              final Beneficiary _receiverModelData = Beneficiary(
                                  beneficiaryId: 0,
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
                                  subCompanyBranchId: int.parse(_sendMoneyController.cashsubCompanyBranchId.value),
                                  relationId: int.parse(_sendMoneyController.relationshipId.value),
                                  phoneNo: _sendMoneyController.phoneNumber.value,
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
                                _sendMoneyController.oldreciver.value = false;
                                _sendMoneyController.saveReceiverData(SaveReceiverModel(beneficiary: _receiverModelData));
                              }else if (box.read(Keys.benePayeeModeID) == Keys.mobileWalletID){
                                final Beneficiary _receiverModelData = Beneficiary(
                                  beneficiaryId:0,
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
                                  subCompanyBranchId: box.read(Keys.subCompanyBranchID),
                                  subCompanyBranchCode: null,
                                  relationId: int.parse(_sendMoneyController.relationshipId.value),
                                  phoneNo: _sendMoneyController.phoneNumber.value,
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
                                  accountNo: _sendMoneyController.subCompanyId.value.toString() == Keys.BkashSubCompanyID ? _sendMoneyController.phoneNumber.value : _sendMoneyController.walletNumberController.text ,
                                  accountTypeId: null,
                                  accountCode:  null,
                                  bankName: _sendMoneyController.bankAndWalletPayeeBankName.value,
                                  bankId: int.parse(_sendMoneyController.bankAndWalletPayeebankId.value),
                                  bankCode: _sendMoneyController.bankCode.value,
                                  bankBranchId: int.parse(_sendMoneyController.bankAndWalletPayeebankBranchId.value),
                                  bankBranchCode: _sendMoneyController.branchCode.value,
                                  bankBranchAddr: _sendMoneyController.fullBranchAddressController.text,
                                  bankCity: _sendMoneyController.branchCityName.value,
                                  bankBranchName: _sendMoneyController.bankAndWalletPayeeBankBranchName.value,
                                  subcompanyCity: null,
                                  subCompanyName: _sendMoneyController.bankandCompanyNamecontroller.text, 
                                  subCompanyBranchName: null,
                                  beneficiaryBankName:_sendMoneyController.bankAndWalletPayeeBankName.value
                                );
                                _sendMoneyController.oldreciver.value = false;
                                _sendMoneyController.saveReceiverData(SaveReceiverModel(beneficiary: _receiverModelData));
                              }else if(box.read(Keys.benePayeeModeID) == Keys.accountPayeeID){
                               final Beneficiary _receiverModelData = Beneficiary(
                                beneficiaryId:0,
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
                                subCompanyBranchId: box.read(Keys.subCompanyBranchID),
                                subCompanyBranchCode: null,
                                relationId: int.parse(_sendMoneyController.relationshipId.value),
                                phoneNo: _sendMoneyController.phoneNumber.value,
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
                                accountTypeId: _sendMoneyController.accountTypeId.value.isEmpty ? null :  int.parse(_sendMoneyController.accountTypeId.value),
                                accountCode: _sendMoneyController.accountCode.value,
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
                              _sendMoneyController.oldreciver.value = false;
                              if(_sendMoneyController.branchCityName.value.isNotEmpty && _sendMoneyController.branchCode.value.isNotEmpty){
                                _sendMoneyController.saveReceiverData(SaveReceiverModel(beneficiary: _receiverModelData));
                              }
                             }
                          
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
      );
    }
  }

