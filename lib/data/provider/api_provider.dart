import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:necmoney/core/utils/keys.dart';
import 'package:necmoney/core/values/strings.dart';
import 'package:necmoney/modules/controller/send_money_base_controller.dart';
import 'package:necmoney/modules/controller/upload_document_controller.dart';

import '../../core/utils/helpers.dart';
import '../../core/utils/log.dart';
import '../../core/utils/session_timer.dart';
import '../../routes/routes.dart';



class ApiProvider{
SendMoneyBaseController _sendMoneyBaseController = Get.put(SendMoneyBaseController());
AddNewDocumentController _addNewDocumentController = Get.put(AddNewDocumentController());
var client = http.Client();
final box  = GetStorage();
SessionTimerController sessionTimer = Get.put(SessionTimerController());

Future<dynamic> getData(
  {
  required String baseUrl,
  required String url
  })async{
  try{
   EasyLoading.show( status: 'Loading...', maskType: EasyLoadingMaskType.black);
    var response = await client.get(Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'RequestVerificationToken': box.read(Keys.token) != null ? box.read(Keys.token) : "null",
      },
    );
  Logger(key: "Getdata", value: response.request);
   EasyLoading.dismiss();
    if(response.statusCode == 200){
      var jsonString = jsonDecode(response.body);
      return jsonString;
    }else{
      var data = jsonDecode(response.body);
      if(response.statusCode == 400 && data["returnMessage"][0].toString().contains(Keys.sessionText) == true){
        Get.offAllNamed(Routes.SIGNIN_SCREEN);
      }else{
        Helpers.dengerAlert(title: "", message:"${data["returnMessage"][0]}");
      }
    }
  } on SocketException catch (_) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "error".tr, message: "noInternetConnection".tr);
  } on HttpException {
    EasyLoading.dismiss();
  } on FormatException {
    EasyLoading.dismiss();
  } catch (e) {
    EasyLoading.dismiss();
    Logger(key: "Unknown", value: "Unknown error $e");
  }
  return null;
}


Future getSingleData(
  {
  required String baseUrl, 
  required String url, 
  })async{
  try{
    var response = await client.get(Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'RequestVerificationToken': box.read(Keys.token) != null ? box.read(Keys.token) : "null",
      },
    );
    Logger(key: "responce", value: response.request);
    if(response.statusCode == 200){
      var jsonString = jsonDecode(response.body);
      return jsonString;
    }else{
      var data = jsonDecode(response.body);
      if(response.statusCode == 400 && data["returnMessage"][0].toString().contains(Keys.sessionText) == true){
        Get.offAllNamed(Routes.SIGNIN_SCREEN);
      }else{
        Helpers.dengerAlert(title: "", message:"${data["returnMessage"][0]}");
      }
    }
  } on SocketException catch (_) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "error".tr, message: "noInternetConnection".tr);
  } on HttpException catch (error) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "error".tr, message: error.message);
  } on FormatException catch (error) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "error".tr, message: error.message);
  } catch (e) {
    EasyLoading.dismiss();
    Logger(key: "Unknown", value: "Unknown error$e");
  }

}



