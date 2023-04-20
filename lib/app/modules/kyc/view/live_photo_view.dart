import 'dart:convert';
import 'dart:typed_data';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/constant.dart';
import 'package:customer/app/modules/dashboard/model/EventModel.dart';
import 'package:customer/app/modules/fetchcas/view/fetch_cas_view.dart';
import 'package:customer/app/modules/kyc/model/applicant_list_response.dart';
import 'package:customer/app/modules/kyc/model/photo_verification_response.dart';
import 'package:customer/app/modules/kyc/viewmodel/kyc_viewmodel.dart';
import 'package:customer/app/modules/login/model/user_decrypt_model.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LivePhotoView extends StatefulWidget {
  FetchCasViewState? fetchCasViewState;
  int isLivePhoto;

  LivePhotoView(this.fetchCasViewState, this.isLivePhoto, {Key? key})
      : super(key: key);

  @override
  _LivePhotoViewState createState() => _LivePhotoViewState();
}

class _LivePhotoViewState extends State<LivePhotoView> {
  bool isTnC = false;

  ApplicantDetail? applicantDetail;
  late KycViewModel _service;

  VerificationData? verificationData;

  bool btnClickable = false;
  String? imageData;

  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var dateController = TextEditingController();

  Uint8List? _byteImage;

  UserDecryptData? userData;

  String? requestNumber;

