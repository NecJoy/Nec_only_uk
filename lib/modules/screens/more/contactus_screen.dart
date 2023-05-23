import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/helpers.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/values/app_color.dart';
import '../../../../core/values/strings.dart';
import '../../../core/utils/keys.dart';
import '../../../routes/routes.dart';

class ContactScreen extends StatelessWidget {
 ContactScreen({Key? key}) : super(key: key);
final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Platform.isIOS
              ? Icon(Icons.arrow_back_ios, color: AppColor.kWhiteColor)
              : Icon(Icons.arrow_back, color: AppColor.kWhiteColor),
        ),
        title: Text(
          'contactUs'.tr,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(140.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: Get.width,
                height: 120,
                decoration: BoxDecoration(
                    color: AppColor.kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                    ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "haveQuestions".tr,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: Get.width / 2 * 1.6,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColor.kWhiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColor.kPrimaryColor, width: 1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("viewAnswerFromOutFrequently".tr,
                              style: Theme.of(context).textTheme.titleSmall),
                          SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: 18.h,
                            height: 5.h,
                            child: CustomButtonWithIcon(
                              onPressed: () {
                                Get.toNamed(Routes.FAQ_SCREEN);
                              },
                              title: 'faqs'.tr,
                              icon: SvgPicture.asset('assets/icon/faq.svg'),
                              textColor: AppColor.kWhiteColor,
                              backgroundColor: MaterialStateProperty.all(
                                AppColor.kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    "ourCustomarCareTeamIsAvailable".tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.kGreyColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "yourConversations".tr,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          "typicallyRepliesInlessThen".tr,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset("assets/icon/24_service.svg"),
                         ),
                        SizedBox(
                          height: 16,
                        ),
                        CustomButtonWithIcon(
                          width: Get.width / 2,
                          onPressed: () {
                            Get.toNamed(Routes.CHAT_SCREEN);
                          },
                          title: "chatWithNecMoney".tr,
                          icon: SvgPicture.asset('assets/icon/faq.svg'),
                          textColor: AppColor.kWhiteColor,
                          backgroundColor: MaterialStateProperty.all(
                            AppColor.kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.kGreyColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Send text or call via WhatsApp".tr,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "typicallyRepliesInlessThenMinute".tr,
                            style: Theme.of(context).textTheme.titleSmall
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: (){
                            Helpers.launchWhatsApp();
                          },
                          child: Align(
                              alignment: Alignment.center,
                              child: Image.asset("assets/icon/whatsapp.gif", scale: 3.0,),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "WhatsApp",
                            style: TextStyle( 
                              color: AppColor.kPrimaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.kGreyColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "giveUsCall".tr,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        Text("typicallyRepliesInlessThenMinute".tr, style: Theme.of(context).textTheme.titleSmall),
                        SizedBox(
                          height: 8,
                        ),
                        Align(alignment: Alignment.center,child: SvgPicture.asset("assets/icon/24_service.svg")),
                        SizedBox(
                          height: 16,
                        ),    
                        CustomButtonWithIcon(
                          width: Get.width / 2,
                          onPressed: () async {
                            if(int.parse(box.read(Keys.senderFromCountryId).toString()) == Keys.canadaCountryID){
                               await FlutterPhoneDirectCaller.callNumber(Strings.canadaSupport);
                            }else{
                               await FlutterPhoneDirectCaller.callNumber(Strings.supportNumberNecMoney);
                            }
                          },
                          title: int.parse(box.read(Keys.senderFromCountryId).toString()) == Keys.canadaCountryID ? Strings.canadaSupport : Strings.supportNumberNecMoney,
                          icon: SvgPicture.asset('assets/icon/phone.svg'),
                          textColor: AppColor.kWhiteColor,
                          backgroundColor: MaterialStateProperty.all(
                            AppColor.kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final Color? textColor;
  final double? width;
  final MaterialStateProperty<Color>? backgroundColor;
  final VoidCallback onPressed;
  const CustomButtonWithIcon(
      {Key? key,
      this.icon,
      this.textColor,
      this.width,
      this.title,
      required this.onPressed,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon!,
      label: Text(
        title!,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      style: ButtonStyle(
        backgroundColor: backgroundColor,
        minimumSize: MaterialStateProperty.all(Size(width ?? 0, 48)),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
