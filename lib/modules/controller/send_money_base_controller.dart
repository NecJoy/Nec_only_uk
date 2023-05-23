import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendMoneyBaseController extends GetxController {

var pageController = PageController();
Future<void>  NavigateSteep(){
   return pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn
    );
  }


}