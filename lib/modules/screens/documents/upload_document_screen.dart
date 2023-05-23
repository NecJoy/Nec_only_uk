import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../../../core/utils/keys.dart';
import '../../../core/values/app_color.dart';
import '../../../core/values/strings.dart';
import '../../../modules/controller/upload_document_controller.dart';
import '../../../core/utils/helpers.dart';
import '../../../routes/routes.dart';
import '../../../widgets/camera_bottom_sheet.dart';
import '../../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../controller/send_money_base_controller.dart';
import '../../controller/sender_detials_controller.dart';

class UploadDocumnetScreen extends StatelessWidget {
final SenderDetailsController _senderDetailsController = Get.put(SenderDetailsController());
final _cameraBottomSheet = CameraBottomSheet();
final  AddNewDocumentController _addNewDocumentController = Get.put(AddNewDocumentController());
 final SendMoneyBaseController _sendMoneyBaseController = Get.put(SendMoneyBaseController());
final box = GetStorage();
UploadDocumnetScreen({Key? key}) : super(key: key);
@override
Widget build(BuildContext context) {
  _addNewDocumentController.documentTypeController.text = box.read(Keys.documnetTypeName).toString().isEmpty ? _senderDetailsController.documentTypeName.value : box.read(Keys.documnetTypeName).toString();
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IgnorePointer(
                child: CustomTextField(
                  level: "documenttype".tr,
                  controller: _addNewDocumentController.documentTypeController,
                ),
              ),
              SizedBox(height: 16,),
              Text("uploadDocument".tr,style: Theme.of(context).textTheme.bodyLarge,),
              SizedBox(height: 8,),
              Obx(()=> Row(
                  mainAxisAlignment: _addNewDocumentController.documentTypeController.text.toLowerCase() == Keys.passport ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _cameraBottomSheet.bottomSheet(
                            context: context,
                            onPressedCamara: () {
                               _addNewDocumentController.pickedImageFromCamera("front");
                                Get.back();
                            },
                            onPressedGallery: () async {
                              _addNewDocumentController.pickedImageFromGellary("front");
                              Get.back();
                            }
                          );
                        },
                        child: DottedBorder(
                          color: _addNewDocumentController.fontDocumentSuccess.value.isEmpty && _addNewDocumentController.frontImage.isEmpty  ?  AppColor.dangerColor : AppColor.kGreenColor,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8),
                          padding: EdgeInsets.all(5),
                          child: Obx(() => Container(
                            height: 100,
                            width: Get.width / 2.5,
                            decoration: BoxDecoration(color: AppColor.kWhiteColor),
                              child: _addNewDocumentController.frontImage.isNotEmpty ? Image.file(File(_addNewDocumentController.frontImage.value)): Center(
                                  child: Column(
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/icon/photo_id_border_icon.svg'),
                                      SizedBox(height: 5),
                                      Text('front'.tr,style: Theme.of(context).textTheme.bodyMedium),
                                    ],
                                  ),
                                ),
                            ),
                          ),
                        ),
                      ),
                      _addNewDocumentController.documentTypeController.text.toLowerCase() == Keys.passport ? SizedBox() :GestureDetector(
                        onTap: () {
                          _cameraBottomSheet.bottomSheet(
                            context: context,
                            onPressedCamara: () {
                               _addNewDocumentController.pickedImageFromCamera("back");
                                Get.back();
                            },
                            onPressedGallery: () async {
                               _addNewDocumentController.pickedImageFromGellary("back");
                                Get.back();
                            }
                          );
                        },
                        child: DottedBorder(
                           color: _addNewDocumentController.fontDocumentSuccess.value.isNotEmpty && _addNewDocumentController.backImage.isNotEmpty ? AppColor.kGreenColor : AppColor.dangerColor,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8),
                          padding: EdgeInsets.all(5),
                          child: Obx(() => Container(
                            height: 100,
                            width: Get.width / 2.5,
                            decoration: BoxDecoration(color: AppColor.kWhiteColor,),
                              child: _addNewDocumentController.backImage.isNotEmpty ? Image.file(File(_addNewDocumentController.backImage.value)): Center(
                                  child: Column(
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                    SvgPicture.asset('assets/icon/photo_id_border_icon.svg'),
                                    SizedBox(height: 5),
                                    Text('back'.tr,style: Theme.of(context).textTheme.bodyMedium),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                ),
              ),
            SizedBox(height: 16,),
            Obx(()=> _addNewDocumentController.fontDocumentSuccess.value.isNotEmpty ?
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.kGreenColor.withOpacity(0.4),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Front ${_addNewDocumentController.fontDocumentSuccess.value}", style: Theme.of(context).textTheme.bodyMedium,),
                      InkWell(
                        onTap: (){
                          _addNewDocumentController.frontImage.value = "";
                          _addNewDocumentController.fontDocumentSuccess.value = "";
                        }, 
                        child: Icon(Icons.remove_circle, color: AppColor.kSecondaryColor),
                      ),
                    ],
                  ),
                ),
              ) : SizedBox()
            ),
            SizedBox(height: 8,),
            Obx(()=> _addNewDocumentController.backDocumentSuccess.value.isNotEmpty ?
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.kGreenColor.withOpacity(0.4),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Back ${_addNewDocumentController.backDocumentSuccess.value}", style: Theme.of(context).textTheme.bodyMedium,),
                      InkWell(
                        onTap: (){
                          _addNewDocumentController.backImage.value = "";
                          _addNewDocumentController.backDocumentSuccess.value = "";
                        }, 
                        child: Icon(Icons.remove_circle, color: AppColor.kSecondaryColor),
                      ),
                    ],
                  ),
                )
              ) : SizedBox()
            ),
            SizedBox(height: 32,),
            Obx(()=>Row(
                children: [
                  CustomButton(
                    buttonLevel: "continue".tr,
                    onPressed: _addNewDocumentController.fontDocumentSuccess.value.isNotEmpty && _addNewDocumentController.frontImage.isNotEmpty || _addNewDocumentController.backImage.isNotEmpty ?  (){
                       if(_addNewDocumentController.newDocument.value == true){
                          if(_addNewDocumentController.frontImage.value.isNotEmpty && _addNewDocumentController.backImage.value.isNotEmpty){
                            box.write(Keys.transaction, Strings.newReceiver);
                            Get.offAndToNamed(Routes.SEND_MONEY_BASE_LAYOUT);
                          }else if(_addNewDocumentController.frontImage.value.isNotEmpty &&  _addNewDocumentController.documentTypeController.value.text == "PASSPORT") {
                            box.write(Keys.transaction, Strings.newReceiver);
                            Get.offAndToNamed(Routes.SEND_MONEY_BASE_LAYOUT);
                          }else if(_addNewDocumentController.backImage.value.isEmpty){
                            Helpers.dengerAlert(title: "documentUpload".tr, message: "pleaseUploadBackImage".tr);
                          }
                           _sendMoneyBaseController.pageController =  PageController(viewportFraction: 1.0,initialPage: 0,keepPage: false);
                       }else{
                          
                          if(box.read(Keys.transaction) == Strings.oldRecevierTransaction ){
                            _sendMoneyBaseController.pageController.jumpToPage(1);
                          }else{
                          _sendMoneyBaseController.pageController.jumpToPage(4);

                          }
                       }
                       
                    } : null,
                    color: AppColor.kPrimaryColor,
                  ),
                ],
               ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





