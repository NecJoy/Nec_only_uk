import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

import '../../../../core/values/app_color.dart';
import '../../../../core/values/strings.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../controller/web_view_controller.dart';

class TermsConditionsScreen extends StatelessWidget {
  final WebViewPageController _webviewPageController =
      Get.put(WebViewPageController());
  final key = UniqueKey();
  late final WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "termsAndConditions".tr,
      ),
      body: Obx(
        () => Stack(
          children: [
            if (_webviewPageController.connected.value)
              WebView(
                key: key,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: Strings.termsConditionUrl,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                  _webviewPageController.webViewController = webViewController;
                  _webviewPageController.controller.complete(webViewController);
                },
                onPageStarted: (String url) {
                  _webviewPageController.isLoading.value = true;
                },
                onProgress: (int process) async {
                  if (process > 20) {
                    _webviewPageController.removeHeaderForTermsCondition();
                  }
                },
                onPageFinished: (String url) {
                  _webviewPageController.isLoading.value = false;
                  _webviewPageController.removeFotter();
                  _controller
                      .runJavascriptReturningResult('Tawk_API.hideWidget();');
                },
              ),
            if (_webviewPageController.isLoading.value)
              Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColor.kPrimaryColor),
                ),
              ),
            if (_webviewPageController.hasError.value)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text("somethingWentWrongPleaseTryAgain".tr),
                ),
              )
          ],
        ),
      ),
    );
  }
}
