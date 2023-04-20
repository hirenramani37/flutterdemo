import 'dart:convert';
import 'dart:math' as math;

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/constant.dart';
import 'package:customer/app/constant/locale_utils.dart';
import 'package:customer/app/modules/dashboard/model/EventModel.dart';
import 'package:customer/app/modules/dashboard/model/dashboard_response.dart';
import 'package:customer/app/modules/dashboard/model/product_feature_response.dart';
import 'package:customer/app/modules/dashboard/viewmodel/loan_view_model.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanPageView extends StatefulWidget {
  const LoanPageView({Key? key}) : super(key: key);

  @override
  _LoanPageViewState createState() => _LoanPageViewState();
}

class _LoanPageViewState extends State<LoanPageView> {
  // var isLoanApplication = false;
  var loanScreen = 1;

  bool isTnC = false;
  bool isProductFeature = false;
  bool isEMICharges = false;
  late LoanViewModel _service;
  var consentTimestamp = 0;
  ProductFeatureChanges? productFeatureChanges;

  @override
  void initState() {
    super.initState();
    _service = LoanViewModel(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return WillPopScope(
      onWillPop: () async {
        if (loanScreen != 1) {
          setState(() {
            loanScreen -= 1;
          });
          if (loanScreen == 1) {
            Constant.eventBus.fire(TitleEvent("Loan"));
          }
          return false;
        }
        return true;
      },
      child: loanScreen == 1
          ? Scaffold(
              backgroundColor: whiteColor,
              body: Column(
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Card(
                      child: ListTile(
                        leading: Image.asset(
                          LocaleKeys.ic_loan_physical,
                          width: 24.w,
                          height: 24.h,
                          color: blackColor,
                        ),
                        title: const Text("Loan Against Physical Mutual Funds"),
                        onTap: () async {
                          if (ConnectivityUtils.instance.hasInternet) {
                            var requestOtpResponse =
                                await _service.dashboardData();
                            if (requestOtpResponse?.code == 200) {
                              final prefs =
                                  await SharedPreferences.getInstance();

                             /* var temp = requestOtpResponse
                                  ?.body?.data?.loanStateList
                                  ?.where((element) => element.loanStatus!.contains(RegExp(r'(?:AUTHORIZE PENDING)|(?:SANCTIONED)')))
                                  .toList();*/
                              if (requestOtpResponse?.body?.data?.loan!=null) {
                                Constant.eventBus.fire(TitleEvent("Loan Application Steps"));
                                setState(() {
                                  loanScreen = 2;
                                });
                                await prefs.setString('loanApplicationId', requestOtpResponse?.body?.data?.loan?.loanApplicationId ?? "");
                                var result = await getApplicantList();
                                if(result){
                                  redirectPage(requestOtpResponse!.body!.data!.loan!);
                                }

                                // Test
                                /* var productFeature =
                                await _service.productFeature();
                                if (productFeature?.code == 200) {
                                  Constant.eventBus.fire(
                                      TitleEvent("Loan Application Steps"));
                                  setState(() {
                                    productFeatureChanges =
                                        productFeature?.body?.changes;
                                    loanScreen = 2;
                                  });
                                }*/
                                // Test
                              } else {
                                var productFeature =
                                    await _service.productFeature();
                                if (productFeature?.code == 200) {
                                  Constant.eventBus.fire(
                                      TitleEvent("Loan Application Steps"));
                                  setState(() {
                                    productFeatureChanges = productFeature?.body?.changes;
                                    loanScreen = 2;
                                  });
                                }
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Card(
                      child: ListTile(
                        leading: Image.asset(
                          LocaleKeys.ic_loan_demat,
                          width: 24.w,
                          height: 24.h,
                          color: blackColor,
                        ),
                        title: const Text("Loan Against Demat Mutual Funds"),
                        onTap: () async {
                          if (ConnectivityUtils.instance.hasInternet) {
                            var requestOtpResponse =
                                await _service.dashboardData();
                            if (requestOtpResponse?.code == 200) {
                              final prefs = await SharedPreferences.getInstance();
                              if (requestOtpResponse?.body?.data?.loan!=null) {
                                Constant.eventBus.fire(TitleEvent("Loan Application Steps"));
                                setState(() {
                                  loanScreen = 2;
                                });
                                await prefs.setString('loanApplicationId', requestOtpResponse?.body?.data?.loan?.loanApplicationId ?? "");
                                var result = await getApplicantList();
                                if(result){
                                  redirectPage(requestOtpResponse!.body!.data!.loan!);
                                }

                                // Test
                                /* var productFeature =
                                await _service.productFeature();
                                if (productFeature?.code == 200) {
                                  Constant.eventBus.fire(
                                      TitleEvent("Loan Application Steps"));
                                  setState(() {
                                    productFeatureChanges =
                                        productFeature?.body?.changes;
                                    loanScreen = 2;
                                  });
                                }*/
                                // Test
                              } else {
                                var productFeature =
                                    await _service.productFeature();
                                if (productFeature?.code == 200) {
                                  Constant.eventBus.fire(
                                      TitleEvent("Loan Application Steps"));
                                  setState(() {
                                    productFeatureChanges =
                                        productFeature?.body?.changes;
                                    loanScreen = 2;
                                  });
                                }
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Scaffold(
              backgroundColor: whiteColor,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
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
                        Column(
                          children: [
                            Text(
                              "NOW GET A LOAN BY COMPLETING",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: blackColor,
                                fontSize: 12.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "6 EASY STEPS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: themeColor,
                                fontSize: 28.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          margin: EdgeInsets.only(left: 16.w, right: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.w),
                            color: themeColor,
                          ),
                          child: Center(
                            child: Text(
                              "1",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Fetch your Consolidated Account Statement of Mutual Fund",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 10.sp,
                              fontFamily: LocaleKeys.font_family,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          margin: EdgeInsets.only(left: 16.w, right: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.w),
                            color: themeColor,
                          ),
                          child: Center(
                            child: Text(
                              "2",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Know your EMI",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 10.sp,
                              fontFamily: LocaleKeys.font_family,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          margin: EdgeInsets.only(left: 16.w, right: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.w),
                            color: themeColor,
                          ),
                          child: Center(
                            child: Text(
                              "3",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Complete KYC & Bank Details",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 10.sp,
                              fontFamily: LocaleKeys.font_family,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          margin: EdgeInsets.only(left: 16.w, right: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.w),
                            color: themeColor,
                          ),
                          child: Center(
                            child: Text(
                              "4",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Check the eligible loan amount & security selection for pledging",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 10.sp,
                              fontFamily: LocaleKeys.font_family,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          margin: EdgeInsets.only(left: 16.w, right: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.w),
                            color: themeColor,
                          ),
                          child: Center(
                            child: Text(
                              "5",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Pledge & Loan TnC Authentication",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 10.sp,
                              fontFamily: LocaleKeys.font_family,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          margin: EdgeInsets.only(left: 16.w, right: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.w),
                            color: themeColor,
                          ),
                          child: Center(
                            child: Text(
                              "6",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Submit Mandate",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 10.sp,
                              fontFamily: LocaleKeys.font_family,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Container(
                            width: 12.w,
                            height: 40.h,
                            color: themeColor,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isProductFeature = !isProductFeature;
                                });
                              },
                              child: Container(
                                width: Get.width,
                                height: 32.h,
                                color: questionBack,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 16.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Product Feature",
                                        style: TextStyle(
                                          color: blackColor,
                                          fontSize: 12.sp,
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Transform.rotate(
                                      angle:
                                          isProductFeature ? 0 : -math.pi / 2,
                                      child: Image.asset(
                                        LocaleKeys.ic_arrow_down,
                                        color: arrowColor,
                                        width: 16.w,
                                        height: 16.h,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isProductFeature,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                margin: EdgeInsets.only(
                                    left: 40.w, right: 10.w, top: 2.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.w),
                                  color: themeColor,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Loan from Rs. ${productFeatureChanges?.minMaxLoanAmount?.MIN_AMT_FORMAT ?? ""} to Rs. ${productFeatureChanges?.minMaxLoanAmount?.MAX_AMT_FORMATE ?? ""}.",
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 11.sp,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                margin: EdgeInsets.only(
                                    left: 40.w, right: 10.w, top: 2.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.w),
                                  color: themeColor,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Loan will be available against Mutual Funds",
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 11.sp,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                margin: EdgeInsets.only(
                                    left: 40.w, right: 10.w, top: 2.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.w),
                                  color: themeColor,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Fully Digital Process",
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 11.sp,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                margin: EdgeInsets.only(
                                    left: 40.w, right: 10.w, top: 2.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.w),
                                  color: themeColor,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Online repayment at any time",
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 11.sp,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                margin: EdgeInsets.only(
                                    left: 40.w, right: 10.w, top: 2.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.w),
                                  color: themeColor,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Disbursement in ${productFeatureChanges?.disbursementWorkingDays ?? ""} working days",
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 11.sp,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Container(
                            width: 12.w,
                            height: 40.h,
                            color: themeColor,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEMICharges = !isEMICharges;
                                });
                              },
                              child: Container(
                                width: Get.width,
                                height: 32.h,
                                color: questionBack,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 16.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "EMI & Charges",
                                        style: TextStyle(
                                          color: blackColor,
                                          fontSize: 11.sp,
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Transform.rotate(
                                      angle: isEMICharges ? 0 : -math.pi / 2,
                                      child: Image.asset(
                                        LocaleKeys.ic_arrow_down,
                                        color: arrowColor,
                                        width: 16.w,
                                        height: 16.h,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isEMICharges,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                margin: EdgeInsets.only(
                                    left: 40.w, right: 10.w, top: 2.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.w),
                                  color: themeColor,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "EMI Per Lakh: as low as Rs ${productFeatureChanges?.emiPerLakhRs ?? ""} for ${productFeatureChanges?.maxTenure ?? ""} months",
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 11.sp,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                margin: EdgeInsets.only(
                                    left: 40.w, right: 10.w, top: 2.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.w),
                                  color: themeColor,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Processing Fees: ${productFeatureChanges?.processingFees ?? ""} of the loan amount",
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 11.sp,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                margin: EdgeInsets.only(
                                    left: 40.w, right: 10.w, top: 2.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.w),
                                  color: themeColor,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Documentation Charges ${productFeatureChanges?.documentChargesForEmandateFormat ?? ""} + Applicable Taxes",
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 11.sp,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                margin: EdgeInsets.only(
                                    left: 40.w, right: 10.w, top: 2.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.w),
                                  color: themeColor,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "CAMS pledging charges – ${productFeatureChanges?.camsCharges ?? ""} + Applicable Taxes",
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 11.sp,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isTnC,
                            onChanged: (value) {
                              setState(() {
                                isTnC = value ?? false;
                              });
                              if (isTnC) {
                                consentTimestamp =
                                    DateTime.now().millisecondsSinceEpoch;
                              }
                            },
                          ),
                          GestureDetector(
                            onTap: () async {
                              var result =
                                  await Get.toNamed(Routes.TERM_CONDITION);
                              if (result != null) {
                                if (result is bool) {
                                  setState(() {
                                    isTnC = result;
                                  });
                                }
                              }
                            },
                            child: Text(
                              "I agree the Term & Conditions",
                              style: TextStyle(
                                color: themeColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (isTnC) {
                          if (ConnectivityUtils.instance.hasInternet) {
                            var productFeatureEligible = await _service
                                .productFeatureEligible(consentTimestamp);
                            if (productFeatureEligible?.code == 200) {
                              if ((productFeatureEligible?.body?.eligibility ??
                                      0) >
                                  0) {
                                _showPopup(
                                    context,
                                    productFeatureEligible?.body?.eligibility ??
                                        0);
                              } else {
                                _showCancelPopup(context);
                              }
                            }
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please check term & condition.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
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
                            "APPLY FOR LOAN",
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
                  ],
                ),
              ),
            ),
    );
  }

  Future<bool?> _showPopup(BuildContext context, int eligibleAmount) async {
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
                    "The customer will be eligible for",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        moneyFormat(eligibleAmount),
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 30.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Would you like to borrow this amount?",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
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
                            Map<String, dynamic> map = {'page': 2};
                            Get.toNamed(Routes.FETCH_CAS, arguments: map);
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
                                "YES",
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
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 30.h,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: blackColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "NO",
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

  Future<bool?> _showCancelPopup(BuildContext context) async {
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
                    height: 16.h,
                  ),
                  Text(
                    "Sorry, You do not have required minimum securities to apply the Loan. Please upload additional securities.",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
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
                              color: blackColor,
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
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<bool> getApplicantList() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.getApplicantList();
      if (requestCas?.code == 200) {
        if (requestCas?.body?.applicantDetails?.isNotEmpty ?? false) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('applicant_data', jsonEncode(requestCas?.body?.applicantDetails![0]));
          return true;
        }
      }
    }
    return false;
  }

  void redirectPage(LoanStateData loanStateData) {
    switch (loanStateData.lastSubmittedStage) {
      case "P_DESK_USER_SELECTION":
        {}
        break;
      case "P_DESK_UPLOAD_SECURITIES":
        {}
        break;
      case "P_DESK_SECURITIES_SELECTION":
        {}
        break;
      case "PRODUCT_FEATURES":
        {
          Map<String, dynamic> map = {'page': 0};
          Get.toNamed(Routes.FETCH_CAS, arguments: map);
        }
        break;
      case "FETCH_CAS":
        {
          Map<String, dynamic> map = {'page': 2};
          Get.toNamed(Routes.EMI_CALCULATOR, arguments: map);
        }
        break;
      case "KNOW_YOUR_EMI":
        {
          Map<String, dynamic> map = {'page': 3, 'kycIndex': 0};
          Get.toNamed(Routes.CKYC_VIEW, arguments: map);
        }
        break;
      case "KYC_PERSONAL_DETAILS":
        {
          Map<String, dynamic> map = {'page': 3, 'kycIndex': 3};
          Get.toNamed(Routes.CKYC_VIEW, arguments: map);
        }
        break;
        case "KYC_DIGILOCKER_DONE":
        {
          Map<String, dynamic> map = {'page': 3, 'kycIndex': 3};
          Get.toNamed(Routes.CKYC_VIEW, arguments: map);
        }
        break;
      case "KYC_ADDRESS_DETAILS":  /// Add LivePhotoView
        {
          Map<String, dynamic> map = {'page': 3, 'kycIndex': 3};
          Get.toNamed(Routes.LIVE_PHOTOS_VIEW, arguments: map);
        }
        break;
      case "KYC_PHOTO_VERIFICATION_DONE":
        {
          // Map<String, dynamic> map = {'page': 5};
          // Get.toNamed(Routes.FETCH_CAS, arguments: map);
           Map<String, dynamic> map = {'page': 5};
           Get.toNamed(Routes.BANK_ADD, arguments: map);
        }
        break;
      case "KYC_BANK_DETAILS":
        {
          Map<String, dynamic> map = {'page': 6};
          Get.toNamed(Routes.SECURITY_SELECTION_VIEW, arguments: map);
        }
        break;
      case "SECURITIES_SELECTION":
        {
          Map<String, dynamic> map = {'page': 7};
          Get.toNamed(Routes.LOAN_SUMMARY_VIEW, arguments: map);
        }
        break;
      case "LOAN_SUMMARY":
        {
          Map<String, dynamic> map = {'page': 8};
          Get.toNamed(Routes.VIEW_ALL_DOCS, arguments: map);
        }
        break;
      case "DOCUMENTS_VIEWED":
        {
          Map<String, dynamic> map = {'page': 9};
          Get.toNamed(Routes.PLEDGE_SECURITY, arguments: map);
        }
        break;
      case "SECURITIES_PLEDGED":
        {
          Map<String, dynamic> map = {'page': 9};
          Get.toNamed(Routes.BANK_MANDATE, arguments: map);
        }
        break;
      case "MANDATE_SUBMITTED":
        {

        }
        break;

    }
  }
}
