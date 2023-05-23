
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../../core/utils/keys.dart';
import '../../core/utils/log.dart';

class MoreController extends GetxController {
  final box = GetStorage();
  var profileImage = "".obs;
  final ImagePicker _picker = ImagePicker();

  Future pickedImageFromCamera()async{
    try{
      final  XFile? _picked = await _picker.pickImage(source: ImageSource.camera);
      if (_picked != null){
        profileImage.value = _picked.path;
        box.write(Keys.profileImage, profileImage.value);
      }
    }catch(err){
      Logger(key: "ImagePath", value: err);
    }
  }

  Future pickedImageFromGellary()async{
    try{
      final  XFile? _picked = await _picker.pickImage(source: ImageSource.gallery);
      if (_picked != null){
        profileImage.value = _picked.path;
        box.write(Keys.profileImage, profileImage.value);
      }
    }catch(err){
      Logger(key: "ImagePath", value: err);
    }
  }
}