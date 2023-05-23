import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

import '../../../core/values/strings.dart';
import '../../../widgets/custom_appbar.dart';


class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final key = UniqueKey();
  late WebViewController webViewController;
  String errorTypeName = "";
  bool isError = false;
  int _stackToView = 1;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "liveChat".tr
      ),
      body: Stack(
      children: [
        if (!isError)
          WebView(
            key: key,
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: Strings.twakUrl,
            onWebViewCreated: (WebViewController webViewController) {
              webViewController = webViewController;
              webViewController.clearCache();
              Future.delayed(Duration(
                seconds: 20
              )).then((value) {
                setState(() {
                  isLoading = false;
                });
              });
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url == 'about:blank' ||
                request.url.contains('tawk.to')) {
                return NavigationDecision.navigate;
              }
              return NavigationDecision.navigate;
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

