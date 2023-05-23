import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/utils/keys.dart';
import '../../core/utils/log.dart';
import '../../core/values/strings.dart';
import '../../data/model/get_dealing_rate_model.dart';
import '../../data/model/subcompany_branch_model.dart';
import '../../data/provider/api_provider.dart';

class  GetDealingRateContoller  extends GetxController {
  
  var dealingRate = 0.0.obs;
  final box = GetStorage();
  ApiProvider _apiProvider = ApiProvider();

  Future getDealingRate({String? subCompanyId, String? countryId, String? currencyId, String? fldPsfx})async{
   
    _apiProvider.getData(
      baseUrl: Strings.baseUrl, 
      url: Strings.getDealingRate + "FldPsfx=$fldPsfx&SubcompanyID=$subCompanyId&CountryID=$countryId&CurrencyID=$currencyId"
    ).then((data){
      if(data != null){
        Logger(key: "DataGetDealinkRate", value: data.toString());
        GetDealingRateModel getDealingRateModel = GetDealingRateModel.fromJson(data);
        dealingRate.value = getDealingRateModel.rate!;
        box.write(Keys.dealingRate, getDealingRateModel.rate!);
        Logger(key: "Get Dealing Rate", value: dealingRate.value);
      }
    });
  }

  
// Cash pay edit bank then call branch name 
  Future getBranchName ({required String subCompaniesCity , required String companyId, required String countryId, required String paymentModeId , required String subCompanyId })async{
    _apiProvider.getData(
        baseUrl: Strings.baseUrl,
        url:  "GlobalService/GetSubcompanyBranches?city=$subCompaniesCity&companyID=${companyId}&countryID=${countryId}&modeID=${paymentModeId}&selectBank=true&subcompanyID=${subCompanyId}",
      ).then((value){
       List <SubcompanyBranchModel> _c = [];
        for (var i in value["subcompanyBranches"]){
          _c.add( SubcompanyBranchModel.fromJson(i));
        }
         box.write(Keys.subCompanyBranchID, _c.first.branchId);
         Logger(key: "Keys.subCompanyBranchID", value: _c.first.branchId);
      });
  }
}

