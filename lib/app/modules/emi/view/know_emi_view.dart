import 'dart:convert';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/constant.dart';
import 'package:customer/app/constant/locale_utils.dart';
import 'package:customer/app/modules/dashboard/model/EventModel.dart';
import 'package:customer/app/modules/dashboard/view/home_bottom_page.dart';
import 'package:customer/app/modules/emi/model/know_emi_response.dart';
import 'package:customer/app/modules/emi/viewmodel/know_emi_viewmodel.dart';
import 'package:customer/app/modules/login/model/user_decrypt_model.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class KnowEMIView extends StatefulWidget {
  const KnowEMIView({Key? key}) : super(key: key);

  @override
  _KnowEMIViewState createState() => _KnowEMIViewState();
}

class _KnowEMIViewState extends State<KnowEMIView> {
  UserDecryptData? userData;
  int selectedIndex = 0;
  double minAmount = 0;
  double minTenure = 0;
  double maxAmount = 0;
  double maxTenure = 0;
  double loanAmount = 0;
  int tenureAmount = 0;
  bool isTnC = false;
  var isCorrespondence = "no";
  List<int> values = [0];

  KnowEmiConfig? knowEmiConfig;

  List<ChartData> chartData = [
    ChartData('', 0, chart3Color),
    ChartData('', 0, chart1Color)
  ];

  late KnowEmiViewModel _service;

