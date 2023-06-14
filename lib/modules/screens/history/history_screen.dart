// ignore_for_file: unnecessary_null_comparison, unused_element

import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/helpers.dart';
import 'package:necmoney/core/values/strings.dart';
import 'package:necmoney/data/service/download_service.dart';
import 'package:necmoney/modules/controller/home_controller.dart';
import 'package:necmoney/modules/controller/pdf_download_controller.dart';
import 'package:necmoney/modules/controller/track_transaction_controller.dart';
import 'package:necmoney/modules/controller/transaction_history_controller.dart';
import 'package:necmoney/routes/routes.dart';
import '../../../core/utils/keys.dart';
import '../../../widgets/date_picker.dart';
import '../../../core/values/app_color.dart';
import '../../../widgets/custom_datepicker_button.dart';
import '../../controller/save_remittance_controller.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);
  final DateTime initialDateTime = DateTime.now();
  final TransactionHistoryController _transactionHistoryController = Get.put(TransactionHistoryController());
  final TrackTransactionController _trackTransactionController = Get.put(TrackTransactionController());
  final SaveRemittanceController _saveRemittanceController = Get.put(SaveRemittanceController());
  final HomeController _homeController = Get.put(HomeController());
  final PdfDownloadController pdfDownloadController = Get.put(PdfDownloadController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('transactions'.tr, style: Theme.of(context).textTheme.displayMedium,),
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(()=>DatePicked(
                      level: "fromDate".tr,
                      onTap: (){
                        DatePicker.datePiker(
                          minimumYear: 1900,
                          context: context,
                          initialDateTime: initialDateTime,
                          maximumYear: DateTime.now().year,
                          onDateTimeChanged: (date){
                            _transactionHistoryController.getDateTime(date: date, fromDate: "fromDate");
                          },
                          onPressed: (){
                            Get.back();
                            if(_transactionHistoryController.endDate.isNotEmpty){
                               _transactionHistoryController.remittance.clear();
                             _transactionHistoryController.getTrasanctionHistory();
                            }
                            if(_transactionHistoryController.startDate.isEmpty){
                              _transactionHistoryController.getDateTime(date: DateTime.now(), fromDate: "fromDate");
                               _transactionHistoryController.getTrasanctionHistory();
                            }
                            
                          }
                        );
                      },
                      date: _transactionHistoryController.startDate.isNotEmpty ? 
                      Text(
                        Helpers.dateTimeFormet(DateTime.parse(_transactionHistoryController.startDate.value)),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ):Text(
                        "DD-MM-YYYY",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                  Obx(()=>DatePicked(
                      level: "toDate".tr,
                      onTap: (){
                        DatePicker.datePiker(
                          minimumYear: 1900,
                          context: context,
                          initialDateTime: initialDateTime,
                          maximumYear: DateTime.now().year,
                          onDateTimeChanged: (date){
                            print(date);
                            _transactionHistoryController.getDateTime(date:date ,toDate: "toDate");
                          },
                          onPressed: (){
                            Get.back();
                            if(_transactionHistoryController.startDate.isNotEmpty){
                              _transactionHistoryController.remittance.clear();
                              _transactionHistoryController.getTrasanctionHistory();
                            }
                            
                          }
                        );
                      },
                      date: _transactionHistoryController.endDate.isNotEmpty ? 
                      Text(
                        Helpers.dateTimeFormet(DateTime.parse(_transactionHistoryController.endDate.value)),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ):Text(
                        "DD-MM-YYYY",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(()=> _transactionHistoryController.remittance.isNotEmpty ?
                 Container( 
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20,bottom: 10),
                    child: Column(
                      children: [
                          Text(
                            "weHaveFoundTotal".tr + " ${_transactionHistoryController.remittance.length} " + "transactionss".tr,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        Text(
                          'inYourHistory'.tr,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ) : SizedBox(),
              ),
              Expanded(
                child: Obx(()=>_transactionHistoryController.isLoading.value ? Center(child: CircularProgressIndicator(color: AppColor.kPrimaryColor,)) : Container(
                    child:  _transactionHistoryController.remittance.isNotEmpty ?  AnimationLimiter(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemCount: _transactionHistoryController.remittance.length,
                        shrinkWrap: true,
                        itemBuilder: ( BuildContext context, index){
                        var data = _transactionHistoryController.remittance[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 600),
                          child:  SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: (){},
                                child: Card(
                                  elevation: 10,
                                  color: AppColor.kWhiteColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      color: AppColor.kSeaGreenColor.withOpacity(0.4),
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor: AppColor.kGreenColor,
                                                          radius: 20,
                                                          child: Center(
                                                            child: Icon(Icons.person,color: AppColor.kWhiteColor,),
                                                          ),
                                                        ),
                                                        SizedBox(width: 8,),
                                                        Expanded(
                                                          child: Text(
                                                            data.beneficiaryName.toString() + " " + data.beneficiarySurname.toString(),
                                                            style: Theme.of(context).textTheme.titleMedium,
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: (){
                                                          Get.toNamed(Routes.CORRECTIONTRANSACTION,  arguments: data.ttid);
                                                        }, 
                                                        icon: Icon(Icons.edit, color: AppColor.kPrimaryColor,)
                                                      ),
                                                      IconButton(
                                                        onPressed: (){
                                                          Get.toNamed(Routes.CANCELTRANSACTION, arguments: data.ttid);
                                                        }, 
                                                        icon: Icon(Icons.cancel, color: AppColor.kSecondaryColor,)
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Issue date: ", style: Theme.of(context).textTheme.titleSmall),
                                                  Text(
                                                    '${Helpers.dateTimeFormet(DateTime.parse("${data.issueDate}"))}',textAlign: TextAlign.start,
                                                    style: Theme.of(context).textTheme.titleSmall,
                                                  ),
                                                ],
                                              ),
                                              data.cardType.toString().toUpperCase() == "VISA"  ? SvgPicture.asset("assets/icon/visa.svg") : 
                                              data.cardType.toString().toUpperCase() == "MASTERCARD"  ? SvgPicture.asset("assets/icon/mastercard.svg") : SizedBox(),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
                                              width: Get.width,
                                              child: Text('transactionCode'.tr,textAlign: TextAlign.start,
                                              style: Theme.of(context).textTheme.titleSmall,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    Helpers.clipBoard(data: data.remittanceNo.toString());
                                                    _trackTransactionController.trackTransaction(
                                                      data.remittanceNo.toString()
                                                    );
                                                    Get.toNamed(Routes.TRACK_TRANSACTION, arguments: data.remittanceNo);
                                                  },
                                                  child: Text(
                                                    data.remittanceNo.toString(),
                                                    style: TextStyle(color: AppColor.kBlueColor, fontSize: 14)
                                                  ),
                                                ),
                                                Text(" || ", style: TextStyle(color: AppColor.kPrimaryColor,fontWeight: FontWeight.bold),),
                                                Text(
                                                  "${data.beneCurrencyCode} ${data.beneAmount}" ,
                                                  style: TextStyle(color: AppColor.kSecondaryColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("transactionStatus".tr,
                                                         style: Theme.of(context).textTheme.titleSmall,
                                                      ),
                                                      Text(data.stPayRefStatus.toString(),
                                                        style: Theme.of(context).textTheme.titleSmall,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: ()async{
                                                          var remittanceNo = data.remittanceNo.toString().split("/");
                                                          var docId = remittanceNo[0];
                                                          var remitterId = remittanceNo[1];
                                                          pdfDownloadController.indexNumber.value = index.toString();
                                                          pdfDownloadController.progressValue.value = "0";
                                                          // if(Platform.isAndroid){
                                                          //   await DownloadService.requestDownload(link: Strings.report + docId + "_" + remitterId + ".pdf");
                                                          // }else {
                                                            
                                                          // }
                                                          var fileName = docId + "_" + remitterId + ".pdf";
                                                           pdfDownloadController.downLoadPdf(fileName, "https://mapp.necmoney.com/Reports/$fileName");
                                                        },
                                                        child: Obx(()=>pdfDownloadController.downloadStart.value == true && pdfDownloadController.indexNumber.value == index.toString() ? Text("${pdfDownloadController.progressValue.value}%")   : Padding(
                                                            padding:  EdgeInsets.all(8.0),
                                                            child:  SvgPicture.asset("assets/icon/download_icons.svg",width: 20,color: AppColor.kGreenColor),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 12),
                                                      data.lastStatus.toString().toUpperCase() != "Cancelled".toUpperCase() ? (data.cardType.toString().toUpperCase() == "VISA" 
                                                     || data.cardType.toString().toUpperCase() == "MASTERCARD") 
                                                     && data.errorCode.toString() == "-999"? InkWell(
                                                        onTap: (){
                                                          box.write(Keys.remittanceNo, data.remittanceNo.toString());
                                                          box.write(Keys.displayAmount,  double.parse(data.equiAmount.toString()) + double.parse(data.equiCommission.toString()));
                                                          _saveRemittanceController.payWithGateway();
                                                        }, 
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text("Repay".toUpperCase(),style: TextStyle(color: AppColor.kPrimaryColor,fontSize: 13, fontWeight: FontWeight.bold),),
                                                        ),
                                                      ) : SizedBox(height: 0, width: 0) :  SizedBox(height: 0, width: 0)
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
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ) : Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              AspectRatio(
                              aspectRatio: 1.5,
                              child: SvgPicture.asset("assets/logo/no_data.svg"),
                              ),
                              Container( 
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20,bottom: 10),
                                child: Column(
                                  children: [
                                    Obx(()=> Text(
                                        "weHaveFoundTotal".tr + " ${_transactionHistoryController.remittance.length} " + "transactionss".tr,
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                    ),
                                    Text(
                                      'inYourHistory'.tr,
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ) ,
                  ),
                ) ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


