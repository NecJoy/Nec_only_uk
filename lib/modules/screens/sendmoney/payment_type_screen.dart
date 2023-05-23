// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/utils/keys.dart';
import '../../../core/values/app_color.dart';
import '../../../core/values/strings.dart';
import '../../../widgets/custom_listtile_button.dart';
import '../../controller/payment_mode_controller.dart';
import '../../controller/send_money_base_controller.dart';
import '../../controller/send_money_controller.dart';
class PaymentTypeScreen extends StatefulWidget {
PaymentTypeScreen({Key? key}) : super(key: key);

  @override
  State<PaymentTypeScreen> createState() => _PaymentTypeScreenState();
}

class _PaymentTypeScreenState extends State<PaymentTypeScreen> {
  var box = GetStorage();

  final SendMoneyController sendMoneyController =  Get.put(SendMoneyController());

  final PaymentTypeController _paymentTypeController = Get.put(PaymentTypeController());

  final SendMoneyBaseController _sendMoneyBaseController = Get.put(SendMoneyBaseController());
  bool errorLodder = false;

  // Stream<List<PaymentTypeModel>> getPaymentMode() {
  //   return Stream.fromFuture(_paymentTypeController.getPaymentMode());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: AppColor.kWhiteColor,
     body: SafeArea(
       child: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(15.0),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
             children: [
                Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('paymentType'.tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('howYouldYou'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Obx(()=> _paymentTypeController.isLodding.value == true ? Center(
                  child: CircularProgressIndicator(
                    color: AppColor.kGreenColor,
                  ),
                ): Column(
                    children: [
                      for(int i = 0; i < _paymentTypeController.paymentModeList.value.length; i++)
                      Column(
                        children: [
                          CustomListTileButton(
                            icon:('assets/icon/bank.svg'),
                            title: _paymentTypeController.paymentModeList.value[i].modeId.toString() == Keys.accountPayeeID ? "Bank account".toUpperCase() : _paymentTypeController.paymentModeList.value[i].description,
                              onTap: (){
                              sendMoneyController.countryFlag.value = "";
                              clearCache();
                              sendMoneyController.paymentModeId.value = _paymentTypeController.paymentModeList.value[i].modeId.toString();
                              box.write(Keys.benePayeeModeID, _paymentTypeController.paymentModeList.value[i].modeId.toString());
                              sendMoneyController.modeName.value = _paymentTypeController.paymentModeList.value[i].description.toString();
                              box.write(Keys.paymentType, Strings.bank);
                              _sendMoneyBaseController.NavigateSteep();
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ],
                   ),
                ),
            ],
          ),
        ),
      )
    ),
  );
}

    void clearCache(){
    sendMoneyController.countryName.value = "";
    sendMoneyController.countryId.value = "";
    sendMoneyController.currenciesId.value = "";
    sendMoneyController.companyId.value = "";
    sendMoneyController.bankAndWalletPayeebankId.value = "";
    sendMoneyController.bankAndWalletPayeeBankName.value = "";
    sendMoneyController.bankCode.value = "";
    sendMoneyController.subCompanyBranchID.value = "";
    sendMoneyController.subCompanyId.value = "";
    sendMoneyController.firstNameController.clear();
    sendMoneyController.lastNameController.clear();
    sendMoneyController.relation.value = "";
    sendMoneyController.phoneNumberController.clear();
    sendMoneyController.walletNumberController.clear();
    sendMoneyController.bankAndWalletPayeeBankName.value = "";
    sendMoneyController.accountNumberController.clear();
    sendMoneyController.branchCityName.value = "";
    sendMoneyController.bankAndWalletPayeeBankBranchName.value = "";
    sendMoneyController.fullBranchAddressController.clear();
    sendMoneyController.cashPayeeBankBranchName.value = "";
    sendMoneyController.cashsubCompaniCityController.clear();
    sendMoneyController.bankandCompanyNamecontroller.clear();
    sendMoneyController.currencycontroller.clear();
    sendMoneyController.subCompanyCode.value = "";
    sendMoneyController.bankAndWalletPayeebankBranchId.value = "";
    sendMoneyController.branchCode.value = "";
    box.write(Keys.subCompanyBranchID, "");
    box.write(Keys.subCompanyBranchCode,"");
    sendMoneyController.cashBranchNameController.clear();
  }
}


/*

                StreamBuilder<List<PaymentTypeModel>>(
                  stream: getPaymentMode(),
                  builder: (BuildContext context , AsyncSnapshot<List<PaymentTypeModel>> snapshort ){
                    if(snapshort.hasError){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: 1.5,
                            child: SvgPicture.asset("assets/logo/no_data.svg"),
                          ),
                          Text("Database connection error! Please try again".tr,
                            style: TextStyle(
                            color: AppColor.kGreyColor,
                            fontSize: 14, 
                            ),
                          ),
                          SizedBox(height: 8.0),
                          // MaterialButton(
                          //   shape: const CircleBorder(),
                          //   color: AppColor.kPrimaryColor,
                          //   padding: const EdgeInsets.all(10),
                          //   onPressed: () async{
                          //     setState(() {
                          //       getPaymentMode();
                          //     });
                          //   },
                          //   child: const Icon(
                          //     Icons.refresh,
                          //     size: 24,
                          //     color: AppColor.kWhiteColor,
                          //   ),
                          // ),
                          if(errorLodder == false)...[
                            MaterialButton(
                            shape: const CircleBorder(),
                            color: AppColor.kPrimaryColor,
                            padding: const EdgeInsets.all(10),
                            onPressed: () async{
                              setState(() {
                                errorLodder = true;
                                getPaymentMode();
                              });
                            },
                            child: const Icon(
                              Icons.refresh,
                              size: 24,
                              color: AppColor.kWhiteColor,
                            ),
                          ),
                          ]else...[
                            CircularProgressIndicator(color: AppColor.kGreenColor,),
                          ]
                        ],
                      );
                    }else if (snapshort.connectionState == ConnectionState.waiting){
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: 1.5,
                              child: SvgPicture.asset("assets/logo/no_data.svg"),
                            ),
                            CircularProgressIndicator(color: AppColor.kPrimaryColor, backgroundColor: AppColor.kWhiteColor,),
                          ],
                      );
                    }else if (snapshort.hasData){
                      return ListView.builder(
                        shrinkWrap: true,
                       // physics: BouncingScrollPhysics(),
                        itemCount: snapshort.data!.length,
                        itemBuilder: (BuildContext context , index){
                          var _data = snapshort.data![index];
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration:  Duration(milliseconds: 600),
                            child: SlideAnimation (
                            horizontalOffset: 100.0,
                            child: FadeInAnimation (
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.kSeaGreenColor,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(width: 1, color: AppColor.kGreenColor)
                                      ),
                                      child: CustomListTileButton(
                                        icon:('assets/icon/bank.svg'),
                                        title:  _data.modeId.toString() == Keys.accountPayeeID ? "Bank account".toUpperCase() :  _data.description ,
                                        onTap: (){
                                            sendMoneyController.countryFlag.value = "";
                                            clearCache();
                                            sendMoneyController.paymentModeId.value =  _data.modeId.toString();
                                            box.write(Keys.benePayeeModeID,  _data.modeId.toString());
                                            sendMoneyController.modeName.value =  _data.description.toString();
                                            box.write(Keys.paymentType, Strings.bank);
                                            _sendMoneyBaseController.NavigateSteep();
                                          },
                                        ),
                                    ),
                                  ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ); 
                    }
                    return Center(child: CircularProgressIndicator(color: AppColor.kGreenColor,));
                  },
                ),

              */