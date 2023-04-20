import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TermsView extends StatefulWidget {
  const TermsView({Key? key}) : super(key: key);

  @override
  _TermsViewState createState() => _TermsViewState();
}

class _TermsViewState extends State<TermsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text("Terms & Conditions"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      margin: EdgeInsets.only(left: 16.w, right: 10.w,top: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.w),
                        color: themeColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Provide my/our explicit consent to NJ Capital Private Limited (NJC) to retrieve my/our KYC detail(s)/data  from CKYC.",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 12.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      margin: EdgeInsets.only(left: 16.w, right: 10.w,top: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.w),
                        color: themeColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Provide the  consent to update the detail(s)/data available with CKYC database if required under relevant regulation(s).",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 12.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      margin: EdgeInsets.only(left: 16.w, right: 10.w,top: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.w),
                        color: themeColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Authorize NJC to obtain information/data concerning me/us from one or more credit bureau(s), bank(s) and any such agencies as may be necessary in order to carry out my /our credit appraisal / affordability assessment while processing  my/our loan Application.",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 12.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      margin: EdgeInsets.only(left: 16.w, right: 10.w,top: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.w),
                        color: themeColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Understand and confirm that the Loan application may be rejected and that the terms of the Loan are derived from my/our credit appraisal/ affordability assessment. The eligibility criteria of the Loan shall solely be determined by NJC and may be amended from time to time.",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 12.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Get.back(result: true);
                },
                child: Container(
                  height: 40.h,
                  margin: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: themeColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "AGREE",
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
            ),
          ],
        ),
      ),
    );
  }
}
