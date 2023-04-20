import 'dart:convert';
import 'dart:io';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/modules/fetchcas/viewmodel/fetch_cas_controller.dart';
import 'package:customer/app/modules/fetchcas/viewmodel/fetch_cas_viewmodel.dart';
import 'package:customer/app/modules/login/model/user_decrypt_model.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_filex/open_filex.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchCasView2 extends StatefulWidget {

  final FetchCasController controller;

  const FetchCasView2(this.controller,{Key? key}) : super(key: key);

  @override
  _FetchCasView2State createState() => _FetchCasView2State(controller);
}

class _FetchCasView2State extends State<FetchCasView2> {
  UserDecryptData? userData;
  File? file = null;
  late FetchCasViewModel _service;
  var isFileUploaded = false;

  _FetchCasView2State(FetchCasController _controller) {
    _controller.methodA = methodA;
  }

  Future<bool> methodA(int index) async {
    if(isFileUploaded){
      return true;
    }else{
      Fluttertoast.showToast(
          msg: "Please upload CAS received on your email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _service = FetchCasViewModel(context);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "SHARE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 16.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "THIS CAS WITH US",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 12.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Image.asset(
                        LocaleKeys.ic_fetch_email,
                        height: 50.w,
                        width: 50.w,
                        color: iconColor,
                      ),
                      Text(
                        "Forward your statement from",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 14.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        userData?.otherData?.email ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 14.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "to ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 14.sp,
                              fontFamily: LocaleKeys.font_family,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "cas@njgroup.in",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: themeColor,
                              fontSize: 14.sp,
                              fontFamily: LocaleKeys.font_family,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 40.w, vertical: 20.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                color: dividerColor,
                                height: 1,
                              ),
                            ),
                            Container(
                              width: 60.w,
                              height: 60.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.w),
                                color: themeColor,
                              ),
                              child: Center(
                                child: Text(
                                  "OR",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 20.sp,
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: dividerColor,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "DOWNLOAD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 16.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "THIS CAS RECEIVED ON YOUR EMAIL",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 12.sp,
                          fontFamily: LocaleKeys.font_family,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Visibility(
                        visible: file != null,
                        child: GestureDetector(
                          onTap: () {
                            OpenFilex.open(file?.path ?? "");
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: dividerColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6.r),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 10.w,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    file?.path ?? "",
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: !isFileUploaded,
                                  child: SizedBox(
                                    width: 10.w,
                                  ),
                                ),
                                Visibility(
                                  visible: !isFileUploaded,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isFileUploaded = false;
                                        file = null;
                                      });
                                    },
                                    child: Image.asset(
                                      LocaleKeys.ic_delete,
                                      width: 26.w,
                                      height: 26.w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: file == null,
                        child: GestureDetector(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf'],
                            );
                            if (result != null) {
                              setState(() {
                                file = File(result.files.single.path ?? "");
                              });
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: Container(
                            height: 130.w,
                            width: 130.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: dividerColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6.r),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                  color: dividerColor,
                                  fontSize: 50.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (file != null && !isFileUploaded) {
                            if (ConnectivityUtils.instance.hasInternet) {
                              var uploadFile = await _service.uploadFile(file!);
                              if (uploadFile?.code == 200) {
                                setState(() {
                                  isFileUploaded = true;
                                });
                                Fluttertoast.showToast(
                                    msg: uploadFile?.message??"",
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
                        child: Container(
                          height: 40.w,
                          width: 130.w,
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
                            child: Text(
                              isFileUploaded ? "UPLOADED" : "UPLOAD",
                              style: TextStyle(
                                color: isFileUploaded ? Colors.green : themeColor,
                                fontSize: 14.sp,
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
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
    );
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userData = UserDecryptData.fromJson(
          jsonDecode(prefs.getString("user_data") ?? ""));
    });
  }
}
