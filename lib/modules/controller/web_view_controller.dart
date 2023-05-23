import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageController extends GetxController {
  @override
  void onInit() {
    connectivityChecker();
    super.onInit();
  }
  var isLoading = false.obs;
  var hasError = false.obs;
  var connected = false.obs;
  final Completer<WebViewController> controller = Completer<WebViewController>();
  late WebViewController webViewController;

  void removeHeaderForTermsCondition() {
    webViewController.runJavascript("javascript:(function() { " +
        "var head = document.getElementsByTagName('header')[0];" +
        "head.parentNode.removeChild(head);" +
        "var breadcumb = document.getElementsByClassName('page-title')[0];" +
        "breadcumb.parentNode.removeChild(breadcumb);" +
        "var topHeader = document.getElementsByClassName('header-top')[0];" +
        "topHeader.parentNode.removeChild(topHeader);" +
        "var preLoader = document.getElementsByClassName('preloader')[0].style.display='none';"
            "preLoader.parentNode.removeChild(preLoader);" +
        "})()")
    .then((value) => debugPrint('Page finished loading Javascript'))
    .catchError((onError) => debugPrint('$onError'));
  }

  void removeHeaderForFaq() {
    webViewController.runJavascript("javascript:(function() { " +
            "var head = document.getElementsByTagName('header')[0];" +
        "head.parentNode.removeChild(head);" +
        "var breadcumb = document.getElementsByClassName('page-title')[0];" +
        "breadcumb.parentNode.removeChild(breadcumb);" +
        "var topHeader = document.getElementsByClassName('header-top')[0];" +
        "topHeader.parentNode.removeChild(topHeader);" +
        "var preLoader = document.getElementsByClassName('preloader')[0].style.display='none';"
            "preLoader.parentNode.removeChild(preLoader);" +
        "var removePadding = document.getElementsByClassName('site-map-content')[0].style.paddingTop = '0px';" +
        "removePadding.parentNode.removeChild(removePadding);" +
        "})()")
    .then((value) => debugPrint('Page finished loading Javascript'))
    .catchError((onError) => debugPrint('$onError'));
  }

  void removeHeaderForPrivacyPolicy() {
    webViewController.runJavascript("javascript:(function() { " +
        "var head = document.getElementsByTagName('header')[0];" +
        "head.parentNode.removeChild(head);" +
        "var breadcumbPrivacyPolicy = document.getElementsByClassName('page-title')[0];"
            "breadcumbPrivacyPolicy.parentNode.removeChild(breadcumbPrivacyPolicy);" +
        "var topHeader = document.getElementsByClassName('header-top')[0];" +
        "topHeader.parentNode.removeChild(topHeader);" +
        "var preLoader = document.getElementsByClassName('preloader')[0].style.display='none';"
            "preLoader.parentNode.removeChild(preLoader);" +
        "var removePadding = document.getElementsByClassName('area-padding')[0].style.paddingTop = '0px';"
            "removePadding.parentNode.removeChild(removePadding);" +
        "})()")
    .then((value) => debugPrint('Page finished loading Javascript'))
    .catchError((onError) => debugPrint('$onError'));
  }

  void removeHeaderForAboutUs() {
    webViewController.runJavascript("javascript:(function() { " +
        "var head = document.getElementsByTagName('header')[0];" +
        "head.parentNode.removeChild(head);" +
        "var breadcumbAboutUs = document.getElementsByClassName('page-title')[0];"
            "breadcumbAboutUs.parentNode.removeChild(breadcumbAboutUs);" +
        "var topHeader = document.getElementsByClassName('header-top')[0];" +
        "topHeader.parentNode.removeChild(topHeader);" +
        "var preLoader = document.getElementsByClassName('preloader')[0].style.display='none';"
            "preLoader.parentNode.removeChild(preLoader);" +
        "var removePadding = document.getElementsByClassName('about-page-area')[0].style.paddingTop = '0px';"
            "removePadding.parentNode.removeChild(removePadding);" +
        "var br = document.getElementsByTagName('br')[0];" +
        "br.parentNode.removeChild(br);" +
        "})()")
    .then((value) => debugPrint('Page finished loading Javascript'))
    .catchError((onError) => debugPrint('$onError'));
  }

  void removeChat() {
    webViewController.runJavascript("javascript:(function() { " +
        "var tawkContainer = document.getElementsByClassName('tawk-min-container')[0];"
            "tawkContainer.parentNode.removeChild(tawkContainer);" +
        "})()")
    .then((value) => debugPrint('Page finished loading Javascript'))
    .catchError((onError) => debugPrint('$onError'));
  }

  void removeFotter() {
    webViewController.runJavascript("javascript:(function() { " +
        "var footer = document.getElementsByTagName('footer')[0];" +
        "footer.parentNode.removeChild(footer);" +
        "var chat = document.getElementsByClassName('footer-bottom')[0];" +
        "chat.parentNode.removeChild(chat);" +
        "})()")
    .then((value) => debugPrint('Page finished loading Javascript'))
    .catchError((onError) => debugPrint('$onError'));
  }

  Future<void> connectivityChecker() async {
    print("Checking internet...");
    try {
      final result = await InternetAddress.lookup('google.com');
      final result2 = await InternetAddress.lookup('facebook.com');
      final result3 = await InternetAddress.lookup('microsoft.com');
      if ((result.isNotEmpty && result[0].rawAddress.isNotEmpty) ||
          (result2.isNotEmpty && result2[0].rawAddress.isNotEmpty) ||
          (result3.isNotEmpty && result3[0].rawAddress.isNotEmpty)) {
        print('connected..');
        connected.value = true;
      } else {
        print("not connected from else..");
        connected.value = false;
      }
    } on SocketException catch (_) {
      print('not connected...');
      connected.value = false;
      hasError.value = true;
    }
  }


}
