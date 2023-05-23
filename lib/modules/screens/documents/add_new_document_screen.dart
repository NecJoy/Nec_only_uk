
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/utils/keys.dart';
import '../../../modules/controller/upload_document_controller.dart';
import '../../../modules/screens/documents/upload_document_screen.dart';
import '../../../../core/values/app_color.dart';
import '../../../../widgets/custom_appbar.dart';

class AddNewDocumentScreen extends StatelessWidget {
  AddNewDocumentScreen({Key? key}) : super(key: key);
  final AddNewDocumentController _addNewDocumentController = Get.put(AddNewDocumentController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    _addNewDocumentController.documentTypeController.text = box.read(Keys.documnetTypeName).toString().toUpperCase();
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: CustomAppBar(title: 'addNewDocument'.tr),
      body: UploadDocumnetScreen(),
    );
  }
}


