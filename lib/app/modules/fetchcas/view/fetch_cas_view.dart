import 'dart:convert';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/constant.dart';
import 'package:customer/app/interface/navigate_interface.dart';
import 'package:customer/app/modules/authentication/model/pledge_docs_response.dart';
import 'package:customer/app/modules/authentication/view/authentication_cams_view.dart';
import 'package:customer/app/modules/authentication/view/authentication_view.dart';
import 'package:customer/app/modules/authentication/view/loan_authentication_view.dart';
import 'package:customer/app/modules/bank/view/bank_detail_view.dart';
import 'package:customer/app/modules/bank/view/bank_mandate_view.dart';
import 'package:customer/app/modules/bank/view/physical_mandate_view.dart';
import 'package:customer/app/modules/dashboard/model/EventModel.dart';
import 'package:customer/app/modules/emi/view/know_emi_view.dart';
import 'package:customer/app/modules/fetchcas/model/request_cas_response.dart';
import 'package:customer/app/modules/fetchcas/view/fetch_cas_view1.dart';
import 'package:customer/app/modules/fetchcas/view/fetch_cas_view2.dart';
import 'package:customer/app/modules/fetchcas/viewmodel/fetch_cas_controller.dart';
import 'package:customer/app/modules/fetchcas/viewmodel/fetch_cas_viewmodel.dart';
import 'package:customer/app/modules/kyc/model/applicant_list_response.dart';
import 'package:customer/app/modules/kyc/view/kyc_details_view.dart';
import 'package:customer/app/modules/kyc/view/live_photo_view.dart';
import 'package:customer/app/modules/otp/view/otp_view.dart';
import 'package:customer/app/modules/security/view/security_selection_view.dart';
import 'package:customer/app/modules/summary/view/loan_summary_view.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bank/view/e_mandate_view.dart';

class FetchCasView extends StatefulWidget {
  const FetchCasView({Key? key}) : super(key: key);

  @override
  FetchCasViewState createState() => FetchCasViewState();
}

class FetchCasViewState extends NavigationInterface {
  int _selectedIndex = 0;
  int _kycIndex = 0;
  var isLivePhoto = 0;
  dynamic arguments = Get.arguments;
  double loanAmount = 0;
  int tenureAmount = 0;
  bool isTnCKYE = false;
  final FetchCasController fetchCasController = FetchCasController();
  late FetchCasViewModel _service;

  SharedPreferences? prefs;

  @override
  onNext() {
    nextClick();
    return super.onNext();
  }

  @override
  onBack() {
    backClick();
    return super.onBack();
  }

