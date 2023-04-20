import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportPageView extends StatefulWidget {
  const ReportPageView({Key? key}) : super(key: key);

  @override
  _ReportPageViewState createState() => _ReportPageViewState();
}

class _ReportPageViewState extends State<ReportPageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          SizedBox(height: 16.h,),
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
                title: const Text("Loan Status Report"),
                onTap: () {},
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
                title: const Text("Request"),
                onTap: () {
                  Get.toNamed(Routes.REQUEST_VIEW);
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
                title: const Text("EMI Calculator"),
                onTap: () {
                  Get.toNamed(Routes.EMI_CALCULATOR);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
