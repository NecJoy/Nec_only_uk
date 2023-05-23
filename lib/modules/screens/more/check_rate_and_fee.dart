// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:necmoney/routes/routes.dart';
import 'package:necmoney/widgets/custom_typeheadfield.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/country_flag.dart';
import '../../../core/utils/keys.dart';
import '../../../core/values/app_color.dart';
import '../../../core/values/strings.dart';
import '../../../data/model/country_model.dart';
import '../../../data/model/get_currencies_model.dart';
import '../../../data/model/get_subcompany_model.dart';
import '../../../data/model/payment_type_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../modules/controller/check_rate_and_fee_controller.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dropdown_search_field.dart';
import '../../../widgets/custom_rate_check_field.dart';
import '../../controller/get_dealing_rate_controller.dart';
import '../../controller/receiver_list_controller.dart';


class CheckRateAndFee extends StatefulWidget {
 CheckRateAndFee({Key? key}) : super(key: key);

  @override
  State<CheckRateAndFee> createState() => _CheckRateAndFeeState();
}

class _CheckRateAndFeeState extends State<CheckRateAndFee> {
  final CheckRateFeeController _checkRateFeeController = Get.put(CheckRateFeeController());
  final GetDealingRateContoller _getDealingRateContoller = Get.put(GetDealingRateContoller());
  final ReceiverListController _reciverListController = Get.put(ReceiverListController());