  @override
  void initState() {
    super.initState();
    _service = KycViewModel(context);
    getApplicantData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return widget.isLivePhoto == 0
        ? SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.TERM_CONDITION);
                        },
                        child: Text(
                          "I agree the Term & Conditions",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14.sp,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Note:\n1. On proceeding, you will be asked to take a live photograph.\n2. Please capture the photo/ video in a well-lit white background place. ",
                    style: TextStyle(
                      color: unselectTab,
                      fontSize: 11.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.fetchCasViewState?.onBack();
                        },
                        child: Container(
                          height: 40.h,
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "BACK",
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
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (!isTnC) {
                              Fluttertoast.showToast(
                                  msg: "Please allow terms and conditions.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              return;
                            }
                            var uploadFile =
                                await _service.photoVerificationInitiate(
                                    applicantDetail?.applicantType ?? "",
                                    applicantDetail?.applicantId ?? 0);
                            var map = <String, String>{};
                            map['url'] = uploadFile!;
                            var result = await Get.toNamed(Routes.HTML_BROWSER,
                                arguments: map);
                            if (result is Map<String, String>) {
                              requestNumber = result["requestNumber"];
                              var results = await _service
                                  .photoVerificationFetch(requestNumber ?? "");
                              if (results?.code == 200) {
                                verificationData =
                                    results?.body?.verificationData;
                                nameController.text =
                                    userData?.otherData?.name ?? "";
                                locationController.text =
                                    verificationData?.country ?? "";
                                dateController.text =DateFormat('yyyy-MM-dd HH:mm:ss').format(DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse( verificationData?.createdAt ?? "",true).toLocal());
                                var photoResult = await _service.fetchFile(
                                    verificationData?.imagePath ?? "");
                                if (photoResult?.code == 200) {
                                  imageData = photoResult?.body?.base64;
                                  setState(() {
                                    _byteImage = const Base64Decoder().convert(imageData?.split(',').last ?? "");
                                    widget.fetchCasViewState?.onNext();
                                  });
                                }
                              }
                            }
                          },
                          child: Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "PROCEED FOR LIVE PHOTO",
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
                    ],
                  ),
                ),
              ],
            ),
          )
        : SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10.h),
                  width: 240.w,
                  height: 140.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: dividerColor,
                      width: 1.w,
                    ),
                  ),
                  child: _byteImage != null
                      ? Image.memory(
                          _byteImage!,
                          height: 140.h,
                          width: 240.w,
                        )
                      : Container(),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Name",
                    style: TextStyle(
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w600,
                        color: unselectTab,
                        fontSize: 12.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextField(
                    readOnly: true,
                    controller: nameController,
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
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Location",
                    style: TextStyle(
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w600,
                        color: unselectTab,
                        fontSize: 12.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextField(
                    readOnly: true,
                    controller: locationController,
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
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Live Photo Capture Date",
                    style: TextStyle(
                        fontFamily: LocaleKeys.font_family,
                        fontWeight: FontWeight.w600,
                        color: unselectTab,
                        fontSize: 12.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextField(
                    readOnly: true,
                    controller: dateController,
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
                      suffixIcon: Image.asset(
                        LocaleKeys.ic_calendar,
                        color: arrowColor,
                        width: 16.w,
                        height: 16.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Visibility(
                  visible: applicantDetail?.photoVerification == null || applicantDetail?.photoVerification == "N",
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (verificationData?.country == "India") {
                              if ((verificationData?.isLiveliness == "N" &&
                                      verificationData?.faceCoverage ==
                                          "not_optimal") ||
                                  verificationData?.photoMatchPercent
                                          ?.round() !=
                                      100) {
                                _showOtherCountryDialog(
                                    context, "Your face can not match.");
                              } else {
                                var result = await _service.updateAction(
                                    requestNumber ?? "",
                                    "DONE",
                                    applicantDetail?.applicantId ?? 0);
                                if (result?.code == 200) {
                                  applicantDetail?.photoVerification = "Y";
                                  applicantDetail?.photoVerificationRequestNumber = int.parse(requestNumber!);
                                  final prefs = await SharedPreferences.getInstance();
                                  await prefs.setString('applicant_data', jsonEncode(applicantDetail));
                                  widget.fetchCasViewState?.onNext();
                                }
                              }
                            } else {
                              _showOtherCountryDialog(context,
                                  "You can not proceed with loan application as you are initiating application from outside India.");
                            }
                          },
                          child: Container(
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "I CONFIRM",
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
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              var result = await _service.updateAction(
                                  requestNumber ?? "",
                                  "RETRY",
                                  applicantDetail?.applicantId ?? 0);
                              if (result?.code == 200) {
                                widget.fetchCasViewState?.onBack();
                              }
                            },
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: blackColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "RE-CAPTURE LIVE PHOTO",
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
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: applicantDetail?.photoVerification == "Y",
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Constant.eventBus.fire(PageChangeEvent(3));
                          },
                          child: Container(
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            decoration: BoxDecoration(
                              color: blackColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "No",
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
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () async {
                            widget.fetchCasViewState?.onNext();
                          },
                          child: Container(
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                  ),
                ),
              ],
            ),
          );
  }

  Future<bool?> _showOtherCountryDialog(
      BuildContext context, String message) async {
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
                    message,
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

  void getApplicantData() async {
    final prefs = await SharedPreferences.getInstance();
    applicantDetail = ApplicantDetail.fromJson(
        jsonDecode(prefs.getString("applicant_data") ?? ""));
    setState(() {
      userData = UserDecryptData.fromJson(
          jsonDecode(prefs.getString("user_data") ?? ""));
    });
    if (applicantDetail?.photoVerification == "Y") {
      /*setState(() {
        widget.fetchCasViewState.onNext();
      });*/
      var results = await _service.photoVerificationFetch(
          (applicantDetail?.photoVerificationRequestNumber ?? 0).toString());
      if (results?.code == 200) {
        verificationData = results?.body?.verificationData;
        nameController.text = userData?.otherData?.name ?? "";
        locationController.text = verificationData?.country ?? "";
        dateController.text =DateFormat('yyyy-MM-dd HH:mm:ss').format(DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse( verificationData?.createdAt ?? "",true).toLocal());
        var photoResult =
            await _service.fetchFile(verificationData?.imagePath ?? "");
        if (photoResult?.code == 200) {
          imageData = photoResult?.body?.base64;
          setState(() {
            _byteImage =
                const Base64Decoder().convert(imageData?.split(',').last ?? "");
          });
        }
      }
    }
  }
}
