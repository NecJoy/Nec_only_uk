import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/helpers.dart';
import 'package:necmoney/data/model/feedback_model.dart';
import '../../core/utils/log.dart';


class FeedbackController extends GetxController {
  CollectionReference feedback = FirebaseFirestore.instance.collection('UserFeedback');
  var commentController = TextEditingController();
  final box = GetStorage();
  var documents = [].obs;
  var imagesUrls = [].obs;

  
  Future getFile() async {
    try {
      FilePickerResult? _result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (_result != null) {
        var _files = _result.paths.map((path) => File(path!)).toList();
        uploadFiles(_files);
        for (var file in _files) {
          documents.add(file.toString().split("/")[7].split("'")[0]);
          //Logger(key: "File error", value: documents);
        }
      }
    } catch (err) {
     // Logger(key: "File error", value: err);
    }
  }



  Future uploadFiles(List _documents) async {
    _documents.forEach((_image) async{
      EasyLoading.show( status: 'Loading...', maskType: EasyLoadingMaskType.black);
      Reference storageReference = await FirebaseStorage.instance.ref().child('data/${_documents}');
      UploadTask uploadTask = storageReference.putFile(_image);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      imagesUrls.add(await taskSnapshot.ref.getDownloadURL()); 
      EasyLoading.dismiss();
    });
  }

  Future<void> saveFeedBack(FeedBackModel feedbackModel) {
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
    return feedback.add(feedbackModel.toJson())
    .then((value) {
      Helpers.showSnackBar(title: "Success", message: "We appreciate you sending us your feedback.");
      EasyLoading.dismiss();
      commentController.clear();
      documents.value = [];
      rating.value = 1;
    }).catchError((error){
      print("Failed to add user: $error");
    });
  }



  var rating = 1.obs;
  void rate(int rat) {
    rating.value = rat;
  }
}