Future postData(
  { 
    required String baseUrl, 
    required String url, 
    required Map<String, dynamic> data, 
    String? token
  })async{
  
  try{
    EasyLoading.show( status: 'Loading...', maskType: EasyLoadingMaskType.black);

    var response = await client.post(Uri.parse("$baseUrl/$url"), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-API-Version': '2',
        'Accept': 'application/json',
        'RequestVerificationToken': box.read(Keys.token) != null ? box.read(Keys.token) : "null",
      }, 
      body: jsonEncode(data)
    );

    EasyLoading.dismiss();
    if(response.statusCode == 200){
      var jsonString = jsonDecode(response.body);
      return jsonString;
    }else if(response.statusCode == 400 
    && jsonDecode(response.body)["returnStatus"] == false 
    && response.request.toString().split(" ")[1] == "${Strings.baseUrl}/${Strings.registerUrl}"){
      return {
        "body": jsonDecode(response.body),
        "returnStatus": jsonDecode(response.body)["returnStatus"],
        "message": jsonDecode(response.body)['returnMessage']
      };
    }else if(response.statusCode == 400 && jsonDecode(response.body)['returnMessage'].toString().contains(Strings.unAssigned)){
      return {
        "body": jsonDecode(response.body),
        "message": jsonDecode(response.body)['returnMessage']
      };
    }else if(response.statusCode == 400 && jsonDecode(response.body)['returnMessage'].toString().contains(Strings.idPasswordNotMatch)){
       Helpers.dengerAlert(title: "Error", message: jsonDecode(response.body)['returnMessage'].toString());
      return;
    }else if(response.statusCode == 400){
      if(jsonDecode(response.body)['returnMessage'].toString().contains("You are not Registered to Activate Account/Activation code is not correct...")){
        Helpers.dengerAlert(
          title: "Alert".tr, 
          message: "yourActivationCodeisIncorrect".tr
        );
      }else if(jsonDecode(response.body)['returnMessage'].toString().toLowerCase().contains("Document is not uploaded for this remitter. Upload document first, then try again.".toLowerCase())) {
        Logger(key: "Data", value: "One");
        if(box.read(Keys.transaction) == Strings.oldRecevierTransaction ){
          _addNewDocumentController.newDocument.value = false;
           _sendMoneyBaseController.pageController.jumpToPage(2);
        }else{
         _sendMoneyBaseController.pageController.jumpToPage(5);
         _addNewDocumentController.newDocument.value = false;
        }
      }else {
        Helpers.dengerAlert(
          title: "Alert".tr, 
          message:  jsonDecode(response.body)['returnMessage'].toString().split("[")[1].split(']')[0] ,
        );
      }
    }else{
      var errorBody = jsonDecode(response.body);
      Helpers.dengerAlert(title: "Alert", message: errorBody["returnMessage"].toString().split("[")[1].split(']')[0]);
      
    }

  } on SocketException catch (_) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "socketException".tr, message: "noInternetConnection".tr);
  } on HttpException catch (error) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "httpException".tr, message: error.message);
  } on FormatException catch (error) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "formatException".tr, message: error.message);
  } catch (e) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "Unknown", message: "Unknown error$e");
  }

}









Future updateData(
  { 
  required String baseUrl, 
  required String url, 
  required Map<String, dynamic> data, 
  required String id, 
  String? token
  })async{

  try{
    EasyLoading.show( status: 'Loading...', maskType: EasyLoadingMaskType.black);
    var response = await client.put(Uri.parse("$baseUrl/$url/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data)
    );
    EasyLoading.dismiss();
    if(response.statusCode == 200){
      var jsonString = jsonDecode(response.body);
      return jsonString;
    }else{
      var errorBody = jsonDecode(response.body);
      Helpers.dengerAlert(title: "error".tr, message: errorBody["message"]);
      return null;
    }
  } on SocketException catch (_) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "error".tr, message: "noInternetConnection".tr);
  } on HttpException catch (error) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "error".tr, message: error.message);
  } on FormatException catch (error) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "error".tr, message: error.message);
  } catch (e) {
    EasyLoading.dismiss();
    Logger(key: "Unknown", value: "Unknown error$e");
  }

}


Future deleteData(
  {
    required String baseUrl, 
    required  String url, 
    required String id
  })async{

  try{
    EasyLoading.show( status: 'Loading...', maskType: EasyLoadingMaskType.black);
    var response = await client.delete(Uri.parse("$baseUrl/$url/$id"));
    EasyLoading.dismiss();
    if(response.statusCode == 200){
      var jsonString = jsonDecode(response.body);
      return jsonString;
    }else{
      var errorBody = jsonDecode(response.body);
      Helpers.dengerAlert(title: "error".tr, message: errorBody["message"]);
      return null;
    }
  } on SocketException catch (_) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "error".tr, message: "noInternetConnection".tr);
  } on HttpException catch (error) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "error".tr, message: error.message);
  } on FormatException catch (error) {
    EasyLoading.dismiss();
    Helpers.dengerAlert(title: "error".tr, message: error.message);
  } catch (e) {
    EasyLoading.dismiss();
    Logger(key: "Unknown", value: "Unknown error$e");
  }

}

}



