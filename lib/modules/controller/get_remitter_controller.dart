
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/utils/keys.dart';
import '../../core/values/strings.dart';
import '../../data/model/get_remitter_model.dart';
import '../../data/provider/api_provider.dart';
import '../../modules/controller/sender_detials_controller.dart';
import '../../routes/routes.dart';

class  GetRemitterInfo extends GetxController {
  final SenderDetailsController  _senderDetialsController = Get.put(SenderDetailsController());
  var dealingRate = 0.0.obs;
  final GetStorage box = GetStorage();
  final ApiProvider _apiProvider = ApiProvider();

  Future getRemitterInfo({String? remitterId})async{
    _apiProvider.getData(
      baseUrl: Strings.baseUrl, 
      url: Strings.getRemitter + "RemitterID=$remitterId"
    ).then((data){
      if(data != null){
        GetRemitterModel getRemitterModel = GetRemitterModel.fromJson(data["remitter"]);
        _senderDetialsController.residanceTypeController.text = showRemitterTypeName(getRemitterModel.countryId.toString());
        _senderDetialsController.firstNameController.text = getRemitterModel.name!;
        _senderDetialsController.surNameController.text = getRemitterModel.surname!;
        _senderDetialsController.otherNameController.text = getRemitterModel.otherName!;
        _senderDetialsController.birthCountryController.text  = getRemitterModel.birthCountry!;
        _senderDetialsController.birthCityController.text = getRemitterModel.birthCity!;
        _senderDetialsController.nationallityController.text = getRemitterModel.nationality!;
        _senderDetialsController.birthdatePiked.value = getRemitterModel.birthDate!;
        _senderDetialsController.userGender.value = getRemitterModel.sexLongName!;
        _senderDetialsController.maritalStatusName.value = getRemitterModel.maritualStatus!;
        _senderDetialsController.empoloyerController.text = getRemitterModel.employer!;
        _senderDetialsController.professionController.text = getRemitterModel.profession!;
        _senderDetialsController.PhoneNumberController.text = getRemitterModel.phoneNo!;
        _senderDetialsController.emailController.text = getRemitterModel.emailAddress!;
        _senderDetialsController.cityController.text = getRemitterModel.birthCity!;
        _senderDetialsController.birthCountryName.value = getRemitterModel.birthCountry!;
        _senderDetialsController.incomeSourceId.value = getRemitterModel.incomeSourceId.toString();
        _senderDetialsController.addressline1Controller.value.text = getRemitterModel.address1!;
        _senderDetialsController.addressline2Controller.value.text = getRemitterModel.address2!;
        _senderDetialsController.provinccCodeController.text = getRemitterModel.provinceCode!;
        _senderDetialsController.provinccnameController.text = getRemitterModel.province!;
        _senderDetialsController.zipPostalController.text = getRemitterModel.zipCode!;
        _senderDetialsController.documentTypeName.value = getRemitterModel.docName!;
        _senderDetialsController.sendFromCountryCode.value = getRemitterModel.countryCode!;
        _senderDetialsController.senderFromCountryName.value = getRemitterModel.countryName!;
         getCityId(data: data,cityID: getRemitterModel.cityId.toString());
        _senderDetialsController.documentNoController.text = getRemitterModel.documentNo.toString().isEmpty ? "" :getRemitterModel.documentNo.toString();
        _senderDetialsController.documentDateIssue.value =  getRemitterModel.docIssueDate.toString().isEmpty ? "" : getRemitterModel.docIssueDate.toString(); 
        _senderDetialsController.documentDateExpire.value = getRemitterModel.docValidUpto.toString().isEmpty ? "" : getRemitterModel.docValidUpto.toString(); 
        _senderDetialsController.documentissuePlaceController.text = getRemitterModel.docIssuePlace.toString().isEmpty ? "" : getRemitterModel.docIssuePlace.toString();
        _senderDetialsController.documentauthorityController.text = getRemitterModel.issuingAuthority.toString().isEmpty ? "" : getRemitterModel.issuingAuthority.toString() ;
        _senderDetialsController.exchangeId.value = getRemitterModel.exchangeId.toString().isEmpty ? "" : getRemitterModel.exchangeId.toString();
        _senderDetialsController.birthCountryId.value = getRemitterModel.birthCountryId.toString().isEmpty ? "" :getRemitterModel.birthCountryId.toString();
        _senderDetialsController.nationlityCountryId.value = getRemitterModel.nationalityCountryId.toString().isEmpty ? "" : getRemitterModel.nationalityCountryId.toString();
        _senderDetialsController.nationlity.value = getRemitterModel.nationality!.isEmpty ? "" : getRemitterModel.nationality!;
        _senderDetialsController.incomeSourceId.value = getRemitterModel.incomeSourceId.toString().isEmpty ? "" : getRemitterModel.incomeSourceId.toString();
        _senderDetialsController.documentTypeid.value = getRemitterModel.docId.toString().isEmpty ? "" :getRemitterModel.docId.toString();
        _senderDetialsController.professionController.text = getRemitterModel.profession.toString().isEmpty ? "" : getRemitterModel.profession.toString();
        _senderDetialsController.documentauthorityController.text = getRemitterModel.issuingAuthority.toString().isEmpty ? "" : getRemitterModel.issuingAuthority.toString();
        _senderDetialsController.cityId.value = getRemitterModel.cityId.toString().isEmpty ? "" :getRemitterModel.cityId.toString();
        getIncomeSourseName(data: data, incomeSourceId: getRemitterModel.incomeSourceId.toString());
         box.write(Keys.senderFromCountryId, getRemitterModel.countryId.toString());
         Get.toNamed(Routes.SENDER_DETAILS_UPDATE_SCREEN);
      }
    });
  }

