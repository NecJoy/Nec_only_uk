
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/keys.dart';



import '../../../core/values/strings.dart';
import '../../../data/model/cancel_transaction_model.dart';
import '../../../data/model/correction_transaction_model.dart';
import '../../../data/model/transaction_history_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../core/utils/helpers.dart';

class TransactionHistoryController extends GetxController{
  
  var remitterFullName = "".obs;
  var fromDateTime =  "".obs;
  var toDateTime = "".obs;
  var isLoading = false.obs;
  var remittance = <Remittance>[].obs;
  var cancelReasonController = TextEditingController();
  var correctionReasonController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final box = GetStorage();

  Future getDateTime ({
    required dynamic date,
    String? fromDate, 
    String? toDate
    })async{
    if(fromDate == "fromDate"){
      fromDateTime.value = Helpers.dateTimeFormet(date);
      startDate.value = date.toString();
    }
    if(toDate == "toDate"){
      toDateTime.value = Helpers.dateTimeFormet(date);
      endDate.value = date.toString();
    }
  }
  var startDate = "".obs;
  var endDate = "".obs;
  ApiProvider _apiProvider = ApiProvider();

  //StartDate=2019-01-05T00:00:00Z&EndDate=2020-12-29T00:00:00Z
   
  Future getTrasanctionHistory()async{
    isLoading.value = true;
    _apiProvider.getSingleData(
      baseUrl: Strings.baseUrl, 
      url: Strings.transactionHistoryUrl + "StartDate=$startDate&EndDate=$endDate"
    ).then((data) {
      isLoading.value = false;
      if(data != null) {
        var _remittances = data['remittances'];
        for (var _data in _remittances) {
          remittance.add(Remittance.fromJson(_data));
        }
        box.write(Keys.exchangeLCIsoCode, data["currencyIsoCode"]);
        box.write(Keys.remAddress, data["remAddress"]);
        box.write(Keys.remCountyCode, data["countryIsoCode"]);
        box.write(Keys.remCity, data["billingCity"]);
        box.write(Keys.loginId, data["remEmailAddress"]);
        box.write(Keys.remName, data["remitterName"]);
        box.write(Keys.remSurname, data["remitterSurname"]);
        box.write(Keys.remZipCode, data["remZipCode"]);
        box.write(Keys.remitterPhoneNumber, data["phoneNo"]);
      }
    });
  }

/*
"currency": "${box.read(Keys.exchangeLCIsoCode)}",
      "remAddress": box.read(Keys.remAddress),
      "remCounty": box.read(Keys.remCountyCode),
      "remCity": box.read(Keys.remCity),
      "remEmail": box.read(Keys.loginId),
      "remName": box.read(Keys.remName),
      "remSurname": "${box.read(Keys.remSurname)}",
      "remPhoneNo": "${box.read(Keys.remitterPhoneNumber)}",
      "remZipCode": "${box.read(Keys.remZipCode)}",
 */

  Future cancelTransaction(CancelTransactionModel cancelTransactionModel)async{
    _apiProvider.postData(
      baseUrl: Strings.baseUrl, 
      url: Strings.cancelTransaction, 
      data: cancelTransactionModel.toJson()
    ).then((data) {
      if(data != null){
        Helpers.showSnackBar(title: "Transaction Cancel", message: "Cancel appplication submitted successfully");
      }
    });
  }

  Future correctionTransaction(CorrectionTransactionModel correctionTransactionModel)async{
    _apiProvider.postData(
      baseUrl: Strings.baseUrl, 
      url: Strings.correctionTransaction, 
      data: correctionTransactionModel.toJson()
    ).then((data) {
      if(data != null){
        Helpers.showSnackBar(title: "Transaction Correction", message: "Correction appplication submitted successfully");
      }
    });
  }

}