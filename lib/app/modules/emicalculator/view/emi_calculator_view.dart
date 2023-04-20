import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmiCalculatorView extends StatefulWidget {
  const EmiCalculatorView({Key? key}) : super(key: key);

  @override
  _EmiCalculatorViewState createState() => _EmiCalculatorViewState();
}

class _EmiCalculatorViewState extends State<EmiCalculatorView> {
  String? docValue;
  List<String> docList = ["Product 1", "Product 2", "Product 3"];
  int loanAmount = 100000;

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
          "EMI Calculator",
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "Select Product",
              style: TextStyle(
                  fontFamily: LocaleKeys.font_family,
                  fontWeight: FontWeight.w600,
                  color: unselectTab,
                  fontSize: 12.sp),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: DropdownButtonFormField<String>(
              value: docValue,
              items: docList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isDense: true,
              isExpanded: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (values) {
                setState(() {
                  docValue = values;
                });
              },
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Loan Amount",
                  style: TextStyle(
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                      color: unselectTab,
                      fontSize: 12.sp),
                ),
                Container(
                  decoration: BoxDecoration(color: boxBackColor),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                  child: Center(
                    child: Text(
                      "$loanAmount",
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
          SizedBox(
            height: 20,
            child: Slider(
              value: loanAmount.toDouble(),
              min: 25000,
              max: 500000,
              activeColor: themeColor,
              inactiveColor: unProgressColor,
              label: 'Set volume value',
              onChanged: (double newValue) {
                setState(() {
                  loanAmount = newValue.round();
                });
              },
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "25,000",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 10.sp,
                    fontFamily: LocaleKeys.font_family,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "5,00,000",
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
            height: 30.h,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: arrowColor,
                width: 1,
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: borderColor,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          'Tenure',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: themeColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          'Min.EMI(Rs.)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: themeColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          'Min.Repayment Amt(Rs.)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: themeColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          'Max. EMI',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: themeColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          'Max.Repayment Amt(Rs.)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: themeColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  height: 1,
                  color: arrowColor,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '6 Months',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '1,739',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '1,03,97',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '1,03,97',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '1,03,97',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  height: 1,
                  color: arrowColor,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '12 Months',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '8,931',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '1,03,97',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '1,03,97',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '1,03,97',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  height: 1,
                  color: arrowColor,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '18 Months',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '1,739',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '1,03,97',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '1,03,97',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          '1,03,97',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  height: 1,
                  color: arrowColor,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 16.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Processing Fees              : ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: themeColor,
                            ),
                          ),
                          Text(
                            'Rs. 590.00',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: themeColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h,),
                      Row(
                        children: [
                          Text(
                            'Documentation Charges : ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: themeColor,
                            ),
                          ),
                          Text(
                            'Rs. 236.00',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: themeColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
