
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/log.dart';
import 'package:necmoney/data/model/get_currencies_model.dart';
import 'package:necmoney/modules/controller/get_customer_commission_controller.dart';
import 'package:necmoney/modules/controller/send_money_base_controller.dart';

import '../../../core/utils/keys.dart';
import '../../../core/values/strings.dart';
import '../../../data/model/save_receiver_model.dart';
import '../../../data/provider/api_provider.dart';
import '../../../modules/controller/get_dealing_rate_controller.dart';
import '../../../routes/routes.dart';
import '../../core/utils/helpers.dart';
import '../../data/model/bank_name_list_model.dart';
import '../../data/model/get_bank_branches_model.dart';


class SendMoneyController extends GetxController{
  GetDealingRateContoller _getDealingRateContoller = Get.put(GetDealingRateContoller());
  final GetCustomerComissionController _getCustomerComissionController = Get.put(GetCustomerComissionController());
  SendMoneyBaseController _sendMoneyBaseController = Get.put(SendMoneyBaseController());
  final box = GetStorage();
  ApiProvider _apiProvider = ApiProvider();

  var countryFlag = "".obs;
  var isoCode = "".obs;
  var currencyISOCode = "".obs;
  var oldreciver = false.obs;
  var hintextNumberFormat = "".obs;
  var reciverEditpay = false;

  
  //var companyName = "".obs;
  var branchCityName = "".obs;
  var nationality = "".obs;
  var accountTypeId = "0".obs;
  var accountCode = "".obs;
  final fullBranchAddressController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final phoneNumber = "".obs;
  final accountNumberController = TextEditingController();
  final walletNumberController = TextEditingController();
  var purposeOfIssueId = "".obs;
  var relation = "".obs;
  var relationshipId = "".obs;
  var subCompanyWalletName = "".obs;
  var branchCode = "".obs;
  var paymentModeId = "".obs;
  var modeName = "".obs;
  var countryName = "".obs;
  //var currencyName = "".obs;
  var countryId = "".obs;
  var currenciesId = "".obs;
  var subCompanyId = "".obs;
  var companyId = "".obs;
  var subCompanyCode = "".obs;


  final bankandCompanyNamecontroller = TextEditingController();
  TextEditingController currencycontroller = TextEditingController();
  final cashBranchNameController = TextEditingController();
  final bankBranchCityController = TextEditingController();
  final bankBranchNameController = TextEditingController();


  var beneficiaryID = "".obs;
  var subCompanyBranchID = "".obs;
 // var subCompanyBranchCode = "".obs;


  //cash
  // var cashsubCompaniesCityname = "".obs;
   TextEditingController cashsubCompaniCityController = TextEditingController();
  var cashPayeeBankBranchName = "".obs;
  var cashsubCompanyBranchId = "".obs;

  // account  taypee
  var bankAndWalletPayeebankId = "".obs;
  var bankAndWalletPayeeBankName = "".obs;
  var bankAndWalletPayeeBankBranchName = "".obs;
  var bankAndWalletPayeebankBranchId = "".obs;


  /// paching valu 
  var bankBranchName = "".obs;
  var bankCity = "".obs;
  var purposeOfIssueName = "".obs;
  var paymentModeCardId = "".obs;
  var paymentModeCardName = "".obs;


  var bankCode = "".obs;


  //api call value store 

  RxList storecountryList = [].obs;
  RxList storeRelationshipList = [].obs;


