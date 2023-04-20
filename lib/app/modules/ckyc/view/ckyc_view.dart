import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CKYCView extends StatefulWidget {
  const CKYCView({Key? key}) : super(key: key);

  @override
  _CKYCViewState createState() => _CKYCViewState();
}

class _CKYCViewState extends State<CKYCView> {

  bool isTnC = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0,
        title: Text(
          "CKYC",
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Upload E-KYC XML",
                  style: TextStyle(
                    fontFamily: LocaleKeys.font_family,
                    fontWeight: FontWeight.w600,
                    color: unselectTab,
                    fontSize: 12.sp,
                  ),
                ),
                TextField(
                  readOnly: true,
                  style: TextStyle(color: blackColor),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
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
                    suffixIcon: Container(
                      width: 90.w,
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: themeColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.w),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "UPLOAD",
                          style: TextStyle(color: themeColor),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Provide Code for your Paperless Offline eKYC",
                  style: TextStyle(
                    fontFamily: LocaleKeys.font_family,
                    fontWeight: FontWeight.w600,
                    color: unselectTab,
                    fontSize: 12.sp,
                  ),
                ),
                TextField(
                  style: TextStyle(color: blackColor),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
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
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isTnC,
                      onChanged: (value) {
                        setState(() {
                          isTnC = value ?? false;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.TERM_CONDITION);
                      },
                      child: Text(
                        "I agree the Term & Conditions",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 14.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "NOTE : To download E-KYC XML, click on",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: unselectTab,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 36.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: blackColor,
                    ),
                    child: Center(
                      child: Text(
                        "BACK",
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
        ),
      ),
    );
  }
}
