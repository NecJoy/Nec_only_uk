

// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/log.dart';
import '../../../core/utils/keys.dart';
import '../../../data/model/country_model.dart';
import '../../../data/model/get_currencies_model.dart';
import '../../../data/model/get_subcompany_model.dart';
import '../../../data/model/subcompany_branch_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/service/country_phone_number.dart';
import '../../../modules/controller/get_subcompanies_branches_controller.dart';
import '../../../modules/controller/send_money_controller.dart';
import '../../../core/values/app_color.dart';
import '../../../core/values/strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dropdown_search_field.dart';
import '../../../widgets/custom_typeheadfield.dart';
import '../../controller/send_money_base_controller.dart';


class PaymentTypeServiceScreen extends StatelessWidget {
  PaymentTypeServiceScreen({Key? key}) : super(key: key);
  final box = GetStorage();
  final SendMoneyController _sendMoneyController = Get.put(SendMoneyController());
  final GetSubCompaniesBranchesController _getSubCompaniesBranchesController = Get.put(GetSubCompaniesBranchesController());
  final ApiProvider _apiProvider = ApiProvider();
  final SendMoneyBaseController _sendMoneyBaseController = Get.put(SendMoneyBaseController());
  final formScreenone = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // clearCache();
    return Scaffold(
      key: key,
      backgroundColor: AppColor.kWhiteColor,
      body: SingleChildScrollView(
       scrollDirection: Axis.vertical,
        reverse: false,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formScreenone,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(()=>CustomDropdownScarchField<CountryModel>(
                          showSearchBox: true,
                          onFind: (String? filter) async{
                            // List c = [];
                            if ( _sendMoneyController.storecountryList.value.isEmpty){
                              var response = await _apiProvider.getSingleData(
                                baseUrl: Strings.baseUrl, 
                                url: Strings.getCountriesUrl + "ModeID=${_sendMoneyController.paymentModeId.value}"
                              );
                              for(var i in response["countries"]){
                                 _sendMoneyController.storecountryList.value.add(i);
                              }
                              print( _sendMoneyController.storecountryList.value.length);
                             
                            }
                            var _c =   _sendMoneyController.storecountryList.value.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                            return _c.map((e) => CountryModel.fromJson(e)).toList();
                           
                          },
                          itemAsString: (CountryModel? u) => u!.name.toString(),
                         
                          hintText: _sendMoneyController.countryName.value.isEmpty ?  "selectReceiverCountry".tr : _sendMoneyController.countryName.value,
                          hintStyle: _sendMoneyController.countryName.value.isEmpty ? null :TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
                          validator:(CountryModel? value){
                            var data = _sendMoneyController.countryName.value.isEmpty ? value : _sendMoneyController.countryName.value;
                            if(data == null){
                              return "countryIsRequired".tr.toString();
                            }
                            return null;
                          },
                          // label:  'country'.tr,
                          searchhintText: "country".tr,
                          onChanged: (CountryModel? value) {
                            if(_sendMoneyController.currencycontroller.text.toString().isNotEmpty){
                              _sendMoneyController.bankandCompanyNamecontroller.clear();
                              _sendMoneyController.currencycontroller.clear();
                               _sendMoneyController.cashsubCompaniCityController.clear();
                            }
                            if(countryNumberFormat.containsKey(value!.countryId.toString()) == true){
                              _sendMoneyController.hintextNumberFormat.value = countryNumberFormat["${value.countryId}"];
                            }
                            _sendMoneyController.countryId.value = value.countryId.toString();
                            _sendMoneyController.countryName.value = value.name.toString();
                            // _sendMoneyController.countryFlag.value = countryflag["${value.name}"];
                            _sendMoneyController.nationality.value = value.nationality.toString();
                            _sendMoneyController.isoCode.value = value.isoCode.toString();
                             _sendMoneyController.getCurrency(
                              countryId:value.countryId.toString(),
                                modeId: _sendMoneyController.paymentModeId.value,
                               );
                            _sendMoneyController.bankandCompanyNamecontroller.clear();
                            _sendMoneyController.cashsubCompaniCityController.clear();
                            _sendMoneyController.bankandCompanyNamecontroller.clear();
                            _sendMoneyController.cashBranchNameController.clear();
                          },
                      ),
                    ),
                    SizedBox(height: 16,),
                   Obx(()=>( IgnorePointer(
                        ignoring: _sendMoneyController.countryId.value.isEmpty ?  true : false,
                        child: CustomTypeheadField<GetCurrenciesModel>(
                            controller: _sendMoneyController.currencycontroller,
                            hintText: "Select currency",
                            noData: "Currency not found",
                            maxLines: 1,
                            direction: AxisDirection.down,
                            hideKeyboard: true,
                            suggestionsCallback: (pattern) async {
                              var response = await _apiProvider.getSingleData(
                                    baseUrl: Strings.baseUrl, 
                                    url: Strings.getCurrenciesUrl + "CountryID=${_sendMoneyController.countryId.value}&ModeID=${_sendMoneyController.paymentModeId.value}"
                                  );
                                  List c = [];
                                  for(var i in response["currencies"]){
                                    c.add(i);
                                  }
                                  var _c =  c.where((element) => element.toString().toLowerCase().contains(pattern.toLowerCase()));
                                  return _c.map((e) => GetCurrenciesModel.fromJson(e)).toList();
                            },
                            itemBuilder: (BuildContext context, GetCurrenciesModel getCurrenciesModel) {
                              return ListTile(
                                title: Text("${getCurrenciesModel.name}"),
                              );
                            },
                            onSuggestionSelected: (GetCurrenciesModel getCurrenciesModel){
                                 _sendMoneyController.currencycontroller.text = getCurrenciesModel.name.toString();
                                 _sendMoneyController.currenciesId.value = getCurrenciesModel.currencyId.toString();
                                 _sendMoneyController.currencyISOCode.value = getCurrenciesModel.isoCode.toString();
                                _sendMoneyController.getCountryCityWithBank(
                                  countryId: _sendMoneyController.countryId.value,
                                  modeId: _sendMoneyController.paymentModeId.value,
                                  currencyID: getCurrenciesModel.currencyId.toString(),
                                );
                            },
                            validator: (value){
                              if (value!.isEmpty) {
                                  return 'Please select currency';
                              }
                              return null;
                            },
                          ),
                        )
                      ),
                    ),
                    if (box.read(Keys.benePayeeModeID) == Keys.accountPayeeID  || box.read(Keys.benePayeeModeID) == Keys.mobileWalletID)...[
                        SizedBox(height: 16,),
                       Obx(() => (IgnorePointer(
                            ignoring: _sendMoneyController.currenciesId.value.isEmpty ?  true : false,
                            child: CustomTypeheadField<SubcompanyModel>(
                              controller: _sendMoneyController.bankandCompanyNamecontroller,
                              hintText: "Select Bank & company",
                              noData: "Bank & company not found",
                              onTap: (){
                                if(_sendMoneyController.bankandCompanyNamecontroller.text.isNotEmpty){
                                  _sendMoneyController.bankandCompanyNamecontroller.clear();
                                }
                              },
                              direction: AxisDirection.down,
                              hideKeyboard: true,
                              maxLines: 2,
                              suggestionsCallback: (pattern) async {
                                var response = await _apiProvider.getSingleData(
                                    baseUrl: Strings.baseUrl, 
                                    url: Strings.getSubcompaniesUrl + "CountryID=${_sendMoneyController.countryId.value.toString()}&CurrencyID=${_sendMoneyController.currenciesId.value.toString()}&ModeID=${_sendMoneyController.paymentModeId.value.toString()}&City="
                                );
                                List c = [];
                                for(var i in response["subcompanies"]){
                                  c.add(i);
                                }
                                var _c =  c.where((element) => element.toString().toLowerCase().contains(pattern.toLowerCase()));
                                return _c.map((e) => SubcompanyModel.fromJson(e)).toList();
                              },
                              itemBuilder: (BuildContext context, SubcompanyModel subcompanyModel ) {
                                return ListTile(
                                  title: Text("${subcompanyModel.name}"),
                                );
                              },
                              onSuggestionSelected: (SubcompanyModel subcompanyModel){
                                  _sendMoneyController.bankandCompanyNamecontroller.text = subcompanyModel.name.toString();
                                  _sendMoneyController.subCompanyId.value = subcompanyModel.subcompanyId.toString();
                                  _sendMoneyController.companyId.value = subcompanyModel.companyId.toString();
                                 _sendMoneyController.subCompanyCode.value = subcompanyModel.code1.toString();
                                  _getSubCompaniesBranchesController.getSubCompaniesBranchesList(
                                    subcompanyModel.countryId.toString(), 
                                    subcompanyModel.subcompanyId.toString(), 
                                    box.read(Keys.benePayeeModeID).toString(), 
                                    subcompanyModel.companyId.toString(), 
                                  );
                                  cashClear();
                                  box.write(Keys.beneBankID, subcompanyModel.bankId.toString());
                                  Logger(key: "BankId", value: subcompanyModel.bankId.toString());
                                  if(box.read(Keys.benePayeeModeID) == Keys.mobileWalletID) {
                                  _sendMoneyController.autoBankGet(
                                      beneBankID: box.read(Keys.beneBankID), 
                                      companyId: _sendMoneyController.companyId.value, 
                                      countryId: _sendMoneyController.countryId.value, 
                                      paymentModeId: box.read(Keys.benePayeeModeID),
                                      subCompanyId: _sendMoneyController.subCompanyId.value,
                                    );   
                                }
                             },
                              validator: (value){
                                if (value!.isEmpty) {
                                    return 'Please select Bank & Company';
                                }
                                return null;
                              },
                            ),
                          )),
                       ),
                      ]else if (box.read(Keys.benePayeeModeID) == Keys.cashPayeeID)...[
                        SizedBox(height: 8,),
                        Obx(() => ( IgnorePointer(
                            ignoring: _sendMoneyController.currenciesId.value.isEmpty ?  true : false,
                            child: CustomTypeheadField(
                              suggestionsCallback: (pattern) async{
                                var response = await _apiProvider.getSingleData(
                                        baseUrl: Strings.baseUrl, 
                                        url: Strings.getSubcompaniesCitysUrl + "CountryID=${_sendMoneyController.countryId.value}&CurrencyID=${_sendMoneyController.currenciesId.value}&ModeID=${_sendMoneyController.paymentModeId.value}"
                                    );
                                List _c = [];
                                for(var i in response["subcompaniesCities"] ){
                                  _c.add(i);
                                }
                                var c = _c.where((element) => element.toString().toLowerCase().contains(pattern.toString().toLowerCase()));
                                return c.map((e) => e.toString());
                          
                              }, 
                              itemBuilder: (BuildContext context , data){
                                return ListTile(
                                  title: Text("$data"),
                                );
                              },
                              noData: "Data not found",
                              controller:  _sendMoneyController.cashsubCompaniCityController,
                              onTap: (){
                                if(_sendMoneyController.cashsubCompaniCityController.text.isNotEmpty){
                                  _sendMoneyController.cashsubCompaniCityController.clear();
                                }
                              },
                              onSuggestionSelected: (dynamic data){
                                  _sendMoneyController.cashsubCompaniCityController.text = data.toString();
                                  _sendMoneyController.bankandCompanyNamecontroller.clear();
                                  _sendMoneyController.cashBranchNameController.clear();
                              },
                              validator: (value){
                                if (value!.isEmpty){
                                  return "cityofBranchIsRequired".tr.toString();
                                }
                                return null;
                              },
                              hintText: "cityofBranch".tr,
                            ),
                          )),
                        ),
                        SizedBox(height: 16,),
                        Obx(() =>(IgnorePointer(
                            ignoring: _sendMoneyController.currenciesId.value.isEmpty && _sendMoneyController.cashsubCompaniCityController.text.isEmpty ?  true : false,
                            child: CustomTypeheadField<SubcompanyModel>(
                                controller: _sendMoneyController.bankandCompanyNamecontroller,
                                hintText: "Select Bank & company",
                                noData: "Bank & company not found",
                                maxLines: 2,
                                direction: AxisDirection.down,
                                hideKeyboard: true,
                                onTap: (){
                                  if(_sendMoneyController.bankandCompanyNamecontroller.text.isNotEmpty){
                                    _sendMoneyController.bankandCompanyNamecontroller.clear();
                                  }
                                },
                                suggestionsCallback: (pattern) async {
                                  var response = await _apiProvider.getSingleData(
                                      baseUrl: Strings.baseUrl, 
                                      url: Strings.getSubcompaniesUrl + "CountryID=${_sendMoneyController.countryId.value.toString()}&CurrencyID=${_sendMoneyController.currenciesId.value.toString()}&ModeID=${_sendMoneyController.paymentModeId.value.toString()}&City=${_sendMoneyController.cashsubCompaniCityController.text}"
                                  );
                                  List c = [];
                                  for(var i in response["subcompanies"]){
                                    c.add(i);
                                  }
                                  var _c =  c.where((element) => element.toString().toLowerCase().contains(pattern.toLowerCase()));
                                  return _c.map((e) => SubcompanyModel.fromJson(e)).toList();
                                },
                                itemBuilder: (BuildContext context, SubcompanyModel subcompanyModel ) {
                                  return ListTile(
                                    title: Text("${subcompanyModel.name}"),
                                  );
                                },
                                onSuggestionSelected: (SubcompanyModel subcompanyModel) {
                                  _sendMoneyController.bankandCompanyNamecontroller.text = subcompanyModel.name.toString();
                                  _sendMoneyController.subCompanyId.value = subcompanyModel.subcompanyId.toString();
                                  _sendMoneyController.companyId.value = subcompanyModel.companyId.toString();
                                  _sendMoneyController.cashBranchNameController.clear();
                                  //_sendMoneyController.subCompanyCode.value = subcompanyModel.code1.toString();
                              },
                                validator: (value){
                                  if (value!.isEmpty) {
                                      return 'Please select Bank & Company';
                                  }
                                  return null;
                                },
                            ),
                          )),
                        ),
                        SizedBox(height: 16),
                       Obx(() =>(IgnorePointer(
                          ignoring:  _sendMoneyController.subCompanyId.value.isEmpty && _sendMoneyController.companyId.value.isEmpty ?  true : false,
                            child: CustomTypeheadField<SubcompanyBranchModel>(
                               controller: _sendMoneyController.cashBranchNameController,
                               onTap: (){
                                if(_sendMoneyController.cashBranchNameController.text.isNotEmpty){
                                  _sendMoneyController.cashBranchNameController.clear();
                                }
                               },
                                hintText: "branchName".tr,
                                noData: "Branch name not found",
                                maxLines: 1,
                                suggestionsCallback: (pattern) async {
                                  var  response = await _apiProvider.getSingleData(
                                    baseUrl: Strings.baseUrl,
                                      url: "GlobalService/GetSubcompanyBranches?city=${_sendMoneyController.cashsubCompaniCityController.text}&companyID=${_sendMoneyController.companyId.value}&countryID=${_sendMoneyController.countryId.value}&modeID=${_sendMoneyController.paymentModeId.value}&selectBank=false&subcompanyID=${_sendMoneyController.subCompanyId.value}"
                                    );
                                    List c = [];
                                    for(var branch in response["subcompanyBranches"] ){
                                      c.add(branch);
                                    }
                                    var _c = c.where((e) => e.toString().toLowerCase().contains(pattern.toLowerCase()));
                                    return _c.map((e) => SubcompanyBranchModel.fromJson(e)).toList();
                                },
                                itemBuilder: (BuildContext context, SubcompanyBranchModel subcompanyModel ) {
                                  return ListTile(
                                    title: Text("${subcompanyModel.name}"),
                                  );
                                },
                                onSuggestionSelected: (SubcompanyBranchModel subcompanyBranchModel) {
                                  _sendMoneyController.cashBranchNameController.text = subcompanyBranchModel.name.toString();
                                    _sendMoneyController.cashPayeeBankBranchName.value = subcompanyBranchModel.name.toString();
                                    _sendMoneyController.cashsubCompanyBranchId.value = subcompanyBranchModel.branchId.toString();
                                },
                                validator: (value){
                                  if (value!.isEmpty) {
                                      return 'Please select Branch name';
                                  }
                                  return null;
                                },
                            ),
                          )
                        ),
                       ),
                      ],
                      SizedBox(height: 16),
                      Row(
                      children: [
                        CustomButton(
                          buttonLevel: "continue".tr,
                          color: AppColor.kGreenColor,
                          onPressed: (){
                            if(formScreenone.currentState!.validate()){
                              formScreenone.currentState!.save();
                              _sendMoneyBaseController.NavigateSteep();
                              if(box.read(Keys.benePayeeModeID) == Keys.mobileWalletID){
                                _sendMoneyController.autoBankCitiesGet();
                                _sendMoneyController.autoGetBankBranches();
                              }
                            }
                          },
                        )
                      ],
                    ),
                 ],
               ),
            ),
          )
        ),
      ),
    );
  }
  cashClear (){
    _sendMoneyController.bankAndWalletPayeebankId.value = "";
    _sendMoneyController.bankAndWalletPayeeBankName.value = "";
    _sendMoneyController.bankCode.value = "";
    _sendMoneyController.accountNumberController.clear();
    _sendMoneyController.bankBranchCityController.clear();            
    _sendMoneyController.bankBranchNameController.clear();
  }
}

