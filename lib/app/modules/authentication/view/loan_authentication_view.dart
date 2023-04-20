import 'dart:convert';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/constant.dart';
import 'package:customer/app/modules/authentication/viewmodel/authentication_viewmodel.dart';
import 'package:customer/app/modules/dashboard/model/EventModel.dart';
import 'package:customer/app/modules/login/model/user_decrypt_model.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../util/connectivity_utils.dart';

class LoanAuthenticationView extends StatefulWidget {
  const LoanAuthenticationView({Key? key}) : super(key: key);

  @override
  _LoanAuthenticationViewState createState() => _LoanAuthenticationViewState();
}

class _LoanAuthenticationViewState extends State<LoanAuthenticationView> {
  bool isSelectAll = false;
  UserDecryptData? userData;
  late AuthenticationViewModel _service;
  DateTime time = DateTime.now();
  String ESIGN_ID_A = "";
  String ESIGN_PDF_ID_A = "";
  String tokenInitate = "";
  num otpInitate = 0;

  @override
  void initState() {
    _service = AuthenticationViewModel(context);
    getDocList();
    getData();
    super.initState();
  }

  void getDocList() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestLonAuth = await _service.pledgeDocs();
      if (requestLonAuth?.code == 200) {
        if (requestLonAuth?.body?.data?.isNotEmpty ?? false) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_auth', jsonEncode(requestLonAuth?.body?.data![0]));
          var data = requestLonAuth?.body?.data?[0];
          if(data?.ESA == "Done" && data?.ESP_CAMS == "Done" && data?.ESA == "Done"){
            Constant.eventBus.fire(PageChangeEvent(12));
          }else{
            setState(() {
              ESIGN_ID_A = data?.ESIGN_ID_A.toString()??"";
              ESIGN_PDF_ID_A = data?.ESIGN_PDF_ID_A.toString()??"";
              agreementInitate(time, ESIGN_ID_A, ESIGN_PDF_ID_A);
              //if (data?.ESA == "Done" && data?.ESP_CAMS == "Done" && data?.ESA == "Done") {
              // }
            });
          }
        }
      }
    }
  }

  Future<void> agreementInitate(DateTime date,String esignId,String esignPdfId) async {
    if(ConnectivityUtils.instance.hasInternet){
      var requestLonAuth = await _service.agreementInitate(date, esignId, esignPdfId);
      if(requestLonAuth?.code == 200){
        var data = requestLonAuth?.body;
        tokenInitate = data?.token.toString()??"";
        otpInitate = data?.otp??0;
        Fluttertoast.showToast(
            msg: otpInitate.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  Future<void> agreementVerifyOtp() async {
    if(ConnectivityUtils.instance.hasInternet){
      var requestLonAuth = await _service.agreementVerifyOtp(time, ESIGN_ID_A, ESIGN_PDF_ID_A,otpInitate.toInt(),tokenInitate);
      if(requestLonAuth?.code == 200){
        var data = requestLonAuth?.message;
        Fluttertoast.showToast(
            msg: data.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
       // tokenInitate = data?.token.toString()??"";
      //  otpInitate = data?.otp.toString()??"";
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: isSelectAll,
                  onChanged: (value) {
                    setState(() {
                      isSelectAll = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    "I/We ${userData?.otherData?.name??""},, confirm that the I/We have fully read through and understand all the terms and conditions of the Loan Term Sheet No.#LTS NO#. I/We authorize NJ Capital Private Limited to disburse the loan and I/We undertake to service the loan in accordance with the terms contained therein.",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 10.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "OTP",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: LocaleKeys.font_family,
                fontWeight: FontWeight.w700,
                color: blackColor,
                fontSize: 12.sp,
              ),
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: borderColor,
              showFieldAsBox: false,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              onSubmit: (String verificationCode) {

              }, // end onSubmit
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {},
              child: Container(
                height: 36.h,
                width: 160.w,
                margin: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "GENERATE OTP",
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
    );
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userData = UserDecryptData.fromJson(
          jsonDecode(prefs.getString("user_data") ?? ""));
    });
  }

}
