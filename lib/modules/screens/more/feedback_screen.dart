
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/helpers.dart';
import 'package:necmoney/core/utils/keys.dart';
import 'package:necmoney/data/model/feedback_model.dart';

import '../../../core/values/app_color.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../controller/feedback_controller.dart';

class FeedbackScreen extends StatelessWidget {

  final FeedbackController _feedbackController = Get.put( FeedbackController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: CustomAppBar(
        title: 'feedback'.tr,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  'pleaseprovideyourfeedbacktohelpustodeliverbetterexperience'.tr,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 32),
                Column(
                  children: [
                    Text(
                      'howsatisfiedareyouwiththeserviceprovider'.tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int index = 1; index < 6; index++)
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                width: Get.width * 0.1,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: AppColor.kPrimaryColor.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Obx(() => Icon(
                                    Icons.star,
                                    color: _feedbackController.rating >= index ? Colors.orangeAccent : AppColor.kWhiteColor,
                                    size: 24,
                                  ),
                                ),
                              ),
                              onTap: () => _feedbackController.rate(index),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 32),
                TextFormField(
                  maxLines: 3,
                  maxLength: 150,
                  controller: _feedbackController.commentController,
                  decoration: InputDecoration(
                    hintText: 'suggestionComments'.tr,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.kGreyColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.kGreyColor),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Column(
                  children: [
                    // Container(
                    //   width: Get.width,
                    //   child: Text('uploadImage'.tr,
                    //     textAlign: TextAlign.start,
                    //     style: Theme.of(context).textTheme.titleMedium
                    //   ),
                    // ),
                    // SizedBox(height: 8),
                    // GestureDetector(
                    //   onTap: () {
                    //     _feedbackController.getFile();
                    //   },
                    //   child: Container(
                    //     height: Get.height * 0.1,
                    //     width: Get.width,
                    //     decoration: BoxDecoration(
                    //       color: AppColor.kWhiteColor,
                    //       border: Border.all(width: 1, color: AppColor.kGreyColor),
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //     child: Obx(() => _feedbackController.documents.isNotEmpty? Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           for (int index = 0; index <_feedbackController.documents.length; index++)
                    //             Text(
                    //               _feedbackController.documents.first.toString(),
                    //               textAlign: TextAlign.center,
                    //               style: TextStyle(
                    //                 color: AppColor.kGreyColor,
                    //                 fontSize: 16,
                    //               ),
                    //             ),
                    //           ],
                    //         )
                    //       : Center(
                    //         child: Text("uploadFileImage".tr,style: Theme.of(context).textTheme.titleSmall),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 100),
                Column(
                  children: [
                    Row(
                      children: [
                        CustomButton(
                          buttonLevel: 'sendFeedback'.tr,
                          onPressed: () {
                            final FeedBackModel feedBackModel = FeedBackModel(
                              name: box.read(Keys.userName),
                              email: box.read(Keys.loginId),
                              message: _feedbackController.commentController.text,
                              rating: _feedbackController.rating.value,
                              // files: _feedbackController.imagesUrls,
                              files: [],
                            );
                            if(_feedbackController.commentController.text.isNotEmpty && _feedbackController.commentController.text.length >= 3){
                              _feedbackController.saveFeedBack(feedBackModel);
                            }else{
                              Helpers.showSnackBar(title: "Required field", message:  "Suggestion/Comments field must be required");
                            }
                          },
                          color: AppColor.kPrimaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