  @override
  void initState() {
    super.initState();
    _service = KnowEmiViewModel(context);
    getData();
    getEmiData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 16.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: boxBackColor,
                        border: Border.all(
                          color: dividerColor,
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Total Portfolio Value",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 12.sp,
                              fontFamily: LocaleKeys.font_family,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            moneyFormatWithoutDecimal(
                                knowEmiConfig?.totalPortfolioValue ?? 0),
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
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: Container(
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: boxBackColor,
                        border: Border.all(
                          color: dividerColor,
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Securities Pledged",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 12.sp,
                              fontFamily: LocaleKeys.font_family,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            moneyFormatWithoutDecimal(
                                knowEmiConfig?.securitiesPledged ?? 0),
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
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: boxBackColor,
                        border: Border.all(
                          color: dividerColor,
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Free Securities available for Pledging",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 12.sp,
                              fontFamily: LocaleKeys.font_family,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            moneyFormatWithoutDecimal(
                                knowEmiConfig?.availableForPledging ?? 0),
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
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: Container(
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: themeColor,
                        border: Border.all(
                          color: dividerColor,
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Loan Eligibility",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 12.sp,
                              fontFamily: LocaleKeys.font_family,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            moneyFormatWithoutDecimal(
                                knowEmiConfig?.loanEligibility ?? 0),
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
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Loan Amount",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 14.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: boxBackColor),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                    child: Center(
                      child: Text(
                        moneyFormatWithoutDecimal(loanAmount),
                        style: TextStyle(
                            color: blackColor,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              height: 20,
              child: Slider(
                value: loanAmount,
                min: minAmount,
                max: maxAmount,
                activeColor: themeColor,
                inactiveColor: unProgressColor,
                label: 'Set volume value',
                onChangeEnd: (double value) {
                  setState(() {
                    loanAmount = value;
                  });
                  getEmiData();
                },
                onChanged: (double newValue) {
                  setState(() {
                    loanAmount = newValue;
                  });
                },
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 28.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    moneyFormatWithoutDecimal(minAmount),
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 10.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    moneyFormatWithoutDecimal(maxAmount),
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 10.sp,
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
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tenure",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 14.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: boxBackColor),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                    child: Center(
                      child: Text(
                        "$tenureAmount",
                        style: TextStyle(
                            color: blackColor,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              height: 20,
              child: Slider(
                value: selectedIndex.toDouble(),
                min: 0,
                max: values.length - 1,
                divisions: values.length - 1 == 0 ? 1 : values.length - 1,
                activeColor: themeColor,
                inactiveColor: unProgressColor,
                label: values[selectedIndex].toString(),
                onChangeEnd: (double newValue) {
                  setState(() {
                    selectedIndex = newValue.toInt();
                    tenureAmount = values[selectedIndex];
                  });
                  getEmiData();
                },
                onChanged: (double newValue) {
                  setState(() {
                    selectedIndex = newValue.toInt();
                    tenureAmount = values[selectedIndex];
                  });
                },
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 28.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${minTenure.toInt()}",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 10.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${maxTenure.toInt()}",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 10.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 160.w,
                        height: 160.w,
                        child: SfCircularChart(
                          series: [
                            DoughnutSeries<ChartData, String>(
                              dataSource: chartData,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              radius: "65",
                              innerRadius: "0",
                            ),
                          ],
                          borderWidth: 1,
                          margin: EdgeInsets.zero,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            color: chart3Color,
                            height: 12.w,
                            width: 12.w,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            "Total Interest",
                            style: TextStyle(
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w700,
                                color: blackColor,
                                fontSize: 8.sp),
                          ),
                          SizedBox(
                            width: 6.h,
                          ),
                          Container(
                            color: chart1Color,
                            height: 12.w,
                            width: 12.w,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            "Principal Loan Amount",
                            style: TextStyle(
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w700,
                                color: blackColor,
                                fontSize: 8.sp),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loan EMI",
                              style: TextStyle(
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                  color: blackColor,
                                  fontSize: 8.sp),
                            ),
                            Text(
                              moneyFormat(
                                  knowEmiConfig?.selected?.EMI_AMOUNT ?? 0),
                              style: TextStyle(
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                  color: blackColor,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Interest Payable",
                              style: TextStyle(
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                  color: blackColor,
                                  fontSize: 8.sp),
                            ),
                            Text(
                              moneyFormat((knowEmiConfig
                                          ?.selected?.TOTAL_REPAY_AMOUNT ??
                                      0) -
                                  double.parse(knowEmiConfig
                                          ?.selected?.LOAN_REQUESTED_AMOUNT ??
                                      "0")),
                              style: TextStyle(
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                  color: blackColor,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Payment",
                              style: TextStyle(
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                  color: blackColor,
                                  fontSize: 8.sp),
                            ),
                            Text(
                              moneyFormat(
                                  knowEmiConfig?.selected?.TOTAL_REPAY_AMOUNT ??
                                      0),
                              style: TextStyle(
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                  color: blackColor,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16.w,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "To add more securities, please ",
                        style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      TextSpan(
                        text: "click here",
                        style: TextStyle(
                          color: themeColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            Constant.eventBus.fire(AddMoreSecurity());
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isTnC,
                    onChanged: (value) {
                      setState(() {
                        isTnC = value ?? false;
                      });
                      Constant.eventBus.fire(EmiValueChanges(loanAmount, tenureAmount,isTnC));
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isTnC = !isTnC;
                        });
                        Constant.eventBus.fire(EmiValueChanges(loanAmount, tenureAmount,isTnC));
                      },
                      child: Text(
                        "${userData?.otherData?.name??""}, agree that I/We agree that I/we will not utilize the money(ies) received under the Loan Facility for investment into capital markets, any immoral, illegal investment and/or speculative purposes and any other purpose which are prohibited under any law for the time being in force.",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 14.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
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

  void getEmiData() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.knowYourEmi(tenureAmount,
          int.parse(moneyFormatWithoutSign(loanAmount).replaceAll(",", "")));
      if (requestCas?.code == 200) {
        setState(() {
          knowEmiConfig = requestCas?.body?.config!;
          values = knowEmiConfig?.availableTenure ?? [0];
          tenureAmount = int.parse(knowEmiConfig?.selected?.TENURE ?? "0");
          loanAmount = double.parse(
              knowEmiConfig?.selected?.LOAN_REQUESTED_AMOUNT ?? "0");
          minAmount = knowEmiConfig?.minLoanAmount ?? 0;
          minTenure = (knowEmiConfig?.availableTenure![0] ?? 0).toDouble();
          maxAmount = knowEmiConfig?.maxLoanAmount ?? 0;
          maxTenure = (knowEmiConfig?.availableTenure![
                      knowEmiConfig!.availableTenure!.length - 1] ??
                  0)
              .toDouble();
          var interest = (knowEmiConfig?.selected?.TOTAL_REPAY_AMOUNT ?? 0) -
              double.parse(
                  knowEmiConfig?.selected?.LOAN_REQUESTED_AMOUNT ?? "0");
          selectedIndex = values.indexOf(tenureAmount);
          chartData = [
            ChartData(
                '',
                (double.parse(knowEmiConfig?.selected?.LOAN_REQUESTED_AMOUNT ??
                            "0") *
                        100) /
                    (knowEmiConfig?.selected?.TOTAL_REPAY_AMOUNT ?? 0),
                chart1Color),
            ChartData(
                '',
                (interest * 100) /
                    (knowEmiConfig?.selected?.TOTAL_REPAY_AMOUNT ?? 0),
                chart3Color)
          ];
        });
      } else {
        setState(() {
          tenureAmount = int.parse(knowEmiConfig?.selected?.TENURE ?? "0");
          loanAmount = double.parse(
              knowEmiConfig?.selected?.LOAN_REQUESTED_AMOUNT ?? "0");
          minAmount = knowEmiConfig?.minLoanAmount ?? 0;
          minTenure = (knowEmiConfig?.availableTenure![0] ?? 0).toDouble();
          maxAmount = knowEmiConfig?.loanEligibility ?? 0;
          maxTenure = (knowEmiConfig?.availableTenure![
                      knowEmiConfig!.availableTenure!.length - 1] ??
                  0)
              .toDouble();
          var interest = (knowEmiConfig?.selected?.TOTAL_REPAY_AMOUNT ?? 0) -
              int.parse(knowEmiConfig?.selected?.LOAN_REQUESTED_AMOUNT ?? "0");
          selectedIndex = values.indexOf(tenureAmount);
          chartData = [
            ChartData(
                '',
                (int.parse(knowEmiConfig?.selected?.LOAN_REQUESTED_AMOUNT ??
                            "0") *
                        100) /
                    (knowEmiConfig?.selected?.TOTAL_REPAY_AMOUNT ?? 0),
                chart1Color),
            ChartData(
                '',
                (interest * 100) /
                    (knowEmiConfig?.selected?.TOTAL_REPAY_AMOUNT ?? 0),
                chart3Color)
          ];
        });
      }
      Constant.eventBus.fire(EmiValueChanges(loanAmount, tenureAmount,isTnC));
    }
  }
}
