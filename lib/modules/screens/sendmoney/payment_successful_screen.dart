

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/modules/controller/save_remittance_controller.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/keys.dart';
import '../../../core/values/app_color.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_button.dart';
import '../../../data/service/share_service.dart';
import '../../controller/pdf_download_controller.dart';


class PaymentSuccessfulScreen  extends StatelessWidget {
  PaymentSuccessfulScreen ({Key? key}) : super(key: key);
  final box = GetStorage();
  final SaveRemittanceController _saveRemittanceController = Get.put(SaveRemittanceController());
  final PdfDownloadController pdfDownloadController = Get.put(PdfDownloadController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Get.toNamed(Routes.BASE_NAV_LAYOUT);
        return  false;
      },
      child: Scaffold(
        backgroundColor: AppColor.kWhiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.kPrimaryColor ,
          title: Text("backToHome".tr, style: Theme.of(context).textTheme.displayMedium,),
          leading: IconButton(
            onPressed: (){
              Get.toNamed(Routes.BASE_NAV_LAYOUT);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 2.5,
                  child: Image.asset("assets/logo/payment_sucessful_icons.png"),
                ),
                SizedBox(height: 32,),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text("transactionCreateSuccessfully".tr,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displaySmall)),
                          ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    box.read(Keys.paymentModeName).toString().toUpperCase() == "BNKXFR".toUpperCase() ? Text(
                      "pleaseViewYouReciptCopy".tr, textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ) : SizedBox(),
                    SizedBox(height: 32),
                    box.read(Keys.paymentModeName).toString().toUpperCase() == "VISA".toUpperCase() ||  box.read(Keys.paymentModeName).toString().toUpperCase() == "MASTERCARD".toUpperCase() ? Row(
                      children: [
                        CustomButton(
                          buttonLevel: "Pay Now Amount: ${double.parse(box.read(Keys.displayAmount).toString())}",
                          onPressed: (){
                            _saveRemittanceController.payWithGateway();
                          },
                          color: AppColor.kSecondaryColor,
                        ),
                      ],
                    ) : SizedBox(width: 0, height: 0),
                    SizedBox(height: 32),
                    box.read(Keys.paymentModeName).toString().toUpperCase() == "BNKXFR".toUpperCase()  ? Row(
                      children: [
                        Obx(()=>CustomButton(
                            buttonLevel: pdfDownloadController.downloadStart.value == true ? "Downloading.." : "downloadReceipt".tr,
                            onPressed: () async{
                              var remittanceNo = box.read(Keys.remittanceNo).toString().split("/");
                              var docId = remittanceNo[0];
                              var remitterId = remittanceNo[1];
                              pdfDownloadController.progressValue.value = "0";
                              var fileName = docId + "_" + remitterId + ".pdf";
                              pdfDownloadController.downLoadPdf(fileName, "$fileName"); 
                            },
                            color: AppColor.kPrimaryColor,
                          ),
                        ),
                        SizedBox(width: 16,),
                        CustomButton(
                          buttonLevel: "shareReceipt".tr,
                          onPressed: () async {
                            await ShareService.shareDocument(data: Helpers.generateReciptLink(box.read(Keys.remittanceNo).toString()));
                          },
                          color: AppColor.kPrimaryColor,
                        )
                      ],
                    ): SizedBox() ,
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



