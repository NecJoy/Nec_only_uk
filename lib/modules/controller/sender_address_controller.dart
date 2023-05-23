import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SenderAddressController extends GetxController{
   final fromKey = GlobalKey<FormState>();
  var searchAddressController = TextEditingController().obs;
  var cityController = TextEditingController().obs;
  // var houseNoController = TextEditingController().obs;
  // var streetAddressController = TextEditingController().obs;
  var isManual = true.obs;
  var address = "".obs;
  var cityId = "".obs;
}