  final  _currencyController  = TextEditingController();
  final  _bankAndCompanyController  = TextEditingController();
  final  countryController  = TextEditingController();
  final ApiProvider _apiProvider = ApiProvider();
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
   clearCache();
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: CustomAppBar(
        title: "checkRateFee".tr,
      ),
      body: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Form(
            key: _checkRateFeeController.checkRatefeeForm,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(height: 8,),
                  CustomDropdownScarchField<PaymentTypeModel>(
                    showSearchBox: false,
                    onFind: (filtter) async{
                      var response = await _apiProvider.getSingleData(
                        baseUrl: Strings.baseUrl,
                        url: Strings.paymentTypeUrl,
                      );
                      List c = [];
                      for(var i in response["paymentModes"]){
                        c.add(i);
                      }
                      var _c = c.where((element) => element.toString().toLowerCase().contains(filtter!.toLowerCase()));
                      return _c.map((e) => PaymentTypeModel.fromJson(e)).toList();
                    },
                    itemAsString: (PaymentTypeModel? u)=>u!.description.toString().toUpperCase(),
                    label: "selectPaymentMode".tr,
                    onChanged: (PaymentTypeModel? data){
                      _checkRateFeeController.paymentModeId.value = data!.modeId.toString();
                      clearCache();
                    },
                  ),
                  SizedBox(height: 16,),
                   Obx(()=> (IgnorePointer(
                    ignoring: _checkRateFeeController.paymentModeId.value.isEmpty ?  true : false,
                     child:  CustomTypeheadField<CountryModel>(
                         controller: countryController,
                         direction: AxisDirection.down,
                        suggestionsCallback: (patten) async{
                          var response = await _apiProvider.getSingleData(
                            baseUrl: Strings.baseUrl,
                              url: Strings.getCountriesUrl + "ModeID=${_checkRateFeeController.paymentModeId.value}",
                            );
                            List c = [];
                            for(var i in response["countries"]){
                              c.add(i);
                            }
                            var _c = c.where((element) => element.toString().toLowerCase().contains(patten.toLowerCase()));
                            return _c.map((e) => CountryModel.fromJson(e)).toList();
                        },

                        itemBuilder: (BuildContext context , CountryModel countryModel){
                          return ListTile(title: Text("${countryModel.name}"),);
                        },
                        onSuggestionSelected: (CountryModel countryModel){
                          countryController.text = countryModel.name.toString();
                          _checkRateFeeController.countryId.value = countryModel.countryId.toString();
                          _checkRateFeeController.countryflags.value = countryflag.keys.contains("${countryModel.name}") == false ? countryflag["DEMO"] : countryflag[countryModel.name.toString()];
                          _currencyController.clear();
                          _bankAndCompanyController.clear();
                        }, 
                        hintText: "Please select country",
                        noData: "Data not found",
                        ),
                      )
                   ),
                  ),
                  SizedBox(height: 16,),
                  CustomTypeheadField<GetCurrenciesModel>(
                    direction: AxisDirection.down,
                      suggestionsCallback: (patten)async{
                        var response = await _apiProvider.getSingleData(
                            baseUrl: Strings.baseUrl,
                            url: Strings.getCurrenciesUrl + "CountryID=${_checkRateFeeController.countryId.value}&ModeID=${_checkRateFeeController.paymentModeId.value}",
                          );
                          List c = [];
                          for(var i in response["currencies"]){
                            c.add(i);
                          }
                          var _c = c.where((element) => element.toString().toLowerCase().contains(patten.toLowerCase()));
                          return _c.map((e) => GetCurrenciesModel.fromJson(e)).toList();
                      },
                      itemBuilder: (BuildContext context , GetCurrenciesModel currenciesModel){
                      return ListTile(title: Text("${currenciesModel.name}"),);
                      }, 
                      onSuggestionSelected: (GetCurrenciesModel getCurrenciesModel){
                          _currencyController.text = getCurrenciesModel.name.toString();
                          _checkRateFeeController.currenciId.value = getCurrenciesModel.currencyId.toString();
                          _checkRateFeeController.currencyname.value = getCurrenciesModel.isoCode.toString();
                          _bankAndCompanyController.clear();
                      },
                      hintText: "Please select currency",
                      controller: _currencyController,
                      noData: "Data not found",
                  ),
                  SizedBox(height: 16,),
                  CustomTypeheadField<SubcompanyModel>(
                    suggestionsCallback: (patten) async {
                      var response =  await _apiProvider.getSingleData(
                          baseUrl: Strings.baseUrl,
                          url: Strings.getSubcompaniesUrl + "CountryID=${_checkRateFeeController.countryId.value}&CurrencyID=${_checkRateFeeController.currenciId.value}&ModeID=${_checkRateFeeController.paymentModeId.value}&City="
                        );
                        List c = [];
                        for(var i in response["subcompanies"]){
                          c.add(i);
                        }
                        var _c = c.where((element) => element.toString().toLowerCase().contains(patten.toLowerCase()));
                        return _c.map((e) => SubcompanyModel.fromJson(e)).toList();
                    },
                    direction: AxisDirection.down,
                    hideKeyboard: true,
                    itemBuilder: (BuildContext context , SubcompanyModel subcompanyModel){
                      return ListTile(title: Text("${subcompanyModel.name}"),);
                    },
                    onSuggestionSelected: (SubcompanyModel subcompanyModel){
                      _bankAndCompanyController.text = subcompanyModel.name.toString();
                      _checkRateFeeController.subCompanyId.value = subcompanyModel.subcompanyId.toString();
                          Future.delayed(Duration(milliseconds: 300)).then((value) {
                            _getDealingRateContoller.getDealingRate(
                              subCompanyId: _checkRateFeeController.subCompanyId.value,
                              countryId: _checkRateFeeController.countryId.value,
                              currencyId: _checkRateFeeController.currenciId.value,
                              fldPsfx: "",
                          );
                      });
                    },
                    maxLines: 2,
                    controller: _bankAndCompanyController,
                    hintText: "Please select bank",
                    noData: "Data not found",
                  ),
                  SizedBox(height: 16),
                  Align(
                    child: Text('transactionAmount'.tr,style: Theme.of(context).textTheme.bodyLarge),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 8),
                  Obx(()=>IgnorePointer(
                      ignoring: _checkRateFeeController.subCompanyId.value.isEmpty ? true : false,
                      child: CustomRateCheckField(
                        controller: _checkRateFeeController.transactionAmountController,
                        focusNode: _checkRateFeeController.transactionAmountFocusNode,
                        onChanged: (_value){
                          DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
                          String operationDate = dateFormat.format(DateTime.now());
                          // _getCustomerComissionController.receiverAmountController.clear();
                          _checkRateFeeController.receiverAmountController.text = (double.parse(_checkRateFeeController.transactionAmountController.text.isNotEmpty ? _checkRateFeeController.transactionAmountController.text : "0.0") *  _getDealingRateContoller.dealingRate.value).toStringAsFixed(2);
                          _checkRateFeeController.getCustomerCommission(
                            amount: _checkRateFeeController.transactionAmountController.text,
                            countryID: _checkRateFeeController.countryId.value,
                            currencyID: _checkRateFeeController.currenciId.value,
                            operationDate: operationDate,
                            subCompanyID: _checkRateFeeController.subCompanyId.value
                          );
                          return null;
                        },
                        hintext: '0.0',
                        currencyname: "${box.read(Keys.exchangeLCIsoCode)}",
                        countryflag:  countryflag.keys.contains(box.read(Keys.remCounty)) == true ? "${countryflag[box.read(Keys.remCounty)]}" : countryflag["DEMO"],
                      ),
                    ),
                  ),
                  // SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: AspectRatio(
                      aspectRatio: 12, 
                      child: SvgPicture.asset("assets/logo/exchange.svg",color: AppColor.kPrimaryColor),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('receiverAmount'.tr,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Obx(()=> IgnorePointer(
                        ignoring: _checkRateFeeController.subCompanyId.value.isEmpty ?  true : false,
                        child: CustomRateCheckField(
                            controller: _checkRateFeeController.receiverAmountController,
                            hintext: '0.0',
                            focusNode:  _checkRateFeeController.receiverAmountFocusNode,
                            onChanged: (_value){
                              DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
                              String operationDate = dateFormat.format(DateTime.now());
                              // _getCustomerComissionController.transactionAmountController.clear();
                              _checkRateFeeController.transactionAmountController.text = (double.parse(_checkRateFeeController.receiverAmountController.text.isNotEmpty ? _checkRateFeeController.receiverAmountController.text : "0.0") /  _getDealingRateContoller.dealingRate.value).toStringAsFixed(2);
                              _checkRateFeeController.getCustomerCommission(
                                amount: _checkRateFeeController.transactionAmountController.text,
                                countryID: _checkRateFeeController.countryId.value,
                                currencyID: _checkRateFeeController.currenciId.value,
                                operationDate: operationDate,
                                subCompanyID: _checkRateFeeController.subCompanyId.value
                              );
                              return null;
                            },
                            currencyname: "${_checkRateFeeController.currencyname.value}",
                            countryflag: "${_checkRateFeeController.countryflags.value.isEmpty ? "assets/country_flag/demo_flag.svg" : "${_checkRateFeeController.countryflags.value}" }",
                          ),
                        ),
                      ), 
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text('exchangeRate'.tr,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      SizedBox(width: 8,),
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Text('1  ${box.read(Keys.exchangeLCIsoCode)} = ',
                            style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Obx(()=> Text(
                              "${_getDealingRateContoller.dealingRate.value}",
                                style: TextStyle(
                                color: AppColor.kGreyColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Obx(()=> Text(
                          "${_checkRateFeeController.diplayTotalAmount.value}" + " ${box.read(Keys.exchangeLCIsoCode)}",
                            textAlign: TextAlign.right,
                            style: _checkRateFeeController.diplayTotalAmount.value.length <= 8 ?  Theme.of(context).textTheme.bodyLarge : TextStyle(fontSize: 14, color: AppColor.kBlackColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('fees'.tr,style: Theme.of(context).textTheme.bodyLarge),
                          SizedBox(width: 5),
                          SvgPicture.asset('assets/icon/circle_question_icon.svg'),
                        ],
                      ),
                      Row(
                        children: [
                          Obx(()=>Text(
                            "${_checkRateFeeController.fee.value} " + "${box.read(Keys.exchangeLCIsoCode)} ", 
                              style: TextStyle(
                              color: AppColor.kGreyColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Obx(()=> _checkRateFeeController.fee == "0.0" ? Text('noTransferFee'.tr,
                            style: Theme.of(context).textTheme.titleMedium,
                            ): SizedBox(),
                          ),
                        ],
                      ),
                    ],
                  ),
                 SizedBox(height: 32),
                  Row(
                    children: [
                      Obx(()=>CustomButton(
                          color: AppColor.kPrimaryColor,
                          buttonLevel: "Send Money".tr,
                          onPressed:_checkRateFeeController.subCompanyId.value.isEmpty ? null : (){
                            _reciverListController.backButton = true;
                            Get.toNamed(Routes.RECEIVER_LIST_SCREEN);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

  void clearCache(){
    countryController.clear();
    _currencyController.clear();
    _bankAndCompanyController.clear();
    _checkRateFeeController.receiverAmountController.clear();
    _checkRateFeeController.transactionAmountController.clear();
    _checkRateFeeController.diplayTotalAmount.value = "0.0";
    _checkRateFeeController.fee.value = "0.0";
  }
}




