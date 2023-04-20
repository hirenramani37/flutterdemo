import 'dart:async';
import 'dart:convert';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/modules/login/model/user_decrypt_model.dart';
import 'package:customer/app/modules/login/viewmodel/login_view_model.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var clientIDController = TextEditingController();
  var mobileController = TextEditingController();
  var otpController = TextEditingController();
  var focusNode = FocusNode();
  late LoginViewModel _service;
  var isMobileShow = false;
  var isOTPShow = false;
  var token = "";
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;

  String clientId = "";

  @override
  void initState() {
    super.initState();
    _service = LoginViewModel(context);
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Container(
      color: whiteColor,
      child: Stack(
        children: [
          Image.asset(
            LocaleKeys.ic_login_back,
            width: Get.width,
          ),
          Scaffold(
            backgroundColor: transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Hello !!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w400,
                                  color: whiteColor,
                                  fontSize: 26.sp),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              "Welcome to the",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                  color: whiteColor,
                                  fontSize: 36.sp),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Image.asset(
                              LocaleKeys.ic_app_icon,
                              width: 160.w,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              "Now get a loan hassle free with\nminimum documentation.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w400,
                                  color: whiteColor,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.r),
                              topLeft: Radius.circular(20.r))),
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 30.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Client ID",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: LocaleKeys.font_family,
                                      fontWeight: FontWeight.w700,
                                      color: blackColor,
                                      fontSize: 12.sp),
                                ),
                                TextField(
                                  controller: clientIDController,
                                  maxLength: 6,
                                  style: TextStyle(color: blackColor),
                                  textInputAction: TextInputAction.next,
                                  textCapitalization: TextCapitalization.characters,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintStyle: TextStyle(color: hintColor),
                                    hintText: "Enter Client ID",
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: themeColor),
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: hintColor),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: hintColor),
                                    ),
                                    isDense: true,
                                  ),
                                ),
                                Visibility(
                                  visible: isMobileShow,
                                  child: const SizedBox(
                                    height: 20,
                                  ),
                                ),
                                Visibility(
                                  visible: isMobileShow,
                                  child: Text(
                                    "Mobile No",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: LocaleKeys.font_family,
                                      fontWeight: FontWeight.w700,
                                      color: blackColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isMobileShow,
                                  child: TextField(
                                    controller: mobileController,
                                    maxLength: 10,
                                    readOnly: true,
                                    style: TextStyle(color: blackColor),
                                    keyboardType: TextInputType.phone,
                                    /*onChanged: (text) {
                                      var maskText = "";
                                      if (text.length <= 6) {
                                        for (var i = 0; i < text.length; i++) {
                                          maskText += "#";
                                        }
                                      } else {
                                        maskText = "######";
                                      }
                                      mobileController.text = text.replaceRange(
                                          0,
                                          text.length < 6 ? text.length : 6,
                                          maskText);
                                      mobileController.selection =
                                          TextSelection.fromPosition(TextPosition(
                                              offset:
                                                  mobileController.text.length));
                                      // focusNode.requestFocus();
                                    },*/
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(color: hintColor),
                                      counterText: "",
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: themeColor),
                                      ),
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: hintColor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: hintColor),
                                      ),
                                      hintText: "Display Mobile No",
                                      isDense: true,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isOTPShow,
                                  child: const SizedBox(
                                    height: 20,
                                  ),
                                ),
                                Visibility(
                                  visible: isOTPShow,
                                  child: Text(
                                    "OTP",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: LocaleKeys.font_family,
                                        fontWeight: FontWeight.w700,
                                        color: blackColor,
                                        fontSize: 12.sp),
                                  ),
                                ),
                                Visibility(
                                  visible: isOTPShow,
                                  child: TextField(
                                    controller: otpController,
                                    style: TextStyle(color: blackColor),
                                    maxLength: 6,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      hintStyle: TextStyle(color: hintColor),
                                      hintText: "Enter OTP",
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: themeColor),
                                      ),
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: hintColor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: hintColor),
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isOTPShow,
                                  child: SizedBox(
                                    height: 4.h,
                                  ),
                                ),
                                Visibility(
                                  visible: isOTPShow,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (ConnectivityUtils
                                            .instance.hasInternet) {
                                          var requestOtpResponse = await _service.resendOTP(token, clientId);
                                          if (requestOtpResponse?.code == 200) {
                                            token = requestOtpResponse?.body?.token ?? "";
                                            if (enableResend) {
                                              enableResend = false;
                                              secondsRemaining = 60;
                                            }
                                          }
                                        }
                                      },
                                      child: Text(
                                        enableResend ? "Resend OTP" : "$secondsRemaining",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w500,
                                          color: themeColor,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (!isMobileShow && !isOTPShow) {
                                      clientId = clientIDController.text.trim();
                                      if (clientId.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Please enter client id",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        return;
                                      }
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      if (ConnectivityUtils.instance.hasInternet) {
                                        var validCustomerResponse =
                                            await _service.validCustomer(clientId);
                                        if (validCustomerResponse?.code == 200) {
                                          mobileController.text = validCustomerResponse?.body?.result ?? "";
                                          setState(() {
                                            isMobileShow = true;
                                          });
                                        }
                                      }
                                    } else if (isMobileShow && !isOTPShow) {
                                      if (clientId.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Please enter client id",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        return;
                                      }
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      if (ConnectivityUtils.instance.hasInternet) {
                                        var requestOtpResponse = await _service.sendOTP(clientId);
                                        if (requestOtpResponse?.code == 200) {
                                          token = requestOtpResponse?.body?.token ?? "";
                                          otpController.text = "${requestOtpResponse?.body?.otp ?? ""}";
                                          secondsRemaining = 60;
                                          enableResend = false;
                                          setState(() {
                                            isOTPShow = true;
                                          });
                                        }
                                      }
                                    } else if (isMobileShow && isOTPShow) {
                                      var otp = otpController.text.trim();
                                      if (otp.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Please enter otp",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        return;
                                      }
                                      if (otp.length < 6) {
                                        Fluttertoast.showToast(
                                            msg: "Please enter valid otp",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        return;
                                      }
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      if (ConnectivityUtils
                                          .instance.hasInternet) {
                                        var requestOtpResponse = await _service
                                            .validateOtp(otp, token, clientId);
                                        if (requestOtpResponse?.code == 200) {
                                          Map<String, dynamic> decodedToken = JwtDecoder.decode(requestOtpResponse?.body?.token ?? "");
                                          final value = UserDecryptModel.fromJson(decodedToken);
                                          final prefs = await SharedPreferences.getInstance();
                                          await prefs.setString('user_data', jsonEncode(value.data));
                                          await prefs.setBool('isLogin', true);
                                          await prefs.setString('token', requestOtpResponse?.body?.token ?? "");
                                          Get.offAllNamed(Routes.DASHBOARD);
                                        }
                                      }
                                    }
                                    // Get.toNamed(Routes.DASHBOARD);
                                  },
                                  child: Container(
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      color: themeColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        !isMobileShow && !isOTPShow ? "SUBMIT" : isMobileShow && !isOTPShow ? "GENERATE OTP" : "VERIFY",
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
                                SizedBox(
                                  height: 20.h,
                                ),
                                /*Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Not register with us?    ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w500,
                                          color: blackColor,
                                          fontSize: 14.sp),
                                    ),
                                    Text(
                                      "Sign Up",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w700,
                                          color: themeColor,
                                          fontSize: 14.sp),
                                    ),
                                  ],
                                )*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
