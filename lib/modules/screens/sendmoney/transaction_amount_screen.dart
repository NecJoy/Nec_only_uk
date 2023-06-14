
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';


import '../../../core/utils/country_flag.dart';
import '../../../core/utils/keys.dart';
import '../../../modules/controller/get_customer_commission_controller.dart';
import '../../../modules/controller/send_money_controller.dart';
import '../../../widgets/custom_dropdown_search_field.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/values/app_color.dart';
import '../../../core/values/strings.dart';
import '../../../data/model/get_subcompany_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_rate_check_field.dart';
import '../../controller/get_dealing_rate_controller.dart';
import '../../controller/send_money_base_controller.dart';


class TransactionAmountScreen extends StatelessWidget {
  TransactionAmountScreen({Key? key}) : super(key: key);
  final SendMoneyController _sendMoneyController = Get.put(SendMoneyController());
  final GetCustomerComissionController _getCustomerComissionController = Get.put(GetCustomerComissionController());
  final SendMoneyBaseController _sendMoneyBaseController = Get.put(SendMoneyBaseController());
  final ApiProvider _apiProvider = ApiProvider();
  final GetDealingRateContoller _getDealingRateContoller = Get.put(GetDealingRateContoller());
  final box = GetStorage();
  final formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      body: SingleChildScrollView(
        reverse: true,
        child:  Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: AppColor.kGreyColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("receiverInformation".tr, style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: 8),
                      CustomReceiverMenu(title: "Name".tr, subTitle: "${_sendMoneyController.firstNameController.text} " + " ${_sendMoneyController.lastNameController.text}"),
                      CustomReceiverMenu(title: "paymentType".tr, subTitle: "${_sendMoneyController.modeName.value.capitalize}"),
                      CustomReceiverMenu(title: "country".tr, subTitle: "${_sendMoneyController.countryName.value.capitalize}"),
                      CustomReceiverMenu(title: "currency".tr, subTitle: "${_sendMoneyController.currencycontroller.text.capitalize}"),
                      CustomReceiverMenu(title: "bankCompany".tr, subTitle: "${_sendMoneyController.bankandCompanyNamecontroller.text.capitalize}"),
                      CustomReceiverMenu(title: "phoneNumber".tr,subTitle: "${box.read(Keys.benePhoneNumber)}"),
                      // ignore: unnecessary_null_comparison
                      box.read(Keys.benePayeeModeID).toString() == Keys.accountPayeeID ?  CustomReceiverMenu(title: "bankName".tr,subTitle: "${box.read(Keys.beneBankName)}") : SizedBox(),
                      _sendMoneyController.paymentModeId.value == Keys.cashPayeeID ? SizedBox() : CustomReceiverMenu(title: "accountNumber".tr,subTitle: "${box.read(Keys.beneAccNo)}"),
                    ],
                  ),
              ),
            ),
            SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.all(15),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       _sendMoneyController.paymentModeId.value == Keys.cashPayeeID ? Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('selectBank'.tr,style: Theme.of(context).textTheme.bodyLarge),
                            SizedBox(height: 8,),
                            IgnorePointer(
                                ignoring: false,
                                child: CustomDropdownScarchField<SubcompanyModel>(
                                  showSearchBox: true,
                                  searchhintText: "bankName".tr,
                                  onFind: (String? filter) async{
                                    var response = await _apiProvider.getSingleData(
                                      baseUrl: Strings.baseUrl, 
                                      url: Strings.getSubcompaniesUrl + "CountryID=${_sendMoneyController.countryId.value.toString()}&CurrencyID=${_sendMoneyController.currenciesId.value.toString()}&ModeID=${_sendMoneyController.paymentModeId.value.toString()}&City="
                                    );
                                    List c = [];
                                    for(var i in response["subcompanies"]){
                                      c.add(i);
                                    }
                                    var _c =  c.where((element) => element.toString().toLowerCase().contains(filter!.toLowerCase()));
                                    return _c.map((e) => SubcompanyModel.fromJson(e)).toList();
                                  },
                                  
                                  itemAsString: (SubcompanyModel? u) => u!.name.toString(),
                                  hintText: _sendMoneyController.bankandCompanyNamecontroller.text.isEmpty ? "bankName".tr : _sendMoneyController.bankandCompanyNamecontroller.text,
                                  // validator:(SubcompanyModel? value){},
                                  onChanged: (SubcompanyModel? value){
                                    _sendMoneyController.bankandCompanyNamecontroller.text = value!.name.toString();
                                    _sendMoneyController.subCompanyId.value = value.subcompanyId.toString();
                                    _sendMoneyController.companyId.value = value.companyId.toString();
                                    _getDealingRateContoller.getDealingRate(
                                      subCompanyId: _sendMoneyController.subCompanyId.value,
                                      countryId: _sendMoneyController.countryId.value,
                                      currencyId: _sendMoneyController.currenciesId.value,
                                      fldPsfx: ""
                                    );
                                    if( _sendMoneyController.subCompanyId.value.toString() != Keys.anyBankSubCompany &&   _sendMoneyController.companyId.value.toString() != Keys.anyBankCompany){
                                          _getDealingRateContoller.getBranchName(
                                          subCompaniesCity: "ANY CITY",
                                          companyId: "${_sendMoneyController.companyId.value}",
                                          subCompanyId: "${_sendMoneyController.subCompanyId.value}",
                                          countryId: "${_sendMoneyController.countryId.value}",
                                          paymentModeId: "${box.read(Keys.benePayeeModeID)}"
                                    );
                                    
                                    }else{
                                      box.write(Keys.subCompanyBranchID, "86211");
                                    }
                                     clearCache();
                                  },
                                  hintStyle: _sendMoneyController.bankandCompanyNamecontroller.text.isEmpty ? null :TextStyle(color: AppColor.kBlackColor,fontWeight: FontWeight.w500),
                                ),
                              ),
                            SizedBox(height: 16),
                          ],
                        ) : SizedBox(),
                        Text('transactionAmount'.tr,style: Theme.of(context).textTheme.bodyLarge),
                        SizedBox(height: 8),
                        CustomRateCheckField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                            LengthLimitingTextInputFormatter(11),
                          ],
                          controller: _getCustomerComissionController.transactionAmountController,
                          focusNode: _getCustomerComissionController.transactionAmountFocusNode,
                          hintext: '0.0',
                          currencyname: "${box.read(Keys.exchangeLCIsoCode)}",
                          onChanged: (_valus){
                            DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
                            String operationDate = dateFormat.format(DateTime.now());
                            _getCustomerComissionController.receiverAmountController.text = (double.parse(_getCustomerComissionController.transactionAmountController.text.isNotEmpty ? _getCustomerComissionController.transactionAmountController.text : "0.0") *  _getDealingRateContoller.dealingRate.value).toStringAsFixed(0);
                            _getCustomerComissionController.getCustomerCommission(
                              amount: _getCustomerComissionController.transactionAmountController.text,
                              countryID: _sendMoneyController.countryId.value,
                              currencyID: _sendMoneyController.currenciesId.value,
                              operationDate: operationDate,
                              subCompanyID: _sendMoneyController.subCompanyId.value
                            );
                            return null;
                          },
                          countryflag: flagWithCountry.showflagWithCountry(box.read(Keys.countryID).toString()),
                         // countryflag: countryflag.keys.contains("${box.read(Keys.remCounty)}") == false ? "${countryflag["DEMO"]}"  :  "${countryflag[box.read(Keys.remCounty)]}",
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('receiverAmount'.tr,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomRateCheckField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                            LengthLimitingTextInputFormatter(11),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          focusNode: _getCustomerComissionController.receiverAmountFocusNode,
                          controller: _getCustomerComissionController.receiverAmountController,
                          hintext: '0.0',
                          onChanged: (_value){
                            DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
                              String operationDate = dateFormat.format(DateTime.now());
                                _getCustomerComissionController.transactionAmountController.text = (double.parse(_getCustomerComissionController.receiverAmountController.text.isNotEmpty ? _getCustomerComissionController.receiverAmountController.text : "0.0") /  _getDealingRateContoller.dealingRate.value).toStringAsFixed(2);
                                _getCustomerComissionController.getCustomerCommission(
                                amount: _getCustomerComissionController.transactionAmountController.text,
                                countryID: _sendMoneyController.countryId.value,
                                currencyID: _sendMoneyController.currenciesId.value,
                                operationDate: operationDate,
                                subCompanyID: _sendMoneyController.subCompanyId.value
                              );
                              return null;
                          },
                          currencyname: "${_sendMoneyController.currencyISOCode.value}",
                          countryflag: countryflag.keys.contains("${_sendMoneyController.countryFlag.value}") == false ? "${countryflag["DEMO"]}" :  "${countryflag["${_sendMoneyController.countryFlag.value}"]}",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text('exchangeRate'.tr,
                            style: TextStyle(
                              color: AppColor.kBlackColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Text('1  ${box.read(Keys.exchangeLCIsoCode)} = ',style: Theme.of(context).textTheme.titleSmall),
                              Obx(()=> Text(
                                "${_getDealingRateContoller.dealingRate.value.toString()}",
                                  style: TextStyle(
                                  color: AppColor.kGreyColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Obx(()=> _getCustomerComissionController.rateLodder.value == true ? Center(
                            child: LoadingAnimationWidget.flickr(
                              leftDotColor: AppColor.kYellow, 
                              rightDotColor: AppColor.kGreenColor, 
                              size: 20,
                            ),
                          ): Text(
                            "${_getCustomerComissionController.diplayTotalAmount.value}" + " ${box.read(Keys.exchangeLCIsoCode)}",
                            textAlign: TextAlign.right,
                               style: TextStyle(
                                color: AppColor.kBlackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Fee'.tr,
                                style: TextStyle(
                                color: AppColor.kBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5),
                            SvgPicture.asset('assets/icon/circle_question_icon.svg'),
                          ],
                        ),
                        Row(
                          children: [
                            Obx(()=>Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "${_getCustomerComissionController.fee.value} " + "${box.read(Keys.exchangeLCIsoCode)}",
                                  style: TextStyle(
                                    color: AppColor.kBlackColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                             ),
                            ),
                            Obx(()=> _getCustomerComissionController.fee == "0.0" ? Text('noTransferFee'.tr,
                                style: TextStyle(
                                  color: AppColor.kBlackColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ): SizedBox(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        CustomButton(
                          buttonLevel: "continue".tr,
                          onPressed: (){
                            if(double.parse("${_getCustomerComissionController.diplayTotalAmount.value}") > 0 && _getCustomerComissionController.transactionAmountController.text.isNotEmpty && _getCustomerComissionController.receiverAmountController.text.isNotEmpty){
                              Helpers.keyboardhide();
                              _sendMoneyBaseController.NavigateSteep();
                              _sendMoneyController.purposeOfIssueName.value = "";
                              _sendMoneyController.paymentModeCardName.value = "";
                            }else{
                              Helpers.dengerAlert(message: "pleaseEnterYourTransactionAmount".tr , title:  "warning".tr);
                            }
                          },
                          color: AppColor.kPrimaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  clearCache(){
    if(_getCustomerComissionController.transactionAmountController.text.isNotEmpty || _getCustomerComissionController.receiverAmountController.text.isNotEmpty){
      _getCustomerComissionController.transactionAmountController.clear();
      _getCustomerComissionController.receiverAmountController.clear();
       _getCustomerComissionController.diplayTotalAmount.value = "0.0";
      _getCustomerComissionController.fee.value = "0.0";
    }else{
      _getCustomerComissionController.receiverAmountController.clear();
      _getCustomerComissionController.transactionAmountController.clear();
      _getCustomerComissionController.diplayTotalAmount.value = "0.0";
      _getCustomerComissionController.fee.value = "0.0";
    }
  }
}

class CustomReceiverMenu extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const CustomReceiverMenu({
    Key? key,
    this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$title",
                style:Theme.of(context).textTheme.titleMedium ,
              ),
              Text(":  ",style: TextStyle(
                color: AppColor.kBlackColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),),
            ],
          ),
        ),
        Expanded( 
          child: Text("$subTitle",style:Theme.of(context).textTheme.titleSmall),
        ),
      ],
    );
  }
}

