
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:necmoney/core/utils/log.dart';
import 'package:necmoney/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';
import 'package:substring_highlight/substring_highlight.dart';
import '../../../core/utils/keys.dart';
import '../../../core/values/app_color.dart';
import '../../../core/values/strings.dart';
import '../../../data/model/get_beneficiary_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../modules/controller/home_controller.dart';
import '../../../modules/controller/receiver_list_controller.dart';
import '../../../routes/routes.dart';
import '../../controller/get_customer_commission_controller.dart';
import '../../controller/get_dealing_rate_controller.dart';
import '../../controller/relationship_controller.dart';
import '../../controller/send_money_base_controller.dart';
import '../../controller/send_money_controller.dart';
import '../../controller/sender_detials_controller.dart';

class ReciverListScreen extends StatefulWidget {

  ReciverListScreen({Key? key}) : super(key: key);

  @override
  State<ReciverListScreen> createState() => _ReciverListScreenState();
}

class _ReciverListScreenState extends State<ReciverListScreen> {
  final SendMoneyController _sendMoneyController = Get.put(SendMoneyController());
  final GetDealingRateContoller _getDealingRateContoller = Get.put(GetDealingRateContoller());
  final GetCustomerComissionController _getCustomerComissionController = Get.put(GetCustomerComissionController());
  final SendMoneyBaseController _sendMoneyBaseController = Get.put(SendMoneyBaseController());
  final SenderDetailsController  _senderDetailsController = Get.put(SenderDetailsController());
  final HomeController _homeController = Get.put(HomeController());
  final RelationshipController _relationshipController = Get.put(RelationshipController());
  final ReceiverListController receiverListController = Get.put(ReceiverListController());

  final ApiProvider _apiProvider = ApiProvider();
  final GetStorage box = GetStorage();
  final PagingController<int, GetBeneficiaryModel> _pagingController = PagingController(firstPageKey: 0);
  
  static const int _pageSize = 9;
  var errorLodder = false;
  String? _searchTerm = "";
 

  Future<void> getReceiverData(int pageKey)async{
    try{
      var response = await _apiProvider.getSingleData(
        baseUrl: Strings.baseUrl,
        url: "GlobalService/GetBeneficiaries?currentPageNumber=$pageKey&pageSize=$_pageSize&searchCriteria=$_searchTerm&sortDirection=ASC&sortExpression=A.Name&status=0",
      );
      List _data = [];
      for(var i in response["beneficiaries"]){
         if(!_data.contains(i)){
            _data.add(i);
         }
      }

      final isLastPage = _data.length < _pageSize;

      if(isLastPage){
        _pagingController.appendLastPage(_data.map((e) => GetBeneficiaryModel.fromJson(e)).toList());
      }else {
        final nextPageKey = pageKey + 1; 
        _pagingController.appendPage(_data.map((e) => GetBeneficiaryModel.fromJson(e)).toList(), nextPageKey);
      }
    }catch(error){
      Logger(key: "Error", value: error);
    }

  }

