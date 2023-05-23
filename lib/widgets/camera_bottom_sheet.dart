import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necmoney/core/values/app_color.dart';

class CameraBottomSheet{
  Future<dynamic> bottomSheet({
    required BuildContext context,
    Function()? onPressedCamara,
    Function()? onPressedGallery,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(15),
          height: Get.height * 0.2,
          child: Column(
            children: [
              InkWell(
                onTap: onPressedCamara,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: AppColor.kGreyColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'camera'.tr,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: onPressedGallery,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.file_upload,
                        color: AppColor.kGreyColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'gallery'.tr,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}