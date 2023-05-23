import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/data/provider/api_provider.dart';
import 'package:necmoney/modules/controller/send_money_controller.dart';

import '../../core/utils/keys.dart';
import '../../core/values/strings.dart';

class RelationshipController extends GetxController{
  final SendMoneyController _sendMoneyController = Get.put(SendMoneyController());
  final beneAccountTypesController = TextEditingController();
  ApiProvider _apiProvider = ApiProvider();
  Map <dynamic, dynamic> map = {}.obs;
  final box = GetStorage();
  var relationshipname = "".obs;
  Future getRelationship({required String relationshipid }) async{
    await _apiProvider.getData(
      baseUrl: Strings.baseUrl, 
      url: Strings.relationshipUrl,
    ).then((data){
      if(data != null){
        for(var i in data["relations"] ){
          List r = [];
          r.add(i);
          //Frist time add key then key == value
          map["${r[0]["relationID"]}"] = "${r[0]["name"]}";
        }
        if(map[relationshipid] != null){
          relationshipname.value = map["${relationshipid}"];
        }
      }
    });
  }


  Future autoGetAccountType ({String? beneBankId, String? companyId, String? countryId, String? paymentModeId  , String?  subCompanyId , int? accountTypeId }) async{
    var response = await _apiProvider.getSingleData(
        baseUrl: Strings.baseUrl,
        url:  box.read(Keys.beneBankID) != null ? "GlobalService/GetSubcompanyBranches?bankID=${beneBankId}&city=${box.read(Keys.subCompanyBankCity)}&companyID=${companyId}&countryID=${countryId}&modeID=${paymentModeId}&selectBank=true&subcompanyID=${subCompanyId}" :
          "GlobalService/GetSubcompanyBranches?city=${box.read(Keys.subCompanyBankCity)}&companyID=${companyId}&countryID=${countryId}&modeID=${paymentModeId}&selectBank=true&subcompanyID=${subCompanyId}"
    );
    List c =[];
    for(var i in response["benefAccTypes"]){
      if(i.toString().isNotEmpty){
        c.add(i);
      }
    }
    if(accountTypeId != null){
      List _x = c.where((element) => element.toString().toUpperCase().contains(RegExp("\.(SAVING|SAVINGS)"))).toList();
      if(_x.isNotEmpty){
        beneAccountTypesController.text = _x[0]["name"];
        _sendMoneyController.accountTypeId.value = _x[0]["accountTypeID"].toString();
        _sendMoneyController.accountCode.value = _x[0]["code1"].toString();
      }else{
        beneAccountTypesController.text = _x[0]["name"];
        _sendMoneyController.accountTypeId.value = _x[0]["accountTypeID"].toString();
        _sendMoneyController.accountCode.value = _x[0]["code1"].toString();
      }
    
    }else{
        List _c = c.where((element) => element.toString().toUpperCase().contains(RegExp("\.(SAVING|SAVINGS)"))).toList();
        if(_c.isNotEmpty){
           beneAccountTypesController.text = _c[0]["name"];
          _sendMoneyController.accountTypeId.value = _c[0]["accountTypeID"].toString();
          _sendMoneyController.accountCode.value = _c[0]["code1"].toString();
        }else{
           beneAccountTypesController.text = c[0]["name"];
          _sendMoneyController.accountTypeId.value = c[0]["accountTypeID"].toString();
          _sendMoneyController.accountCode.value = c[0]["code1"].toString();
        }

    }
    

    
  }


  
}

