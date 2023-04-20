import 'dart:convert';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/constant.dart';
import 'package:customer/app/modules/authentication/model/pledge_docs_response.dart';
import 'package:customer/app/modules/authentication/viewmodel/authentication_viewmodel.dart';
import 'package:customer/app/modules/dashboard/model/EventModel.dart';
import 'package:customer/app/modules/fetchcas/viewmodel/fetch_cas_controller.dart';
import 'package:customer/app/modules/otp/model/kfin_otp_response.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpView extends StatefulWidget {
  final FetchCasController? controller;

  const OtpView(this.controller, {Key? key}) : super(key: key);

  @override
  _OtpViewState createState() => _OtpViewState(controller!);
}

class _OtpViewState extends State<OtpView> {
  late AuthenticationViewModel _service;
  PledgeDocsData? pledgeDocData;

  OtpAuthPortfolio? otpPortfolio;
  String? token;

  _OtpViewState(FetchCasController _controller) {
    _controller.methodA = methodA;
  }

  var otp = "";

  Future<bool> methodA(int index) async {
    print("otp${otp.length}");
    if (otp.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter the OTP(One Time Password) received from KFIN RTA",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    if (otp.length != 6) {
      Fluttertoast.showToast(
          msg: "Invalid OTP. Please enter valid OTP",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    var data = {
      'kfinRefNo': '${otpPortfolio?.kfinRefNo}',
      'lienBankAcc': '${otpPortfolio?.lienBankAcc}',
      'otp': otp,
      'requestId': '${otpPortfolio?.requestId}',
      'ucc': '${otpPortfolio?.ucc}',
      'token': '$token'
    };
    if (ConnectivityUtils.instance.hasInternet) {
      var result = await _service.kfinVerifyOtp(data);
      if (result?.code == 200) {
        var prefs = await SharedPreferences.getInstance();
        var applicantDetail = PledgeDocsData.fromJson(jsonDecode(prefs.getString("user_auth") ?? ""));
        applicantDetail.ESP_KFIN = "Done";
        await prefs.setString(
            'user_auth', jsonEncode(applicantDetail.ESP_KFIN));
        Constant.eventBus.fire(PageChangeEvent(10));
      } else if (result != null) {
        Fluttertoast.showToast(
            msg: result.body?.message ?? "",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    return false;
  }

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
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    LocaleKeys.ic_eye,
                    width: 60.w,
                    height: 60.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Please enter the",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 16.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "OTP received from KFintech",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 16.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "on your registered Mobile no.\nto authorize the pledge.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 16.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    borderColor: borderColor,
                    showFieldAsBox: false,

                    onCodeChanged: (String code) {
                      //handle validation or checks here
                     // otp = code;
                     // print("otpView $otp");
                    },
                    onSubmit: (String verificationCode) {
                      otp = verificationCode;
                      print("otpView $otp");
                    }, // end onSubmit
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      sendKfinOtp();
                    },
                    child: Container(
                      height: 40.h,
                      width: 200.w,
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "RESEND OTP",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getDocList() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.pledgeDocs();
      if (requestCas?.code == 200) {
        if (requestCas?.body?.data?.isNotEmpty ?? false) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(
              'user_auth', jsonEncode(requestCas?.body?.data![0]));
          pledgeDocData = requestCas?.body?.data![0];
          if (pledgeDocData?.ESP_KFIN == "Done" &&
              pledgeDocData?.ESP_CAMS == "Done" &&
              pledgeDocData?.ESA == "Done") {
            Constant.eventBus.fire(PageChangeEvent(12));
          } else if (pledgeDocData?.ESP_KFIN == "Done" &&
              pledgeDocData?.ESP_CAMS == "Done" &&
              pledgeDocData?.ESA != "Done") {
            Constant.eventBus.fire(PageChangeEvent(11));
          } else if (pledgeDocData?.ESP_KFIN == "Done" &&
              pledgeDocData?.ESP_CAMS != "Done") {
            Constant.eventBus.fire(PageChangeEvent(10));
          } else {
            sendKfinOtp();
          }
        }
      }
    }
  }

  void sendKfinOtp() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.kfinOtpRequest();
      if (requestCas?.code == 200) {
        otpPortfolio = requestCas?.body?.otpAuthPortfolio;
        token = requestCas?.body?.token;
        Fluttertoast.showToast(
            msg: requestCas?.message ?? "",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
