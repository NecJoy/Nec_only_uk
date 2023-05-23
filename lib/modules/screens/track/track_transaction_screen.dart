import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:necmoney/core/utils/helpers.dart';

import '../../../core/values/app_color.dart';
import '../../../modules/controller/track_transaction_controller.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';



class TrackTranscationScreen extends StatelessWidget {
  TrackTranscationScreen({ Key? key }) : super(key: key);
  final TrackTransactionController _trackTransactionController = Get.put(TrackTransactionController());

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    if(arguments != null) _trackTransactionController.trackController.text = arguments.toString();
    return WillPopScope(
      onWillPop: ()async{
        _trackTransactionController.trackTransactionData.clear();
        _trackTransactionController.trackController.clear();
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: CustomAppBar(
            title: "trackTrnsaction".tr,
            leading: IconButton(
            onPressed: (){
              _trackTransactionController.trackTransactionData.clear();
              _trackTransactionController.trackController.clear();
              Get.back();
            }, 
            icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back, color: AppColor.kWhiteColor),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        'enterTransactionCode'.tr,
                        style: TextStyle(color: AppColor.kBlackColor, fontSize: 14, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 36,),
                      TextFormField(
                        controller: _trackTransactionController.trackController,
                        keyboardType: TextInputType.streetAddress,
                        onChanged: (value){
                          if(value.isEmpty){
                            _trackTransactionController.trackTransactionData.clear();
                          }
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: Image.asset("assets/icon/spinner.png"),
                          suffixIcon: IconButton(
                            onPressed: (){
                            _trackTransactionController.trackController.clear();
                            _trackTransactionController.trackTransactionData.value = [];
                          },
                           icon: Icon(Icons.cancel,color: AppColor.kSecondaryColor,),
                          ),
                          label: Text("GB0206360/006049".tr, style: TextStyle(color: AppColor.kGreyColor),),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.kGreyColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.kGreyColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                    CustomButton(
                      buttonLevel: 'trackTrnsaction'.tr,
                      color: AppColor.kPrimaryColor,
                      onPressed: (){
                        if(_trackTransactionController.trackController.text.isNotEmpty){
                          _trackTransactionController.trackTransaction(
                            _trackTransactionController.trackController.text
                          );
                          Helpers.keyboardhide();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 64,),
                Obx(()=>_trackTransactionController.trackTransactionData.isNotEmpty ? Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.kGreenColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border:Border.all(width: 2, color: AppColor.kGreenColor)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Center(
                                  child: RawMaterialButton(
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
                                ),
                              ),
                              Column(
                                children: [
                                  Text("Transaction Number", style: TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.bold)),
                                  SizedBox(height: 8),
                                  Text(_trackTransactionController.trackTransactionData.first.remittanceNo.toString(), style: TextStyle(color: AppColor.kGreyColor)),
                                ],
                              ),
                              SizedBox(height: 8,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('paymentStatus'.tr, style: TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.bold)),
                                  SizedBox(height: 8),
                                  Text(_trackTransactionController.paymentLastStatus.toString(), style: TextStyle(color: AppColor.kGreyColor)),
                                ],
                              ),
                              SizedBox(height: 16,),
                              Text('Issue Date'.tr, style: TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text(
                                Helpers.dateTimeFormet(DateTime.parse(_trackTransactionController.trackTransactionData.first.issueDate.toString().split(" ")[0])),
                                style: TextStyle(color: AppColor.kGreyColor),
                              ),
                              SizedBox(height: 8,),
                              Text('Issue Time'.tr, style: TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text(
                                "${_trackTransactionController.trackTransactionData.first.issueTime.toString()}",
                                style: TextStyle(color: AppColor.kGreyColor),
                              ),
      
                            //   ListView.builder(
                            //     itemCount: _trackTransactionController.statusWallet.length,
                            //     shrinkWrap: true,
                            //     physics: NeverScrollableScrollPhysics(),
                            //     itemBuilder: (context ,index){
                            //       return IntrinsicHeight(
                            //         child: Container(
                            //           child: Row(
                            //             crossAxisAlignment: CrossAxisAlignment.stretch,
                            //             mainAxisSize: MainAxisSize.min,
                            //             children: [
                            //               Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               verticalDirection: VerticalDirection.down,
                            //               children: [
                            //                 Icon(
                            //                   Icons.check_circle,
                            //                   size: 24, 
                            //                   color: _trackTransactionController.getColorBuilder(index)
                            //                 ),
                            //                 index == _trackTransactionController.statusWallet.length -1 ? SizedBox() :   Container(
                            //                   height: 40,
                            //                   width: 2,
                            //                   color: _trackTransactionController.getLineColorBuilder(index)
                            //                 ),
                            //               ],
                            //             ),
                            //             SizedBox(width: 10),
                            //             Expanded(
                            //               child: Column(
                            //                 mainAxisSize: MainAxisSize.min,
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 children: [
                            //                   Text(
                            //                     _trackTransactionController.statusWallet[index],
                            //                     style:  Theme.of(context).textTheme.titleSmall,
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //            ],
                            //           ),
                            //         ),
                            //       );
                            //     }
                            //   ),
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
                  ) : SizedBox(),
                 ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

