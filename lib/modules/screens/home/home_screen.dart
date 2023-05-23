

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/modules/controller/home_controller.dart';
import 'package:necmoney/routes/routes.dart';
import 'package:sizer/sizer.dart';
import '../../../core/utils/keys.dart';
import '../../../core/values/app_color.dart';
import '../../controller/get_remitter_controller.dart';
import '../../controller/sender_detials_controller.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController _homeController = Get.put(HomeController());
  final GetRemitterInfo _getRemitterInfo = Get.put(GetRemitterInfo());
  final SenderDetailsController  _senderDetailsController = Get.put(SenderDetailsController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.h),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.kPrimaryColor,
          // title: Text("home".tr, style: Theme.of(context).textTheme.displayMedium),
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 15,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 15,),
                    Text(
                      "Hello!",                     
                      style: TextStyle(
                        color: AppColor.kYellow,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: Get.width / 2,
                      child: Text(
                        "${box.read(Keys.userName)}",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: AppColor.kWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp
                        ),
                        // style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    SizedBox(height: 4),
                    box.read(Keys.remitterId) != null ? Text(
                      "[ ${box.read(Keys.clientID)} ]",
                       style: TextStyle(
                        color: AppColor.kWhiteColor.withOpacity(0.75),
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp
                      ),
                    ) : GestureDetector(
                      onTap: (){
                        // Get.toNamed(Routes.SENDER_DETAILS_BASE_SCREEN);
                        if(int.parse(box.read(Keys.senderFromCountryId).toString()) == Keys.canadaCountryID){
                          Get.toNamed(Routes.SENDER_INFO_SCREEN_CANADA);
                        }else if(int.parse(box.read(Keys.senderFromCountryId).toString()) == Keys.unitedKingdomCounryID){
                          Get.offAndToNamed(Routes.SENDER_DETAILS_BASE_SCREEN);
                        }else {
                          Get.offAndToNamed(Routes.SENDER_DETAILS_BASE_SCREEN);
                        }
                        _senderDetailsController.senderDetailsPageController = PageController(viewportFraction: 1.0, initialPage: 0);
                      },
                      child: Text(
                        "Profile Incomplete",
                        style: TextStyle(
                          color: AppColor.kSeaGreenColor,
                          fontSize: 12.sp,
                        )
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: IconButton(
                    onPressed: (){
                      _homeController.calculateLenght();
                      Get.toNamed(Routes.NOTIFICATION_SCREEN);
                    }, 
                    icon: Obx(()=> badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -5, end: -3),
                      badgeContent: Text(_homeController.notoficationLength.toString(), style: TextStyle(color: AppColor.kWhiteColor, fontSize: 12),),
                      child: Icon(Icons.notifications, color: AppColor.kWhiteColor, size: 32,),
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            SizedBox(height: 36,),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                         _getRemitterInfo.getRemitterDetailsForPayment(box.read(Keys.remitterId).toString());
                        Future.delayed(Duration(seconds: 1),(){
                          Get.toNamed(Routes.CHECK_RATE_AND_FEE);
                        });
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icon/great_rate_icon.svg'),
                          SizedBox(height: 8,),
                          Text('greatRates'.tr,
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              decoration:TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.double,
                            )
                          ),
                          SizedBox(height: 4,),
                          Text('greatRateslow'.tr, textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32,),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(Routes.TRACK_TRANSACTION);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icon/transfer_icon.svg'),
                          SizedBox(height: 8,),
                          Text('trackyourtransfer'.tr,
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              decoration:TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.double,
                            )
                          ),
                          SizedBox(height: 4,),
                          Text('getStatusUpdates'.tr,textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32,),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(Routes.PRIVACY_POLICY_SCREEN);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icon/safe_icon.svg'),
                          SizedBox(height: 8,),
                          Text('safeandsecure'.tr,
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              decoration:TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.double,
                            )
                          ),
                          SizedBox(height: 4),
                          Text('yourInformationisalways'.tr, textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                   ],
                 ),
              ),
            ],
          ),
        )
      ),
    );
  } 
}

