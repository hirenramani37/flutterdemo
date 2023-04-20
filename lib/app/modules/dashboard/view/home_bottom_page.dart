import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
  }

  final List<ChartData> chartData = [
    ChartData('₹ 30,000', 50, chart1Color),
    ChartData('₹ 15,000', 50, chart2Color)
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Existing Relations with us",
                    style: TextStyle(
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w700,
                        color: blackColor,
                        fontSize: 12.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  height: 200.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(color: borderColor, width: 1),
                        ),
                        margin: EdgeInsets.only(left: 16.w),
                        width: 240.w,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10.h, left: 16.w),
                                    width: Get.width,
                                    child: Text(
                                      "LAN - 458752",
                                      style: TextStyle(
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w700,
                                          color: blackColor,
                                          fontSize: 10.sp),
                                    ),
                                  ),
                                  Container(
                                    color: borderColor,
                                    height: 1,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 5.h,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 120.w,
                                        height: 140.w,
                                        child: SfCircularChart(
                                          series: [
                                            DoughnutSeries<ChartData, String>(
                                              dataSource: chartData,
                                              pointColorMapper:
                                                  (ChartData data, _) =>
                                                      data.color,
                                              xValueMapper:
                                                  (ChartData data, _) => data.x,
                                              yValueMapper:
                                                  (ChartData data, _) => data.y,
                                              radius: "55",
                                              innerRadius: "40",
                                              startAngle: -90,
                                              endAngle: -90,
                                              dataLabelSettings:
                                                  const DataLabelSettings(
                                                isVisible: true,
                                                labelPosition:
                                                    ChartDataLabelPosition
                                                        .outside,
                                              ),
                                              /*dataLabelSettings: const DataLabelSettings(
                                                isVisible: true,
                                              ),*/
                                              // name: 'Data'
                                            ),
                                          ],
                                          borderWidth: 1,
                                          margin: EdgeInsets.zero,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  color: blackColor,
                                                  height: 16.w,
                                                  width: 16.w,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Text(
                                                  "EMI Amount - 2000",
                                                  style: TextStyle(
                                                      fontFamily: LocaleKeys
                                                          .font_family,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: blackColor,
                                                      fontSize: 8.sp),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  color: chart1Color,
                                                  height: 16.w,
                                                  width: 16.w,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Text(
                                                  "LoanAmount",
                                                  style: TextStyle(
                                                      fontFamily: LocaleKeys
                                                          .font_family,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: blackColor,
                                                      fontSize: 8.sp),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  color: chart2Color,
                                                  height: 16.w,
                                                  width: 16.w,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Text(
                                                  "Outstanding Amount",
                                                  style: TextStyle(
                                                      fontFamily: LocaleKeys
                                                          .font_family,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: blackColor,
                                                      fontSize: 8.sp),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Html(
                                    data:
                                        "<B>ROI:</B> 0% | <B>Loan Start Date:</B> 30-01-2022 | <B>Tenure:</B> 18 Years",
                                    shrinkWrap: true,
                                    style: {
                                      '#': Style(
                                        fontSize: FontSize(8.sp),
                                      ),
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Loan Products",
                    style: TextStyle(
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w700,
                        color: blackColor,
                        fontSize: 12.sp),
                  ),
                ),
                Container(
                    height: 90.h,
                    margin: EdgeInsets.only(top: 10.h),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(color: borderColor, width: 1),
                          ),
                          margin: EdgeInsets.only(left: 16.w),
                          width: 140.w,
                          height: 90.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                LocaleKeys.ic_loan_against,
                                width: 70,
                                height: 70,
                              ),
                              Text(
                                "Loan Against Securities",
                                style: TextStyle(
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w500,
                                    color: blackColor,
                                    fontSize: 10.sp),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(color: borderColor, width: 1),
                          ),
                          width: 140.w,
                          height: 90.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                LocaleKeys.ic_home_loan,
                                width: 70,
                                height: 70,
                              ),
                              Text(
                                "Home Loan",
                                style: TextStyle(
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w500,
                                    color: blackColor,
                                    fontSize: 10.sp),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(color: borderColor, width: 1),
                          ),
                          margin: EdgeInsets.only(right: 16.w),
                          width: 140.w,
                          height: 90.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                LocaleKeys.ic_personal_loan,
                                width: 70,
                                height: 70,
                              ),
                              Text(
                                "Personal Loan",
                                style: TextStyle(
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w500,
                                    color: blackColor,
                                    fontSize: 10.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Brand @ EMI Store",
                    style: TextStyle(
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w700,
                        color: blackColor,
                        fontSize: 12.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  height: 50.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            left: index == 0 ? 16.w : 5.w,
                            right: index == 9 ? 16.w : 5.w),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(color: borderColor, width: 1),
                        ),
                        width: 110.w,
                        child: Image.asset(LocaleKeys.ic_dummy_brand),
                      );
                    },
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

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color? color;
}
