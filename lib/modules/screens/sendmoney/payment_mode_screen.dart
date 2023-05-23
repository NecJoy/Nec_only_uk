// ignore_for_file: must_be_immutable


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/helpers.dart';
import 'package:necmoney/modules/controller/receiver_list_controller.dart';
import 'package:sizer/sizer.dart';
import '../../../core/values/app_color.dart';
import '../../../data/model/instrument_model.dart';
import '../../../data/model/purpose_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../modules/controller/save_remittance_controller.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_button.dart';
import '../../../core/utils/keys.dart';
import '../../../core/values/strings.dart';
import '../../../widgets/custom_dropdown_search_field.dart';
import '../../controller/get_customer_commission_controller.dart';
import '../../controller/send_money_controller.dart';


class PaymentModeScreen extends StatelessWidget {
  final SaveRemittanceController _saveRemittanceController = Get.put(SaveRemittanceController());
  final GetCustomerComissionController _getCustomerComissionController = Get.put(GetCustomerComissionController());
  final SendMoneyController _sendMoneyController = Get.put(SendMoneyController());
  // final GetRemitterInfo _getRemitterInfo = Get.put(GetRemitterInfo());
  final ApiProvider _apiProvider = ApiProvider();
  final _formKey = GlobalKey<FormState>();
  final  ReceiverListController _receiverListController = Get.put(ReceiverListController());
  final box = GetStorage();
  List instrumentTypes = [];
  List purposesList = [];

  PaymentModeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('paymentMode'.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text('pleaseselectyourPaymentMode'.tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  AspectRatio(
                    aspectRatio: 1.4,
                    child: SvgPicture.asset("assets/logo/payment.svg"),
                  ),
                  CustomDropdownScarchField<PurposeModel>(
                    showSearchBox: true,
                    searchhintText: "purpose Of Issue",
                    onFind: (String? filter) async{
                      if(purposesList.isEmpty){
                          var response = await _apiProvider.getSingleData(
                            baseUrl: Strings.baseUrl, 
                            url: Strings.purposeUrl + "RemitterID=${box.read(Keys.remitterId)}",
                          );

                          //user payment type 
                          for(var i in response["instrumentTypes"]){
                              instrumentTypes.add(i);
                          }
                          box.write(Keys.exchangeLCIsoCode, response["exchangeLCIsoCode"]);
                          box.write(Keys.remAddress, response["remAddress"]);
                          box.write(Keys.remCountyCode, response["remCountryIsoCode"]);
                          box.write(Keys.remCity, response["remCity"]);
                          box.write(Keys.loginId, response["remEmailAddress"]);
                          box.write(Keys.remName, response["remName"]);
                          box.write(Keys.remSurname, response["remSurname"]);
                          box.write(Keys.remZipCode, response["remZipCode"]);
                          box.write(Keys.remitterPhoneNumber, response["remPhoneNo"]);
                          for(var i in response["purposes"]){
                           purposesList.add(i);
                          }
                          box.write(Keys.aesKey, response["baseKey"]);

                      }
                      var _c =  purposesList.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                      return _c.map((e) => PurposeModel.fromJson(e)).toList();
                    },
                    itemAsString: (PurposeModel? data)=>data!.name.toString(),
                    // label: 'purposeOfIssue'.tr,
                    hintText: _sendMoneyController.purposeOfIssueName.value.isEmpty ? 'purposeOfIssue'.tr :  _sendMoneyController.purposeOfIssueName.value ,
                    hintStyle: _sendMoneyController.purposeOfIssueName.value.isEmpty ? null :TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
                    validator:(PurposeModel? value){
                      var data =  _sendMoneyController.purposeOfIssueName.value.isEmpty ? value :  _sendMoneyController.purposeOfIssueName.value;
                      if(data == null){
                        return "purposeOfIssueIsRequired".tr;
                      }
                      return null;
                    },
                    onChanged: (PurposeModel? value){
                      _sendMoneyController.purposeOfIssueId.value = value!.purposeId.toString();
                      _sendMoneyController.purposeOfIssueName.value = value.name.toString();
                    },
                  ),
                  SizedBox(height: 16,),
                  CustomDropdownScarchField<InstrumentModel>(
                    showSearchBox: true,
                    onFind: (String? filter) async{
                     if(instrumentTypes.isEmpty){
                        var response = await _apiProvider.getSingleData(
                          baseUrl: Strings.baseUrl, 
                          url: Strings.instrumentUrl + "RemitterID=${box.read(Keys.remitterId).toString()}",
                        );
                        box.write(Keys.remitNoPrefix ,response["remitNoPrefix"]);
                      
                        for(var i in response["instrumentTypes"]){
                          instrumentTypes.add(i);
                        }
                     }
                      var _c =  instrumentTypes.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                      return _c.map((e) =>InstrumentModel.fromJson(e)).toList();
                    },
                    itemAsString: (InstrumentModel? u)=>u!.name.toString(),
                    searchhintText: "paymentMode".tr,
                    // label: 'Payment mode',
                    hintText: _sendMoneyController.paymentModeCardName.value.isEmpty ? 'Payment mode' : _sendMoneyController.paymentModeCardName.value,
                    hintStyle: _sendMoneyController.paymentModeCardName.value.isEmpty ? null :TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w400),
                    validator:(InstrumentModel? value){
                      var data = _sendMoneyController.paymentModeCardName.value.isEmpty ? value : _sendMoneyController.paymentModeCardName.value;
                      if(data == null){
                        return "paymentModeIsRequired".tr;
                      }
                      return null;
                    },
                    onChanged: (InstrumentModel? value){
                      if(value!.name == "VISA" || value.name == "MASTERCARD"){
                       //_getRemitterInfo.getRemitterDetailsForPayment(box.read(Keys.remitterId).toString());
                      }
                      if(value.name == "BANK TRANSFER"){
                        box.write(Keys.paymentModeName, "BNKXFR");
                      }else{
                        box.write(Keys.paymentModeName, value.name.toString());
                      }
                      // box.write(Keys.remCounty, value)
                      _sendMoneyController.paymentModeCardId.value = value.instrumentTypeId.toString();
                      _sendMoneyController.paymentModeCardName.value = value.name.toString();
                    },
                  ),
                  SizedBox(height: 32,),
                  Row(
                    children: [
                      CustomButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()) {
                            //  box.write(Keys.transaction, 1);
                            _formKey.currentState!.save();
                            if(_getCustomerComissionController.transactionAmountController.text.isEmpty){
                                Helpers.dengerAlert(title: "Warning", message: "Please enter valid amount . Your amount ${_getCustomerComissionController.transactionAmountController.text} ");
                            }else if(box.read(Keys.benePhoneNumber).toString().isNotEmpty && _sendMoneyController.lastNameController.text.isNotEmpty && _sendMoneyController.firstNameController.text.isNotEmpty && _sendMoneyController.beneficiaryID.value.isNotEmpty && _sendMoneyController.countryId.value.isNotEmpty){
                            if((box.read(Keys.benePayeeModeID) == Keys.mobileWalletID)){
                             final walletPayPlainText  = """{
                              "remittanceNoPrefix": "${box.read(Keys.remitNoPrefix)}",
                              "adjustedDCAmount": 0,
                              "beneAccNo": "${box.read(Keys.walletNumber)}",
                              "benePhone": "${box.read(Keys.benePhoneNumber)}",
                              "beneAccTypeID": 199,
                              "beneAmount": "${_getCustomerComissionController.receiverAmountController.text}",
                              "beneBankName": "${box.read(Keys.beneBankName)}",
                              "beneBankBranchID": ${box.read(Keys.beneBankBranchID)},
                              "beneBankID": ${box.read(Keys.beneBankID)},
                              "beneBranchName": "${box.read(Keys.beneBranchName)}",
                              "beneBrnAddress": "ANYWHERE",
                              "beneCountryID": ${int.parse(_sendMoneyController.countryId.value)},
                              "beneCurrencyID": ${int.parse(_sendMoneyController.currenciesId.value)},
                              "beneDocID": null,
                              "beneDocNo": "",
                              "beneficiaryID": ${int.parse(_sendMoneyController.beneficiaryID.value.toString())},
                              "beneficiarySurname": "${_sendMoneyController.lastNameController.text.toUpperCase()}",
                              "beneficiaryName": "${_sendMoneyController.firstNameController.text.toUpperCase()}",
                              "relationID": ${int.parse(_sendMoneyController.relationshipId.value.toString())},
                              "benePayeeModeID": ${box.read(Keys.benePayeeModeID)},
                              "subCompanyBranchID": ${box.read(Keys.subCompanyBranchID)},
                              "companyID": ${int.parse(_sendMoneyController.companyId.value.toString())},
                              "subCompanyID": ${int.parse(_sendMoneyController.subCompanyId.value.toString())},
                              "debitCardID": null,
                              "discountedComm": 0,
                              "encashedPoint": 0,
                              "encashedPointAmount": 0,
                              "equiAmount": ${_getCustomerComissionController.transactionAmountController.text},
                              "ofrdAmount": ${_getCustomerComissionController.transactionAmountController.text},
                              "equiCommission": ${_getCustomerComissionController.fee.value},
                              "ofrdCommission": ${_getCustomerComissionController.fee.value},
                              "taxAmount": 0,
                              "cardCharge": 0,
                              "instrumentDetail": "",
                              "instrumentTypeID": "${int.parse(_sendMoneyController.paymentModeCardId.value.toString())}",
                              "maturityDate": "${DateTime.now()}",
                              "issueDate": "${DateTime.now()}",
                              "othrRcvdAmount": 0,
                              "othrRcvdCommission": 0,
                              "pDRate": ${box.read(Keys.dealingRate)}, 
                              "purposeDetail": "${_sendMoneyController.purposeOfIssueName.value}",
                              "purposeID": "${int.parse(_sendMoneyController.purposeOfIssueId.value.toString())}",
                              "aMLRemBhvClsID": null,
                              "aMLRemBhvClsValue": 0,
                              "aMLOpVoteClsID": null,
                              "aMLOpVoteClsValue": 0,
                              "aMLCoopClsID": null,
                              "aMLCoopClsValue": 0,
                              "aMLOpTypeClsID": null,
                              "aMLOpTypeClsValue": 0,
                              "fldPsfx": "",
                              "cdType": "${box.read(Keys.paymentModeName)}",
                              "cdNo": "",
                              "cdExp": "",
                              "cdSecCode": ""
                            }""";
                              _saveRemittanceController.saveRemittance(walletPayPlainText);
                              // Clipboard.setData(new ClipboardData(text: walletPayPlainText));
                            }else if((box.read(Keys.benePayeeModeID) == Keys.accountPayeeID)){
                              final accountPayPlainText  = """{
                                "remittanceNoPrefix": "${box.read(Keys.remitNoPrefix)}",
                                "adjustedDCAmount": 0,
                                "beneAccNo": "${box.read(Keys.beneAccNo)}",
                                "benePhone": "${box.read(Keys.benePhoneNumber)}",
                                "beneAccTypeID": "${box.read(Keys.beneAccTypeID)}",
                                "beneAmount": "${_getCustomerComissionController.receiverAmountController.text}",
                                "beneBankName": "${box.read(Keys.beneBankName)}",
                                "beneBankBranchID": ${box.read(Keys.beneBankBranchID)},
                                "beneBankID": ${box.read(Keys.beneBankID)},
                                "beneBranchName": "${box.read(Keys.beneBranchName)}",
                                "beneBrnAddress": "${box.read(Keys.beneBrnAddress)}",
                                "beneCountryID": ${int.parse(_sendMoneyController.countryId.value.toString())},
                                "beneCurrencyID": ${int.parse(_sendMoneyController.currenciesId.value.toString())},
                                "beneDocID": null,
                                "beneDocNo": "",
                                "beneficiaryID": ${int.parse(_sendMoneyController.beneficiaryID.value.toString())},
                                "beneficiarySurname": "${_sendMoneyController.lastNameController.text.toUpperCase()}",
                                "beneficiaryName": "${_sendMoneyController.firstNameController.text.toUpperCase()}",
                                "relationID": ${int.parse(_sendMoneyController.relationshipId.value.toString())},
                                "benePayeeModeID": ${box.read(Keys.benePayeeModeID)},
                                "subCompanyBranchID": ${box.read(Keys.subCompanyBranchID)},
                                "companyID": ${int.parse(_sendMoneyController.companyId.value.toString())},
                                "subCompanyID": ${int.parse(_sendMoneyController.subCompanyId.value.toString())},
                                "debitCardID": null,
                                "discountedComm": 0,
                                "encashedPoint": 0,
                                "encashedPointAmount": 0,
                                "equiAmount": ${_getCustomerComissionController.transactionAmountController.text},
                                "ofrdAmount": ${_getCustomerComissionController.transactionAmountController.text},
                                "equiCommission": ${_getCustomerComissionController.fee.value},
                                "ofrdCommission": ${_getCustomerComissionController.fee.value},
                                "taxAmount": 0,
                                "cardCharge": 0,
                                "instrumentDetail": "",
                                "instrumentTypeID": "${int.parse(_sendMoneyController.paymentModeCardId.value.toString())}",
                                "maturityDate": "${DateTime.now()}",
                                "issueDate": "${DateTime.now()}",
                                "othrRcvdAmount": 0,
                                "othrRcvdCommission": 0,
                                "pDRate": ${box.read(Keys.dealingRate)}, 
                                "purposeDetail": "${_sendMoneyController.purposeOfIssueName.value}",
                                "purposeID": "${int.parse(_sendMoneyController.purposeOfIssueId.value.toString())}",
                                "aMLRemBhvClsID": null,
                                "aMLRemBhvClsValue": 0,
                                "aMLOpVoteClsID": null,
                                "aMLOpVoteClsValue": 0,
                                "aMLCoopClsID": null,
                                "aMLCoopClsValue": 0,
                                "aMLOpTypeClsID": null,
                                "aMLOpTypeClsValue": 0,
                                "fldPsfx": "",
                                "cdType":"${box.read(Keys.paymentModeName)}",
                                "cdNo": "",
                                "cdExp": "",
                                "cdSecCode": ""
                              }""";
                              _saveRemittanceController.saveRemittance(accountPayPlainText);
                            // Clipboard.setData(new ClipboardData(text: accountPayPlainText));
          
                            }else if((box.read(Keys.benePayeeModeID) == Keys.cashPayeeID)) {
                             final cashPayPlainText  = """{
                                "remittanceNoPrefix": "${box.read(Keys.remitNoPrefix)}",
                                "adjustedDCAmount": 0,
                                "beneAccNo": "",
                                "benePhone": "${box.read(Keys.benePhoneNumber)}",
                                "beneAccTypeID": 0,
                                "beneAmount": "${_getCustomerComissionController.receiverAmountController.text}",
                                "beneBankName": "",
                                "beneBankBranchID": ${box.read(Keys.beneBankBranchID)},
                                "beneBankID": ${box.read(Keys.beneBankID)},
                                "beneBranchName": "",
                                "beneBrnAddress": "",
                                "beneCountryID": ${int.parse(_sendMoneyController.countryId.value.toString())},
                                "beneCurrencyID": ${int.parse(_sendMoneyController.currenciesId.value.toString())},
                                "beneDocID": null,
                                "beneDocNo": "",
                                "beneficiaryID": ${int.parse(_sendMoneyController.beneficiaryID.value.toString())},
                                "beneficiarySurname": "${_sendMoneyController.lastNameController.text.toUpperCase()}",
                                "beneficiaryName": "${_sendMoneyController.firstNameController.text.toUpperCase()}",
                                "relationID": ${int.parse(_sendMoneyController.relationshipId.value.toString())},
                                "benePayeeModeID": ${box.read(Keys.benePayeeModeID)},
                                "subCompanyBranchID": ${box.read(Keys.subCompanyBranchID)},
                                "companyID": ${int.parse(_sendMoneyController.companyId.value.toString())},
                                "subCompanyID": ${int.parse(_sendMoneyController.subCompanyId.value.toString())},
                                "debitCardID": null,
                                "discountedComm": 0,
                                "encashedPoint": 0,
                                "encashedPointAmount": 0,
                                "equiAmount": ${_getCustomerComissionController.transactionAmountController.text},
                                "ofrdAmount": ${_getCustomerComissionController.transactionAmountController.text},
                                "equiCommission": ${_getCustomerComissionController.fee.value},
                                "ofrdCommission": ${_getCustomerComissionController.fee.value},
                                "taxAmount": 0,
                                "cardCharge": 0,
                                "instrumentDetail": "",
                                "instrumentTypeID": "${int.parse(_sendMoneyController.paymentModeCardId.value.toString())}",
                                "maturityDate": "${DateTime.now()}",
                                "issueDate": "${DateTime.now()}",
                                "othrRcvdAmount": 0,
                                "othrRcvdCommission": 0,
                                "pDRate": ${box.read(Keys.dealingRate)}, 
                                "purposeDetail": "${_sendMoneyController.purposeOfIssueName.value}",
                                "purposeID": "${int.parse(_sendMoneyController.purposeOfIssueId.value.toString())}",
                                "aMLRemBhvClsID": null,
                                "aMLRemBhvClsValue": 0,
                                "aMLOpVoteClsID": null,
                                "aMLOpVoteClsValue": 0,
                                "aMLCoopClsID": null,
                                "aMLCoopClsValue": 0,
                                "aMLOpTypeClsID": null,
                                "aMLOpTypeClsValue": 0,
                                "fldPsfx": "",
                                "cdType": "${box.read(Keys.paymentModeName)}",
                                "cdNo": "",
                                "cdExp": "",
                                "cdSecCode": ""
                              }""";
                               _saveRemittanceController.saveRemittance(cashPayPlainText);
                              // Clipboard.setData(new ClipboardData(text: cashPayPlainText));
                            }
                            }else{
                              Helpers.dengerAlert(title: "Alart" , message: "Your name and phone number missing . Please edit receiver information . Then Try again" );
                            }

                            print(_receiverListController.paymentType.values);
                          }
                        },
                        buttonLevel: "Send",
                        color: AppColor.kGreenColor,
                      )
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: 'ByClickingSendYouareAgreetoOur'.tr, style: Theme.of(context).textTheme.bodyMedium),
                              TextSpan(
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  Get.toNamed(Routes.TERMS_CONDITIONS);
                                },
                                text: 'termsAndConditions'.tr,
                                style: TextStyle(
                                  fontSize:12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.kBlueColor
                                  ),
                              ),
                              TextSpan(text: 'andOur'.tr),
                              TextSpan(
                                 recognizer: TapGestureRecognizer()..onTap = () {
                                  Get.toNamed(Routes.PRIVACY_POLICY_SCREEN);
                                },
                                text: 'privacyPolicy'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.kBlueColor,
                                  fontSize:12.sp,
                                ),
                              ),
                              TextSpan(text: 'andConfirmThatYouHaveReadCarefullyAndFully'.tr,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextSpan(
                                 recognizer: TapGestureRecognizer()..onTap = () async{
                                  await Helpers.launchURL(Strings.necMoneyUrl);
                                },
                                text: 'necMoney'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.kBlueColor,
                                  fontSize:12.sp,
                                ),
                              ),
                              TextSpan(text: 'andCanOptOutatAnyTime'.tr),
                              TextSpan(text: 'Necmoney.com' + "willAppearOnYourBillingStatement".tr),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
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






// 2019-02-14T00:00:00.000Z
// 2019-02-14T00:00:00.000Z