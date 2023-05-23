import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/keys.dart';
import 'package:necmoney/core/values/strings.dart';
import 'package:necmoney/data/provider/api_provider.dart';


class ExchangeLCIsoCode extends GetxController{

  ApiProvider _apiProvider = ApiProvider();
  final box = GetStorage();
  Future getexchangeCode ()async{
   await _apiProvider.getData(
      baseUrl: Strings.baseUrl,
      url: Strings.getBenefsForTT,
    ).then((data){
      if(data != null){
        box.write(Keys.exchangeLCIsoCode, data["exchangeLCIsoCode"]);
        box.write(Keys.remCountyCode, data["remitNoPrefix"]);
      }
    });
  }

}