import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StatementAccountView extends StatefulWidget {
  const StatementAccountView({Key? key}) : super(key: key);

  @override
  _StatementAccountViewState createState() => _StatementAccountViewState();
}

class _StatementAccountViewState extends State<StatementAccountView> {
  List<bool> selectionItems = [false, false];

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
          "Statement of Account",
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: Column(
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
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: selectionItems.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.h,right: 16.w),
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 2.h),
                      color: applicantBack,
                      child: Text(
                        "Interest : 12%",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 12.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: dividerColor,
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 20.h,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "LAN",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: unselectTab,
                                            fontFamily: LocaleKeys.font_family,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Text(
                                          "3134",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: blackColor,
                                            fontFamily: LocaleKeys.font_family,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Loan Amount",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: unselectTab,
                                            fontFamily: LocaleKeys.font_family,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Text(
                                          "50,000",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: blackColor,
                                            fontFamily: LocaleKeys.font_family,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14.h,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tenure",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: unselectTab,
                                            fontFamily: LocaleKeys.font_family,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "6 months",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: blackColor,
                                            fontFamily: LocaleKeys.font_family,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Start Date",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: unselectTab,
                                            fontFamily: LocaleKeys.font_family,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "20-01-2022",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: blackColor,
                                            fontFamily: LocaleKeys.font_family,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 10.w),
                            child: Checkbox(
                              value: selectionItems[index],
                              onChanged: (value) {
                                setState(() {
                                  selectionItems[index] = value ?? false;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
              },
              child: Container(
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Download",
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
    );
  }
}
