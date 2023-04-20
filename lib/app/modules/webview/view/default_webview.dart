import 'package:customer/app/constant/LocalColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppBrowser extends StatefulWidget {
  @override
  _InAppBrowserState createState() => _InAppBrowserState();
}

class _InAppBrowserState extends State<InAppBrowser> {
  WebViewController? _controller;
  dynamic arguments = Get.arguments;

  String? url;

  @override
  void initState() {
    super.initState();
    if (arguments != null && arguments is Map<String, dynamic>) {
      if (arguments.containsKey('url')) {
        url = arguments['url'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: '$url',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
          onPageStarted: (value) {
            print("Redirection Url : ${value}");
            if (value.contains("https://ifapartner.njtechdesk.com/partner/customer/personal-details")) {
              var logId = value.toString().replaceAll("https://ifapartner.njtechdesk.com/partner/customer/personal-details?logId=", "").split("&token=")[0];
              var token = value.toString().replaceAll("https://ifapartner.njtechdesk.com/partner/customer/personal-details?logId=", "").split("&token=")[1];
              var map = <String, String>{};
              map['logId'] = logId;
              map['token'] = token;
              Get.back(result: map);
            }else if(value.contains("https://test.njindiaonline.com/onlinetrading/camsApi.fin?action=processCAMSResponse&sess_identifier=")){
              var sessionId = value.toString().replaceAll("https://test.njindiaonline.com/onlinetrading/camsApi.fin?action=processCAMSResponse&sess_identifier=", "");
              var map = <String, String>{};
              map['sessionId'] = sessionId;
              Get.back(result: map);
            }
          },
          onPageFinished: (value){

          },
        ),
      ),
    );
  }
}
