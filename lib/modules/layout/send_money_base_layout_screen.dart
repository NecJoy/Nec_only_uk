import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/helpers.dart';
import 'package:necmoney/core/utils/log.dart';
import 'package:necmoney/modules/controller/send_money_base_controller.dart';
import '../../core/values/app_color.dart';
import '../../routes/routes.dart';
import '../../core/utils/keys.dart';
import '../../core/values/strings.dart';
import '../controller/send_money_controller.dart';
import '../screens/documents/upload_document_screen.dart';
import '../screens/sendmoney/payment_mode_screen.dart';
import '../screens/sendmoney/payment_type_screen.dart';
import '../screens/sendmoney/payment_type_service_screen.dart';
import '../screens/sendmoney/receiver_information_screen.dart';
import '../screens/sendmoney/transaction_amount_screen.dart';

class SendMoneyBaseLayoutScreen extends StatefulWidget {
  @override
  State<SendMoneyBaseLayoutScreen> createState() => _SendMoneyBaseLayoutScreenState();
}
class _SendMoneyBaseLayoutScreenState extends State<SendMoneyBaseLayoutScreen> {
  final SendMoneyController _sendMoneyController = Get.put(SendMoneyController());
  final SendMoneyBaseController _sendMoneyBaseController = Get.put(SendMoneyBaseController());
  final box = GetStorage();
  var currentIndex = 1;
  List<Widget> _newRecevierTransaction = [
    PaymentTypeScreen(),
    PaymentTypeServiceScreen(),
    ReciverInformationScreen(),
    TransactionAmountScreen(),
    PaymentModeScreen(),
    UploadDocumnetScreen(),
  ];

  List<Widget> _oldRecevierTransaction = [
    TransactionAmountScreen(),
    PaymentModeScreen(),
    UploadDocumnetScreen(),
  ];

  double  calculateProgreessValue( double  pagesLength) {
    var progressValue = currentIndex / pagesLength;
    Logger(key: "ProgressValue", value: progressValue);
    Logger(key: "ProgressValue", value: progressValue);
    return progressValue;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if (_sendMoneyBaseController.pageController.offset == 0.0) {
          if(box.read(Keys.transaction) == Strings.oldRecevierTransaction){
            if(_sendMoneyController.reciverEditpay == true){
              Get.toNamed(Routes.BASE_NAV_LAYOUT);
            }else{
              Get.back();
            }
          }else {
            Get.toNamed(Routes.BASE_NAV_LAYOUT);
          }
        }else {
          if(_sendMoneyController.paymentModeId == Keys.mobileWalletID  && currentIndex == 3 || _sendMoneyController.paymentModeId == Keys.cashPayeeID  && currentIndex == 3 || _sendMoneyController.paymentModeId == Keys.accountPayeeID &&  currentIndex == 3 ){
            Get.toNamed(Routes.BASE_NAV_LAYOUT);
          }else if(box.read(Keys.transaction) == Strings.oldRecevierTransaction && currentIndex == 1 || currentIndex == 4){
            Get.toNamed(Routes.BASE_NAV_LAYOUT);
          }else{
            _sendMoneyBaseController.pageController.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.kGreenColor,
          automaticallyImplyLeading: false,
          leading: InkWell(
          onTap: () {
            Helpers.keyboardhide();
            if (_sendMoneyBaseController.pageController.offset == 0.0) {
              if(box.read(Keys.transaction) == Strings.oldRecevierTransaction){
                if(_sendMoneyController.reciverEditpay == true){
                  Get.toNamed(Routes.BASE_NAV_LAYOUT);
                }else{
                  Get.back();
                }
              }else {
                Get.toNamed(Routes.BASE_NAV_LAYOUT);
              }
            }else {
              if(_sendMoneyController.paymentModeId == Keys.mobileWalletID  && currentIndex == 3 || _sendMoneyController.paymentModeId == Keys.cashPayeeID  && currentIndex == 3 || _sendMoneyController.paymentModeId == Keys.accountPayeeID &&  currentIndex == 3 ){
                 Get.toNamed(Routes.BASE_NAV_LAYOUT);
              }else if(box.read(Keys.transaction) == Strings.oldRecevierTransaction && currentIndex == 1 || currentIndex == 4){
                Get.toNamed(Routes.BASE_NAV_LAYOUT);
              }else{
                 _sendMoneyBaseController.pageController.previousPage(
                 duration: const Duration(milliseconds: 400),
                 curve: Curves.easeInOut,
               );
              }
            }
          },
          child: Icon( currentIndex == 0 ? Icons.close : Icons.arrow_back_ios,size: 30,color: AppColor.kWhiteColor,
          )),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "sendMoney".tr,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(
                height: 8,
              ),
              LinearProgressIndicator(
                value: box.read(Keys.transaction) == Strings.oldRecevierTransaction ? calculateProgreessValue(double.parse(_oldRecevierTransaction.length.toString())): calculateProgreessValue(double.parse(_newRecevierTransaction.length.toString())),
                backgroundColor: AppColor.kWhiteColor,
                color: AppColor.kYellow,
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: PageView(
              controller: _sendMoneyBaseController.pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (newIndex) {
                setState(() {
                  currentIndex = newIndex;
                });
              },
              children: box.read(Keys.transaction) == Strings.oldRecevierTransaction ? _oldRecevierTransaction : _newRecevierTransaction,
            ),
          ),
      ),
    );
  }
}





