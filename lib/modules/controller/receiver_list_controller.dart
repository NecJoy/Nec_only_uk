
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/log.dart';
import 'package:necmoney/data/provider/api_provider.dart';

import '../../core/values/strings.dart';
class ReceiverListController extends GetxController{
  TextEditingController searchController = TextEditingController();
 ApiProvider _apiProvider = ApiProvider();
  final box = GetStorage();
  var backButton = false;
  var currentPageNumber  = 1;

  Map<dynamic , dynamic > paymentType =  {}.obs;
 

// Stream <List<GetBeneficiaryModel>> getResiverData()async* {
//   _baseNavController.apiProgress.value = true;
//   var searchCriteria =  searchController.text.isEmpty ? "": searchController.text;
//   var response = await _apiProvider.getSingleData(
//      baseUrl: Strings.baseUrl,
//      url: "GlobalService/GetBeneficiaries?currentPageNumber=$currentPageNumber&pageSize=10&searchCriteria=$searchCriteria&sortDirection=ASC&sortExpression=A.Name&status=0",
//   );
//   List data = [];
//   for(var i in  response["beneficiaries"]){
//       data.add(i);
//   }
//   _baseNavController.apiProgress.value = false;
//  yield data.map((e) => GetBeneficiaryModel.fromJson(e)).toList();
  
// }

Future getPaymentMode()async{
  var response = await _apiProvider.getSingleData(
     baseUrl: Strings.baseUrl,
     url: Strings.paymentTypeUrl,
  );
  for(var i in  response["paymentModes"]){
      List r = [];
      r.add(i);
      //Frist time add key then key == value
      paymentType["${r[0]["description"]}"] = "${r[0]["modeID"]}";
  }

 // Logger(key: "paymentType", value: paymentType.toString());
}




}