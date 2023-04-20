import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/constant.dart';
import 'package:customer/app/modules/dashboard/model/EventModel.dart';
import 'package:customer/app/modules/dashboard/view/home_bottom_page.dart';
import 'package:customer/app/modules/dashboard/view/loan_bottom_page.dart';
import 'package:customer/app/modules/dashboard/view/report_bottom_page.dart';
import 'package:customer/app/modules/dashboard/view/service_bottom_page.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;
  final pages = [
    const HomePageView(),
    const LoanPageView(),
    const ReportPageView(),
    const ServicePageView(),
  ];

  final titles = ["Home", "Loan", "Report", "Service"];

  @override
  void initState() {
    super.initState();
    Constant.title = "Home";
    Constant.eventBus.on<TitleEvent>().listen((event) {
      setState(() {
        Constant.title = event.title;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: themeColor,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () => Constant.key.currentState!.openDrawer(),
        ),
        title: _selectedIndex == 0
            ? Image.asset(
                LocaleKeys.ic_app_icon,
                width: 100.w,
              )
            : Text(/*titles[_selectedIndex]*/Constant.title),
        actions: [
          Visibility(
            visible: _selectedIndex == 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: applyBtn,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    "APPLY FOR LOAN",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 10.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _selectedIndex == 0,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.w),
              width: 24,
              padding: const EdgeInsets.all(4),
              height: 24,
              child: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  LocaleKeys.ic_notification,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Scaffold(
          key: Constant.key,
          drawer: Drawer(
            child: SafeArea(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  ListTile(
                    leading: Image.asset(
                      LocaleKeys.ic_nav_profile,
                      width: 24.w,
                      height: 24.h,
                      color: blackColor,
                    ),
                    title: const Text("PROFILE"),
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(Routes.PROFILE);
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      LocaleKeys.ic_nav_loan,
                      width: 24.w,
                      height: 24.h,
                      color: blackColor,
                    ),
                    title: const Text("APPLY FOR LOAN"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      LocaleKeys.ic_nav_service,
                      width: 24.w,
                      height: 24.h,
                      color: blackColor,
                    ),
                    title: const Text("SERVICE"),
                    onTap: () {
                      Navigator.pop(context);
                      _onItemTapped(3);
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      LocaleKeys.ic_nav_report,
                      width: 24.w,
                      height: 24.h,
                      color: blackColor,
                    ),
                    title: const Text("REPORTS"),
                    onTap: () {
                      Navigator.pop(context);
                      _onItemTapped(2);
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      LocaleKeys.ic_nav_setting,
                      width: 24.w,
                      height: 24.h,
                      color: blackColor,
                    ),
                    title: const Text("SETTING"),
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(Routes.SETTING);
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      LocaleKeys.ic_nav_help,
                      width: 24.w,
                      height: 24.h,
                      color: blackColor,
                    ),
                    title: const Text("HELP & SUPPORT"),
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(Routes.HELP);
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      LocaleKeys.ic_nav_logout,
                      width: 24.w,
                      height: 24.h,
                      color: blackColor,
                    ),
                    title: const Text("LOGOUT"),
                    onTap: () {
                      Get.offAllNamed(Routes.LOGIN);
                    },
                  ),
                ],
              ),
            ),
          ),
          body: pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  LocaleKeys.ic_bottom_home_in,
                  width: 26.w,
                  height: 26.w,
                ),
                activeIcon: Image.asset(
                  LocaleKeys.ic_bottom_home,
                  width: 26.w,
                  height: 26.w,
                ),
                label: 'HOME',
                backgroundColor: whiteColor,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  LocaleKeys.ic_bottom_loan_in,
                  width: 26.w,
                  height: 26.w,
                ),
                activeIcon: Image.asset(
                  LocaleKeys.ic_bottom_loan,
                  width: 26.w,
                  height: 26.w,
                ),
                label: 'LOAN',
                backgroundColor: whiteColor,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  LocaleKeys.ic_bottom_report_in,
                  width: 26.w,
                  height: 26.w,
                ),
                activeIcon: Image.asset(
                  LocaleKeys.ic_bottom_report,
                  width: 26.w,
                  height: 26.w,
                ),
                label: 'REPORT',
                backgroundColor: whiteColor,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  LocaleKeys.ic_bottom_service_in,
                  width: 26.w,
                  height: 26.w,
                ),
                activeIcon: Image.asset(
                  LocaleKeys.ic_bottom_service,
                  width: 26.w,
                  height: 26.w,
                ),
                label: 'SERVICE',
                backgroundColor: whiteColor,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: themeColor,
            unselectedItemColor: blackColor,
            showUnselectedLabels: true,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Constant.title = titles[_selectedIndex];
    });
  }
}
