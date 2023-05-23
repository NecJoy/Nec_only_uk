import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/keys.dart';
import '../../data/model/get_customer_commission_model.dart';
import '../../modules/controller/get_dealing_rate_controller.dart';
import '../../core/values/strings.dart';
import '../../data/provider/api_provider.dart';

class GetCustomerComissionController extends GetxController{

  final GetDealingRateContoller _dealingRateContoller = Get.put(GetDealingRateContoller());
  ApiProvider _apiProvider = ApiProvider();
  var dealingRate = "".obs;
  final  transactionAmountController = TextEditingController();
  final  receiverAmountController = TextEditingController();
  var fee = "0.0".obs;
  var cardFee = "0.0".obs;
  var totalAomunt = "0.0".obs;
  var exchangeRate = 0.0.obs;
  late FocusNode transactionAmountFocusNode;
  late FocusNode receiverAmountFocusNode;
  var diplayTotalAmount = "0.0".obs;
  final box = GetStorage();
  Future getCustomerCommission({String? amount, String? countryID, String? currencyID, String? operationDate, String? subCompanyID})async{
    _apiProvider.getSingleData(
      baseUrl: Strings.baseUrl, 
      url: Strings.getCustomerCommission + "amount=$amount&cardType=VISA&countryID=$countryID&currencyID=$currencyID&operationDate=$operationDate.000Z&subCompanyID=$subCompanyID"
    ).then((data){
      print(data);
      fee.value = "0.0";
      cardFee.value = "0.0";
      diplayTotalAmount.value = "0.0";
      if(data != null){
        GetCustomerCommissionModel getCustomerCommissionModel = GetCustomerCommissionModel.fromJson(data);
        if(getCustomerCommissionModel.amount!  > 0.0){
          fee.value = getCustomerCommissionModel.commission.toString();
          cardFee.value = getCustomerCommissionModel.cardCharge.toString();
          exchangeRate.value = _dealingRateContoller.dealingRate.value;
          if(transactionAmountFocusNode.hasFocus){
            receiverAmountController.text = "Loading..";
            receiverAmountController.text = (double.parse(transactionAmountController.text.isNotEmpty ? transactionAmountController.text  : "0.0") *  _dealingRateContoller.dealingRate.value).toStringAsFixed(0);
            diplayTotalAmount.value = (double.parse(fee.value) + double.parse(transactionAmountController.text.isNotEmpty ?  transactionAmountController.text  : "0.0")).toStringAsFixed(2);
            box.write(Keys.displayAmount, diplayTotalAmount.value);
          }else if(receiverAmountFocusNode.hasFocus){
            transactionAmountController.text = "Loading..";
            transactionAmountController.text = (double.parse(receiverAmountController.text.isNotEmpty ? receiverAmountController.text  : "0.0" ) /  _dealingRateContoller.dealingRate.value).toStringAsFixed(2);
            diplayTotalAmount.value = (double.parse(fee.value) + double.parse(transactionAmountController.text.isNotEmpty ?  transactionAmountController.text  : "0.0")).toStringAsFixed(2);
            box.write(Keys.displayAmount, diplayTotalAmount.value);
          }
        }
      }
    });
  }

  @override
  void onInit() {
    transactionAmountFocusNode = FocusNode();
    receiverAmountFocusNode = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    transactionAmountFocusNode.dispose();
    receiverAmountFocusNode.dispose();
    super.onClose();
  }

}