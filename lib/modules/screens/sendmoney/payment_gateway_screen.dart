
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:necmoney/routes/routes.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../widgets/custom_appbar.dart';

class PaymentGatewayScreen extends StatefulWidget {
  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {

  final key = UniqueKey();
  final box = GetStorage();
  late WebViewController webViewController;
  String errorTypeName = "";
  bool isError = false;
  int _stackToView = 1;
  bool isLoading = true;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "payment".tr,
        leading: IconButton(
          onPressed: (){
            Get.toNamed(Routes.BASE_NAV_LAYOUT);
          },
          icon: Icon(Icons.arrow_back)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
          if(!isError)
            WebView(
              key: key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: Get.arguments,
              onWebViewCreated: (WebViewController controller){
                webViewController = controller;
                webViewController.clearCache();
                Future.delayed(Duration(
                  seconds: 30
                )).then((value) {
                  setState(() {
                    isLoading = false;
                  });
                });
              },
               onPageFinished: (String url) {
                setState(() {
                  _stackToView = 0;
                });
              },
              onWebResourceError: (error) => setState(() {
                isError = true;
                errorTypeName = error.errorType.toString();
              }),
            ),
            
            if (isError && !isLoading) Center(
              child: showErrorText(errorTypeName, context),
            ),
            
            if(_stackToView == 1 && isLoading)
            Container(child: Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }
}



Text showErrorText(err, context){
  Text _text; 
  switch(err) { 
    case "WebResourceErrorType.authentication": { 
      _text =  Text("User authentication failed on server.", );
    }   
    break;  

    case "WebResourceErrorType.connect": { 
      _text =  Text("Failed to connect to the server.", );
    } 
    break;

    case "WebResourceErrorType.failedSslHandshake": { 
      _text =  Text("Failed to perform SSL handshake.", );
    } 
    break;

    case "WebResourceErrorType.file": { 
      _text =  Text("Generic file error", );
    } 
    break;

    case "WebResourceErrorType.fileNotFound": { 
      _text =  Text("File not found.", );  
    } 
    break;

    case "WebResourceErrorType.hostLookup": { 
      _text =  Text("Internet connection error.");
    } 
    break;

    case "WebResourceErrorType.io": { 
      _text  = Text("Failed to read or write to the server.", );  
    } 
    break;

    case "WebResourceErrorType.proxyAuthentication": { 
      _text  = Text("User authentication failed on proxy", );  
    } 
    break;

    case "WebResourceErrorType.timeout": { 
      _text  = Text("Connection timed out. Try again.", );  
    } 
    break;

    case "WebResourceErrorType.unsupportedScheme": { 
      _text  = Text("Unsupported URI scheme", );  
    } 
    break;

    case "WebResourceErrorType.webContentProcessTerminated": { 
      _text  = Text("The web content process was terminated.", );  
    } 
    break;

    case "WebResourceErrorType.webViewInvalidated": { 
      _text  = Text("The web view was invalidated.", );  
    } 
    break;

    case "WebResourceErrorType.javaScriptExceptionOccurred": { 
      _text  = Text("A JavaScript exception occurred.", );  
    }     
    break;

    default: { 
      _text  = Text("An exception has occurred. Please try again.", );
    }
    break; 
  } 
  return _text;
}

