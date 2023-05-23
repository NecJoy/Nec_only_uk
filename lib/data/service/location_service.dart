// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/instance_manager.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:necmoney/core/utils/log.dart';
// import 'package:necmoney/modules/controller/signup_controller.dart';

// import '../../core/utils/country_flag.dart';
// import '../../core/utils/keys.dart';
// import 'package:get/get.dart';

// class LocationService{
// // CountryController _countryController =  Get.put(CountryController());
// SignUpController _signUpController = Get.put(SignUpController());
// // ignore: unused_field
// late String _currentAddress;
// void get getLocation => determinePosition();
// final box = GetStorage();
// var getCountryCode = "";
// /// When the location services are not enabled or permissions
// /// are denied the `Future` will return an error.
// Future determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the 
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale 
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }
  
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately. 
//     return Future.error(
//       'Location permissions are permanently denied, we cannot request permissions.');
//   } 

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//    _getCurrentLocation();
// }


// Future _getCurrentLocation()async{
//   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//   .then((Position position) {
//      _getAddressFromLatLng(position.latitude, position.longitude);
//   }).catchError((e){
//     print(e);
//   });

// }

// Future<void> _getAddressFromLatLng(lat, lon) async {
//   try {
//     List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

//     Placemark place = placemarks[0];
//     _currentAddress ="${place.locality}, ${place.postalCode}, ${place.country}";
//     _signUpController.isoCountryCode.value = place.isoCountryCode.toString(); 
//     _signUpController.countryName.value = place.country != null ? place.country.toString() : "";
//     _signUpController.countryFlag.value = place.country != null ? countryflag[place.country.toString().toUpperCase()] : "";
//     box.write(Keys.registerCountry, place.country != null ? place.country.toString().toUpperCase() : "");
//     getCountryCode = place.country!; 
//     _signUpController.selectedCountryIndex.value = countryflag.keys.toList().indexOf("${_signUpController.countryName.toString().toUpperCase()}");
//     print("Current address: ${place.country.toString().toUpperCase() }");
    
//   } catch (err) {
//     Logger(key: "Error", value: err);
//   }
// }



// }

