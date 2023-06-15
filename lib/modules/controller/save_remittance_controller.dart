
import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:necmoney/core/utils/helpers.dart';
import 'package:necmoney/core/utils/log.dart';

import '../../../core/values/strings.dart';
import '../../../data/provider/api_provider.dart';
import '../../../routes/routes.dart';
import '../../core/utils/keys.dart';

class SaveRemittanceController extends GetxController{
  ApiProvider _apiProvider = ApiProvider();
  var box  = GetStorage();
  var client = http.Client();
  var remittanceNo = "".obs;


  Future saveRemittance(plainText)async{
    final key = Key.fromUtf8(box.read(Keys.aesKey));
    final iv = IV.fromUtf8(box.read(Keys.aesKey));
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: "PKCS7" ));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    _apiProvider.postData(
      baseUrl: Strings.baseUrl, 
      url: Strings.saveRemittance, 
      data: {
        "encryptedData" : encrypted.base64 
      }
    ).then((data) {
      if(data != null){
        remittanceNo.value = data["remittanceNo"];
        box.write(Keys.remittanceNo, data["remittanceNo"]);
        Get.toNamed(Routes.PAYMENT_SUCCESSFUL_SCREEN);
      }
    });

  }


/*

Pay with card data store two way . 
1. User select purpose Of Issue then get Card payment data 
2. User date search in history screen then get Card payment in History controller 
*/

  Future payWithGateway()async{
    double _parseDisplayAmonut = double.parse(box.read(Keys.displayAmount).toString());
    double _displayAmount = _parseDisplayAmonut * 100;
    Map<String , dynamic> dataMap =  {
      "currency": "${box.read(Keys.exchangeLCIsoCode)}",
      "amount": _displayAmount.round(),
      "description": "Payment of Order No: ${box.read(Keys.remittanceNo)} Amount: ${box.read(Keys.exchangeLCIsoCode) + " ${box.read(Keys.displayAmount)}"}",
      "trackingId": "${box.read(Keys.remittanceNo)}",
      "remAddress": "${box.read(Keys.remAddress)}",
      "remCounty": "${box.read(Keys.remCountyCode)}",
      "remCity": "${box.read(Keys.remCity)}",
      "remEmail": "${box.read(Keys.loginId)}",
      "remName": "${box.read(Keys.remName)}",
      "remSurname": "${box.read(Keys.remSurname)}",
      "remPhoneNo": "${box.read(Keys.remitterPhoneNumber)}",
      "remZipCode": "${box.read(Keys.remZipCode)}",
    };
    //Logger(key: "Data", value:dataMap.toString());
    _apiProvider.postData(
      baseUrl: Strings.baseUrl, 
      url: Strings.createTxn365Token, 
      data: dataMap,
    ).then((data){
      if(data["checkout"] != null){
        final uri = Uri.tryParse(data["checkout"]["redirect_url"]); 
        final isValid = uri != null && uri.hasAbsolutePath && uri.scheme.startsWith('http') || uri!.scheme.startsWith('https');
        if(isValid){
          Get.toNamed(Routes.PAYMENT_GATEWAY_SCREEN, arguments: data["checkout"]["redirect_url"]);
        }
      }else{
        Helpers.dengerAlert(title: "Gateway" , message:data["message"] );
      }
    });
  }
}


/*

{
  "amount": double.parse(box.read(Keys.displayAmount).toString()) * 100,
  "currency": box.read(Keys.exchangeLCIsoCode),
  "description": "Payment of Order No : ${box.read(Keys.remittanceNo)}.  Payment amount: ${box.read(Keys.displayAmount)}",
  "trackingId": box.read(Keys.remittanceNo),
  "remAddress": box.read(Keys.remAddress),
  "remCounty": box.read(Keys.remCountyCode),
  "remCity": box.read(Keys.remCity),
  "remZipCode": box.read(Keys.remZipCode),
  "remEmail": box.read(Keys.loginId),
  "remName": box.read(Keys.remName),
  "remSurname": box.read(Keys.remSurname),
} 



 */


