import 'package:get/get.dart';
import '../../../core/values/strings.dart';
import '../../../data/model/payment_type_model.dart';
import '../../../data/provider/api_provider.dart';


class PaymentTypeController extends GetxController{


  
ApiProvider _apiProvider = ApiProvider();
RxList<PaymentTypeModel> paymentModeList = <PaymentTypeModel>[].obs;
var isLodding = false.obs;

Future getPaymentMode()async{
  isLodding.value = true;
  var response = await _apiProvider.getSingleData(
    baseUrl: Strings.baseUrl, 
    url: Strings.paymentTypeUrl
  );
  var data = response;
  List _paymentMode = data["paymentModes"];
  for(var i = 0 ; i < _paymentMode.length; i++){
     paymentModeList.add(PaymentTypeModel.fromJson(_paymentMode[i]));
  }
  isLodding.value = false;
}


@override
  void onInit() {
    getPaymentMode();
    super.onInit();
  }

// Future <List<PaymentTypeModel>> getPaymentMode()async{
//   var response = await _apiProvider.getSingleData(
//      baseUrl: Strings.baseUrl,
//      url: Strings.paymentTypeUrl,
//   );
//   List data = [];
//   for(var i in  response["paymentModes"]){
//       data.add(i);
//   }
//  return data.map((e) => PaymentTypeModel.fromJson(e)).toList();
  

// }


// @override
// void onReady() {
//   Future.delayed(Duration(milliseconds: 500)).then((value) => getPaymentMode());
//   super.onReady();
// }

}