import 'dart:io';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/modules/bank/viewmodel/bank_viewmodel.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class BankAddView extends StatefulWidget {
  const BankAddView({Key? key}) : super(key: key);

  @override
  _BankAddViewState createState() => _BankAddViewState();
}

class _BankAddViewState extends State<BankAddView> {
  String? bankDetailsDocument;
  String? accountType;

  var bankIFCS = TextEditingController();
  var bankName = TextEditingController();
  var bankBranch = TextEditingController();
  var bankAddress = TextEditingController();
  var bankAc = TextEditingController();
  var bankConfirmAc = TextEditingController();
  var acHolderName = TextEditingController();
  var micr = TextEditingController();
  var bankProof = TextEditingController();
  var fileShow = false;
  File? file = null;
  var isFileUploaded = false;
  final FocusNode _focus = FocusNode();
  late BankViewModel _service;

  String path = "";
  int id = 0;

  @override
  void initState() {
    super.initState();
    _service = BankViewModel(context);
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() async {
    if (!_focus.hasFocus) {
      var ifsc = bankIFCS.text.toString();
      if (ifsc.isNotEmpty) {
        if (ConnectivityUtils.instance.hasInternet) {
          var result = await _service.getIfsc(ifsc);
          if (result?.code == 200) {
            bankName.text = result?.body?.bank?.bankName ?? bankName.text;
            bankBranch.text = result?.body?.bank?.branchName ?? bankBranch.text;
            micr.text = result?.body?.bank?.MICR ?? micr.text;
          }
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text("Add New Bank"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Bank IFSC Code",
                  style: TextStyle(
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                      color: unselectTab,
                      fontSize: 12.sp),
                ),
                TextField(
                  controller: bankIFCS,
                  textCapitalization: TextCapitalization.characters,
                  style: TextStyle(color: blackColor),
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  focusNode: _focus,
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
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Bank Name",
                  style: TextStyle(
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                      color: unselectTab,
                      fontSize: 12.sp),
                ),
                TextField(
                  controller: bankName,
                  maxLines: 1,
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
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Bank Branch",
                  style: TextStyle(
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                      color: unselectTab,
                      fontSize: 12.sp),
                ),
                TextField(
                  style: TextStyle(color: blackColor),
                  controller: bankBranch,
                  maxLines: 1,
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
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Bank Address",
                  style: TextStyle(
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                      color: unselectTab,
                      fontSize: 12.sp),
                ),
                TextField(
                  style: TextStyle(color: blackColor),
                  controller: bankAddress,
                  maxLines: 1,
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
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Bank A/C No.",
                  style: TextStyle(
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                      color: unselectTab,
                      fontSize: 12.sp),
                ),
                TextField(
                  controller: bankAc,
                  maxLines: 1,
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
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "Confirm Bank A/C No.",
                  style: TextStyle(
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                      color: unselectTab,
                      fontSize: 12.sp),
                ),
                TextField(
                  controller: bankConfirmAc,
                  maxLines: 1,
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
                /*SizedBox(
                  height: 16.h,
                ),
                Text(
                  "A/C Holder Name",
                  style: TextStyle(
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                      color: unselectTab,
                      fontSize: 12.sp),
                ),
                TextField(
                  controller: acHolderName,
                  maxLines: 1,
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
                ),*/
                SizedBox(
                  height: 16.h,
                ),
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
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "MICR",
                  style: TextStyle(
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w600,
                      color: unselectTab,
                      fontSize: 12.sp),
                ),
                TextField(
                  controller: micr,
                  maxLines: 1,
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
                Visibility(
                  visible: fileShow,
                  child: SizedBox(
                    height: 16.h,
                  ),
                ),
                Visibility(
                  visible: fileShow,
                  child: Text(
                    "Bank Details Document",
                    style: TextStyle(
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w600,
                        color: unselectTab,
                        fontSize: 12.sp),
                  ),
                ),
                Visibility(
                  visible: fileShow,
                  child: DropdownButton<String>(
                    hint: const Text("Select Bank Details Document"),
                    value: bankDetailsDocument,
                    isDense: false,
                    items: LocaleKeys.bankDocumentList.map((String value) {
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
                        bankDetailsDocument = values;
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: fileShow,
                  child: SizedBox(
                    height: 16.h,
                  ),
                ),
                Visibility(
                  visible: fileShow,
                  child: Text(
                    "Bank Proof",
                    style: TextStyle(
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w600,
                        color: unselectTab,
                        fontSize: 12.sp),
                  ),
                ),
                Visibility(
                  visible: fileShow,
                  child: TextField(
                    readOnly: true,
                    controller: bankProof,
                    maxLines: 1,
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );
                      if (result != null) {
                        setState(() {
                          file = File(result.files.single.path ?? "");
                          isFileUploaded = false;
                          bankProof.text = file?.path ?? "";
                        });
                      } else {
                        // User canceled the picker
                      }
                    },
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
                      suffixIcon: Container(
                        width: 90.w,
                        margin: EdgeInsets.symmetric(vertical: 6.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isFileUploaded ? Colors.green : dividerColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.r),
                          ),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () async {
                              if (file != null && !isFileUploaded) {
                                if (ConnectivityUtils.instance.hasInternet) {
                                  var uploadFile =
                                      await _service.uploadFile(file!);
                                  if (uploadFile?.code == 200) {
                                    path = uploadFile?.body?.fileName ?? "";
                                    setState(() {
                                      isFileUploaded = true;
                                    });
                                    Fluttertoast.showToast(
                                        msg: uploadFile?.message ?? "",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
                              }
                            },
                            child: Text(
                              isFileUploaded ? "UPLOADED" : "UPLOAD",
                              style: TextStyle(
                                color:
                                    isFileUploaded ? Colors.green : themeColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: boxBackColor,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.back();
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
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  var ifcCode = bankIFCS.text.toString().trim();
                  var bName = bankName.text.toString().trim();
                  var bBranch = bankBranch.text.toString().trim();
                  var bAddress = bankAddress.text.toString().trim();
                  var bAc = bankAc.text.toString().trim();
                  var bCAc = bankConfirmAc.text.toString().trim();
                  // var aHName = acHolderName.text.toString().trim();
                  var lAccountType = accountType;
                  var micrCode = micr.text.toString().trim();
                  var document = bankDetailsDocument;
                  var proof = bankProof.text.toString().trim();
                  if (ifcCode.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "IFSC code is required",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  if (bName.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Bank name is required",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  if (bBranch.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Branch name is required",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  if (bAddress.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Bank address is required",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  if (bAc.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Account number is required",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  if (bCAc.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Confirm account number is required",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  if (bAc != bCAc) {
                    Fluttertoast.showToast(
                        msg: "Account number do not match",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  /*if (aHName.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Account holder name is required",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }*/
                  if ((lAccountType ?? "").isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Account type is required",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  if (micrCode.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "MICR number is required",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  var data = {
                    'accountNo': bAc,
                    'accountType': lAccountType,
                    'bankAddress': bAddress,
                    'bankBranch': bBranch,
                    'bankIfsc': ifcCode,
                    'bankName': bName,
                    'id': id,
                    'micr': micrCode,
                    'pennyDropStatus': "",
                  };

                  if (fileShow) {
                    if ((document ?? "").isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Account bank details document is required",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    if (proof.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Document is required",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    if (!isFileUploaded) {
                      Fluttertoast.showToast(
                          msg: "Upload selected document",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return;
                    }
                    data['verificationDocName'] = document;
                    data['verificationDocPath'] = path;
                  } else {
                    data['verificationDocName'] = "";
                    data['verificationDocPath'] = "";
                  }
                  if (ConnectivityUtils.instance.hasInternet) {
                    var result = await _service.addBankData(data);
                    if (result?.code == 200) {
                      Get.back(result: true);
                    } else if (result?.code == 3005 || result?.code == 3006) {
                      id = result?.body?.bankId ?? 0;
                      Fluttertoast.showToast(
                          msg: result?.message??"",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      if ((result?.body?.pennyDrop?.pennyDropCount ?? 0) >= 3) {
                        setState(() {
                          fileShow = true;
                        });
                      }
                    }
                  }
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
                      "SUBMIT",
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
    );
  }
}
