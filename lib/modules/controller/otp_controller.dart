
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import '../../data/provider/api_provider.dart';
import '../../modules/controller/signin_controller.dart';
import '../../core/utils/keys.dart';
import '../../core/utils/log.dart';
import '../../core/values/strings.dart';
import '../../data/model/activation_model.dart';
import '../../data/model/resend_activation_model.dart';
import '../../data/model/signin_model.dart';


class OTPController extends GetxController{
  ApiProvider _apiProvider = ApiProvider();
  final box = GetStorage();
  final SignInController _signInController = Get.put(SignInController());
  
  Future resendActivation(ResendActivationModel resendActivationModel)async{
    _apiProvider.postData(
      baseUrl: Strings.baseUrl,
      url: Strings.resendActivationUrl,
      data: resendActivationModel.toJson(),
    ).then((data) {
      Logger(key: "Resend Activation", value: data);
    });
  }

  Future accountActivation(ActivationModel activationModel)async{
    _apiProvider.postData(
      baseUrl: Strings.baseUrl,
      url: Strings.activationUrl,
      data: activationModel.toJson(),
    ).then((data) {
      if(data != null){
        var signInModel = SignInModel(
          loginId: box.read(Keys.email), // Store locally 
          password: box.read(Keys.password), // Store locally
          tryCount: _signInController.tryCount.value += 1,
        );
        Future.delayed(Duration(milliseconds: 500)).then((value) {
          _signInController.signIn(signInModel: signInModel,);
        });
      }
    });
  }

  

}