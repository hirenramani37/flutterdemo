import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RequestView extends StatefulWidget {
  const RequestView({Key? key}) : super(key: key);

  @override
  _RequestViewState createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
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
          "Request",
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Card(
              child: ListTile(
                leading: Image.asset(
                  LocaleKeys.ic_bottom_report,
                  width: 24.w,
                  height: 24.h,
                  color: blackColor,
                ),
                title: const Text("Statement of Accounts"),
                onTap: () {
                  Get.toNamed(Routes.STATEMENT_ACCOUNT);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Card(
              child: ListTile(
                leading: Image.asset(
                  LocaleKeys.ic_bottom_service,
                  width: 24.w,
                  height: 24.h,
                  color: blackColor,
                ),
                title: const Text("Interim Valuation Report"),
                onTap: () {
                  Get.toNamed(Routes.INTERIM_VALUATION);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Card(
              child: ListTile(
                leading: Image.asset(
                  LocaleKeys.ic_report_emi,
                  width: 24.w,
                  height: 24.h,
                  color: blackColor,
                ),
                title: const Text("Repayment Schedule"),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Card(
              child: ListTile(
                leading: Image.asset(
                  LocaleKeys.ic_report_emi,
                  width: 24.w,
                  height: 24.h,
                  color: blackColor,
                ),
                title: const Text("Interest Certificate"),
                onTap: () {
                  Get.toNamed(Routes.INTEREST_CERTIFICATE);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Card(
              child: ListTile(
                leading: Image.asset(
                  LocaleKeys.ic_bottom_service,
                  width: 24.w,
                  height: 24.h,
                  color: blackColor,
                ),
                title: const Text("NOC"),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
