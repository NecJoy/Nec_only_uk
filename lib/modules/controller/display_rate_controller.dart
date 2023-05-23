
import 'package:get/get.dart';
import 'package:necmoney/modules/controller/base_nav_layout_controller.dart';
import '../../core/values/strings.dart';
import '../../data/model/display_rate_model.dart';
import '../../data/provider/api_provider.dart';

class DisplayRateController extends GetxController{
ApiProvider _apiProvider = ApiProvider();
BaseNavController _baseNavController = Get.put(BaseNavController());

Stream  <List<DisplayRateModel>> getMoneyRate () async* {
  _baseNavController.apiProgress.value = true;
 var response = await _apiProvider.getSingleData(
  baseUrl: Strings.baseUrl,
  url: Strings.displayRateUrl,
  );

  List _data = [];
  for(var i in response["items"]){
    _data.add(i);
  }
   _baseNavController.apiProgress.value = false;
  yield _data.map((e) => DisplayRateModel.fromJson(e)).toList();
}



}