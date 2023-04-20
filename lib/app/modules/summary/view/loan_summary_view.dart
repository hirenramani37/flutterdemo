import 'dart:convert';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/locale_utils.dart';
import 'package:customer/app/modules/login/model/user_decrypt_model.dart';
import 'package:customer/app/modules/summary/model/loan_summary_response.dart';
import 'package:customer/app/modules/summary/viewmodel/loan_summary_viewmodel.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanSummaryView extends StatefulWidget {
  const LoanSummaryView({Key? key}) : super(key: key);

  @override
  _LoanSummaryViewState createState() => _LoanSummaryViewState();
}

class _LoanSummaryViewState extends State<LoanSummaryView> {

  UserDecryptData? userData;

  late LoanSummaryViewModel _service;

  LoanSummaryData? loanSummary;

  @override
  void initState() {
    super.initState();
    _service = LoanSummaryViewModel(context);
    getData();
    getLoanSummaryData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Portfolio Value",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    moneyFormat(loanSummary?.portfolioValue??0),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Eligible Loan Amount",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    moneyFormat(loanSummary?.eligibleLoanAmount??0),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "No. of Securities",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    "${(loanSummary?.kfin?.numberOfSecurities??0)+(loanSummary?.cams?.numberOfSecurities??0)}",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Pledged Units",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    moneyFormatWithoutSign3((loanSummary?.kfin?.unitesPledged??0)+(loanSummary?.cams?.unitesPledged??0)),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Total Pledged Securities",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    moneyFormat((loanSummary?.kfin?.totalValueOfPledgedSecurities??0)+(loanSummary?.cams?.totalValueOfPledgedSecurities??0)),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Bank Name",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    loanSummary?.bankName??"",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Account Number",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    loanSummary?.accountNumber??"",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: Get.width,
                child: Text(
                  "Breakup",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: themeColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                color: dividerColor,
                height: 0.7.h,
                width: Get.width,
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Applied Loan Amount",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    moneyFormat(loanSummary?.appliedLoanAmount??0),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Tenure(in months)",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    "${loanSummary?.tenure??0}",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Rate of Interest(in %)",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    "${moneyFormatWithoutSign2(loanSummary?.rateOfInterest??0)}%",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "EMI Amount",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    moneyFormat(loanSummary?.emiAmount??0),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Documentation charges",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    moneyFormatWithoutDecimal(loanSummary?.documentationFees??0),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Processing Fee",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    moneyFormatWithoutDecimal(loanSummary?.processingFees??0),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Annual percentage rate(in %)",
                      style: TextStyle(
                        color: unselectTab,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    "${moneyFormatWithoutSign2(loanSummary?.aprPercent??0)}%",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: loanSummary?.cams != null,
                child: SizedBox(
                  height: 12.h,
                ),
              ),
              Visibility(
                visible: loanSummary?.cams != null,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "RTA Processing charges (for CAMS only)",
                        style: TextStyle(
                          color: unselectTab,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      moneyFormatWithoutDecimal(loanSummary?.camsProcessingCharges??0),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getData() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userData = UserDecryptData.fromJson(
          jsonDecode(prefs.getString("user_data") ?? ""));
    });
  }

  void getLoanSummaryData() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.loanSummary();
      if(requestCas?.code == 200){
        setState(() {
          loanSummary = requestCas?.body?.data;
        });
      }
    }
  }
}
