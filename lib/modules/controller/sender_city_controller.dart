import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:necmoney/core/values/strings.dart';
import 'package:necmoney/data/provider/api_provider.dart';
import 'package:necmoney/modules/controller/sender_detials_controller.dart';

import '../../core/utils/keys.dart';

class SenderCityController extends GetxController{
  ApiProvider _apiProvider = ApiProvider();
  final box = GetStorage();
 SenderDetailsController _senderDetailsController = Get.put(SenderDetailsController());
  Future getCityId({required String data})async{
    if(_senderDetailsController.localcityAddressLineList.isEmpty){
      var responce = await _apiProvider.getData(
          baseUrl: Strings.baseUrl,
          url: "GlobalService/GetCities?Filter=${box.read(Keys.senderFromCountryName)}&CountryId= ${box.read(Keys.senderFromCountryId)}"
      );
      if(responce["cities"] != null){
       for(var i in responce["cities"]){
          _senderDetailsController.localcityAddressLineList.add(i);
       }
      }
    }

    var c = _senderDetailsController.localcityAddressLineList.where((element) => element.toString().contains("$data".toUpperCase()));
        List cityId = c.map((e) => e["cityID"]).toList();
        if(cityId.isNotEmpty){
          box.write(Keys.cityId, cityId[0]);
          print(box.read(Keys.cityId));
        }else{
          print(box.read(Keys.cityId));
          box.write(Keys.cityId, "9663");
    }

  }
}