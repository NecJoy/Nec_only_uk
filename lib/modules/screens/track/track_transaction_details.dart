import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_color.dart';
import '../../../widgets/custom_button.dart';


class TrackTranscationDetailsScreen extends StatelessWidget {
  const TrackTranscationDetailsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.kWhiteColor,
        leading: IconButton(
          onPressed: (){
            Get.back();
          }, 
          icon: Icon(Icons.arrow_back_ios, color: AppColor.kPrimaryColor),
        ),
        title: Text(
          'trackYourTransaction'.tr, 
          style: TextStyle(color: AppColor.kPrimaryColor, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
              RawMaterialButton(
                onPressed: () {},
                elevation: 2.0,
                fillColor: AppColor.kPrimaryColor,
                child: Image.asset("assets/icon/transaction.png"),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(
                  side: BorderSide(
                    width: 2, color: AppColor.kWhiteColor, 
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 277,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.kLightGreenColor,
                      borderRadius: BorderRadius.circular(8),
                      border:Border.all(width: 2, color: AppColor.kGreenColor)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                           TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text("transacTionNumber".tr, style: TextStyle(color: AppColor.kGreyColor),),
                            ),
                          ),
                          Text('paymentStatus'.tr),
                          Text('cancelled'.tr, style: TextStyle(color: AppColor.kBlackColor, fontSize: 25),),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColor.kGreenColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(child: Text("cancelledMessage".tr, style: TextStyle(color: AppColor.kWhiteColor),)),
                                Icon(Icons.warning_amber_rounded, color: Colors.white,size: 36,),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                  Transform.translate(
                    offset: Offset(0,-12),
                    child: Container(
                      height: 23,
                      width: 177,
                      decoration: BoxDecoration(
                        color: AppColor.kSecondaryColor,
                         borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(child: Text("transactionDetails".tr, style: TextStyle(color: AppColor.kWhiteColor),)),
                    ),
                  ),
                ],
              ),
             Row(
              children: [
                CustomButton(
                  buttonLevel: 'trackAnotherTransaction'.tr,
                  color: AppColor.kSecondaryColor,
                  onPressed: (){
                    Get.back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



