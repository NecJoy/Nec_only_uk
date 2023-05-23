// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:necmoney/core/utils/keys.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../core/values/app_color.dart';
import '../values/strings.dart';

class Helpers {
static final box = GetStorage();
static bool get hasToken => _hasToken();
static late DateTime currentBackPressTime;


static showSnackBar({String? message, String? title, SnackPosition? snackPosition}){
    Get.rawSnackbar(
        title: title,
        message: message,
        isDismissible: false,
        instantInit: false,
        titleText: Text("$title",style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.kWhiteColor),),
        messageText: Text("$message",style: TextStyle(fontWeight: FontWeight.w500, color: AppColor.kWhiteColor.withOpacity(0.9)),),
        backgroundColor: AppColor.kGreenColor,
        leftBarIndicatorColor: AppColor.kYellow,
        snackPosition: snackPosition ?? SnackPosition.TOP,
        margin: EdgeInsets.only(left: 2),
        snackStyle: SnackStyle.FLOATING,
      );
}


static dengerAlert({String? message, String? title, SnackPosition? snackPosition}){
     Get.rawSnackbar(
        // title: title,
        // message: message,
        isDismissible: false,
        instantInit: false,
        titleText: Row(
          children: [
            Icon(Icons.error, color: AppColor.dangerColor,),
            SizedBox(width: 6,),
            Text("Alarted",style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.kBlackColor, fontSize: 18),),
          ],
        ),
        messageText: Text("$message",style: TextStyle(fontWeight: FontWeight.normal, color: AppColor.kBlackColor.withOpacity(0.6)),),
        backgroundColor: AppColor.kYellow,
        leftBarIndicatorColor: AppColor.kWhiteColor,
        snackPosition: snackPosition ?? SnackPosition.TOP,
        margin: EdgeInsets.only(left: 2),
        snackStyle: SnackStyle.FLOATING,
        overlayColor: AppColor.kGreenColor.withOpacity(0.1),
        overlayBlur: 0.1,
        forwardAnimationCurve: Curves.bounceInOut,
      );
}


static clipBoard({required String data}){
  Clipboard.setData(new ClipboardData(text: data));
  if(Platform.isAndroid){
    Fluttertoast.showToast(
      msg: "Copyed!",
    );
  }else {
    Get.snackbar('Copyed!',data, duration: Duration(seconds: 1));
  }
}

static bool _hasToken(){
  if(box.read(Keys.token) != null){
    return true;
  }else{
    return false;
  }
}


static String getDateTimeFormator(dateTime){
  var inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
  var inputDate = inputFormat.parse(dateTime); // <-- dd/MM 24H format
  var outputFormat = DateFormat('dd-MM-yyyy hh:mm aa');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}
//yyyy-MM-dd hh:mm:ss

// static String setLocalTime(){
//   DateTime _dateTime = DateTime.now();
//   DateFormat formatterTime =  DateFormat("dd-MM-yyyy hh:mm aa");
//   String localDateTime = formatterTime.format(_dateTime);
//   return localDateTime.toString();
// }


static String generateReciptLink(String? data){
  var remittanceNo = data.toString().split("/");
  var docId = remittanceNo[0];
  var remitterId = remittanceNo[1];
  var link = Strings.report + docId + "_" + remitterId + ".pdf";
  return link;
}


static Future<void> launchURL(url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}

static Future launchWhatsApp() async {
  final link = WhatsAppUnilink(
    phoneNumber: Strings.whatsAppPhoneNumber,
    text: "Is anyone available to chat with me?",
  );
  await launch('$link');
}
static dateTimeFormet (date){
 return DateFormat('dd-MM-yyyy').format(date);
}


static Future<void> launchPhoneDialer(String contactNumber) async {
  final Uri _phoneUri = Uri(
      scheme: "tel",
      path: contactNumber
  );
  try {
    if (await canLaunch(_phoneUri.toString())){
     await launch(_phoneUri.toString());
    }
  } catch (error) {
    throw("Cannot dial");
  }
}

static keyboardhide (){
  return  FocusManager.instance.primaryFocus?.unfocus();
}

 
 static InputDecoration CustomInputDecoration () {
    return InputDecoration(
      filled: true,
      contentPadding:EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      suffixIcon: Icon(Icons.arrow_drop_down,size: 32,color: AppColor.kBlackColor,),
      hintText: "Search your country",
      fillColor: AppColor.kSeaGreenColor,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.kGreenColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.kGreenColor),
      ),
      focusedErrorBorder:OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.kGreenColor),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.kSecondaryColor),
      ),
    );
  }

}

