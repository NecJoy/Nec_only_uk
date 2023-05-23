
import '../../data/provider/api_provider.dart';

class OnBoardController{

 final ApiProvider _apiProvider = ApiProvider();
  List imagelist = [];
  Future   getImageSlider() async{
    List response =  await _apiProvider.postData(
      baseUrl: "http://119.148.33.142:8080", 
      url:"file-server/images",
      data: {},
    );
    imagelist = response;
    print(imagelist.length);
  }
}