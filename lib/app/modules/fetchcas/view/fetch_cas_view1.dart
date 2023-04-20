import 'dart:convert';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/modules/fetchcas/viewmodel/fetch_cas_viewmodel.dart';
import 'package:customer/app/modules/login/model/user_decrypt_model.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchCasView1 extends StatefulWidget {
  FetchCasView1({Key? key}) : super(key: key);

  @override
  _FetchCasView1State createState() => _FetchCasView1State();
}

class _FetchCasView1State extends State<FetchCasView1> {
  UserDecryptData? userData;

  late FetchCasViewModel _service;


  @override
  void initState() {
    super.initState();
    _service = FetchCasViewModel(context);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "SUBMIT YOUR REQUEST FOR",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 12.sp,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "CONSOLIDATED ACCOUNTS STATEMENT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: themeColor,
                            fontSize: 16.sp,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Row(
                            children: [
                              Image.asset(
                                LocaleKeys.ic_fetch_email,
                                height: 36.w,
                                width: 36.w,
                                color: iconColor,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                userData?.otherData?.email??"",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 12.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Row(
                            children: [
                              Image.asset(
                                LocaleKeys.ic_fetch_profile,
                                height: 36.w,
                                width: 36.w,
                                color: iconColor,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                userData?.otherData?.pan ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 12.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          /*Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                _showFetchPopup(context, widget);
              },
              child: Container(
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 16.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  Future<bool?> _showFetchPopup(
      BuildContext context, FetchCasView1 widget) async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              color: whiteColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Image.asset(
                    LocaleKeys.ic_correct_image,
                    height: 60.w,
                    width: 60.w,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "You will receive a mail from",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "samfS@kfintech.com",
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 14.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "The password of the statement is",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "NJC@1234",
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 14.sp,
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
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 30.h,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "SUBMIT",
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
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userData = UserDecryptData.fromJson(
          jsonDecode(prefs.getString("user_data") ?? ""));
    });
  }
}
