import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServicePaymentView extends StatefulWidget {
  const ServicePaymentView({Key? key}) : super(key: key);

  @override
  _ServicePaymentViewState createState() => _ServicePaymentViewState();
}

class _ServicePaymentViewState extends State<ServicePaymentView> {
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
          "Payment",
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
                title: const Text("Overdue EMI"),
                onTap: () {
                  Get.toNamed(Routes.OVERDUE_VIEW);
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
                title: const Text("Margin Shortfall"),
                onTap: () {
                  Get.toNamed(Routes.MARGIN_SHORTFALL);
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
                title: const Text("EMI Payment"),
                onTap: () {
                  Get.toNamed(Routes.EMI_PAYMENT);
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
                title: const Text("Foreclosure of Loan"),
                onTap: () {
                  Get.toNamed(Routes.FORECLOSUER_LOAN);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
