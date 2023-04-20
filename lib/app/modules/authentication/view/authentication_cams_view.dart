import 'dart:async';
import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/constant.dart';
import 'package:customer/app/modules/authentication/model/pledge_docs_response.dart';
import 'package:customer/app/modules/authentication/viewmodel/authentication_viewmodel.dart';
import 'package:customer/app/modules/dashboard/model/EventModel.dart';
import 'package:customer/app/modules/fetchcas/viewmodel/fetch_cas_controller.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationCamsView extends StatefulWidget {
  final FetchCasController controller;

  const AuthenticationCamsView(this.controller, {Key? key}) : super(key: key);

  @override
  _AuthenticationCamsViewState createState() => _AuthenticationCamsViewState(controller);
}

class _AuthenticationCamsViewState extends State<AuthenticationCamsView>
    with AfterLayoutMixin<AuthenticationCamsView> {
  late AuthenticationViewModel _service;

  BuildContext? progressContext;
  bool showError = false;

  _AuthenticationCamsViewState(FetchCasController _controller) {
    _controller.methodB = methodB;
  }

  Future<bool> methodB(int index) async {
    var prefs = await SharedPreferences.getInstance();
    var applicantDetail =
        PledgeDocsData.fromJson(jsonDecode(prefs.getString("user_auth") ?? ""));
    if (applicantDetail.ESP_KFIN == "Done" && applicantDetail.ESP_CAMS == "Done" && applicantDetail.ESA == "Done") {
      Constant.eventBus.fire(PageChangeEvent(12));
    } else if (applicantDetail.ESP_KFIN == "Done" && applicantDetail.ESP_CAMS == "Done" && applicantDetail.ESA != "Done") {
      Constant.eventBus.fire(PageChangeEvent(11));
    } else if (applicantDetail.ESP_KFIN == "Done" && applicantDetail.ESP_CAMS != "Done") {
      if (!verifyApiCall) {
        showPopup(context);
        // showWaitingPopup(context, "");
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _service = AuthenticationViewModel(context);
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    var applicantDetail = PledgeDocsData.fromJson(jsonDecode(prefs.getString("user_auth") ?? ""));
    if (applicantDetail.ESP_KFIN == "Done" && applicantDetail.ESP_CAMS == "Done" && applicantDetail.ESA == "Done") {
      Constant.eventBus.fire(PageChangeEvent(12));
    } else if (applicantDetail.ESP_KFIN == "Done" && applicantDetail.ESP_CAMS == "Done" && applicantDetail.ESA != "Done") {
      Constant.eventBus.fire(PageChangeEvent(11));
    } else if (applicantDetail.ESP_KFIN == "Done" && applicantDetail.ESP_CAMS != "Done") {
      if (!verifyApiCall) {
        showPopup(context);
        // showWaitingPopup(context, "");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Visibility(
              visible: showError,
              child: Text(
                "Your pledged request with CAMS has failed. Please reinitiate the same",
                style: TextStyle(
                  color: themeColor,
                  fontSize: 16.sp,
                  fontFamily: LocaleKeys.font_family,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  var verifyApiCall = false;

  void getAuthenticationUrl() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.requestCamsUrl();
      if (requestCas?.code == 200) {
        var map = <String, String>{};
        map['url'] = requestCas?.body?.redirectLink ?? "";
        var results = await Get.toNamed(Routes.DEFAULT_BROWSER, arguments: map);
        if (results is Map<String, String>) {
          var sessionId = results["sessionId"];
          verifyApiCall = true;
          showWaitingPopup(context, sessionId ?? "");
        }
      }
    }
  }

  Future<bool?> showWaitingPopup(BuildContext context, String sessionId) async {
    checkCamsStatus(sessionId);
    return await showDialog<bool>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          progressContext = context;
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
              content: Container(
                color: whiteColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:  [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  verifyApiCall = false;
                                  Get.back();
                                  setState(() {
                                    showError = true;
                                  });
                                },
                                child: const Icon(
                                  Icons.close,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Please wait for 5 min",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 16.sp,
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            color: themeColor,
                            backgroundColor: dividerColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<bool?> showPopup(BuildContext context) async {
    return await showDialog<bool>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              color: whiteColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Alert",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 14.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "You will be redirected to myCAMS portal for pledge authorization.",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Get.back();
                          setState(() {
                            showError = true;
                          });
                        },
                        child: Container(
                          height: 30.h,
                          width: 100.w,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: unselectTab,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Close",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Get.back();
                          /*setState(() {
                            showError = false;
                          });
                          getAuthenticationUrl();*/
                          Constant.eventBus.fire(PageChangeEvent(11));
                        },
                        child: Container(
                          height: 30.h,
                          width: 100.w,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(11),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void checkCamsStatus(String sessionId) async {
    if (verifyApiCall) {
      if (ConnectivityUtils.instance.hasInternet) {
        var requestCas = await _service.checkCamsStatus(sessionId);
        if (requestCas?.code == 200) {
          if (requestCas?.body?.pledgeStatus != "PLEDGED") {
            Timer(const Duration(seconds: 10),
                () => {checkCamsStatus(sessionId)});
          } else {
            if (progressContext != null) {
              Navigator.pop(progressContext!);
            }
            setState(() {
              showError = false;
            });
            var prefs = await SharedPreferences.getInstance();
            var applicantDetail = PledgeDocsData.fromJson(jsonDecode(prefs.getString("user_auth") ?? ""));
            applicantDetail.ESP_CAMS = "Done";
            await prefs.setString('user_auth', jsonEncode(applicantDetail.ESP_KFIN));
            Constant.eventBus.fire(PageChangeEvent(11));
          }
        } else {
          if (progressContext != null) {
            Navigator.pop(progressContext!);
          }
          setState(() {
            showError = true;
          });
        }
      }
    }
  }
}
