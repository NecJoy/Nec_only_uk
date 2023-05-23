import 'package:flutter/material.dart';
import 'package:necmoney/widgets/custom_outline_button.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../core/values/app_color.dart';

class TextCopyWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? update;
  final  void Function() onPressed;
  const TextCopyWidget({
    Key? key,
    this.title,
    this.subtitle,
    this.update,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(title!.tr, style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(width: 8),
                    update !=  null ? Text( update!,
                    style: TextStyle(
                      color: AppColor.kSecondaryColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ): Container(),
                ],
              ),
              SizedBox(height: 0.5.h),
              Text(subtitle!.tr, style: Theme.of(context).textTheme.titleSmall,),
            ],
          ),
          SizedBox(
            height: 30,
            child: CustomOutlineButton(
              buttonLevel: "Copy",
              levelColor: AppColor.kPrimaryColor,
              borderColor: AppColor.kPrimaryColor,
              color: AppColor.kWhiteColor,
              onPressed:onPressed,
              width: 10.w,
            ),
          ),
        ],
      ),
    );
  }
}