  @override
  void initState() {
   // receiverListController.getPaymentMode();
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      getReceiverData(pageKey);
    });

  }

   void _updateSearchTerm(String searchTerm) {
     _searchTerm = searchTerm;
    _pagingController.refresh();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("receiver".tr, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
        backgroundColor: AppColor.kPrimaryColor,
        automaticallyImplyLeading: receiverListController.backButton,
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
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8,right: 8,top: 15,bottom: 2),
          child: Container(
            height: 50,
            child: CustomTextField(
              controller: receiverListController.searchController,
               inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
               ],
              onChanged: (value) {
                if(value.toString().isEmpty){
                  _updateSearchTerm(receiverListController.searchController.text);
                }else{
                  _updateSearchTerm(receiverListController.searchController.text);
                }
                _pagingController.refresh();
                //
              },
              suffixIcon: IconButton(
                color: AppColor.kGreenColor,
                onPressed: (){
                  _updateSearchTerm("");
                  receiverListController.searchController.clear();
                }, 
                icon: Icon(Icons.cancel)
                ) ,
                hintText: "Enter receiver first name",
              level: "Search receiver name",
            ),
          ),
        ),
        SizedBox(height: 8,),
        Expanded(
          child: PagedListView<int, GetBeneficiaryModel>(
            pagingController: _pagingController,
           physics: BouncingScrollPhysics(),
            builderDelegate: PagedChildBuilderDelegate<GetBeneficiaryModel> (
              firstPageProgressIndicatorBuilder: (_) => Center(child: CircularProgressIndicator(color: AppColor.kPrimaryColor,)),
              newPageProgressIndicatorBuilder:(_) => Center(child: CircularProgressIndicator(color: AppColor.kPrimaryColor,)),
              noItemsFoundIndicatorBuilder: (_){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 2.8,
                      child: SvgPicture.asset("assets/logo/no_data.svg"),
                    ),
                    Text("reciverNotFound".tr,
                      style: TextStyle(
                        color: AppColor.kGreyColor,
                        fontSize: 14, 
                      ),
                    ),
                  ],
                );
              },
              itemBuilder: (context, item, index) {
                var _data = item;
                return Column(
                  children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: (){
                            if(_data.modeId.toString() == Keys.accountPayeeID && _data.accountTypeId == null){
                              EasyLoading.show( status: 'Loading...', maskType: EasyLoadingMaskType.black);
                              _getReciverData(_data);
                              final snack = SnackBar(
                                content: Text('Your receivers some data missing . Please edit'),duration: Duration(seconds: 2),
                                dismissDirection: DismissDirection.up,
                                backgroundColor: AppColor.kSecondaryColor,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snack);
                              box.write(Keys.transaction, Strings.oldRecevierTransaction);
                              _sendMoneyBaseController.pageController =  PageController(viewportFraction: 1.0);
                              Get.toNamed(Routes.RECEIVER_EDIT_SCREEN, arguments: _data);
                              box.write(Keys.transaction, Strings.oldRecevierTransaction);
                              EasyLoading.dismiss();
                              }else{
                              box.write(Keys.walletNumber, _data.accountNo.toString());
                              box.write(Keys.benePhoneNumber, _data.phoneNo.toString());
                              box.write(Keys.beneBankName, _data.beneficiaryBankName.toString());
                              box.write(Keys.beneBankBranchID, _data.bankBranchId.toString());
                              box.write(Keys.beneBankID, _data.bankId.toString());
                              box.write(Keys.beneBranchName, _data.bankBranchName);
                              box.write(Keys.benePayeeModeID, _data.modeId.toString());
                              box.write(Keys.subCompanyBranchID, _data.subCompanyBranchId);
                              box.write(Keys.beneAccNo, _data.accountNo.toString());
                              box.write(Keys.beneBrnAddress, _data.bankBranchAddr);
                              box.write(Keys.beneAccTypeID, _data.accountTypeId);
                              _sendMoneyController.countryId.value = _data.countryId.toString();
                              _sendMoneyController.currenciesId.value = _data.currencyId.toString();
                              _sendMoneyController.beneficiaryID.value = _data.beneficiaryId.toString();
                              _sendMoneyController.lastNameController.text = _data.surname.toString();
                              _sendMoneyController.firstNameController.text = _data.name.toString();
                              _sendMoneyController.relationshipId.value = _data.relationId.toString();
                              _sendMoneyController.companyId.value = _data.companyId.toString();
                              _sendMoneyController.subCompanyId.value = _data.subCompanyId.toString();
                              _sendMoneyController.modeName.value = _data.modeName.toString();
                              _sendMoneyController.countryName.value = _data.countryName.toString();
                              _sendMoneyController.currencycontroller.text = _data.currencyName.toString();
                              _sendMoneyController.bankandCompanyNamecontroller.text = _data.subCompanyName.toString();
                              _sendMoneyController.paymentModeId.value = _data.modeId.toString();
                              _sendMoneyController.countryFlag.value = _data.countryName.toString();
                              _sendMoneyController.currencyISOCode.value = _data.currencyIsoCode.toString();
                              box.write(Keys.transaction, Strings.oldRecevierTransaction);
                              _sendMoneyController.oldreciver.value = true;
        
                              _getDealingRateContoller.getDealingRate(
                                subCompanyId: _sendMoneyController.subCompanyId.value,
                                countryId: _sendMoneyController.countryId.value,
                                currencyId: _sendMoneyController.currenciesId.value,
                                fldPsfx: ""
                              );
                              cacheClear();
                              _sendMoneyBaseController.pageController =  PageController(viewportFraction: 1.0);
                              Get.toNamed(Routes.SEND_MONEY_BASE_LAYOUT);         
                            }
                          },
                          child: Card(
                            color: AppColor.kWhiteColor,
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: Get.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: AppColor.kGreenColor,
                                                  child: Center(child: Icon(Icons.person,color: AppColor.kWhiteColor,),),
                                                ),
                                                SizedBox(width: 8,),
                                                Container(
                                                  width: MediaQuery.of(context).size.width/ 2,
                                                  //color: AppColor.dangerColor,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                     SubstringHighlight(
                                                       text: _data.fullName.toString().toUpperCase(),     // search result string from database or something
                                                       term: receiverListController.searchController.text,
                                                       overflow: TextOverflow.fade,
                                                       textStyle: TextStyle(
                                                         color: AppColor.kGreenColor,
                                                         fontSize: 11.sp,
                                                         fontWeight: FontWeight.bold,
                                                       ), 
                                                       textStyleHighlight: TextStyle(
                                                         color: AppColor.kSecondaryColor,
                                                         fontSize: 11.sp,
                                                         fontWeight: FontWeight.bold,
                                                       ),      // user typed "et"
                                                     ),
                                                      // Text( _data.fullName.toString().toUpperCase(),
                                                      //   overflow: TextOverflow.fade,
                                                      //   style: TextStyle(
                                                      //     color: AppColor.kGreenColor,
                                                      //     fontSize: 11.sp,
                                                      //     fontWeight: FontWeight.bold,
                                                      //   ),
                                                      // ),
                                                      Text(_data.phoneNo.toString(),
                                                        style: TextStyle(
                                                          color: AppColor.kGreyColor,
                                                          fontSize: 9.sp,
                                                        ),
                                                      ),
                                                    ],     
                                                  ),
                                                ),
                                              ],
                                            ),  
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: TextButton(
                                              onPressed: (){
                                                EasyLoading.show( status: 'Loading...', maskType: EasyLoadingMaskType.black);
                                                _getReciverData(_data);
                                               // Edit 
                                               box.write(Keys.transaction, Strings.oldRecevierTransaction);
                                                  _sendMoneyBaseController.pageController =  PageController(viewportFraction: 1.0);
                                                  Get.toNamed(Routes.RECEIVER_EDIT_SCREEN, arguments: _data);
                                                  box.write(Keys.transaction, Strings.oldRecevierTransaction);
                                                  EasyLoading.dismiss();
                                              },
                                              child: Text("edit".tr.toUpperCase(),
                                                style: TextStyle(
                                                  color: AppColor.kGreenColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(_data.modeName.toString().toUpperCase(),
                                        style: TextStyle(
                                          color: AppColor.kGreyColor.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 8,),
                                      Text(_data.beneficiaryBankName.toString().capitalize!,
                                        style: TextStyle(
                                          color: AppColor.kGreyColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                SvgPicture.asset("assets/icon/cash_icons.svg",width: 20,),
                                                SizedBox(width: 4,),
                                                Text(_data.countryName.toString().capitalize!,
                                                  style: TextStyle(
                                                    color: AppColor.kGreenColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                              children: [
                                                _data.statusDetail == "Active" ? Icon(Icons.thumb_up_alt_rounded,size: 16, color: AppColor.kGreenColor,):  Icon(Icons.thumb_down_alt_rounded ,size: 16, color: AppColor.dangerColor,), 
                                                SizedBox(width: 8,),
                                                Text("${_data.statusDetail}".tr,
                                                  style: TextStyle(
                                                    color: _data.statusDetail == "Active" ? AppColor.kGreenColor : AppColor.dangerColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );   
              },
            )
          ),
        ),
      ],
    ), 

    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: AppColor.kGreenColor,
      onPressed: (){
          box.write(Keys.transaction, Strings.newReceiver);
        if(box.read(Keys.remitterId) != null){
          _sendMoneyBaseController.pageController =  PageController(viewportFraction: 1.0, initialPage: 0);
          Get.toNamed(Routes.SEND_MONEY_BASE_LAYOUT);
          _getCustomerComissionController.transactionAmountController.text = "";
          _getCustomerComissionController.receiverAmountController.text = "";
          _getCustomerComissionController.diplayTotalAmount.value = "0.0";
        }else {
          _senderDetailsController.senderDetailsPageController = PageController(viewportFraction: 1.0,initialPage: 0);
            if(int.parse(box.read(Keys.senderFromCountryId).toString()) == Keys.canadaCountryID ){
            Get.toNamed(Routes.SENDER_INFO_SCREEN_CANADA);
          }else if(int.parse(box.read(Keys.senderFromCountryId).toString()) == Keys.unitedKingdomCounryID){
            Get.offAndToNamed(Routes.SENDER_DETAILS_BASE_SCREEN);
          }else {
            Get.offAndToNamed(Routes.SENDER_DETAILS_BASE_SCREEN);
          }
        }
      },
      label: Text("addReceiver".tr),
      icon: Icon(Icons.add),
    )
   ); 
  }


  _getReciverData(GetBeneficiaryModel _data) async{
      _sendMoneyController.relationshipId.value = _data.relationId.toString();
      _sendMoneyController.beneficiaryID.value = _data.beneficiaryId.toString();
      box.write(Keys.remitterId, _data.remitterId.toString());
      _sendMoneyController.firstNameController.text = _data.name.toString();
      _sendMoneyController.lastNameController.text = _data.surname.toString();
      _sendMoneyController.countryId.value = _data.countryId.toString();
      _sendMoneyController.subCompanyId.value = _data.subCompanyId.toString();
      _sendMoneyController.currenciesId.value = _data.currencyId.toString();
      _sendMoneyController.currencycontroller.text = _data.currencyName.toString();
      _sendMoneyController.currencyISOCode.value = _data.currencyIsoCode.toString();
      _sendMoneyController.companyId.value = _data.companyId.toString();
      _sendMoneyController.paymentModeId.value =  _data.modeId.toString();
      box.write(Keys.subCompanyBranchID, _data.subCompanyBranchId.toString());
      box.write(Keys.benePayeeModeID, _data.modeId.toString());
      box.write(Keys.beneBankID, _data.bankId);
      Logger(key: "beneBankId", value: _data.bankId);
      _sendMoneyController.getCountryCityWithBank(
            countryId: _data.countryId.toString(),
            currencyID: _data.currencyId.toString(),
            modeId: _data.modeId.toString(),
      );
      _sendMoneyController.phoneNumberController.text = _data.phoneNo.toString();
      _sendMoneyController.modeName.value = _data.modeName.toString();
      _sendMoneyController.countryName.value = _data.countryName.toString();
      _sendMoneyController.nationality.value = _data.nationality.toString();
      _sendMoneyController.accountNumberController.text = _data.accountNo.toString();
      _sendMoneyController.bankAndWalletPayeeBankName.value = _data.bankName.toString();
      _sendMoneyController.bankAndWalletPayeebankId.value = _data.bankId.toString();
      _sendMoneyController.bankCode.value = _data.bankCode.toString();
      _sendMoneyController.bankAndWalletPayeebankBranchId.value = _data.bankBranchId.toString();
      _sendMoneyController.branchCode.value = _data.bankBranchCode.toString();
      _sendMoneyController.fullBranchAddressController.text = _data.bankBranchAddr.toString();
      _sendMoneyController.branchCityName.value = _data.bankCity.toString();
      _sendMoneyController.bankAndWalletPayeeBankBranchName.value = _data.bankBranchName.toString();
      _sendMoneyController.bankandCompanyNamecontroller.text = _data.subCompanyName.toString();
      _sendMoneyController.bankAndWalletPayeeBankName.value = _data.beneficiaryBankName.toString();
      _sendMoneyController.cashsubCompaniCityController.text = _data.subcompanyCity.toString();
      _sendMoneyController.bankandCompanyNamecontroller.text = _data.subCompanyName.toString();
      _sendMoneyController.cashPayeeBankBranchName.value = _data.subCompanyBranchName.toString();

       _relationshipController.getRelationship(relationshipid: "${_data.relationId}");
        if(_data.accountTypeId != null){
          _sendMoneyController.accountTypeId.value = _data.accountTypeId.toString();
          _sendMoneyController.accountCode.value = _data.accountCode.toString();
        }
        /*Edit screen subCompany api all need bankId . Get bankID this function this funtion call mobile wallet .
        because account type subCompany list bankID = null */
        _sendMoneyController.getSubCompanisListWithReceiverEdit(
          countryId: _data.countryId.toString(),
          currenciesId: _data.currencyId.toString(),
          paymentModeId: _data.modeId.toString(),
          subCompanyID: _data.subCompanyId.toString(),
        );
        //Edit screen account type get 
        if(_data.modeId.toString() != Keys.cashPayeeID){
        _relationshipController.autoGetAccountType(
            accountTypeId: _data.accountTypeId,
            beneBankId: _data.bankId.toString(),
            companyId: _data.companyId.toString(),
            subCompanyId: _data.subCompanyId.toString(),
            countryId: _data.countryId.toString(),
            paymentModeId: _data.modeId.toString(),
          );
        }
      cacheClear();   
  }

  cacheClear(){
    _getCustomerComissionController.transactionAmountController.text = "";
    _getCustomerComissionController.receiverAmountController.text = "";
    _getCustomerComissionController.diplayTotalAmount.value = "0.0";
    _getCustomerComissionController.fee.value = "0.0";
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}








