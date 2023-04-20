import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/constant.dart';
import 'package:customer/app/modules/authentication/viewmodel/authentication_viewmodel.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../util/connectivity_utils.dart';
import '../../dashboard/model/EventModel.dart';

class EMandateView extends StatefulWidget {
  const EMandateView({Key? key}) : super(key: key);

  @override
  _EMandateViewState createState() => _EMandateViewState();
}

class _EMandateViewState extends State<EMandateView> {

  bool isSelectAll = false;
  String? accountType;
  var isCorrespondence = "";
  late AuthenticationViewModel _service;
  TextEditingController applicationNameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankACNumberController = TextEditingController();
  TextEditingController bankACTypeNameController = TextEditingController();
  TextEditingController modeOfHoldingController = TextEditingController();
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController mandateMaximumController = TextEditingController();

  @override
  void initState() {
    _service = AuthenticationViewModel(context);
    eMandate();
    super.initState();

  }

  Future<void> eMandate() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestBankMandate = await _service.eMandate();
      if (requestBankMandate?.code == 200) {
        var data = requestBankMandate?.body;
        applicationNameController.text = data?.applicantName.toString()??"";
        bankNameController.text = data?.bankName.toString()??"";
        bankACNumberController.text = data?.bankAccNo.toString()??"";
        bankACTypeNameController.text = data?.bankAccType.toString()??"";
        loanAmountController.text = data?.loanAmount.toString()??"";
        mandateMaximumController.text = data?.mandateMaxLimit.toString()??"";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h,),
              Text(
                "Verify below details for E-Mandate Registration",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: LocaleKeys.font_family,
                  fontWeight: FontWeight.w700,
                  color: blackColor,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Application Name",
                style: TextStyle(
                  fontFamily: LocaleKeys.font_family,
                  fontWeight: FontWeight.w500,
                  color: unselectTab,
                  fontSize: 12.sp,
                ),
              ),
              TextFormField(
                controller: applicationNameController,
                readOnly: true,
                style: TextStyle(color: blackColor),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: hintColor),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: hintColor),
                  ),
                  isDense: true,
                ),
              ),
              SizedBox(height: 20.h,),
              Text(
                "Bank Name",
                style: TextStyle(
                  fontFamily: LocaleKeys.font_family,
                  fontWeight: FontWeight.w500,
                  color: unselectTab,
                  fontSize: 12.sp,
                ),
              ),
              TextFormField(
                controller: bankNameController,
                readOnly: true,
                style: TextStyle(color: blackColor),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: hintColor),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: hintColor),
                  ),
                  isDense: true,
                ),
              ),
              SizedBox(height: 20.h,),
              Text(
                "A/C No.",
                style: TextStyle(
                  fontFamily: LocaleKeys.font_family,
                  fontWeight: FontWeight.w500,
                  color: unselectTab,
                  fontSize: 12.sp,
                ),
              ),
              TextFormField(
                controller: bankACNumberController,
                readOnly: true,
                style: TextStyle(color: blackColor),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: hintColor),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: hintColor),
                  ),
                  isDense: true,
                ),
              ),
              SizedBox(height: 20.h,),
              Text(
                "Account Type",
                style: TextStyle(
                    fontFamily: LocaleKeys.font_family,
                    fontWeight: FontWeight.w600,
                    color: unselectTab,
                    fontSize: 12.sp),
              ),
              DropdownButton<String>(
                hint: const Text("Select Account Type"),
                value: accountType,
                isDense: false,
                items: LocaleKeys.accountTypeList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                isExpanded: true,
                onChanged: (values) {
                  setState(() {
                    accountType = values;
                  });
                },
              ),
              SizedBox(height: 20.h,),
              Text(
                "Holding Status",
                style: TextStyle(
                  fontFamily: LocaleKeys.font_family,
                  fontWeight: FontWeight.w500,
                  color: unselectTab,
                  fontSize: 12.sp,
                ),
              ),
              TextFormField(
                controller: loanAmountController,
                readOnly: true,
                style: TextStyle(color: blackColor),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: hintColor),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: hintColor),
                  ),
                  isDense: true,
                ),
              ),
              SizedBox(height: 20.h,),
              Text(
                "Loan Amount",
                style: TextStyle(
                  fontFamily: LocaleKeys.font_family,
                  fontWeight: FontWeight.w500,
                  color: unselectTab,
                  fontSize: 12.sp,
                ),
              ),
              TextFormField(
                controller: mandateMaximumController,
                readOnly: true,
                style: TextStyle(color: blackColor),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: hintColor),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: hintColor),
                  ),
                  isDense: true,
                ),
              ),
              SizedBox(height: 20.h,),
              Text(
                "Max Mandate Limit",
                style: TextStyle(
                  fontFamily: LocaleKeys.font_family,
                  fontWeight: FontWeight.w500,
                  color: unselectTab,
                  fontSize: 12.sp,
                ),
              ),
              TextFormField(
                readOnly: true,
                style: TextStyle(color: blackColor),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: hintColor),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: hintColor),
                  ),
                  isDense: true,
                ),
              ),
              SizedBox(height: 20.h,),
              Text(
                "Mode of Mandate Authentication",
                style: TextStyle(
                  fontFamily: LocaleKeys.font_family,
                  fontWeight: FontWeight.w500,
                  color: unselectTab,
                  fontSize: 12.sp,
                ),
              ),
              Row(
                children: [
                  Radio(
                    value: "net_banking",
                    groupValue: isCorrespondence,
                    onChanged: (value) {
                      setState(() {
                        isCorrespondence = value.toString();
                      });
                    },
                  ),
                  Text(
                    "Net Banking",
                    style: TextStyle(
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w600,
                        color: blackColor,
                        fontSize: 12.sp),
                  ),
                  Radio(
                    value: "debit_card",
                    groupValue: isCorrespondence,
                    onChanged: (value) {
                      setState(() {
                        isCorrespondence = value.toString();
                      });
                    },
                  ),
                  Text(
                    "Debit Card",
                    style: TextStyle(
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w600,
                        color: blackColor,
                        fontSize: 12.sp),
                  ),
                  Radio(
                    value: "aadhaar",
                    groupValue: isCorrespondence,
                    onChanged: (value) {
                      setState(() {
                        isCorrespondence = value.toString();
                      });
                    },
                  ),
                  Text(
                    "Aadhaar",
                    style: TextStyle(
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w600,
                        color: blackColor,
                        fontSize: 12.sp),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isSelectAll,
                    onChanged: (value) {
                      setState(() {
                        isSelectAll = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        color: CupertinoColors.link,
                        fontSize: 12.sp,
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> showPopup(BuildContext context) async {
    return await showDialog<bool>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              color: whiteColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                  isCorrespondence=="net_banking"? Text(
                    "You will be directed to your bank's netbanking page to authorize the E-Mandate.",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                    ),
                  ) : isCorrespondence=="aadhaar" ? Text(
                    "Your Aadhaar should be registered with your bank account and you will be redirected to eSign the Aadhaar based eMandate",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                    ),
                  ) : isCorrespondence=="debit_card" ? Text(
                    "You will be redirected to myCAMS portal for pledge authorization.",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                    ),
                  ):
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
                           // showError = true;
                          });
                        },
                        child: Container(
                          height: 30.h,
                          width: 100.w,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: unselectTab,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Close",
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
                      GestureDetector(
                        onTap: () async {
                          Get.back();
                          /*setState(() {
                            showError = false;
                          });
                          getAuthenticationUrl();*/
                          //Constant.eventBus.fire(PageChangeEvent(11));
                        },
                        child: Container(
                          height: 30.h,
                          width: 100.w,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(11),
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
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