  @override
  void initState() {
    super.initState();
    _service = FetchCasViewModel(context);
    initData();
    if (arguments != null && arguments is Map<String, dynamic>) {
      if (arguments.containsKey('page')) {
        _selectedIndex = arguments['page'];
      }
      if (arguments.containsKey('kycIndex')) {
        _kycIndex = arguments['kycIndex'];
      }
    }
    Constant.eventBus.on<FetchSubmitEvent>().listen((event) {
      nextClick();
    });
    Constant.eventBus.on<PageChangeEvent>().listen((event) {
      if (event.page == 4) {
        var applicantDetail = ApplicantDetail.fromJson(
            jsonDecode(prefs?.getString("applicant_data") ?? ""));
        if (applicantDetail.photoVerification == "Y") {
          isLivePhoto = 1;
        }
      }
      setState(() {
        _selectedIndex = event.page;
      });
    });
    Constant.eventBus.on<KycPageChangeEvent>().listen((event) {
      setState(() {
        _kycIndex = event.page;
      });
    });
    Constant.eventBus.on<EmiValueChanges>().listen((event) {
      loanAmount = event.loanAmount;
      tenureAmount = event.tenureAmount;
      isTnCKYE = event.isPrivacy;
    });
    Constant.eventBus.on<AddMoreSecurity>().listen((event) {
      _showAddMoreSecuritiesPopup(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          backClick();
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: themeColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: whiteColor, //change your color here
          ),
          title: Text(
            _selectedIndex == 0
                ? "Fetch & Share CAS"
                : _selectedIndex == 1
                    ? "Fetch & Share CAS"
                    : _selectedIndex == 2
                        ? "Know your EMI"
                        : _selectedIndex == 3
                            ? "Your KYC details"
                            : _selectedIndex == 4
                                ? "Live Photo"
                                : _selectedIndex == 5
                                    ? "Bank Details"
                                    : _selectedIndex == 6
                                        ? "Security Selection"
                                        : _selectedIndex == 7
                                            ? "Loan Summary"
                                            : _selectedIndex == 8
                                                ? "Authentication"
                                                : _selectedIndex == 9
                                                    ? "Authentication"
                                                    : _selectedIndex == 10
                                                        ? "Authentication"
                                                        : _selectedIndex == 11
                                                            ? "Loan Form Authentication"
                                                            : _selectedIndex ==
                                                                    12
                                                                ? "Bank Mandate for Loan"
                                                                : _selectedIndex ==
                                                                        13
                                                                    ? "E Mandate"
                                                                    : "Physical Mandate",
            style: TextStyle(color: whiteColor),
          ),
        ),
        body: _selectedIndex == 0
            ? FetchCasView1()  ///FetchCasView1()
            : _selectedIndex == 1
                ? FetchCasView2(fetchCasController)
                : _selectedIndex == 2
                    ? const KnowEMIView()
                    : _selectedIndex == 3
                        ? KycDetailView(_kycIndex, fetchCasController)
                        : _selectedIndex == 4
                            ? LivePhotoView(this, isLivePhoto)
                            : _selectedIndex == 5
                                ? BankDetailView(fetchCasController)
                                : _selectedIndex == 6
                                    ? SecuritySelectionView(fetchCasController)
                                    : _selectedIndex == 7
                                        ? const LoanSummaryView()
                                        : _selectedIndex == 8
                                            ? const AuthenticationView()
                                            : _selectedIndex == 9
                                                ? OtpView(fetchCasController)
                                                : _selectedIndex == 10
                                                    ?  AuthenticationCamsView(fetchCasController)
                                                    : _selectedIndex == 11
                                                        ? const LoanAuthenticationView()
                                                        : _selectedIndex == 12
                                                            ? const BankMandateView()
                                                            : _selectedIndex == 13
                                                                ? const EMandateView()
                                                                : const PhysicalMandateView(),
        bottomNavigationBar: Stack(
          children: [
            Visibility(
              visible: _selectedIndex != 4,
              child: Container(
                color: boxBackColor,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    Visibility(
                      visible: _selectedIndex == 10,
                      child: Expanded(
                        child: GestureDetector(
                          onTap: () {
                            /*setState(() {
                              _selectedIndex = 6;
                            });*/
                            fetchCasController.methodB(0);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                LocaleKeys.ic_fetch_back,
                                width: 26.w,
                                height: 26.w,
                              ),
                              Text(
                                "RETRY",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 12.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _selectedIndex != 9 && _selectedIndex != 10,
                      child: Expanded(
                        child: GestureDetector(
                          onTap: () {
                            backClick();
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                LocaleKeys.ic_fetch_back,
                                width: 26.w,
                                height: 26.w,
                              ),
                              Text(
                                "BACK",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 12.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _selectedIndex != 8 &&
                          _selectedIndex != 9 &&
                          _selectedIndex != 10 &&
                          _selectedIndex != 12,
                      child: Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              LocaleKeys.ic_fetch_reset,
                              width: 26.w,
                              height: 26.w,
                            ),
                            Text(
                              "RESET",
                              style: TextStyle(
                                color: blackColor,
                                fontSize: 12.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _showCancelPopup(context);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              LocaleKeys.ic_fetch_cancel,
                              width: 26.w,
                              height: 26.w,
                            ),
                            Text(
                              "CANCEL",
                              style: TextStyle(
                                color: blackColor,
                                fontSize: 12.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _selectedIndex != 8 && _selectedIndex != 10 && _selectedIndex != 12,
                      child: Expanded(
                        child: GestureDetector(
                          onTap: () {
                            nextClick();
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                LocaleKeys.ic_fetch_next,
                                width: 26.w,
                                height: 26.w,
                              ),
                              Text(
                                _selectedIndex != 9 ? "NEXT" : "SUBMIT",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 12.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: false,
              child: Container(
                color: boxBackColor,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              LocaleKeys.ic_proceed_same,
                              width: 26.w,
                              height: 26.w,
                            ),
                            Text(
                              "PROCEED WITH SAME",
                              style: TextStyle(
                                color: blackColor,
                                fontSize: 12.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          nextClick();
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.CKYC_VIEW);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              LocaleKeys.ic_update_kyc,
                              width: 26.w,
                              height: 26.w,
                            ),
                            Text(
                              "UPDATE KYC",
                              style: TextStyle(
                                color: blackColor,
                                fontSize: 12.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showFetchPopup(
      BuildContext context, RequestCasResponse? requestCas) async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              color: whiteColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Image.asset(
                    LocaleKeys.ic_correct_image,
                    height: 60.w,
                    width: 60.w,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "You will receive a mail from",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "cas@njgroup.in",
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 14.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "The password of the statement is",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "NJC@1234",
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 14.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                            setState(() {
                              _selectedIndex += 1;
                            });
                          },
                          child: Container(
                            height: 30.h,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "SUBMIT",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 14.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<bool?> _showCancelPopup(BuildContext context) async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              color: whiteColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Are you sure, you want to cancel this request?",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 30.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "NO",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.back();
                        },
                        child: Container(
                          height: 30.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "YES",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<bool?> _showAddMoreSecuritiesPopup(BuildContext context) async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              color: whiteColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Add more Securities?",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 14.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Are you sure, you want to add more securities?",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 30.h,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: unselectTab,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 14.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                            setState(() {
                              _selectedIndex = 1;
                            });
                          },
                          child: Container(
                            height: 30.h,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 14.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<bool?> _showKFINPopup(BuildContext context) async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.r,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Your pledge request with KFIN has failed.",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 14.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Possible reasons could be,",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "  ○ Incorrect Email/Mobile entered for KFIN",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 11.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "  ○ Some Units/Folios may already be pledged",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 11.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "  ○ Securities already redeemed or redemption order is placed",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 11.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "  ○ Multiple holders mapped against any Folio",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 11.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Please modify your security selection and resubmit the pledge request.",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 9.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                            setState(() {
                              _selectedIndex += 1;
                            });
                          },
                          child: Container(
                            height: 30.h,
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "MODIFY SECURITY SELECTION",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 12.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          setState(() {});
                        },
                        child: Container(
                          height: 30.h,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "CANCEL",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 12.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<bool?> _showCAMSPopup(BuildContext context) async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.r,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Your pledge request with CAMS has failed.",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 14.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Possible reasons could be,",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "  ○ Incorrect Email/Mobile entered for CAMS",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 11.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "  ○ Some units/Folios may already be pledged",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 11.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "  ○ Securities already redeemed or redemption order is placed",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 11.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "  ○ Multiple holders mapped against any Folio",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 11.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Please modify your security selection and resubmit the pledge request.",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 9.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                            setState(() {
                              _selectedIndex += 1;
                            });
                          },
                          child: Container(
                            height: 30.h,
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "MODIFY SECURITY SELECTION",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 12.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          setState(() {});
                        },
                        child: Container(
                          height: 30.h,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "CANCEL",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 12.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void nextClick() async {
    if (_selectedIndex == 0) {
      getData();
    } else if (_selectedIndex == 1) {
      var result = await fetchCasController.methodA(0);
      if (result) {
        processFetchFile();
      }
    } else if (_selectedIndex == 2) {
      if (isTnCKYE) {
        saveEmiDetails();
      } else {
        Fluttertoast.showToast(
            msg: "Please allow privacy policy!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else if (_selectedIndex == 3) {
      if (_kycIndex == 0 || _kycIndex == 1 || _kycIndex == 2) {
        var result = await fetchCasController.methodA(_kycIndex);
        if (result) {
          setState(() {
            _kycIndex += 1;
          });
        }
      } else if (_kycIndex == 3) {
        var result = await fetchCasController.methodA(_kycIndex);
      }
    } else if (_selectedIndex == 4) {
      if (isLivePhoto != 1) {
        setState(() {
          isLivePhoto += 1;
        });
      } else {
        setState(() {
          _selectedIndex += 1;
        });
      }
    } else if (_selectedIndex == 5) {
      var result = await fetchCasController.methodA(0);
      if (result) {
        setState(() {
          _selectedIndex = 6;
        });
      }
    } else if (_selectedIndex == 6) {
      var result = await fetchCasController.methodA(0);
      if (result) {
        _showKFINPopup(context);
      }
    } else if (_selectedIndex == 7) {
      showLoanConfirmDialog();
    } else if (_selectedIndex == 9) {
      await fetchCasController.methodA(0);
      /*setState(() {
        _selectedIndex = 11;
      });*/
    } else {
      if (_selectedIndex != 12) {
        setState(() {
          _selectedIndex += 1;
        });
      }
    }
  }

  void backClick() {
    print(_selectedIndex);
    if (_selectedIndex == 3) {
      if (_kycIndex != 0) {
        setState(() {
          _kycIndex -= 1;
        });
      } else {
        setState(() {
          _selectedIndex -= 1;
        });
      }
    } else if (_selectedIndex == 4) {
      if (isLivePhoto != 0) {
        var applicantDetail = ApplicantDetail.fromJson(
            jsonDecode(prefs?.getString("applicant_data") ?? ""));
        if (applicantDetail.photoVerification == "Y") {
          setState(() {
            _kycIndex = 3;
            _selectedIndex -= 1;
          });
        } else {
          setState(() {
            isLivePhoto -= 1;
          });
        }
      } else {
        setState(() {
          _kycIndex = 3;
          _selectedIndex -= 1;
        });
      }
    } else if (_selectedIndex == 5) {
      var applicantDetail = ApplicantDetail.fromJson(
          jsonDecode(prefs?.getString("applicant_data") ?? ""));
      if (applicantDetail.photoVerification == "Y") {
        setState(() {
          isLivePhoto = 1;
          _selectedIndex -= 1;
        });
      } else {
        setState(() {
          isLivePhoto = 0;
          _selectedIndex -= 1;
        });
      }
    } else if (_selectedIndex == 10) {
      var applicantDetail = PledgeDocsData.fromJson(
          jsonDecode(prefs?.getString("user_auth") ?? ""));
      if (applicantDetail.ESP_KFIN == "Done") {
        setState(() {
          _selectedIndex = 8;
        });
      } else if (applicantDetail.ESP_KFIN != "Done") {
        setState(() {
          _selectedIndex = 9;
        });
      }
    } else if (_selectedIndex == 11) {
      /*  var applicantDetail = PledgeDocsData.fromJson(
          jsonDecode(prefs?.getString("user_auth") ?? ""));
      if (applicantDetail.ESP_KFIN == "Done") {
        setState(() {
          _selectedIndex = 8;
        });
      } else {
        setState(() {
          _selectedIndex = 9;
        });
      }*/
      var applicantDetail = PledgeDocsData.fromJson(
          jsonDecode(prefs?.getString("user_auth") ?? ""));
      if (applicantDetail.ESP_KFIN == "Done" && applicantDetail.ESP_CAMS == "Done") {
        setState(() {
          _selectedIndex = 8;
        });
      } else if (applicantDetail.ESP_KFIN == "Done" && applicantDetail.ESP_CAMS != "Done") {
        setState(() {
          _selectedIndex = 10;
        });
      } else if (applicantDetail.ESP_KFIN != "Done" && applicantDetail.ESP_CAMS != "Done") {
        setState(() {
          _selectedIndex = 9;
        });
      }
    } else if (_selectedIndex == 12) {
      var applicantDetail = PledgeDocsData.fromJson(
          jsonDecode(prefs?.getString("user_auth") ?? ""));
      if (applicantDetail.ESP_KFIN == "Done" && applicantDetail.ESP_CAMS == "Done" && applicantDetail.ESA == "Done") {
        setState(() {
          _selectedIndex = 8;
        });
      } else if (applicantDetail.ESP_KFIN == "Done" && applicantDetail.ESP_CAMS == "Done" && applicantDetail.ESA != "Done") {
        setState(() {
          _selectedIndex = 11;
        });
      } else if (applicantDetail.ESP_KFIN == "Done" &&
          applicantDetail.ESP_CAMS != "Done" &&
          applicantDetail.ESA != "Done") {
        setState(() {
          _selectedIndex = 10;
        });
      } else if (applicantDetail.ESP_KFIN != "Done" &&
          applicantDetail.ESP_CAMS != "Done" &&
          applicantDetail.ESA != "Done") {
        setState(() {
          _selectedIndex = 9;
        });
      }
    } else if (_selectedIndex == 14) {
      setState(() {
        _selectedIndex = 12;
      });
    } else {
      if (_selectedIndex != 0) {
        setState(() {
          _selectedIndex -= 1;
        });
      }
    }
  }

  void getData() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.requestCas();
      if (requestCas?.code == 200) {
        _showFetchPopup(context, requestCas);
      }
    }
  }

  void processFetchFile() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.processCas();
      if (requestCas?.code == 200) {
        Fluttertoast.showToast(
            msg: requestCas?.message ?? "",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          _selectedIndex = 2;
        });
      }
    }
  }

  void saveEmiDetails() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.saveEmis(loanAmount, tenureAmount);
      if (requestCas?.code == 200) {
        setState(() {
          _selectedIndex = 3;
        });
      }
    }
  }

  void initData() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool?> showLoanConfirmDialog() async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              color: whiteColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Alert",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 14.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Are you sure you want to submit Loan Request for Term Loan?",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 30.h,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: unselectTab,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "No",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 14.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            Get.back();
                            if (ConnectivityUtils.instance.hasInternet) {
                              var result = await _service.loanSanction();
                              if (result?.code == 200) {
                                showLoanSuccessDialog(
                                    result?.body?.requestNumber ?? "");
                              }
                            }
                          },
                          child: Container(
                            height: 30.h,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 14.sp,
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<bool?> showLoanSuccessDialog(String requestNumber) async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              color: whiteColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "Please proceed for Term sheet and Pledge authorization",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 14.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Your loan request has been placed successfully, Your Loan request Ref. No. is $requestNumber. The loan status will be updated shortly.",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Get.back();
                          setState(() {
                            _selectedIndex = 8;
                          });
                        },
                        child: Container(
                          height: 30.h,
                          width: 120.w,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Ok",
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
