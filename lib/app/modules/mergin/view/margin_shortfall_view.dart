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

class MarginShortfallView extends StatefulWidget {
  const MarginShortfallView({Key? key}) : super(key: key);

  @override
  _MarginShortfallViewState createState() => _MarginShortfallViewState();
}

class _MarginShortfallViewState extends State<MarginShortfallView> {
  int loanAmount = 100000;
  int tenureAmount = 12;
  bool isTnC = false;
  var isCorrespondence = "no";

  final List<ChartData> chartData = [
    ChartData('₹ 30,000', 65, chart3Color),
    ChartData('₹ 15,000', 35, chart1Color)
  ];

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
          "Margin Shortfall",
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
                height: 60.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: boxBackColor,
                          border: Border.all(
                            color: dividerColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Overdue EMI Amount",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 12.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "6,00,000",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 20.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: boxBackColor,
                          border: Border.all(
                            color: dividerColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Margin Shortfall",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 12.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "3,00,000",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 20.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                height: 60.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: boxBackColor,
                          border: Border.all(
                            color: dividerColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Prepayment Amount",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 12.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "1,40,000",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 20.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: themeColor,
                          border: Border.all(
                            color: dividerColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Total Amount to pay",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 12.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "2,00,000",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 20.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                child: Column(
                  children: [
                    Text(
                      "Note:\n\n1) Overdue EMI & EMI Amount will not be allowed to modify.\n2) Margin Shortfall Amount will be inclusive of the Interest charge (if any applicable).\n3) Pre-payment of Loan will be allowed only after the full payment of Overdue EMI/EMI Amount/Margin Shortfall Amount.\n4)Pre-payment charges(if any) is applicable on the Pre-payment of the loan.",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: unselectTab,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
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
