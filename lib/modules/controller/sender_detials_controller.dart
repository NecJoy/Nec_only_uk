

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/core/utils/helpers.dart';
import 'package:necmoney/core/utils/keys.dart';
import 'package:necmoney/core/utils/log.dart';
import 'package:necmoney/core/values/strings.dart';
import 'package:necmoney/data/model/city_model.dart';
import 'package:necmoney/data/model/country_model.dart';
import 'package:necmoney/data/model/save_profile_model.dart';
import 'package:necmoney/data/provider/api_provider.dart';
import 'package:necmoney/modules/controller/exchange_isocode_controller.dart';

import '../../data/enams/enum.dart';
import '../../data/model/signin_model.dart';
import '../../routes/routes.dart';

class SenderDetailsController extends GetxController {
  final ExchangeLCIsoCode _exchangeLCIsoCode =  Get.put(ExchangeLCIsoCode());
  var senderDetailsPageController = PageController();
  var updateProfile = false.obs;
  void NavigateSteep(){
    senderDetailsPageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn
    );
  }

    final box = GetStorage();
    final _apiProvider = ApiProvider();
    
   
    var birthdateValidator = "dd/MM/yyyy".obs;
    var documentDateIssueValidator = "dd/MM/yyyy".obs;
    var documentDateExpireValidator = "dd/MM/yyyy".obs;
    var genderValidator = Gender.Male.obs;
    var birthCountryList =[].obs;
    var countryId = "".obs;
    var countryCityList =[].obs;
    var remitterList = <RemitterModel>[].obs;


    
    static final RegExp nameRegExp = RegExp('[a-zA-Z]');
    final fullNameController = TextEditingController();
    final firstNameController = TextEditingController();
    final surNameController = TextEditingController();
    final otherNameController = TextEditingController();
    final professionController = TextEditingController();
    final emailController = TextEditingController();
    final PhoneNumberController = TextEditingController();
    final empoloyerController = TextEditingController();
    final cityController = TextEditingController();
    final addressline1Controller = TextEditingController().obs;
    final addressline2Controller = TextEditingController().obs;
    final provinccCodeController = TextEditingController();
    final provinccnameController = TextEditingController();
    final zipPostalController = TextEditingController();
    final documentissuePlaceController = TextEditingController();
    final documentauthorityController = TextEditingController();
    final documentNoController = TextEditingController();
    final fiscalCodeController = TextEditingController();
    final birthCountryController = TextEditingController();
    final birthCityController = TextEditingController();
    final nationallityController = TextEditingController();
    var residanceTypeController = TextEditingController();
    final incomeSourceNameController = TextEditingController();
    
    var remeitterTypeName = "".obs;
    var birthCountryName = "".obs;
    var birthCountryId = "".obs;
    var senderFromCountryName = "".obs;
    var sendFromCountryCode = "".obs;
    var nationlity = "".obs;
    var nationlityCountryId ="".obs;
    var birthdatePiked = "".obs;
    var groupGender = Gender.UnKnown.obs;
    var nationalIdCardExpireDate = "".obs;
    var documentDateIssue = "".obs;
    var documentissuePlaceId = "".obs;
    var documentDateExpire = "".obs;
    var documentTypeName = "".obs;
    var documentTypeid = "".obs;
    var maritalStatusName = "".obs;
    var incomeSourceId = "".obs;
   // var incomeSourceName = "".obs;
    var exchangeId = "".obs;
    var userGender = "".obs;
    var tryCount = 0.obs;
    var cityId = "".obs;
     var cityCode = "".obs;
    var cityName = "".obs;


    //local store data with api call
    RxList localbirthCountryList2 = [].obs;
    RxList localsourceOfIncomeList = [].obs;
    RxList localcityAddressLineList = [].obs;
    RxList localdocumentTypeList = [].obs;

    Future getRemittersetup ()async{
      var response = await _apiProvider.getSingleData(
        baseUrl: Strings.baseUrl,
        // remitter country all setup is  getRemitterWithDependencies this api 
        url: Strings.getRemitterWithDependencies,
      );
       if(response["countries"] != null){
        List countryList = response["countries"];
        for(var i = 0 ; i < countryList.length; i++){
          localbirthCountryList2.add(countryList[i]);
        }
       }
       if(response["incomeSources"] != null){
        List incomeSources = response["incomeSources"];
        for(var i = 0; i <incomeSources.length; i++){
          localsourceOfIncomeList.add(incomeSources[i]);
        }
       }
       if(response["cities"] != null){
         List cities = response["cities"];
         for(var i = 0; i < cities.length ; i++){
           localcityAddressLineList.add(cities[i]);
         }
       }
      if(response["remitterDocumentTypes"] != null){
        List remitterDocumentTypes = response["remitterDocumentTypes"];
        for(var i = 0; i< remitterDocumentTypes.length; i++){
          localdocumentTypeList.add(remitterDocumentTypes[i]);
        }
      }
    }




  


    Future createRemitter(SaveProfileModel saveProfileModel)async{
      _apiProvider.postData(
        baseUrl:Strings.baseUrl,
        url: Strings.saveProgileUrl,
        data: saveProfileModel.toJson(),
      ).then((data){
        if(data != null){
          Helpers.showSnackBar(message: "${data["returnMessage"]}", title: "" );
          box.write(Keys.userId, data["returnMessage"].toString().split(":")[1].split(" ")[1]);
          var signInModel = SignInModel(
            loginId: box.read(Keys.email), // Store locally 
            password: box.read(Keys.password),// Store locally
            tryCount: tryCount.value += 1,
          );
          _apiProvider.postData(
            baseUrl: Strings.baseUrl, 
            url: Strings.loginUrl, 
            data: signInModel.toJson(),
          ).then((_data){
            if(_data != null && updateProfile == false){
            _exchangeLCIsoCode.getexchangeCode();
            box.write(Keys.remitterId, _data["remitterID"]);
            box.write(Keys.clientID, _data["clientID"]);
            box.write(Keys.transaction, Strings.newReceiver);
              if( int.parse(box.read(Keys.senderFromCountryId).toString().toString()) == Keys.canadaCountryID){
                Get.toNamed(Routes.SEND_MONEY_BASE_LAYOUT);
              }else{
                senderDetailsPageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn
                );
              }
            }else{
              Get.toNamed(Routes.BASE_NAV_LAYOUT);
             return null;
            }
          });
        }
      });
    }


    //use get nationality  search 
    Future getBirthCountry()async{
     var response = await _apiProvider.getData(
        baseUrl: Strings.baseUrl,
        url: Strings.birthCountryUrl,
      );
      var data = response;
      if(data != null){
        for(var i in data["countries"]){
          birthCountryList.add(CountryModel.fromJson(i));
        }
      }
    }


    Future getCountryCity ({required String countryName , required String CountryId})async{
     var response = await _apiProvider.getData(
        baseUrl: Strings.baseUrl,
        url: "GlobalService/GetCities?Filter=$countryName&CountryId=$countryId"
      );
      var data = response;
      if(data != null){
        for(var i in data["cities"]){
          countryCityList.add(CityModel.fromJson(i));
        }
      }

    }

    // String getSourceOfIncome(){
    //   if(incomeSourceId.value.isEmpty) return "";
    //   if(incomeSource.values.contains(int.parse(incomeSourceId.value))){
    //     incomeSource.forEach((key, value) {
    //       if(value == int.parse(incomeSourceId.value)){
    //       incomeSourceName.value = key;
    //       }
    //     });
    //   }
    //  return incomeSourceName.value;
    // }


    void onClickRadioButton(value) {
    groupGender.value = value;
      if(groupGender.value != Gender.UnKnown){
        genderValidator.value = groupGender.value;
        print(genderValidator.value);
      }
      update();
    }

    Future getDateofBirth({ DateTime? data , String? formate})async{
      if(formate == Strings.DateofBirth){
        birthdatePiked.value =  data.toString();
        if(birthdatePiked.value.isNotEmpty) {
          birthdateValidator.value  = birthdatePiked.value;
        }
      } else if(formate == Strings.DocumentDateIssue) {
        documentDateIssue.value =  data.toString();
        print(data);
        DateTime addDate = DateTime(
          data!.year + 99,
          data.month,
          data.day,
          data.hour,
          data.minute,
          data.second,
          data.millisecond,
          data.microsecond,
        );
        print(addDate);
        documentTypeName.value == Keys.nationalIdCard ? documentDateExpire.value = addDate.toString() : null ;
        if(documentDateIssue.value.isNotEmpty) {
          documentDateIssueValidator.value  = documentDateIssue.value;
          
        }

      }else if (formate == Strings.DocumentDateExpire){
        documentDateExpire.value =  data.toString();
        if(documentDateExpire.value.isNotEmpty) {
          documentDateExpireValidator.value  = documentDateExpire.value;
        }
      }
    }
    

    
}