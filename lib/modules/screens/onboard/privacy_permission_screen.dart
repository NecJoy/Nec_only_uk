
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/values/app_color.dart';
import 'package:necmoney/core/values/strings.dart';
import 'package:necmoney/widgets/custom_appbar.dart';
import 'package:necmoney/widgets/custom_button.dart';
import '../../../core/utils/keys.dart';
import '../../../core/utils/session_timer.dart';
import '../../../routes/routes.dart';

class PrivacyPermission extends StatelessWidget {
 PrivacyPermission({Key? key}) : super(key: key);
final SessionTimerController _sessionTimerController = Get.put(SessionTimerController());
final box = GetStorage();
  @override
  Widget build(BuildContext context) {
     _sessionTimerController.checkSession = false;
    return Scaffold(
      appBar: CustomAppBar(
        title: "privecyPolicy".tr,
        leading: Text(""),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14),
                    //Nec Money Transfer Limited
                    Text("Nec Money Transfer Limited started its journey in 2015 under UK based Authorized Payment Institution, We are authorized with HMRC and obtained our MLR registration. More importantly, Nec Money Transfer Limited has approval by Financial Conduct Authority (FCA),Registered Office is 624A Romford road, Manor park,London, E125AQ, United Kingdom.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: AppColor.kBlackColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text("We may collect certain personal information which (either on its own or when combined with other information we hold about you) allows us to identify you as an individual and which is about you. We set out below personal information that we generally process in connection with all our products and services.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: AppColor.kBlackColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text("This includes:",
                      style: TextStyle(
                        color: AppColor.kBlackColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8,),
                    dettestData(
                      title: "Contact(Email and phone)",
                    ),
                    SizedBox(height: 8,),
                    DescriptionData(description: "Basically, we are collected email address and phone number for verification customers account, and we never share customer data with any others",),
                    SizedBox(height: 16),
                    dettestData(
                      title: "Image",
                    ),
                    SizedBox(height: 8,),
                    DescriptionData(description: "We are access gallery and camera for uploading and capture Identification documents for verifying Known Your Customer (KYC)",),
                    SizedBox(height: 16),
                    dettestData(
                      title: "Basic Personal Data",
                    ),
                    SizedBox(height: 8,),
                    DescriptionData(description: "Your title, full name, signature, and contact details, including for instance your email address, home and mobile telephone;",),
                    DescriptionData(description: "Your home address;",),
                    DescriptionData(description: "Your date of birth and/or age;",),
                    DescriptionData(description: "Your place of birth, nationality;",),
                    DescriptionData(description: "Demographic information such as age and gender;",),
                    SizedBox(height: 16),
                    dettestData(
                      title: "Data To Comply With Money Laundering Regulations:",
                    ),
                    SizedBox(height: 8,),
                    DescriptionData(description: "Proof of your identity, such as a passport, driving licence, national ID card or residence permit;",),
                    DescriptionData(description: "Proof of address, such as a utility bill or bank statement;",),
                    DescriptionData(description: "Details on the source of funds being sent, for example occupation details, payslips, credit card statements, tax rebate receipts or bank loan agreements.",),
                    SizedBox(height: 16,),
                    dettestData(
                      title: "Personal information obtained from third party sources (where you have provided the relevant permission), including:",
                    ),
                    SizedBox(height: 8,),
                    DescriptionData(description: "Banks and payment service providers used to transfer money to us;",),
                    DescriptionData(description: "Advertising networks; and",),
                    DescriptionData(description: "Search engine providers (such as Yahoo or Google).",),
                    SizedBox(height: 16,),
                    dettestData(
                      title: "Technical data, including:",
                    ),
                    SizedBox(height: 8,),
                    DescriptionData(description: "App downloads;",),
                    DescriptionData(description: "Operating system;",),
                    DescriptionData(description: "Browser type.",),
                    DescriptionData(description: "Camera",),
                    DescriptionData(description: "Exteranl storage",),
                    SizedBox(height: 16,),
                    Text("When you download our Mobile App, in addition to the information mentioned above we collect and process:",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: AppColor.kBlackColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16,),
                    dettestData(
                      title: "Information you give us.",
                    ),
                    SizedBox(height: 8,),
                    Text("This is the information that you consent to give to us about you when you download or register to use the Mobile App, subscribe to our services or by corresponding with us. This information includes identity, contact, financial and marketing and communications data. If you contact us we will keep a record of that correspondence.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: AppColor.kBlackColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16,),
                    dettestData(
                      title: "Information we collect about you and your device.",
                    ),
                    SizedBox(height: 8,),
                    Text("Each time you use our Mobile App we will automatically collect information on the type of device you use, operating system version, and system and performance indication. We may send you push notifications from time-to-time in order to update you about any events or promotions that we may be running. If you no longer wish to receive these types of communications, you may turn them off at the device level. To ensure you receive proper notifications, we will need to collect certain information about your device such as operating system and user identification information.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: AppColor.kBlackColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16,),
                    dettestData(
                      title: "Mobile Analytics Data.",
                    ),
                    SizedBox(height: 8,),
                    Text("We may collect this data to allow us to better understand the functionality of our mobile software on your phone. This software may record information such as how often you use the mobile app, the events that occur within it, aggregated usage, performance data, and where the mobile app was downloaded from. We do not link the information we store within the analytics software to any personal data you submit within the mobile app.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: AppColor.kBlackColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16,),
                  ],
                ),
              ),
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     GetBuilder<PrivacyPermissionController>(
            //       builder: (_){
            //         return Checkbox(
            //         activeColor: AppColor.kPrimaryColor,
            //         value: _privacyPermissionController.checkedTermsCondition,
            //         onChanged: (newValue){
            //           print(_privacyPermissionController.checkedTermsCondition);
            //           _privacyPermissionController.checkTermsCondition(newValue);
            //           if(_privacyPermissionController.checkedTermsCondition){
            //             FocusScope.of(context).unfocus();
            //           }
            //         }
            //       );
            //     }
            //     ),
            //     Expanded(
            //       child: Text.rich(
            //         TextSpan(
            //           children: [
            //             TextSpan(text: 'iAcecpetThe'.tr, style: Theme.of(context).textTheme.bodyMedium),
            //             TextSpan(
            //               recognizer: TapGestureRecognizer()..onTap = () {
            //                 Get.toNamed(Routes.TERMS_CONDITIONS);
            //               },
            //               text: 'termsAndCondition'.tr,
            //               style: TextStyle(
            //                 fontSize:12.sp,
            //                   fontWeight: FontWeight.bold,
            //                   color: AppColor.kBlueColor
            //                 ),
            //             ),
            //             TextSpan(text:'and'.tr),
            //             TextSpan(
            //               recognizer: TapGestureRecognizer()..onTap = () {
            //                 Get.toNamed(Routes.PRIVACY_POLICY_SCREEN);
            //               },
            //               text: 'privecyPolicy'.tr,
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 color: AppColor.kBlueColor,
            //                 fontSize:12.sp,
            //               ),
            //             ),
            //             TextSpan(text: 'findOutNewService'.tr,
            //               style: Theme.of(context).textTheme.bodyMedium,
            //             ),
            //           ],
            //         ),
            //         textAlign: TextAlign.left,
            //       ),
            //     ),
            //   ],
            //   ),
            Container(
              height: 60,
              child: Row(
                children: [
                  CustomButton(
                    buttonLevel: "I agree",
                    color: AppColor.kGreenColor,
                    onPressed: (){
                      box.write(Keys.checkBoxVelue, Strings.agree);
                      Get.toNamed(Routes.ONBOARD_SCREEN);
                    },
                  )
                ],
              ),
            ),
          ],
        )
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: (){

      //   }, 
      //   label: Text("I agree"),
      // ),
    );
  }
}

class DescriptionData extends StatelessWidget {
  final String? description;
  const DescriptionData({
    this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.black),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
              child: Text(description!,style: TextStyle(
                color: AppColor.kBlackColor,
                fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class dettestData extends StatelessWidget {
  final String?  title;

  const dettestData({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: CircleAvatar(radius: 4,backgroundColor: AppColor.kBlackColor,),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(title!,style: TextStyle(
              color: AppColor.kBlackColor,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),),
          ),
          SizedBox(height: 8,),
        ],
      ),
    );
  }
}