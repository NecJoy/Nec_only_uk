// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/helpers.dart';
import 'package:necmoney/core/utils/number_validator.dart';
import 'package:necmoney/widgets/custom_typeheadfield.dart';

import '../../../core/utils/keys.dart';
import '../../../core/values/app_color.dart';
import '../../../core/values/strings.dart';
import '../../../data/model/bank_name_list_model.dart';
import '../../../data/model/get_bank_branches_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../modules/controller/send_money_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../data/model/save_receiver_model.dart';
import '../../../widgets/custom_dropdown_search_field.dart';
import '../../../widgets/custom_textfield.dart';



class ReciverPaymentInfoScreen extends StatelessWidget {
 ReciverPaymentInfoScreen({Key? key}) : super(key: key);
  var box = GetStorage();
  final _fromScreenthree =GlobalKey<FormState>();
  final SendMoneyController _sendMoneyController = Get.put(SendMoneyController());
  final ApiProvider _apiProvider = ApiProvider();
  // final beneAccountTypesController = TextEditingController();
  List benefAccTypes = [];

  @override
  Widget build(BuildContext context) {
    // clearCache();
    return Scaffold(
      body: SingleChildScrollView(
        reverse: false,
        keyboardDismissBehavior:ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key:_fromScreenthree,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('receiverInfo'.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: 8,
                ),
                Text('fillInTheDetailsOfYourRecevierInfromation'.tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 16,),
                if(box.read(Keys.benePayeeModeID) == Keys.accountPayeeID || box.read(Keys.benePayeeModeID) == Keys.mobileWalletID)...[
                    SizedBox(height: 16),
                    CustomDropdownScarchField<BankNameModel>(
                      showSearchBox: true,
                      searchhintText: "bank".tr,
                      onFind: (String? fitter) async {
                        var response = await _apiProvider.getSingleData(
                          baseUrl: Strings.baseUrl,
                          url: box.read(Keys.beneBankID) != "null" ? "GlobalService/GetSubcompanyBranches?bankID=${box.read(Keys.beneBankID)}&city=${box.read(Keys.subCompanyBankCity)}&companyID=${_sendMoneyController.companyId.value}&countryID=${_sendMoneyController.countryId.value}&modeID=${_sendMoneyController.paymentModeId.value}&selectBank=true&subcompanyID=${_sendMoneyController.subCompanyId.value}" :
                           "GlobalService/GetSubcompanyBranches?city=${box.read(Keys.subCompanyBankCity)}&companyID=${_sendMoneyController.companyId.value}&countryID=${_sendMoneyController.countryId.value}&modeID=${_sendMoneyController.paymentModeId.value}&selectBank=true&subcompanyID=${_sendMoneyController.subCompanyId.value}"
                        );
                        benefAccTypes.add(response["benefAccTypes"]);
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

                    CustomTypeheadField(
                        controller: _sendMoneyController.bankBranchCityController,
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
                    SizedBox(height: 16),

                    CustomTypeheadField<BankBranchModel>(
                        controller: _sendMoneyController.bankBranchNameController,
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
                    SizedBox(height: 16),
                ],
                Row(
                  children: [
                    CustomButton(
                      onPressed: (){
                        
                        if (_fromScreenthree.currentState!.validate()) {
                          _fromScreenthree.currentState!.save();
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
                           }else{
                             Helpers.dengerAlert(title: "", message: "");
                           }
                          
                        }
                      },
                      buttonLevel: "continue".tr,
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


