import 'package:customer/app/constant/LocalColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HtmlBrowser extends StatefulWidget {
  @override
  _HtmlBrowserState createState() => _HtmlBrowserState();
}

class _HtmlBrowserState extends State<HtmlBrowser> {
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();
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
    return /*Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
      ),
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.dataFromString('$url', mimeType: 'text/html')),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              mediaPlaybackRequiresUserGesture: false,
            ),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            _controller = controller;
          },
          androidOnPermissionRequest: (InAppWebViewController controller,
              String origin, List<String> resources) async {
            resources.map((e) => print("Permissions ==> $e"));
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
        ),
      ),
    );*/
        Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
      ),
      body: SafeArea(
        child: InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(
            url: WebUri.uri(Uri.dataFromString('$url', mimeType: 'text/html'),),),
          initialSettings: InAppWebViewSettings(
            mediaPlaybackRequiresUserGesture: false,
            allowsInlineMediaPlayback: true,
            geolocationEnabled: true
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onGeolocationPermissionsShowPrompt: (controller,value) async {
            return GeolocationPermissionShowPromptResponse(allow: true,origin: value,retain: true);
          },
          onLoadStart: (controller,uri){
            if(uri.toString().contains("https://ifapartner.njtechdesk.com/partner/customer/personal-details?requestNumber=")){
              var requestNumber = uri.toString().replaceAll("https://ifapartner.njtechdesk.com/partner/customer/personal-details?requestNumber=", "");
              var map = <String, String>{};
              map['requestNumber'] = requestNumber;
              Get.back(result: map);
            }
            print("Permission ==> $uri");
          },
          onPermissionRequest: (controller, request) async {
            final resources = <PermissionResourceType>[];
            if (request.resources.contains(PermissionResourceType.CAMERA)) {
              final cameraStatus = await Permission.camera.request();
              if (!cameraStatus.isDenied) {
                resources.add(PermissionResourceType.CAMERA);
              }
            }
            if (request.resources.contains(PermissionResourceType.MICROPHONE)) {
              final microphoneStatus =
              await Permission.microphone.request();
              if (!microphoneStatus.isDenied) {
                resources.add(PermissionResourceType.MICROPHONE);
              }
            }
            // only for iOS and macOS
            if (request.resources
                .contains(PermissionResourceType.CAMERA_AND_MICROPHONE)) {
              final cameraStatus = await Permission.camera.request();
              final microphoneStatus =
              await Permission.microphone.request();
              if (!cameraStatus.isDenied && !microphoneStatus.isDenied) {
                resources.add(PermissionResourceType.CAMERA_AND_MICROPHONE);
              }
            }
            return PermissionResponse(
                resources: resources,
                action: resources.isEmpty
                    ? PermissionResponseAction.DENY
                    : PermissionResponseAction.GRANT);
          },
        ),
      ),
    );
  }
}
