import 'dart:convert';
import 'dart:io';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/constant.dart';
import 'package:customer/app/modules/authentication/model/pledge_docs_response.dart';
import 'package:customer/app/modules/authentication/viewmodel/authentication_viewmodel.dart';
import 'package:customer/app/modules/dashboard/model/EventModel.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  _AuthenticationViewState createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  late AuthenticationViewModel _service;

  bool isKfinShow = false;
  bool isCamsShow = false;
  bool termView = false;
  bool kfinShow = false;
  bool camsShow = false;
  PledgeDocsData? pledgeDocData;

  @override
  void initState() {
    super.initState();
    _service = AuthenticationViewModel(context);
    getDocList();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: Stack(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor,
                          width: 1,
                        ),
                      ),
                      width: Get.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Loan Term Sheet",
                                  style: TextStyle(
                                    color: blackColor,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Click on view to verify the document",
                                  style: TextStyle(
                                    color: unselectTab,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              getDocument("AGREEMENT", "0");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: themeColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    4.r,
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 2.h,
                                horizontal: 14.w,
                              ),
                              child: Text(
                                "VIEW",
                                style: TextStyle(
                                  color: themeColor,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isKfinShow,
                      child: SizedBox(
                        height: 10.h,
                      ),
                    ),
                    Visibility(
                      visible: isKfinShow,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 1,
                          ),
                        ),
                        width: Get.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pledge Request Form For KFIN",
                                    style: TextStyle(
                                      color: blackColor,
                                      fontFamily: LocaleKeys.font_family,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    "Click on view to verify the document",
                                    style: TextStyle(
                                      color: unselectTab,
                                      fontFamily: LocaleKeys.font_family,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                getDocument("KFIN",
                                    pledgeDocData?.ESIGN_PDF_ID_P_KFIN ?? "");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: themeColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      4.r,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 2.h,
                                  horizontal: 14.w,
                                ),
                                child: Text(
                                  "VIEW",
                                  style: TextStyle(
                                    color: themeColor,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isCamsShow,
                      child: SizedBox(
                        height: 10.h,
                      ),
                    ),
                    Visibility(
                      visible: isCamsShow,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 1,
                          ),
                        ),
                        width: Get.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pledge Request Form For CAMS",
                                    style: TextStyle(
                                      color: blackColor,
                                      fontFamily: LocaleKeys.font_family,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    "Click on view to verify the document",
                                    style: TextStyle(
                                      color: unselectTab,
                                      fontFamily: LocaleKeys.font_family,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                getDocument("CAMS",
                                    pledgeDocData?.ESIGN_PDF_ID_P_CAMS ?? "");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: themeColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      4.r,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 2.h,
                                  horizontal: 14.w,
                                ),
                                child: Text(
                                  "VIEW",
                                  style: TextStyle(
                                    color: themeColor,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      "If you have selected CAMS security for pledging, then you will be directed to their page.",
                      style: TextStyle(
                        color: blackColor,
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  // Constant.eventBus.fire(FetchSubmitEvent());
                  if (!termView) {
                    _showValidationPopup(context);
                    return;
                  }
                  if (isKfinShow) {
                    if (!kfinShow) {
                      _showValidationPopup(context);
                      return;
                    }
                  }
                  if (isCamsShow) {
                    if (!camsShow) {
                      _showValidationPopup(context);
                      return;
                    }
                  }
                  _showConfirmationPopup(context);
                },
                child: Container(
                  height: 40.h,
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: themeColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "PROCEED FOR PLEDGE AUTHENTICATION",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 12.sp,
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showValidationPopup(BuildContext context) async {
    return await showDialog<bool>(
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
                    "Please click on \"View\" to view the Loan Term sheet & Pledge Request Form.${termView ? "" : "\n• LOAN TERM SHEET"}${isKfinShow && kfinShow ? "" : "\n• KFIN pledge request form"}${isCamsShow && camsShow ? "" : "\n• CAMS pledge request form"}",
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
                        },
                        child: Container(
                          height: 30.h,
                          width: 100.w,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
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

  Future<bool?> _showConfirmationPopup(BuildContext context) async {
    return await showDialog<bool>(
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
                    "Are you sure you want to proceed for Authentication?",
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
                          if (pledgeDocData?.ESP_KFIN == "Done" && pledgeDocData?.ESP_CAMS == "Done" && pledgeDocData?.ESA == "Done") {
                            Constant.eventBus.fire(PageChangeEvent(12));
                          } else if (pledgeDocData?.ESP_KFIN == "Done" && pledgeDocData?.ESP_CAMS == "Done" && pledgeDocData?.ESA != "Done") {
                            Constant.eventBus.fire(PageChangeEvent(11));
                          } else if (pledgeDocData?.ESP_KFIN == "Done" && pledgeDocData?.ESP_CAMS != "Done") {
                            Constant.eventBus.fire(PageChangeEvent(10));
                          }else{
                            Constant.eventBus.fire(FetchSubmitEvent());
                          }
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

  void getDocument(String type, String pledgeId) async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.pledgeDocView(type, pledgeId);
      if (requestCas?.code == 200) {
        if (type == "AGREEMENT") {
          termView = true;
        } else if (type == "KFIN") {
          kfinShow = true;
        } else if (type == "CAMS") {
          camsShow = true;
        }
        var bytes =
            base64Decode(requestCas?.body?.base64?.replaceAll('\n', '') ?? "");
        Directory appDocDir = await getApplicationDocumentsDirectory();
        final file = File("${appDocDir.path}/nj_customer.pdf");
        await file.writeAsBytes(bytes.buffer.asUint8List());
        print("PDF Path : ${file.path}");
        Map<String, dynamic> map = {'path': file.path};
        Get.toNamed(Routes.PDF_VIEW, arguments: map);
      }
    }
  }

  void getDocList() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.pledgeDocs();
      if (requestCas?.code == 200) {
        if (requestCas?.body?.data?.isNotEmpty ?? false) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_auth', jsonEncode(requestCas?.body?.data![0]));
          setState(() {
            pledgeDocData = requestCas?.body?.data![0];
            isKfinShow = requestCas?.body?.RTA?.contains("KFIN") ?? false;
            isCamsShow = requestCas?.body?.RTA?.contains("CAMS") ?? false;
          });
        }
      }
    }
  }
}
