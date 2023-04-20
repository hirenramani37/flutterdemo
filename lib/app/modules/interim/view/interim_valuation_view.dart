import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InterimValuationView extends StatefulWidget {
  const InterimValuationView({Key? key}) : super(key: key);

  @override
  _InterimValuationViewState createState() => _InterimValuationViewState();
}

class _InterimValuationViewState extends State<InterimValuationView> {
  String? docValue;
  List<String> docList = [
    "Doc 1",
    "Doc 2",
    "Doc 3"
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
          "Interim Valuation Report",
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
              child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Product",
                  style: TextStyle(
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                      color: unselectTab,
                      fontSize: 12.sp),
                ),
                SizedBox(
                  height: 8.h,
                ),
                DropdownButtonFormField<String>(
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
              ],
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {},
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
