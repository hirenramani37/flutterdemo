import 'dart:convert';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/common.dart';
import 'package:customer/app/constant/constant.dart';
import 'package:customer/app/constant/locale_utils.dart';
import 'package:customer/app/modules/dashboard/model/EventModel.dart';
import 'package:customer/app/modules/fetchcas/viewmodel/fetch_cas_controller.dart';
import 'package:customer/app/modules/login/model/user_decrypt_model.dart';
import 'package:customer/app/modules/security/model/fetch_security_response.dart';
import 'package:customer/app/modules/security/viewmodel/security_viewmodel.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecuritySelectionView extends StatefulWidget {
  final FetchCasController? controller;

  const SecuritySelectionView(this.controller, {Key? key}) : super(key: key);

  @override
  _SecuritySelectionViewState createState() =>
      _SecuritySelectionViewState(controller!);
}

class _SecuritySelectionViewState extends State<SecuritySelectionView> {
  bool isSelectAll = false;
  bool isDisableAll = false;
  List<SecurityData> securityList = [];
  FetchSecurityBody? fetchSecurityBody;
  UserDecryptData? userData;

  bool isTnC = false;

  late SecurityViewModel _service;

  _SecuritySelectionViewState(FetchCasController _controller) {
    _controller.methodA = methodA;
  }