  Future saveReceiverData(SaveReceiverModel _saveReceiverModel) async {
    _apiProvider.postData(
      baseUrl: Strings.baseUrl,
      url: Strings.saveReceiver,
      data:_saveReceiverModel.toJson(),
    ).then((data){
      if(data != null){
        Helpers.showSnackBar(title: "Congrats", message: "${data["returnMessage"][0].toString()}");
        GetReceiverDataModel _data = GetReceiverDataModel.fromJson(data["beneficiary"]);
        box.write(Keys.walletNumber, _data.accountNo.toString());
        box.write(Keys.benePhoneNumber, _data.phoneNo == null ? "" : _data.phoneNo.toString());
        box.write(Keys.beneBankName, _data.beneficiaryBankName.toString());
        box.write(Keys.beneBankBranchID, _data.bankBranchId.toString());
        box.write(Keys.beneBankID,  _data.bankId.toString());
        box.write(Keys.beneBranchName, _data.bankBranchName);
        box.write(Keys.benePayeeModeID, _data.modeId.toString());
        box.write(Keys.subCompanyBranchID, _data.subCompanyBranchId);
        box.write(Keys.beneAccNo, _data.accountNo.toString());
        box.write(Keys.beneBrnAddress, _data.bankBranchAddr);
        box.write(Keys.beneAccTypeID, _data.accountTypeId);
        countryId.value = _data.countryId.toString();
        currenciesId.value = _data.currencyId.toString();
        beneficiaryID.value = _data.beneficiaryId.toString();
        lastNameController.text = _data.surname == null ? "" : _data.surname.toString();
        firstNameController.text = _data.name == null ? "" : _data.name.toString();
        relationshipId.value = _data.relationId.toString();
        companyId.value = _data.companyId.toString();
        subCompanyId.value = _data.subCompanyId.toString();
        modeName.value = _data.modeName.toString();
        countryName.value = _data.countryName.toString();
        bankandCompanyNamecontroller.text = _data.subCompanyName.toString();
        currencycontroller.text = _data.currencyName.toString();
        countryFlag.value = _data.countryName.toString();
        _getCustomerComissionController.transactionAmountController.text = "";
       _getCustomerComissionController.receiverAmountController.text = "";
       _getCustomerComissionController.diplayTotalAmount.value = "0.0";
       _getCustomerComissionController.fee.value = "0.0";
        if(box.read(Keys.transaction) == Strings.oldRecevierTransaction){
         _sendMoneyBaseController.pageController =  PageController(viewportFraction: 1.0);
          box.write(Keys.transaction, Strings.oldRecevierTransaction);
          Get.toNamed(Routes.SEND_MONEY_BASE_LAYOUT);
          _getDealingRateContoller.getDealingRate(
            subCompanyId: subCompanyId.value,
            countryId: countryId.value,
            currencyId: currenciesId.value,
            fldPsfx: ""
          );
        }else{
          if(box.read(Keys.benePayeeModeID) == Keys.mobileWalletID || box.read(Keys.benePayeeModeID) == Keys.cashPayeeID){
            _sendMoneyBaseController.pageController.jumpToPage(3);
              _getDealingRateContoller.getDealingRate(
              subCompanyId: subCompanyId.value,
              countryId: countryId.value,
              currencyId: currenciesId.value,
              fldPsfx: ""
            );
          }else{
            _sendMoneyBaseController.NavigateSteep();
            _getDealingRateContoller.getDealingRate(
            subCompanyId: subCompanyId.value,
            countryId: countryId.value,
            currencyId: currenciesId.value,
            fldPsfx: "" );
          }

        }
      }
    });
  }

  Future getCurrency ({required String countryId, required String modeId ,}) async{
      var response = await _apiProvider.getData(
          baseUrl: Strings.baseUrl, 
          url: Strings.getCurrenciesUrl + "CountryID=${countryId}&ModeID=${modeId}"
      );
      List<GetCurrenciesModel> _data = [];
      for(var i in response["currencies"]){
        _data.add(GetCurrenciesModel.fromJson(i));
      }
      if(_data.isNotEmpty){
        if(_data[0].currencyId.toString() == "1"){
          currencycontroller.text = _data[1].name.toString();
          currenciesId.value = _data[1].currencyId.toString();
          currencyISOCode.value = _data[1].isoCode.toString();
          
        }else{
          currencycontroller.text = _data[0].name.toString();
          currenciesId.value = _data[0].currencyId.toString();
          currencyISOCode.value = _data[0].isoCode.toString();
        }
        await getCountryCityWithBank(
            countryId: countryId ,
            modeId: modeId,
            currencyID: currenciesId.value,
        );
        
      }  
  }

  //this funtion call just walletType information get . This wallet time information get automatic 
  Future autoBankGet ({required String beneBankID , required String companyId , required String countryId , required String  paymentModeId , String? subCompanyId}) async{
    var responce = await _apiProvider.getData(
      baseUrl: Strings.baseUrl,
      url: "GlobalService/GetSubcompanyBranches?bankID=$beneBankID&city=DHAKA&companyID=$companyId&countryID=$countryId&modeID=$paymentModeId&selectBank=true&subcompanyID=$subCompanyId"
    );
    List<BankNameModel> c = [];
      for(var bank in responce["benefBanks"]){
        c.add(BankNameModel.fromJson(bank));
    }
    
     bankAndWalletPayeebankId.value = c[0].bankId.toString();
     bankAndWalletPayeeBankName.value = c[0].name.toString();
     bankCode.value = c[0].code1.toString();
     subCompanyWalletName.value = c[0].name.toString();

  }

