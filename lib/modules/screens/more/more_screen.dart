import 'dart:io';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/helpers.dart';
import 'package:necmoney/core/values/strings.dart';
import 'package:necmoney/modules/controller/get_remitter_controller.dart';
import 'package:necmoney/modules/controller/home_controller.dart';
import 'package:necmoney/modules/controller/more_controller.dart';
import 'package:necmoney/modules/controller/signin_controller.dart';
import 'package:necmoney/modules/controller/upload_document_controller.dart';


import 'package:necmoney/routes/routes.dart';
import 'package:sizer/sizer.dart';
import '../../../core/utils/keys.dart';
import '../../../core/utils/session_timer.dart';
import '../../../core/values/app_color.dart';
import '../../controller/exchange_isocode_controller.dart';
import '../../controller/receiver_list_controller.dart';
import '../../controller/sender_detials_controller.dart';


// ignore: must_be_immutable
class MoreScreen extends StatelessWidget {
  final MoreController _moreController = Get.put(MoreController());
  final GetRemitterInfo _getRemitterInfo = Get.put(GetRemitterInfo());
  final SignInController _signInController = Get.put(SignInController());
  final HomeController _homeController = Get.put(HomeController());
  final ExchangeLCIsoCode _exchangeLCIsoCode =  Get.put(ExchangeLCIsoCode());
  final ReceiverListController _reciverListController = Get.put(ReceiverListController());
  final AddNewDocumentController _addNewDocumentController = Get.put(AddNewDocumentController());
  final SenderDetailsController  _senderDetailsController = Get.put(SenderDetailsController());
  SessionTimerController sessionTimer = Get.put(SessionTimerController());
  final box = GetStorage();
  MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: AppBar(
        title: Text(
          'more'.tr,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        backgroundColor: AppColor.kPrimaryColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: (){
              _homeController.calculateLenght();
              Get.toNamed(Routes.NOTIFICATION_SCREEN);
            }, 
            icon: Obx(()=> badges.Badge(
                position: badges.BadgePosition.topEnd(top: -5, end: -3),
                badgeContent: Text(_homeController.notoficationLength.toString(), style: TextStyle(color: AppColor.kWhiteColor, fontSize: 10),),
                child: Icon(Icons.notifications, color: AppColor.kWhiteColor, size: 28,),
              ),
            )
          ),
          SizedBox(width: 10,)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                        Obx(() => _moreController.profileImage.isNotEmpty? CircleAvatar(
                          backgroundColor: AppColor.kPrimaryColor,
                          radius: 40,
                          child: CircleAvatar(
                            radius: 38,
                            backgroundImage: FileImage(File(box.read(Keys.profileImage)))
                          ),
                        ): CircleAvatar(
                          backgroundColor: AppColor.kPrimaryColor,
                          radius: 40,
                          child: Icon(Icons.person, size: 50, color: AppColor.kWhiteColor,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width / 2,
                        child: Text(
                         "${box.read(Keys.userName)}",
                         overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Text(
                        "customerIDNumber".tr,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 4,),
                      box.read(Keys.remitterId) != null ? Text(
                       "${box.read(Keys.clientID)}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ) : GestureDetector(
                        onTap: (){
                          _senderDetailsController.senderDetailsPageController = PageController(viewportFraction: 1.0,initialPage: 0);
                          if(int.parse(box.read(Keys.senderFromCountryId).toString()) == Keys.canadaCountryID){
                            Get.toNamed(Routes.SENDER_INFO_SCREEN_CANADA);
                          }else if(int.parse(box.read(Keys.senderFromCountryId).toString()) == Keys.unitedKingdomCounryID){
                            Get.offAndToNamed(Routes.SENDER_DETAILS_BASE_SCREEN);
                          }else {
                            Get.offAndToNamed(Routes.SENDER_DETAILS_BASE_SCREEN);
                          }
                        },
                        child: Text(
                          "Profile incomplete",
                          style: TextStyle(
                            color: AppColor.kSecondaryColor,
                            fontSize: 12.sp,
                          )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(height: 16),
              Text(
                "account".tr,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.kGreyColor.withOpacity(0.5), width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        if(box.read(Keys.remitterId) != null){
                          _getRemitterInfo.getRemitterInfo(remitterId: box.read(Keys.remitterId).toString());
                        }else{
                          _senderDetailsController.senderDetailsPageController = PageController(viewportFraction: 1.0,initialPage: 0);
                        if(box.read(Keys.senderFromCountryId) == 278){
                            Get.toNamed(Routes.SENDER_INFO_SCREEN_CANADA);
                          }else if(box.read(Keys.senderFromCountryId) == 197){
                            Get.offAndToNamed(Routes.SENDER_DETAILS_BASE_SCREEN);
                          }else {
                            Get.offAndToNamed(Routes.SENDER_DETAILS_BASE_SCREEN);
                          }
                        }
                      },
                      title: Text(
                        "personalData".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColor.kSeagreyColor,
                      height: 0,
                    ),
                    ListTile(
                      onTap: () {
                        if(box.read(Keys.remitterId) != null){
                           _getRemitterInfo.getRemitterDetailsForPayment(box.read(Keys.remitterId).toString());
                          _addNewDocumentController.newDocument.value = true;
                           //_addNewDocumentController.documentTypeController.text = box.read(Keys.documnetTypeName).toString().isEmpty ? _senderDetailsController.documentTypeName.value : box.read(Keys.documnetTypeName).toString();
                            Get.toNamed(Routes.ADD_NEW_DOCUMENT_SCREEN);
                        }else{
                           _senderDetailsController.senderDetailsPageController = PageController(viewportFraction: 1.0,initialPage: 0);
                          if(int.parse(box.read(Keys.senderFromCountryId).toString()) == Keys.canadaCountryID){
                            Get.toNamed(Routes.SENDER_INFO_SCREEN_CANADA);
                          }else if(int.parse(box.read(Keys.senderFromCountryId).toString()) == Keys.unitedKingdomCounryID){
                            Get.offAndToNamed(Routes.SENDER_DETAILS_BASE_SCREEN);
                          }else {
                            Get.offAndToNamed(Routes.SENDER_DETAILS_BASE_SCREEN);
                          }
                        }
                      },
                      title: Text(
                        "uploadDocument".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColor.kSeagreyColor,
                      height: 0,
                    ),
                    ListTile(
                      onTap: () {
                         EasyLoading.show( status: 'Loading...', maskType: EasyLoadingMaskType.black);
                        _getRemitterInfo.getRemitterDetailsForPayment(box.read(Keys.remitterId).toString());
                        _exchangeLCIsoCode.getexchangeCode();
                        Get.toNamed(Routes.CHECK_RATE_AND_FEE);
                        EasyLoading.dismiss();
                      },
                      title: Text(
                        "checkRatefee".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColor.kSeagreyColor,
                      height: 0,
                    ),
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.TRACK_TRANSACTION);
                      },
                      title: Text(
                        "trackingTransaction".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColor.kSeagreyColor,
                      height: 0,
                    ),
                    ListTile(
                      onTap: () {
                        _reciverListController.backButton = true;
                        // _reciverListController.getBeneficiaryData();
                        Get.toNamed(Routes.RECEIVER_LIST_SCREEN);
                      },
                      title: Text(
                        "receiver".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "supportOthers".tr,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.kGreyColor.withOpacity(0.5), width: 1),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.CONTARCT_SCREEN);
                      },
                      title: Text(
                        "contactUs".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColor.kSeagreyColor,
                      height: 0,
                    ),
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.FEEDBACK_SCREEN);
                      },
                      title: Text(
                        "feedBack".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColor.kSeagreyColor,
                      height: 0,
                    ),
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.ABOUT_SCREEN);
                      },
                      title: Text(
                        "aboutUs".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColor.kSeagreyColor,
                      height: 0,
                    ),
                    ListTile(
                      onTap: (){
                        if(Platform.isAndroid){
                          Helpers.launchURL(Strings.playRatingUrl);
                        }else {
                          Helpers.launchURL(Strings.appStoreRatingUrl);
                        }
                      },
                      title: Text(
                        "rating".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColor.kSeagreyColor,
                      height: 0,
                    ),
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.PRIVACY_POLICY_SCREEN);
                      },
                      title: Text(
                        "privacyPolicy".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColor.kSeagreyColor,
                      height: 0,
                    ),
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.TERMS_CONDITIONS);
                      },
                      title: Text(
                        "termsAndConditions".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColor.kSeagreyColor,
                      height: 0,
                    ),
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.UPDATE_PASSWORD_SCREEN);
                      },
                      title: Text(
                        "Change Password".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColor.kSeagreyColor,
                      height: 0,
                    ),
                      ListTile(
                        onTap:  ()  {
                          if(Platform.isAndroid){
                            Helpers.launchURL("https://play.google.com/store/apps/details?id=com.necmoney.necmoneyapp");
                          }else{
                            Helpers.launchURL("https://apps.apple.com/us/app/nec-money/id1476959641");
                          }
                        },
                        title: Text(
                          "Update now".tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing:  Icon(Icons.download),
                      ),
                    Divider(
                      thickness: 1,
                      color: AppColor.kSeagreyColor,
                      height: 0,
                    ),
                    ListTile(
                      onTap: ()  {
                        EasyLoading.show( status: 'Loading...', maskType: EasyLoadingMaskType.black);
                          Future.delayed(Duration(seconds: 2),(){
                            box.remove(Keys.email);
                            box.remove(Keys.password);
                            box.remove(Keys.token);
                            _signInController.logout = true;
                            EasyLoading.dismiss();
                            Get.offAllNamed(Routes.SIGNIN_SCREEN);
                        });
                      
                      },
                      title: Text(
                        "logOut".tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Icon(Icons.exit_to_app),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Version ${box.read(Keys.nowAppVersion)}",
                  style: TextStyle(
                    color: AppColor.kGreyColor.withOpacity(0.8),
                    fontSize: 11,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



