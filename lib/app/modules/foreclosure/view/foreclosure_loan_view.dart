import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/modules/dashboard/view/home_bottom_page.dart';
import 'package:customer/app/modules/fetchcas/view/fetch_cas_view1.dart';
import 'package:customer/app/modules/fetchcas/view/fetch_cas_view2.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ForeclosureLoanView extends StatefulWidget {
  const ForeclosureLoanView({Key? key}) : super(key: key);

  @override
  _ForeclosureLoanViewState createState() => _ForeclosureLoanViewState();
}

class _ForeclosureLoanViewState extends State<ForeclosureLoanView> {

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
          "Foreclosure Loan",
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: applicantBack,
                width: Get.width,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                child: Text(
                  "Applicant : Ujjwal Raut",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 14.sp,
                    fontFamily: LocaleKeys.font_family,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Text(
                      "Loan Balance : ",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "4150",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 20.sp,
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Note : 1) Foreclosure charges(if any) is applicable on the Foreclosure of the loan.",
                  style: TextStyle(
                    color: unselectTab,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Container(
                    height: 36.h,
                    width: 100.w,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: themeColor,
                    ),
                    child: Center(
                      child: Text(
                        "Pay",
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 16.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 36.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: blackColor,
                    ),
                    child: Center(
                      child: Text(
                        "RESET",
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 16.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