  Future getRemitterDetailsForPayment(String remitterId, {bool isRePayment = false, String? trackingId})async{
    _apiProvider.getData(
      baseUrl: Strings.baseUrl, 
      url: Strings.getRemitter + "RemitterID=$remitterId"
    ).then((data){
    if(data != null){
        print("Data $data");
        GetRemitterModel getRemitterModel = GetRemitterModel.fromJson(data["remitter"]);
        box.write(Keys.documnetTypeName , getRemitterModel.docName.toString());
        box.write(Keys.remCounty, getRemitterModel.countryName.toString());
        _senderDetialsController.documentTypeName.value = getRemitterModel.docName.toString();
        // box.write(Keys.remAddress, getRemitterModel.fullAddress.toString());
        // box.write(Keys.remCity, getRemitterModel.cityCode.toString());
        // box.write(Keys.remZipCode, getRemitterModel.zipCode.toString());
        // box.write(Keys.remName, getRemitterModel.name.toString());
        // box.write(Keys.remSurname, getRemitterModel.surname.toString());
        // box.write(Keys.remitterPhoneNumber, getRemitterModel.phoneNo.toString());
        //For repayment
        // if(isRePayment){
        //   //amount
        //   _saveRemittanceController.payWithGateway(trackingId);
        // }
      }
    });
  }


  getCityId({required dynamic data, required String cityID}){
      Map <dynamic, dynamic> map = {}.obs;
      if(data != null){
        for(var i in data["cities"] ){
          List r = [];
          r.add(i);
          map["${r[0]["cityID"]}"] = "${r[0]["name"]}";
        }
        if(map[cityID] != null){
           _senderDetialsController.cityController.text = map["${cityID}"];
        }
      }
  }

  getIncomeSourseName({required dynamic data, required String incomeSourceId}){
    Map <dynamic, dynamic> map = {}.obs;
     for(var i in data["incomeSources"] ){
          List r = [];
          r.add(i);
          map["${r[0]["sourceID"]}"] = "${r[0]["name"]}";
        }
        if(map[incomeSourceId] != null){
          _senderDetialsController.incomeSourceNameController.text = map["${incomeSourceId}"];
      }
  }

  



  String showRemitterTypeName (countryId){
    switch(countryId){
      case "197" : {
        return "EU RESIDENCE";
      }
      case "278" : {
        return "RESIDENCE";
      }
      case "123" : {
        return "RESIDENCE";
      }
      default:{
        return "";
      } 

    }
  }
}