  Future<bool> methodA(int index) async {
    var tempTotal = securityList.where((element) => element.selected).toList();
    var tempSelectedUnit = tempTotal
        .where((element) => element.selectedUnits.toString().isEmpty || (element.selectedUnits ?? 0.0) <= 0.0).toList();
    if (tempTotal.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please select the securities.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    } else if (tempSelectedUnit.isNotEmpty) {
      Fluttertoast.showToast(
          msg: "Please selected securities into enter units.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    } else if (!isTnC) {
      Fluttertoast.showToast(
          msg: "Please select the securities.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    } else {
      _showConfirmationPopup(context);
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _service = SecurityViewModel(context);
    getData();
    getSecurityData();
  }

  @override
  Widget build(BuildContext context) {
    var tempTotal = securityList
        .where((element) => element.selected)
        .toList()
        .map((e) => ((e.selectedUnits ?? 0) * (e.amountPerUnit ?? 0)))
        .toList();
    var selectSecurity =
        tempTotal.isNotEmpty ? tempTotal.reduce((a, b) => a + b) : 0;

    var tempEligible = securityList
        .where((element) => element.selected)
        .toList()
        .map((e) => ((((e.selectedUnits ?? 0) * (e.amountPerUnit ?? 0)) *
                (e.ltvPer ?? 0)) /
            100))
        .toList();
    var eligibleLoanAmount =
        tempEligible.isNotEmpty ? tempEligible.reduce((a, b) => a + b) : 0;

    ScreenUtil.init(context);
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isSelectAll,
                      onChanged: isDisableAll
                          ? null
                          : (value) {
                              for (var e in securityList) {
                                if (!(e.disabled ?? false)) {
                                  e.selected = value ?? false;
                                }
                              }
                              setState(() {
                                securityList = securityList;
                                isSelectAll = value ?? false;
                              });
                            },
                    ),
                    Text(
                      "Select All",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14.sp,
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Applied Loan Amount : ",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12.sp,
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      moneyFormatWithoutDecimal(
                          fetchSecurityBody?.appliedLoanAmount ?? 0),
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12.sp,
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: securityList.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 5.h,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Folio No",
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
                                    securityList[index].folioNo ?? "",
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
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Registrar Transfer Agents",
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
                                      securityList[index].rta ?? "",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Scheme Name",
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
                                      securityList[index].securityName ?? "",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Current Value",
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
                                      moneyFormatWithoutDecimal(
                                          securityList[index].total ?? 0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Available Units",
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
                                      moneyFormatWithoutSign(
                                          securityList[index].units ?? 0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Lien Units",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: unselectTab,
                                        fontFamily: LocaleKeys.font_family,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    TextField(
                                      controller: securityList[index]
                                          .selectedUnitsController /* TextEditingController(
                                          text:
                                              "${securityList[index].selectedUnits?.toInt()}")*/
                                      ,
                                      readOnly: (securityList[index].disabled ?? false) || (!securityList[index].selected),
                                      onChanged: (value) {
                                        var unit = value.isEmpty
                                            ? 0.0
                                            : double.parse(value);
                                        var avUnit =
                                            securityList[index].units ?? 0;
                                        if (avUnit >= unit) {
                                          setState(() {
                                            securityList[index].selectedUnits = unit;
                                            print("${securityList[index].selectedUnits}");
                                          });
                                        } else {
                                          securityList[index]
                                              .selectedUnitsController
                                              ?.value = TextEditingValue(
                                            text: securityList[index]
                                                    .selectedUnits
                                                    ?.toInt()
                                                    .toString() ??
                                                "",
                                            selection:
                                                TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: securityList[index]
                                                      .selectedUnitsController!
                                                      .value
                                                      .selection
                                                      .baseOffset),
                                            ),
                                          );
                                        }
                                      },
                                      inputFormatters: [
                                        DecimalTextInputFormatter(
                                            decimalRange: 3)
                                      ],
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: themeColor),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: hintColor),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: hintColor),
                                          ),
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 3.h, horizontal: 8.w)),
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
                          value: securityList[index].selected,
                          onChanged: securityList[index].disabled ?? false
                              ? null
                              : (value) {
                                  setState(() {
                                    securityList[index].selected =
                                        value ?? false;
                                  });
                                },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: dividerColor,
                        width: 1,
                      ),
                    ),
                    height: 70.h,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Selected Securities Total",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          moneyFormatWithoutDecimal(selectSecurity ?? 0),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w800,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Container(
                    height: 70.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: dividerColor,
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Eligible Loan amount",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          moneyFormatWithoutDecimal(eligibleLoanAmount),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w800,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: dividerColor,
                        width: 1,
                      ),
                    ),
                    height: 70.h,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Existing available limit",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          moneyFormatWithoutDecimal(
                              fetchSecurityBody?.existingLimit ?? 0),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w800,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Container(
                    height: 70.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: dividerColor,
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Total eligibility",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          moneyFormatWithoutDecimal(eligibleLoanAmount +
                              (fetchSecurityBody?.existingLimit ?? 0)),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w800,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: isTnC,
                  onChanged: (value) {
                    setState(() {
                      isTnC = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isTnC = !isTnC;
                      });
                    },
                    child: Text(
                      "I ${userData?.otherData?.name ?? ""}, confirm that I/We have requested for Pledge of selected securities in favour of NJC. I/We agree to pledge the securities in the name of NJC in order to get disbursal of the loan and I/We further undertake to service the loan in accordance with the terms contained therein.",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14.sp,
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "NOTE:\n1) Loan can be availed against holders Folios only.\n2) The eligibility amount displayed above is based on the indicated investment holding(s) and the actual loan amount is subject to creation of pledge and completion of Loan documentation.",
                style: TextStyle(fontSize: 10.sp),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationPopup(BuildContext context) async {
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
                    "Confirmation",
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
                    "Please make sure that you haven't initiated any redemption/sale transaction on the selected securities as it would be rejected.",
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
                          onTap: () async {
                            Get.back();
                            var checkEmpty = securityList.where((element) =>
                                element.selected &&
                                element.selectedUnits.toString().isEmpty);
                            if (checkEmpty.isNotEmpty) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Please selected securities into enter units.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              return;
                            }
                            if (ConnectivityUtils.instance.hasInternet) {
                              List<Map<String, Object>> list = [];
                              for (var security in securityList) {
                                var temp = {
                                  'customerPortFolioImportId':
                                      security.customerPortFolioImportId ?? 0,
                                  'perUnitPrice': security.amountPerUnit ?? 0,
                                  'selectedUnits': security.selectedUnits ?? 0,
                                  'selected': security.selected
                                };
                                list.add(temp);
                              }

                              var data = {
                                'consent': {
                                  'consentMessage':
                                      "I ${userData?.otherData?.name ?? ""}, confirm that I/We have requested for Pledge of selected securities in favour of NJC. I/We agree to pledge the securities in the name of NJC in order to get disbursal of the loan and I/We further undertake to service the loan in accordance with the terms contained therein.",
                                  'consentTimestamp':
                                      DateTime.now().millisecondsSinceEpoch,
                                  'ipAddress': ""
                                },
                                'securities': list
                              };
                              var requestCas =
                                  await _service.saveSelectedSecurity(data);
                              if (requestCas?.code == 200) {
                                Constant.eventBus.fire(PageChangeEvent(7));
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

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userData = UserDecryptData.fromJson(
          jsonDecode(prefs.getString("user_data") ?? ""));
    });
  }

  void getSecurityData() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.fetchAllSecurity();
      if (requestCas?.code == 200) {
       var tempList = (requestCas?.body?.dataList ?? []);
        for (var e in tempList) {
          e.selected = (e.isSelected == "Y");
          e.selectedUnitsController?.text = "${(e.selectedUnits ?? 0).toInt()}";
        }
        setState(() {
          fetchSecurityBody = requestCas?.body;
          securityList = tempList;
          isSelectAll = (requestCas?.body?.dataList ?? []).where((element) => element.selected).toList().length == (requestCas?.body?.dataList ?? []).length;
          isDisableAll = (requestCas?.body?.dataList ?? []).where((element) => element.disabled ?? false).toList().length ==(requestCas?.body?.dataList ?? []).length;
        });
      }
    }
  }
}
