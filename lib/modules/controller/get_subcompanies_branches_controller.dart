import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import '../../core/utils/keys.dart';
import '../../data/model/get_subcompanies_branches.dart';
import '../../core/utils/log.dart';
import '../../core/values/strings.dart';
import '../../data/provider/api_provider.dart';

class GetSubCompaniesBranchesController extends GetxController{


 ApiProvider _apiProvider = ApiProvider();
  var subCompaniesBranches = <GetSubcompanyBranchModel>[].obs;
  final box = GetStorage();
  
  Future getSubCompaniesBranchesList(String? countryId, String? subcompanyID, String? modeId, String? companyID)async{
   var response = await _apiProvider.getData(
    baseUrl: Strings.baseUrl,                                   
    url: Strings.getSubcompaniesBranchesUrl + "city=${box.read(Keys.subCompanyBankCity)}&companyID=$companyID&countryID=$countryId&modeID=$modeId&selectBank=true&subcompanyID=$subcompanyID"
  );
  var data = response;
  List _c = [];
  //subcompanyBranches
  for (var i in data["subcompanyBranches"]) {
    _c.add(i);
  }

  box.write(Keys.subCompanyBranchID, _c[0]["branchID"]);
  Logger(key: "subCompanyBranches Check", value: _c);
  Logger(key: "subCompanyBranches Check", value: box.read(Keys.subCompanyBranchID));

 }

}