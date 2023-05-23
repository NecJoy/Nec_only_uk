
import 'package:get/get.dart';
import 'package:necmoney/data/service/database_service.dart';

class HomeController extends GetxController{
  
  var notoficationLength = 0.obs;
  
  final List imgList = [
    // "assets/logo/vector.png",
    // "assets/logo/vector.png",
    // "assets/logo/vector.png",
    // "assets/logo/vector.png",
    // "assets/logo/vector.png",
    // "assets/logo/vector.png",
  ];
  var currentIndex = 0.obs;
   // Initial Selected Value
  var dropdownvalue = 'Bangladesh'.obs;  
  // List of items in our dropdown menu

  
  var items = [    
    'Bangladesh',
    'India',
    'Pakistan',
    'Srilanka',
  ];

  Future calculateLenght()async{
    final _data = await DataBaseService.instance.getUnReadFCM();
    notoficationLength.value = _data.length;
  }

  @override
  void onInit() {
    calculateLenght();
    super.onInit();
  }
}