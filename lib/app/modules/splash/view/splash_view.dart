import 'dart:async';

import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    checkIsLogin();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                LocaleKeys.ic_app_icon,
                width: 140.w,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 6.h, 0, 0),
                child: Text(
                  LocaleKeys.app_name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkIsLogin() async {
    final prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool("isLogin");
    Timer(
        const Duration(seconds: 3),
        () => {
              if (isLogin == null)
                {Get.offNamed(Routes.LOGIN)}
              else if (isLogin)
                {Get.offNamed(Routes.DASHBOARD)}
              else
                {Get.offNamed(Routes.LOGIN)}
            });
  }
}