  Future autoBankCitiesGet ()async {
    var responce = await _apiProvider.getData(
      baseUrl: Strings.baseUrl,
      url:  Strings.getBankCitiesUrl + "BankID=${bankAndWalletPayeebankId.value}",
    );
    List c =[];
    for(var i in responce["bankCities"]){
      c.add(i);
    }
    branchCityName.value = c[0].toString();
  }


  Future autoGetBankBranches () async{
     var responce = await _apiProvider.getData(
      baseUrl: Strings.baseUrl,
      url:  Strings.getBankBranchesUrl + "BankID=${bankAndWalletPayeebankId.value}&City=${branchCityName.value}",
    );
   // Logger(key: "responcePrint", value:responce);
    List<BankBranchModel> c = [];
    for(var i in responce["bankBranches"]){
      c.add(BankBranchModel.fromJson(i));
    }

     fullBranchAddressController.text = c[0].fullAddress.toString();
     bankAndWalletPayeebankBranchId.value = c[0].bankBranchId.toString();
     branchCode.value = c[0].code1.toString();
     bankAndWalletPayeeBankBranchName.value = c[0].name.toString();
     
  }

  // AccountType and wallet Type get auto account type id and account code 
  Future autoGetAccountType () async{
    var response = await _apiProvider.getData(
        baseUrl: Strings.baseUrl,
        url: box.read(Keys.beneBankID) != "null" ? "GlobalService/GetSubcompanyBranches?bankID=${box.read(Keys.beneBankID)}&city=${box.read(Keys.subCompanyBankCity)}&companyID=${companyId.value}&countryID=${countryId.value}&modeID=${paymentModeId.value}&selectBank=true&subcompanyID=${subCompanyId.value}" :
          "GlobalService/GetSubcompanyBranches?city=${box.read(Keys.subCompanyBankCity)}&companyID=${companyId.value}&countryID=${countryId.value}&modeID=${paymentModeId.value}&selectBank=true&subcompanyID=${subCompanyId.value}"
    );
    List c =[];
    for(var i in response["benefAccTypes"]){
      if(i.toString().isNotEmpty){
        c.add(i);
      }
    }
    List _c = c.where((element) => element.toString().toUpperCase().contains(RegExp("\.(SAVING|SAVINGS)"))).toList();
    if(_c.isNotEmpty){
      accountTypeId.value = _c[0]["accountTypeID"].toString();
      accountCode.value = _c[0]["code1"].toString();
    }else{
      accountTypeId.value = c[0]["accountTypeID"].toString();
      accountCode.value = c[0]["code1"].toString();
    }
  }

  //This funtion call just mobile wattet.Company bankId probide in wallet 
  //This work account type and wallet 
  Future getSubCompanisListWithReceiverEdit({required String countryId , required String currenciesId , required String paymentModeId , required String subCompanyID }) async{
    var response = await _apiProvider.getSingleData(
        baseUrl: Strings.baseUrl, 
        url: Strings.getSubcompaniesUrl + "CountryID=${countryId}&CurrencyID=${currenciesId}&ModeID=${paymentModeId}&City="
      );
    List c = [];
    for(var i in response["subcompanies"]){
      c.add(i);
    }
    // Logger(key: "GetSubCompany", value: c.toString());
    // Logger(key: "subCompanyID", value: subCompanyID);
    if(c.isNotEmpty){
      List _c =  c.where((element) => element.toString().contains(subCompanyID.toString())).toList();
      if(_c.isNotEmpty){
         box.write( Keys.beneBankID , _c[0]["bankID"]);
      }else{
        box.remove(Keys.beneBankID);
      }
     
    }
    
    
  }

  Future getCountryCityWithBank ({String? countryId, String? currencyID , String? modeId } ) async{
    var responce = await _apiProvider.getSingleData(
      baseUrl: Strings.baseUrl,
      url: Strings.getCountryPayCity + "countryID=$countryId&currencyID=$currencyID&modeID=$modeId",
    );
    //Logger(key: "Responce", value: responce);
    List _city = [];
    for(var i in responce["subcompaniesCities"]){
      _city.add(i);
    }
    if(_city.isNotEmpty){
       box.write(Keys.subCompanyBankCity , _city[0].toString());
    }
  }

}

