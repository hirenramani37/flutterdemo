import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServicePageView extends StatefulWidget {
  const ServicePageView({Key? key}) : super(key: key);

  @override
  _ServicePageViewState createState() => _ServicePageViewState();
}

class _ServicePageViewState extends State<ServicePageView> {
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
                title: const Text("Payments"),
                onTap: () {
                  Get.toNamed(Routes.SERVICE_PAYMENT);
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
                title: const Text("Unpledge Request"),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Card(
              child: ListTile(
                leading: Image.asset(
                  LocaleKeys.ic_service_mandate,
                  width: 24.w,
                  height: 24.h,
                  color: blackColor,
                ),
                title: const Text("Mandate Management"),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Card(
              child: ListTile(
                leading: Image.asset(
                  LocaleKeys.ic_service_query,
                  width: 24.w,
                  height: 24.h,
                  color: blackColor,
                ),
                title: const Text("Post a Query"),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
