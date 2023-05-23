import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/helpers.dart';
import '../../core/utils/keys.dart';
import '../../core/values/app_color.dart';
import '../../core/values/strings.dart';



class AddNewDocumentController extends GetxController{

  var frontImage = "".obs;
  var backImage = "".obs;
  final box = GetStorage();
  var documentTypeName = "".obs;
  var fontDocumentSuccess = "".obs;
  var backDocumentSuccess = "".obs;
  var documentTypeController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var newDocument = true.obs; 

  Future pickedImageFromCamera(form)async{
    try{
      final  XFile? _picked = await _picker.pickImage(source: ImageSource.camera);
      File? croppedFile = await ImageCropper().cropImage(
        sourcePath: _picked!.path,
          aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColor.kGreenColor,
          toolbarWidgetColor: AppColor.kWhiteColor,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      
      File compressedFile = await FlutterNativeImage.compressImage(croppedFile!.path,quality: 95, percentage: 95);
      
      if (compressedFile.toString().isNotEmpty){
        if(form == "front"){ 
          frontImage.value = compressedFile.path;
          uploadDocument(frontImage.value, "front");
        }else {
          backImage.value = compressedFile.path;
          uploadDocument(backImage.value, "back");
        }
      }
    }catch(err){
    }
  }


  Future pickedImageFromGellary (form)async{
      File? compressedFile;
      try{
        if(Platform.isAndroid){
          FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
          compressedFile = await FlutterNativeImage.compressImage(result!.files.single.path.toString(), quality: 95, percentage: 95);
        }else{
          final  XFile? _picked = await _picker.pickImage(source: ImageSource.gallery,);
          compressedFile  = await FlutterNativeImage.compressImage(_picked!.path.toString(), quality: 95, percentage: 95);
        }

        if (compressedFile.toString().isNotEmpty){
          if(form == "front"){ 
            frontImage.value = compressedFile.path;
            uploadDocument(frontImage.value, "front");
          }else {
            backImage.value = compressedFile.path;
            uploadDocument(backImage.value, "back");
          }
        }
      }catch(err){
      }
    }

    





Future uploadDocument(filePath, form) async {
  final httpDio = Dio();
  final formData = dio.FormData.fromMap({
    "data": "{}",
    "File": await dio.MultipartFile.fromFile(
        filePath,
        filename: filePath.toString().split("/").last,
        contentType: MediaType('image', 'jpg'),
      ),
    "type": "image/jpg"
  });

  try {
    EasyLoading.show( status: 'Loading...', maskType: EasyLoadingMaskType.black);
    final dio.Response response = await httpDio.post(
      Strings.baseUrl +"/"+ Strings.documentUpload,
      data: formData,
      options: dio.Options(
        headers: {
          "RequestVerificationToken": box.read(Keys.token),
          "Content-Type": "multipart/form-data"
         }
        )
      );
      if (response.statusCode == 200) {
        if(form == "front"){
          fontDocumentSuccess.value = response.data;
        }
        if(form == "back"){
          backDocumentSuccess.value = response.data;
        }
      }
    EasyLoading.dismiss();
  } on dio.DioError catch (e) {
     EasyLoading.dismiss();
    frontImage.value = "";
    backImage.value = "";
    Helpers.dengerAlert(title: "Error" , message: e.response!.data.toString());
  }
 }
}



