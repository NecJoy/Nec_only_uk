
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/values/app_color.dart';
import '../../core/values/strings.dart';
import '../../data/model/track_transcation_model.dart';
import '../../data/provider/api_provider.dart';

class TrackTransactionController extends GetxController{
  var trackController = TextEditingController();
  ApiProvider _apiProvider = ApiProvider();
   var paymentLastStatus = "".obs;

   final List statusWallet = [
    "Your bank account\nAwaiting your bank payment",
    "In Hold (FirstTran).",
    "bKash",
    "Recipient account"
  ];


  int indexOfData(){
    if(statusWallet.contains(trackTransactionData.first.lastStatus)){
     return statusWallet.indexOf(trackTransactionData.first.lastStatus);
    }
    return 0;
  }

  getColorBuilder(index){
    if(index <= indexOfData()){
      return AppColor.kPrimaryColor;
    }else{
      return AppColor.kGreyColor.withOpacity(0.5);
    }
  }

  getLineColorBuilder(index){
    if(index < indexOfData()){
      return AppColor.kPrimaryColor;
    }else{
      return AppColor.kGreyColor.withOpacity(0.5);
    }
  }




  var trackTransactionData = <TrackTransactionModel>[].obs;
  Future trackTransaction(String? remittanceNo)async{
    _apiProvider.postData(
      baseUrl: Strings.baseUrl, 
      url: Strings.trackTransactionUrl, 
      data: {"remittanceNo": remittanceNo}
    ).then((data) {
      if(data != null){
        paymentLastStatus.value = data["lastStatus"];
        trackTransactionData.add(TrackTransactionModel.fromJson(data));
      }
    });
  } 

}