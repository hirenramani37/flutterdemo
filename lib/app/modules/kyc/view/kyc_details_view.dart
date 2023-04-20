import 'dart:convert';
import 'dart:io';

import 'package:customer/app/constant/LocalColors.dart';
import 'package:customer/app/constant/constant.dart';
import 'package:customer/app/modules/dashboard/model/EventModel.dart';
import 'package:customer/app/modules/fetchcas/viewmodel/fetch_cas_controller.dart';
import 'package:customer/app/modules/kyc/model/address_detail_response.dart';
import 'package:customer/app/modules/kyc/model/address_list_response.dart';
import 'package:customer/app/modules/kyc/model/applicant_list_response.dart';
import 'package:customer/app/modules/kyc/model/digiloker_fetch_response.dart';
import 'package:customer/app/modules/kyc/model/personal_detail_response.dart';
import 'package:customer/app/modules/kyc/model/purpose_list_response.dart';
import 'package:customer/app/modules/kyc/viewmodel/kyc_viewmodel.dart';
import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/util/connectivity_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KycDetailView extends StatefulWidget {
  var kycIndex;
  final FetchCasController controller;

  KycDetailView(this.kycIndex, this.controller, {Key? key}) : super(key: key);

  @override
  _KycDetailViewState createState() => _KycDetailViewState(this.controller);
}

class _KycDetailViewState extends State<KycDetailView> {
  double emiAmount = 0;

  _KycDetailViewState(FetchCasController _controller) {
    _controller.methodA = methodA;
  }

  bool isTnC = false;
  bool isTnCAddress = false;
  var isFileUploaded = false;
  List<String> selectedValueService = [];
  List<String> selectedValueInvestment = [];

  Future<bool> methodA(int index) async {
    if (index != 3) {
      if ((applicantDetail?.applicantId ?? 0) > 0) {
        if (personalDetail?.digiLockerStatus == "READY_FOR_DIGILOCKER") {
          if (ConnectivityUtils.instance.hasInternet) {
            if (index == 2) {
              var result = await _service
                  .digilokerRetry(applicantDetail?.applicantId ?? 0);
              if (result != null) {
                if (result.code == 200) {
                  callDigiloker(result.body?.digiLockerId ?? 0);
                } else {
                  Fluttertoast.showToast(
                      msg: "${result.message}",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              }
            } else {
              return true;
            }
          }
        } else if (personalDetail?.digiLockerStatus == "USER_APPROVED") {
          return true;
        }
      } else {
        if (index == 0) {
          var applicantName = applicantNameController.text;
          var pan = panController.text;
          var dot = birthController.text;
          var fatherName = fatherNameController.text;
          var marital = maritalStatusValue;
          var genderLocal = gender;
          if (applicantName.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please enter applicant name!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (pan.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please enter pan number!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (dot.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please select birth date!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (fatherName.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please enter father name!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (marital?.isEmpty ?? true) {
            Fluttertoast.showToast(
                msg: "Please select marital status!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (genderLocal?.isEmpty ?? true) {
            Fluttertoast.showToast(
                msg: "Please select gender!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          return true;
        } else if (index == 1) {
          var mobile = mobileController.text;
          var emailId = emailController.text;
          var mobileCAMS = mobileCAMSController.text;
          var mobileKfintech = mobileKfintechController.text;
          var landlineNumber = landlineController.text;
          var alternateNumber = alternateNumberController.text;
          if (mobile.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please enter mobile number!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (emailId.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please enter email id!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (mobileCAMS.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please enter CAMS mobile number!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (mobileKfintech.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please enter Kfintech mobile number!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          return true;
        } else if (index == 2) {
          var applicantName = applicantNameController.text;
          var pan = panController.text;
          var dot = DateFormat('yyyy-MM-dd')
              .format(DateFormat('dd/MM/yyyy').parse(birthController.text));
          var fatherName = fatherNameController.text;
          var marital = maritalStatusValue;
          var genderLocal = gender;

          var mobile = mobileController.text;
          var emailId = emailController.text;
          var mobileCAMS = mobileCAMSController.text;
          var mobileKfintech = mobileKfintechController.text;
          var landlineNumber = landlineController.text;
          var alternateNumber = alternateNumberController.text;

          var ckycNo = cKycNumberController.text;
          var occupation = occupationValue;
          var exposedPerson = politicallyExposedValue;
          var relationPep = relationPEPController.text;
          var servingLoan = selectedValueService;
          var investmentMade = selectedValueInvestment;
          var estimatedNetWorth = netWorthController.text;
          var industryOccupation = industryOccupationValue;
          var monthlyIncome = monthlyIncomeController.text;
          var purposeLoan = selectPurposeData?.purposeMastId;
          var kycXmlPath = eKycController.text;
          var kycCode = eKycCodeController.text;

          if (ckycNo.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please enter CKYC number!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (occupation?.isEmpty ?? true) {
            Fluttertoast.showToast(
                msg: "Please select occupation!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (exposedPerson?.isEmpty ?? true) {
            Fluttertoast.showToast(
                msg: "Please select Politically exposed person!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (exposedPerson == "Related to Politically exposed person") {
            if (relationPep.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Please select Politically exposed person!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return false;
            }
          }
          if (exposedPerson == "Politically exposed person" || exposedPerson == "Related to Politically exposed person") {
            if (selectedValueService.isEmpty ?? true) {
              Fluttertoast.showToast(
                  msg: "Please select Source of funds for servicing the loan!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return false;
            }
            if (selectedValueInvestment.isEmpty ?? true) {
              Fluttertoast.showToast(
                  msg:
                      "Please select Source of funds from which the investment was made!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return false;
            }
            if (estimatedNetWorth.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Please enter Estimated Net worth (Rs.)!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return false;
            }
            if (industryOccupation?.isEmpty ?? true) {
              Fluttertoast.showToast(
                  msg: "Please select Industry of occupation!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return false;
            }
          }
          if (monthlyIncome.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please enter Gross Monthly Income (In Rs.)!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (double.parse(monthlyIncome) < (emiAmount)) {
            Fluttertoast.showToast(
                msg:
                    "Your monthly income should be greater then Rs. ${emiAmount * 1.5} amount",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (selectPurposeData?.purpose?.isEmpty ?? true) {
            Fluttertoast.showToast(
                msg: "Please select Loan Purpose!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (purposeLoan == "Investment In capital markets") {
            Fluttertoast.showToast(
                msg: "NJ Term loan is not available for this purpose.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if (!isTnC) {
            Fluttertoast.showToast(
                msg: "Please allow terms and conditions.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          var consentTimestamp = DateTime.now().millisecondsSinceEpoch;
          final body = {
            'applicantName': applicantName,
            'fatherName': fatherName,
            'dateOfBirth': dot,
            'maritalStatus': marital,
            'pan': pan,
            'gender': genderLocal,
            'nationality': "INDIAN",
            'taxStatus': "Individual",
            'occupation': occupation,
            'politicallyExposed': exposedPerson,
            'relationPep': relationPep,
            'fundServingLoan': politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA" ? servingLoan :[],
            'fundInvestmentMade': politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA" ? investmentMade : [],
            'netWorth':  politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA" ? estimatedNetWorth : "",
            'industryOfOccupation': politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA" ? industryOccupation : "",
            'mobile': mobile,
            'landline': landlineNumber,
            'camsMobile': mobileCAMS,
            'kfinMobile': mobileKfintech,
            'alternateContact': alternateNumber,
            'emailId': emailId,
            'monthlyIncome': monthlyIncome,
            'purposeOfLoan': purposeLoan,
            'ekycXmlPath': kycXmlPath,
            'ekycXmlPassword': kycCode,
            'ckycNo': ckycNo,
            'applicantId': personalDetail?.applicantId,
            'applicantType': personalDetail?.applicantType,
            'digiLockerStatus': personalDetail?.digiLockerStatus,
            'consentList': [
              {
                'consentMessage':
                    "I/We hereby provide my/our explicit consent to NJC to update my/our address detail(s)/data in Central KYC (Know Your Customer) CKYC maintained by Central Registry of Securitisation Asset Reconstruction and Security Interest of India(CERSAI).",
                'consentTimestamp': "$consentTimestamp",
                'ipAddress': "",
              }
            ]
          };
          print("bodybody$body");
          if (ConnectivityUtils.instance.hasInternet) {
            var result = await _service.savePersonalDetails(body);
            if (result != null) {
              if (result.code == 200) {
                if (result.body != null) {
                  await callDigiloker(result.body?.digiLockerId ?? 0);
                }
              } else {
                Fluttertoast.showToast(
                    msg: "${result.message}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          }
        }
      }
    } else {
      if (applicantDetail?.addressDetails == "Y") {
        Constant.eventBus.fire(PageChangeEvent(4));
      } else {
        var consentTimestamp = DateTime.now().millisecondsSinceEpoch;
        if (isCorrespondence == "yes") {
          var correspondence = permanentAddress?.address ?? "";
          var country = permanentAddress?.country ?? "";
          var state = permanentAddress?.state ?? "";
          var city = permanentAddress?.city ?? "";
          var pincode = permanentAddress?.pincode ?? "";
          var proofType = permanentAddress?.addressProofType ?? "";
          var addressProof = permanentAddress?.addressProofFile ?? "";
          var addressType = "CORRESPONDENCE";
          var applicantId = applicantDetail?.applicantId ?? 0;
          final body = {
            'addressId': 0,
            'address': correspondence,
            'country': country,
            'state': state,
            'city': city,
            'pincode': pincode,
            'addressProofType': proofType,
            'addressProofFile': addressProof,
            'addressType': addressType,
            'applicantId': applicantId,
            'consentList': [
              {
                'consentMessage':
                    "I/We hereby provide my/our explicit consent to NJC to update my/our address detail(s)/data in Central KYC (Know Your Customer) CKYC maintained by Central Registry of Securitisation Asset Reconstruction and Security Interest of India(CERSAI).",
                'consentTimestamp': "$consentTimestamp",
                'ipAddress': "",
              }
            ]
          };
          saveAddress(body);
        } else {
          if(correspondenceController.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Please enter Correspondence Address!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if(countryController.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Please enter Country!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if(stateController.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Please enter State!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if(cityController.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Please enter City!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if(pincodeController.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Please enter Pincode!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if(addressProofValue?.isEmpty??false){
            Fluttertoast.showToast(
                msg: "Please select Address proof!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          if(!isFileUploaded){
            Fluttertoast.showToast(
                msg: "Please upload address proof!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return false;
          }
          var correspondence = correspondenceController.text ?? "";
          var country = countryController.text ?? "";
          var state = stateController.text ?? "";
          var city = cityController.text ?? "";
          var pincode = pincodeController.text ?? "";
          var proofType = addressProofValue ?? "";
          var addressProof = addressProofController.text ?? "";
          var addressType = "CORRESPONDENCE";
          var applicantId = applicantDetail?.applicantId ?? 0;
          final body = {
            'addressId': 0,
            'address': correspondence,
            'country': country,
            'state': state,
            'city': city,
            'pincode': pincode,
            'addressProofType': proofType,
            'addressProofFile': addressProof,
            'addressType': addressType,
            'applicantId': applicantId,
            'consentList': [
              {
                'consentMessage':
                    "I/We hereby provide my/our explicit consent to NJC to update my/our address detail(s)/data in Central KYC (Know Your Customer) CKYC maintained by Central Registry of Securitisation Asset Reconstruction and Security Interest of India(CERSAI).",
                'consentTimestamp': "$consentTimestamp",
                'ipAddress': "",
              }
            ]
          };
          saveAddress(body);
        }
      }
    }
    return false;
  }

  var isCorrespondence = "yes";
  String? gender;
  File? file = null;
  File? addressFile = null;
  String? maritalStatusValue;
  String? occupationValue;
  String? industryOccupationValue;
  String? politicallyExposedValue;
  String? SourceServicingValue;
  String? SourceInvestmentValue;
  String? addressProofValue;
  late KycViewModel _service;
  List<PurposeData> purposeList = [];
  PurposeData? selectPurposeData;
  ApplicantDetail? applicantDetail;
  List<ApplicantDetail> applicantList = [];
  List<AddressDetail> addressList = [];
  PersonalDetail? personalDetail;
  AddressData? permanentAddress;
  AddressData? correspodenceAddress;

  List<String> occupationList = [];
  List<String> politicallyExposedList = [];
  List<String> sourceServingLoanList = [];
  List<String> sourceInvestmentLoanList = [];
  List<String> industryOccupationList = [];
  List<String> maritalStatusList = [];

  var applicantNameController = TextEditingController();
  var panController = TextEditingController();
  var birthController = TextEditingController();
  var fatherNameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var mobileCAMSController = TextEditingController();
  var mobileKfintechController = TextEditingController();
  var landlineController = TextEditingController();
  var alternateNumberController = TextEditingController();
  var cKycNumberController = TextEditingController();
  var tanController = TextEditingController();
  var nationalityController = TextEditingController();
  var relationPEPController = TextEditingController();
  var netWorthController = TextEditingController();
  var monthlyIncomeController = TextEditingController();
  var eKycController = TextEditingController();
  var eKycCodeController = TextEditingController();
  var permanentController = TextEditingController();
  var correspondenceController = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  var pincodeController = TextEditingController();
  var addressProofController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _service = KycViewModel(context);
    nationalityController.text = "India";
    tanController.text = "Individual";
    occupationList.addAll(LocaleKeys.occupationList);
    politicallyExposedList.addAll(LocaleKeys.politicallyExposedList);
    sourceServingLoanList.addAll(LocaleKeys.sourceServingLoanList);
    sourceInvestmentLoanList.addAll(LocaleKeys.sourceServingLoanList);
    industryOccupationList.addAll(LocaleKeys.industryOccupationList);
    maritalStatusList.addAll(LocaleKeys.maritalStatusList);
    getPurposeList();
    getApplicantList();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "PERSONAL",
                    style: TextStyle(
                      color: widget.kycIndex >= 0 ? themeColor : unselectTab,
                      fontSize: 10.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Container(
                    width: 70.w,
                    height: 2.h,
                    color: widget.kycIndex >= 0 ? themeColor : unselectTab,
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "CONTACT DETAILS",
                    style: TextStyle(
                      color: widget.kycIndex > 0 ? themeColor : unselectTab,
                      fontSize: 10.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Container(
                    width: 120.w,
                    height: 2.h,
                    color: widget.kycIndex > 0 ? themeColor : unselectTab,
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "OTHERS",
                    style: TextStyle(
                      color: widget.kycIndex > 1 ? themeColor : unselectTab,
                      fontSize: 10.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Container(
                    width: 60.w,
                    height: 2.h,
                    color: widget.kycIndex > 1 ? themeColor : unselectTab,
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "ADDRESS",
                    style: TextStyle(
                      color: widget.kycIndex > 2 ? themeColor : unselectTab,
                      fontSize: 10.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Container(
                    width: 65.w,
                    height: 2.h,
                    color: widget.kycIndex > 2 ? themeColor : unselectTab,
                  )
                ],
              ),
            ],
          ),
          widget.kycIndex == 0
              ? Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            "Applicant Name",
                            style: TextStyle(
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w600,
                                color: unselectTab,
                                fontSize: 12.sp),
                          ),
                          TextField(
                            readOnly: true,
                            controller: applicantNameController,
                            textCapitalization: TextCapitalization.characters,
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
                            "PAN",
                            style: TextStyle(
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w600,
                                color: unselectTab,
                                fontSize: 12.sp),
                          ),
                          TextField(
                            readOnly: true,
                            controller: panController,
                            textCapitalization: TextCapitalization.characters,
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
                            "Date of Birth",
                            style: TextStyle(
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w600,
                                color: unselectTab,
                                fontSize: 12.sp),
                          ),
                          TextField(
                            readOnly: true,
                            controller: birthController,
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
                              suffixIcon: GestureDetector(
                                onTap: () async {
                                  if (!((applicantDetail?.applicantId ?? 0) >
                                      0)) {
                                    await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1920),
                                        lastDate: DateTime.now(),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: themeColor,
                                                onPrimary: whiteColor,
                                                onSurface: themeColor,
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        }).then((selectedDate) {
                                      if (selectedDate != null) {
                                        birthController.text =
                                            DateFormat('dd/MM/yyyy')
                                                .format(selectedDate);
                                      }
                                    });
                                  }
                                },
                                child: Image.asset(
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
                          Text(
                            "Father's Name",
                            style: TextStyle(
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w600,
                                color: unselectTab,
                                fontSize: 12.sp),
                          ),
                          TextField(
                            readOnly: (applicantDetail?.applicantId ?? 0) > 0,
                            style: TextStyle(color: blackColor),
                            textCapitalization: TextCapitalization.characters,
                            controller: fatherNameController,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-z A-Z]'))
                            ],
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: hintColor),
                              hintText: "Enter Father's Name",
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
                            "Marital Status",
                            style: TextStyle(
                                fontFamily: LocaleKeys.font_family,
                                fontWeight: FontWeight.w600,
                                color: unselectTab,
                                fontSize: 12.sp),
                          ),
                          DropdownButton<String>(
                            hint: const Text("Select Marital Status"),
                            value: maritalStatusValue,
                            items: maritalStatusList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            isExpanded: true,
                            onChanged: (applicantDetail?.applicantId ?? 0) > 0
                                ? null
                                : (values) {
                                    setState(() {
                                      maritalStatusValue = values;
                                    });
                                  },
                            // onChanged: null,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            "Gender",
                            style: TextStyle(
                              fontFamily: LocaleKeys.font_family,
                              fontWeight: FontWeight.w600,
                              color: unselectTab,
                              fontSize: 12.sp,
                            ),
                          ),
                          Row(
                            children: [
                              Radio(
                                value: "MALE",
                                groupValue: gender,
                                onChanged:
                                    (applicantDetail?.applicantId ?? 0) > 0
                                        ? null
                                        : (value) {
                                            setState(() {
                                              gender = value.toString();
                                            });
                                          },
                              ),
                              Text(
                                "Male",
                                style: TextStyle(
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w600,
                                  color: blackColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                              Radio(
                                value: "FEMALE",
                                groupValue: gender,
                                onChanged:
                                    (applicantDetail?.applicantId ?? 0) > 0
                                        ? null
                                        : (value) {
                                            setState(() {
                                              gender = value.toString();
                                            });
                                          },
                              ),
                              Text(
                                "Female",
                                style: TextStyle(
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w600,
                                  color: blackColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                              Radio(
                                value: "OTHER",
                                groupValue: gender,
                                onChanged:
                                    (applicantDetail?.applicantId ?? 0) > 0
                                        ? null
                                        : (value) {
                                            setState(() {
                                              gender = value.toString();
                                            });
                                          },
                              ),
                              Text(
                                "Other",
                                style: TextStyle(
                                  fontFamily: LocaleKeys.font_family,
                                  fontWeight: FontWeight.w600,
                                  color: blackColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : widget.kycIndex == 1
                  ? Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                "Mobile No.",
                                style: TextStyle(
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                    color: unselectTab,
                                    fontSize: 12.sp),
                              ),
                              TextField(
                                readOnly: true,
                                controller: mobileController,
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
                                "Email ID",
                                style: TextStyle(
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                    color: unselectTab,
                                    fontSize: 12.sp),
                              ),
                              TextField(
                                readOnly: true,
                                controller: emailController,
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
                                "Mobile No registered with CAMS",
                                style: TextStyle(
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                    color: unselectTab,
                                    fontSize: 12.sp),
                              ),
                              TextField(
                                readOnly:
                                    (applicantDetail?.applicantId ?? 0) > 0,
                                controller: mobileCAMSController,
                                style: TextStyle(color: blackColor),
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintStyle: TextStyle(color: hintColor),
                                  hintText: "Enter Mobile No",
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
                                "Mobile No registered with Kfintech",
                                style: TextStyle(
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                    color: unselectTab,
                                    fontSize: 12.sp),
                              ),
                              TextField(
                                readOnly:
                                    (applicantDetail?.applicantId ?? 0) > 0,
                                controller: mobileKfintechController,
                                style: TextStyle(color: blackColor),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintStyle: TextStyle(color: hintColor),
                                  hintText: "Enter Mobile No",
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
                                "Landline No.",
                                style: TextStyle(
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                    color: unselectTab,
                                    fontSize: 12.sp),
                              ),
                              TextField(
                                readOnly:
                                    (applicantDetail?.applicantId ?? 0) > 0,
                                style: TextStyle(color: blackColor),
                                maxLength: 11,
                                controller: landlineController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: hintColor),
                                  counterText: "",
                                  hintText: "Enter Landline No.",
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
                                "Alternate Contact No.",
                                style: TextStyle(
                                    fontFamily: LocaleKeys.font_family,
                                    fontWeight: FontWeight.w600,
                                    color: unselectTab,
                                    fontSize: 12.sp),
                              ),
                              TextField(
                                readOnly:
                                    (applicantDetail?.applicantId ?? 0) > 0,
                                controller: alternateNumberController,
                                style: TextStyle(color: blackColor),
                                textInputAction: TextInputAction.next,
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: hintColor),
                                  hintText: "Enter Contact No.",
                                  counterText: "",
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
                                height: 20.h,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : widget.kycIndex == 2
                      ? Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Text(
                                    "CKYC No",
                                    style: TextStyle(
                                        fontFamily: LocaleKeys.font_family,
                                        fontWeight: FontWeight.w600,
                                        color: unselectTab,
                                        fontSize: 12.sp),
                                  ),
                                  TextField(
                                    readOnly: true,
                                    controller: cKycNumberController,
                                    style: TextStyle(color: blackColor),
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: themeColor),
                                      ),
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: hintColor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: hintColor),
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    "Tax Status",
                                    style: TextStyle(
                                        fontFamily: LocaleKeys.font_family,
                                        fontWeight: FontWeight.w600,
                                        color: unselectTab,
                                        fontSize: 12.sp),
                                  ),
                                  TextField(
                                    readOnly: true,
                                    style: TextStyle(color: blackColor),
                                    controller: tanController,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(color: hintColor),
                                      hintText: "Enter Tax Status",
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: themeColor),
                                      ),
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: hintColor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: hintColor),
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    "Nationality",
                                    style: TextStyle(
                                        fontFamily: LocaleKeys.font_family,
                                        fontWeight: FontWeight.w600,
                                        color: unselectTab,
                                        fontSize: 12.sp),
                                  ),
                                  TextField(
                                    controller: nationalityController,
                                    readOnly: true,
                                    style: TextStyle(color: blackColor),
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(color: hintColor),
                                      hintText: "Enter Nationality",
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: themeColor),
                                      ),
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: hintColor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: hintColor),
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    "Occupation",
                                    style: TextStyle(
                                        fontFamily: LocaleKeys.font_family,
                                        fontWeight: FontWeight.w600,
                                        color: unselectTab,
                                        fontSize: 12.sp),
                                  ),
                                  DropdownButton<String>(
                                    hint: const Text("Select Occupation"),
                                    value: occupationValue,
                                    isDense: false,
                                    itemHeight: 64.0,
                                    items: occupationList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 13.sp),
                                        ),
                                      );
                                    }).toList(),
                                    isExpanded: true,
                                    onChanged:
                                        (applicantDetail?.applicantId ?? 0) > 0
                                            ? null
                                            : (values) {
                                                setState(() {
                                                  occupationValue = values;
                                                });
                                              },
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    "Politically exposed person?",
                                    style: TextStyle(
                                        fontFamily: LocaleKeys.font_family,
                                        fontWeight: FontWeight.w600,
                                        color: unselectTab,
                                        fontSize: 12.sp),
                                  ),
                                  DropdownButton<String>(
                                    hint: const Text(
                                        "Select Politically exposed person"),
                                    value: politicallyExposedValue,
                                    isDense: false,
                                    items: politicallyExposedList
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                        ),
                                      );
                                    }).toList(),
                                    isExpanded: true,
                                    onChanged:
                                        (applicantDetail?.applicantId ?? 0) > 0
                                            ? null
                                            : (values) {
                                                setState(() {
                                                  politicallyExposedValue = values;
                                                });
                                              },
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue == "Related to Politically exposed person",
                                    child: SizedBox(
                                      height: 16.h,
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null &&
                                        politicallyExposedValue!.isNotEmpty &&
                                        politicallyExposedValue ==
                                            "Related to Politically exposed person",
                                    child: Text(
                                      "Relationship with PEP",
                                      style: TextStyle(
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w600,
                                          color: unselectTab,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null &&
                                        politicallyExposedValue!.isNotEmpty &&
                                        politicallyExposedValue ==
                                            "Related to Politically exposed person",
                                    child: TextField(
                                      readOnly:
                                          (applicantDetail?.applicantId ?? 0) >
                                              0,
                                      style: TextStyle(color: blackColor),
                                      controller: relationPEPController,
                                      maxLength: 200,
                                      textInputAction: TextInputAction.next,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[a-z A-Z]'))
                                      ],
                                      decoration: InputDecoration(
                                        counterText: "",
                                        hintStyle: TextStyle(color: hintColor),
                                        hintText: "Enter Relationship with PEP",
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: themeColor),
                                        ),
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: hintColor),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: hintColor),
                                        ),
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA",
                                    child: SizedBox(
                                      height: 10.h,
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA",
                                    child: Text(
                                      "Source of funds for servicing the loan",
                                      style: TextStyle(
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w600,
                                          color: unselectTab,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA" ? true :false,
                                    child: SizedBox(
                                      height: 10.h,
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA"? true :false,
                                      child: DropDownMultiSelect(
                                        onChanged: (List<String> x) {
                                          setState(() {
                                            selectedValueService =x;
                                          });
                                        },
                                        options: sourceServingLoanList,
                                        isDense: true,
                                        selectedValues: selectedValueService,
                                        whenEmpty: 'Select Source of funds',
                                      ),
                                  ),



                                  // Visibility(
                                  //   visible: politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA",
                                  //   child: DropdownButton<String>(
                                  //     hint:
                                  //         const Text("Select Source of funds"),
                                  //     value: SourceServicingValue,
                                  //     isDense: false,
                                  //     items: sourceServingLoanList
                                  //         .map((String value) {
                                  //       return DropdownMenuItem<String>(value: value,
                                  //         child: Text(value,),);}).toList(),
                                  //     isExpanded: true,
                                  //     onChanged:
                                  //         (applicantDetail?.applicantId ?? 0) > 0 ? null : (values) {
                                  //                 setState(() {
                                  //                   SourceServicingValue = values;
                                  //                 });
                                  //               },
                                  //   ),
                                  // ),
                                  Visibility(
                                    visible: politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA",
                                    child: SizedBox(
                                      height: 16.h,
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA",
                                    child: Text(
                                      "Source of funds from which the investment was made",
                                      style: TextStyle(
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w600,
                                          color: unselectTab,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA",
                                    child: SizedBox(
                                      height: 10.h,
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA",
                                    child: DropDownMultiSelect(
                                      onChanged: (List<String> x) {
                                        setState(() {
                                          selectedValueInvestment = x;
                                        });
                                      },
                                      options: sourceInvestmentLoanList,
                                      isDense: true,
                                      selectedValues: selectedValueInvestment,
                                      whenEmpty: 'Select Source of funds',
                                    ),
                                  ),

                                  // Visibility(
                                  //   visible: politicallyExposedValue != null && politicallyExposedValue!.isNotEmpty && politicallyExposedValue != "NA",
                                  //   child: DropdownButton<String>(
                                  //     hint: Text("Select Source of funds"),
                                  //     value: SourceInvestmentValue,
                                  //     isDense: false,
                                  //     items: sourceInvestmentLoanList
                                  //         .map((String value) {
                                  //       return DropdownMenuItem<String>(
                                  //         value: value,
                                  //         child: Text(
                                  //           value,
                                  //         ),
                                  //       );
                                  //     }).toList(),
                                  //     isExpanded: true,
                                  //     onChanged:
                                  //         (applicantDetail?.applicantId ?? 0) >
                                  //                 0
                                  //             ? null
                                  //             : (values) {
                                  //                 setState(() {
                                  //                   SourceInvestmentValue =
                                  //                       values;
                                  //                 });
                                  //               },
                                  //   ),
                                  // ),


                                  Visibility(
                                    visible: politicallyExposedValue != null &&
                                        politicallyExposedValue!.isNotEmpty &&
                                        politicallyExposedValue != "NA",
                                    child: SizedBox(
                                      height: 16.h,
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null &&
                                        politicallyExposedValue!.isNotEmpty &&
                                        politicallyExposedValue != "NA",
                                    child: Text(
                                      "Estimated Net worth (Rs.)",
                                      style: TextStyle(
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w600,
                                          color: unselectTab,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null &&
                                        politicallyExposedValue!.isNotEmpty &&
                                        politicallyExposedValue != "NA",
                                    child: TextField(
                                      readOnly:
                                          (applicantDetail?.applicantId ?? 0) >
                                              0,
                                      controller: netWorthController,
                                      style: TextStyle(color: blackColor),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(color: hintColor),
                                        hintText: "Enter Estimated Net worth",
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: themeColor),
                                        ),
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: hintColor),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: hintColor),
                                        ),
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null &&
                                        politicallyExposedValue!.isNotEmpty &&
                                        politicallyExposedValue != "NA",
                                    child: SizedBox(
                                      height: 16.h,
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null &&
                                        politicallyExposedValue!.isNotEmpty &&
                                        politicallyExposedValue != "NA",
                                    child: Text(
                                      "Industry of occupation",
                                      style: TextStyle(
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w600,
                                          color: unselectTab,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  Visibility(
                                    visible: politicallyExposedValue != null &&
                                        politicallyExposedValue!.isNotEmpty &&
                                        politicallyExposedValue != "NA",
                                    child: DropdownButton<String>(
                                      hint: const Text(
                                          "Select Industry of occupation"),
                                      value: industryOccupationValue,
                                      isDense: false,
                                      items: industryOccupationList
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                          ),
                                        );
                                      }).toList(),
                                      isExpanded: true,
                                      onChanged:
                                          (applicantDetail?.applicantId ?? 0) >
                                                  0
                                              ? null
                                              : (values) {
                                                  setState(() {
                                                    industryOccupationValue =
                                                        values;
                                                  });
                                                },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    "Gross Monthly Income (In Rs.)",
                                    style: TextStyle(
                                        fontFamily: LocaleKeys.font_family,
                                        fontWeight: FontWeight.w600,
                                        color: unselectTab,
                                        fontSize: 12.sp),
                                  ),
                                  TextField(
                                    readOnly:
                                        (applicantDetail?.applicantId ?? 0) > 0,
                                    controller: monthlyIncomeController,
                                    style: TextStyle(color: blackColor),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(color: hintColor),
                                      hintText: "Enter Monthly Income",
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: themeColor),
                                      ),
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: hintColor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: hintColor),
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    "Loan Purpose",
                                    style: TextStyle(
                                        fontFamily: LocaleKeys.font_family,
                                        fontWeight: FontWeight.w600,
                                        color: unselectTab,
                                        fontSize: 12.sp),
                                  ),
                                  DropdownButton<PurposeData>(
                                    hint: const Text("Select Loan Purpose"),
                                    value: selectPurposeData,
                                    isDense: false,
                                    items: purposeList.map((PurposeData value) {
                                      return DropdownMenuItem<PurposeData>(
                                        value: value,
                                        child: Text(
                                          value.purpose ?? "",
                                        ),
                                      );
                                    }).toList(),
                                    isExpanded: true,
                                    onChanged:
                                        (applicantDetail?.applicantId ?? 0) > 0
                                            ? null
                                            : (values) {
                                                setState(() {
                                                  selectPurposeData = values;
                                                });
                                              },
                                  ),
                                  Visibility(
                                    visible: cKycNumberController.text.isEmpty,
                                    child: SizedBox(
                                      height: 16.h,
                                    ),
                                  ),
                                  Visibility(
                                    visible: cKycNumberController.text.isEmpty,
                                    child: Text(
                                      "Upload E-KYC XML",
                                      style: TextStyle(
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w600,
                                          color: unselectTab,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  Visibility(
                                    visible: cKycNumberController.text.isEmpty,
                                    child: TextField(
                                      readOnly: true,
                                      controller: eKycController,
                                      style: TextStyle(color: blackColor),
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: themeColor),
                                        ),
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: hintColor),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: hintColor),
                                        ),
                                        isDense: true,
                                        suffixIcon: GestureDetector(
                                          onTap: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                              type: FileType.custom,
                                              allowedExtensions: ['zip'],
                                            );
                                            if (result != null) {
                                              eKycController.text =
                                                  result.files.single.path ??
                                                      "";
                                              setState(() {
                                                file = File(
                                                    result.files.single.path ??
                                                        "");
                                              });
                                            } else {
                                              // User canceled the picker
                                            }
                                          },
                                          child: Container(
                                            width: 90.w,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 6.h),
                                            decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: themeColor),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(6.w),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "UPLOAD",
                                                style: TextStyle(
                                                    color: themeColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: cKycNumberController.text.isEmpty,
                                    child: SizedBox(
                                      height: 16.h,
                                    ),
                                  ),
                                  Visibility(
                                    visible: cKycNumberController.text.isEmpty,
                                    child: Text(
                                      "Provide Code for your Paperless Offline eKYC",
                                      style: TextStyle(
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w600,
                                          color: unselectTab,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  Visibility(
                                    visible: cKycNumberController.text.isEmpty,
                                    child: TextField(
                                      readOnly:
                                          (applicantDetail?.applicantId ?? 0) >
                                              0,
                                      controller: eKycCodeController,
                                      maxLength: 15,
                                      style: TextStyle(color: blackColor),
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(color: hintColor),
                                        hintText: "Enter Code",
                                        counterText: "",
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: themeColor),
                                        ),
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: hintColor),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: hintColor),
                                        ),
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: personalDetail?.digiLockerStatus !=
                                        "READY_FOR_DIGILOCKER",
                                    child: SizedBox(
                                      height: 10.h,
                                    ),
                                  ),
                                  Visibility(
                                    visible: applicantDetail?.applicantId == 0,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              "I/We hereby provide my/our explicit consent to NJC to update my/our address detail(s)/data in Central KYC (Know Your Customer) CKYC maintained by Central Registry of Securitisation Asset Reconstruction and Security Interest of India(CERSAI).",
                                              style: TextStyle(
                                                color: blackColor,
                                                fontSize: 14.sp,
                                                fontFamily:
                                                    LocaleKeys.font_family,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Text(
                                    "Permanent Address",
                                    style: TextStyle(
                                      fontFamily: LocaleKeys.font_family,
                                      fontWeight: FontWeight.w600,
                                      color: unselectTab,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  TextField(
                                    readOnly: true,
                                    controller: permanentController,
                                    style: TextStyle(
                                      color: blackColor,
                                    ),
                                    maxLength: 150,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        color: hintColor,
                                      ),
                                      counterText: "",
                                      hintText: "Enter Permanent Address",
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: themeColor,
                                        ),
                                      ),
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: hintColor,
                                        ),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: hintColor,
                                        ),
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    "Is your resident address same as correspondence address?",
                                    style: TextStyle(
                                      fontFamily: LocaleKeys.font_family,
                                      fontWeight: FontWeight.w600,
                                      color: unselectTab,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: "yes",
                                        groupValue: isCorrespondence,
                                        onChanged:
                                            applicantDetail?.addressDetails ==
                                                    "Y"
                                                ? null
                                                : (value) {
                                                    setState(() {
                                                      isCorrespondence =
                                                          value.toString();
                                                    });
                                                  },
                                      ),
                                      Text(
                                        "Yes",
                                        style: TextStyle(
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w600,
                                          color: blackColor,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Radio(
                                        value: "no",
                                        groupValue: isCorrespondence,
                                        onChanged:
                                            applicantDetail?.addressDetails ==
                                                    "Y"
                                                ? null
                                                : (value) {
                                                    setState(() {
                                                      isCorrespondence =
                                                          value.toString();
                                                    });
                                                  },
                                      ),
                                      Text(
                                        "No",
                                        style: TextStyle(
                                          fontFamily: LocaleKeys.font_family,
                                          fontWeight: FontWeight.w600,
                                          color: blackColor,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: isCorrespondence == "no",
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        Text(
                                          "Correspondence Address",
                                          style: TextStyle(
                                            fontFamily: LocaleKeys.font_family,
                                            fontWeight: FontWeight.w600,
                                            color: unselectTab,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        TextField(
                                          controller: correspondenceController,
                                          readOnly:
                                              applicantDetail?.addressDetails ==
                                                  "Y",
                                          style: TextStyle(
                                            color: blackColor,
                                          ),
                                          maxLength: 150,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                              color: hintColor,
                                            ),
                                            counterText: "",
                                            hintText:
                                                "Enter Correspondence Address",
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: themeColor,
                                              ),
                                            ),
                                            disabledBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: hintColor,
                                              ),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: hintColor,
                                              ),
                                            ),
                                            isDense: true,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        Text(
                                          "Country",
                                          style: TextStyle(
                                            fontFamily: LocaleKeys.font_family,
                                            fontWeight: FontWeight.w600,
                                            color: unselectTab,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        TextField(
                                          readOnly:
                                              applicantDetail?.addressDetails ==
                                                  "Y",
                                          controller: countryController,
                                          style: TextStyle(
                                            color: blackColor,
                                          ),
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                              color: hintColor,
                                            ),
                                            hintText: "Enter Country",
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: themeColor,
                                              ),
                                            ),
                                            disabledBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: hintColor,
                                              ),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: hintColor,
                                              ),
                                            ),
                                            isDense: true,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        Text(
                                          "State",
                                          style: TextStyle(
                                            fontFamily: LocaleKeys.font_family,
                                            fontWeight: FontWeight.w600,
                                            color: unselectTab,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        TextField(
                                          controller: stateController,
                                          style: TextStyle(
                                            color: blackColor,
                                          ),
                                          readOnly:
                                              applicantDetail?.addressDetails ==
                                                  "Y",
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                              color: hintColor,
                                            ),
                                            hintText: "Enter State",
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: themeColor,
                                              ),
                                            ),
                                            disabledBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: hintColor,
                                              ),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: hintColor,
                                              ),
                                            ),
                                            isDense: true,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        Text(
                                          "City",
                                          style: TextStyle(
                                            fontFamily: LocaleKeys.font_family,
                                            fontWeight: FontWeight.w600,
                                            color: unselectTab,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        TextField(
                                          controller: cityController,
                                          style: TextStyle(
                                            color: blackColor,
                                          ),
                                          readOnly:
                                              applicantDetail?.addressDetails ==
                                                  "Y",
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            hintStyle:
                                                TextStyle(color: hintColor),
                                            hintText: "Enter City",
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: themeColor,
                                              ),
                                            ),
                                            disabledBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: hintColor,
                                              ),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: hintColor,
                                              ),
                                            ),
                                            isDense: true,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        Text(
                                          "Pin Code",
                                          style: TextStyle(
                                            fontFamily: LocaleKeys.font_family,
                                            fontWeight: FontWeight.w600,
                                            color: unselectTab,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        TextField(
                                          controller: pincodeController,
                                          style: TextStyle(
                                            color: blackColor,
                                          ),
                                          readOnly:
                                              applicantDetail?.addressDetails ==
                                                  "Y",
                                          maxLength: 7,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                              color: hintColor,
                                            ),
                                            counterText: "",
                                            hintText: "Enter Pin Code",
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: themeColor,
                                              ),
                                            ),
                                            disabledBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: hintColor,
                                              ),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: hintColor,
                                              ),
                                            ),
                                            isDense: true,
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              applicantDetail?.addressDetails !=
                                                  "Y",
                                          child: SizedBox(
                                            height: 16.h,
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              applicantDetail?.addressDetails !=
                                                  "Y",
                                          child: Text(
                                            "Correspondence Address Proof Type",
                                            style: TextStyle(
                                              fontFamily:
                                                  LocaleKeys.font_family,
                                              fontWeight: FontWeight.w600,
                                              color: unselectTab,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              applicantDetail?.addressDetails !=
                                                  "Y",
                                          child: DropdownButton<String>(
                                            hint: const Text(
                                              "Select Address Proof",
                                            ),
                                            value: addressProofValue,
                                            isDense: false,
                                            items: LocaleKeys.addressProofList
                                                .map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                ),
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                            onChanged: applicantDetail
                                                        ?.addressDetails ==
                                                    "Y"
                                                ? null
                                                : (values) {
                                                    setState(() {
                                                      addressProofValue =
                                                          values;
                                                    });
                                                  },
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              applicantDetail?.addressDetails !=
                                                  "Y",
                                          child: SizedBox(
                                            height: 16.h,
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              applicantDetail?.addressDetails !=
                                                  "Y",
                                          child: Text(
                                            "Upload Address Proof",
                                            style: TextStyle(
                                              fontFamily:
                                                  LocaleKeys.font_family,
                                              fontWeight: FontWeight.w600,
                                              color: unselectTab,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              applicantDetail?.addressDetails !=
                                                  "Y",
                                          child: TextField(
                                            readOnly: true,
                                            onTap: () async {
                                              if (applicantDetail
                                                      ?.addressDetails !=
                                                  "Y") {
                                                FilePickerResult? result =
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                  type: FileType.custom,
                                                  allowedExtensions: ['pdf'],
                                                );
                                                if (result != null) {
                                                  addressProofController.text =
                                                      result.files.single
                                                              .path ??
                                                          "";
                                                  setState(() {
                                                    addressFile = File(result
                                                            .files
                                                            .single
                                                            .path ??
                                                        "");
                                                  });
                                                } else {
                                                  // User canceled the picker
                                                }
                                              }
                                            },
                                            controller: addressProofController,
                                            style: TextStyle(color: blackColor),
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: themeColor,
                                                ),
                                              ),
                                              disabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: hintColor,
                                                ),
                                              ),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: hintColor,
                                                ),
                                              ),
                                              isDense: true,
                                              suffixIcon: GestureDetector(
                                                onTap: () async {
                                                  if (addressFile != null && !isFileUploaded) {
                                                    if (ConnectivityUtils.instance.hasInternet) {
                                                      var uploadFile = await _service.uploadFile(addressFile!);
                                                      if (uploadFile?.code == 200) {
                                                        setState(() {isFileUploaded = true;});
                                                        Fluttertoast.showToast(msg: uploadFile?.message ?? "",
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
                                                  width: 90.w,
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 6.h,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: isFileUploaded
                                                          ? Colors.green
                                                          : dividerColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                        6.w,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      isFileUploaded ? "UPLOADED" : "UPLOAD",
                                                      style: TextStyle(
                                                        color: isFileUploaded
                                                            ? Colors.green
                                                            : themeColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        applicantDetail?.addressDetails != "Y",
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                          value: isTnCAddress,
                                          onChanged: (value) {
                                            setState(() {
                                              isTnCAddress = value ?? false;
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isTnCAddress = !isTnCAddress;
                                              });
                                            },
                                            child: Text(
                                              "I/We hereby provide my/our explicit consent to NJC to update my/our address detail(s)/data in Central KYC (Know Your Customer) CKYC maintained by Central Registry of Securitisation Asset Reconstruction and Security Interest of India(CERSAI).",
                                              style: TextStyle(
                                                color: blackColor,
                                                fontSize: 14.sp,
                                                fontFamily:
                                                    LocaleKeys.font_family,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
        ],
      ),
    );
  }

  void getPurposeList() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.getPurposeList();
      if (requestCas?.code == 200) {
        setState(() {
          purposeList = requestCas?.body?.list ?? [];
        });
      }
    }
  }

  void getApplicantList() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.getApplicantList();
      if (requestCas?.code == 200) {
        if (requestCas?.body?.applicantDetails?.isNotEmpty ?? false) {
          applicantList = requestCas?.body?.applicantDetails ?? [];
          applicantDetail = requestCas?.body?.applicantDetails![0];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('applicant_data', jsonEncode(applicantDetail));
          emiAmount = requestCas?.body?.emiAmount ?? 0;
          getPersonalDetails();
          getAddressList();
        }
      }
    }
  }

  void getPersonalDetails() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas =
          await _service.getPersonalDetails(applicantDetail?.applicantId ?? 0);
      if (requestCas?.code == 200) {
        personalDetail = requestCas?.body?.applicantDetails;
        setData();
      }
    }
  }

  void getAddressList() async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.getAddressList();
      if (requestCas?.code == 200) {
        addressList = requestCas?.body?.applicantDetails ?? [];
        for (var address in addressList) {
          getAddressDetail(address);
        }
      }
    }
  }

  void getAddressDetail(AddressDetail address) async {
    if (ConnectivityUtils.instance.hasInternet) {
      var requestCas = await _service.getAddressDetails(address.addressId ?? 0);
      if (requestCas?.code == 200) {
        if (requestCas?.body?.applicantDetails?.addressType == "PERMANENT") {
          permanentAddress = requestCas?.body?.applicantDetails;
          permanentController.text = permanentAddress?.address ?? "";
        } else if (requestCas?.body?.applicantDetails?.addressType ==
            "CORRESPONDENCE") {
          setState(() {
            isCorrespondence = "no";
          });
          correspodenceAddress = requestCas?.body?.applicantDetails;
          correspondenceController.text = correspodenceAddress?.address ?? "";
          countryController.text = correspodenceAddress?.country ?? "";
          stateController.text = correspodenceAddress?.state ?? "";
          cityController.text = correspodenceAddress?.city ?? "";
          pincodeController.text = correspodenceAddress?.pincode ?? "";
          addressProofController.text =
              correspodenceAddress?.addressProofFile ?? "";
        }
      }
    }
  }

  void setData() {
    applicantNameController.text = personalDetail?.applicantName ?? "";
    panController.text = personalDetail?.pan ?? "";
    birthController.text = DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(personalDetail?.dateOfBirth ?? ""));
    fatherNameController.text = personalDetail?.fatherName ?? "";
    maritalStatusValue = personalDetail?.maritalStatus;
    gender = personalDetail?.gender ?? "";
    mobileController.text = personalDetail?.mobile ?? "";
    emailController.text = personalDetail?.emailId ?? "";
    mobileCAMSController.text = personalDetail?.camsMobile ?? "";
    mobileKfintechController.text = personalDetail?.kfinMobile ?? "";
    landlineController.text = personalDetail?.landline ?? "";
    alternateNumberController.text = personalDetail?.alternateContact ?? "";
    cKycNumberController.text = personalDetail?.ckycNo ?? "";
    // tanController.text = personalDetail?.taxStatus ?? "";
    // nationalityController.text = personalDetail?.nationality ?? "";
    relationPEPController.text = personalDetail?.relationPep ?? "";
    netWorthController.text = personalDetail?.netWorth.toString() ?? "";
    monthlyIncomeController.text = personalDetail?.monthlyIncome ?? "";
    eKycController.text = personalDetail?.ekycXmlPath ?? "";
    eKycCodeController.text = personalDetail?.ekycXmlPassword ?? "";
    isTnC = personalDetail?.digiLockerStatus == "READY_FOR_DIGILOCKER";
    if (personalDetail?.occupation != null &&
        personalDetail!.occupation!.isNotEmpty) {
      if (!occupationList.contains(personalDetail?.occupation ?? "")) {
        setState(() {
          occupationList.add(personalDetail?.occupation ?? "");
          occupationValue = personalDetail?.occupation ?? "";
        });
      } else {
        setState(() {
          occupationValue = personalDetail?.occupation ?? "";
        });
      }
    }

    if (personalDetail?.politicallyExposed != null && personalDetail!.politicallyExposed!.isNotEmpty) {
      if (!politicallyExposedList.contains(personalDetail?.politicallyExposed ?? "")) {
        setState(() {
          politicallyExposedList.add(personalDetail?.politicallyExposed ?? "");
          politicallyExposedValue = personalDetail?.politicallyExposed ?? "";
        });
      } else {
        setState(() {
          politicallyExposedValue = personalDetail?.politicallyExposed ?? "";
        });
      }
    }

    if (personalDetail?.fundServingLoan != null && personalDetail!.fundServingLoan!.isNotEmpty) {
      if (!sourceServingLoanList.contains(personalDetail?.fundServingLoan ?? "")) {
        setState(() {
          sourceServingLoanList.add(personalDetail?.fundServingLoan ?? "");
          selectedValueService.add(personalDetail?.fundServingLoan ?? "");
          //SourceServicingValue = personalDetail?.fundServingLoan ?? "";
        });
      } else {
        setState(() {
          //SourceServicingValue = personalDetail?.fundServingLoan ?? "";
          selectedValueService.add(personalDetail?.fundServingLoan ?? "");
        });
      }
    }

    if (personalDetail?.fundInvestmentMade != null && personalDetail!.fundInvestmentMade!.isNotEmpty) {
      if (!sourceInvestmentLoanList.contains(personalDetail?.fundInvestmentMade ?? "")) {
        setState(() {
          sourceInvestmentLoanList.add(personalDetail?.fundInvestmentMade ?? "");
         // SourceInvestmentValue = personalDetail?.fundInvestmentMade ?? "";
          selectedValueInvestment.add(personalDetail?.fundInvestmentMade ?? "");
        });
      } else {
        setState(() {
          selectedValueInvestment.add(personalDetail?.fundInvestmentMade ?? "");
         // SourceInvestmentValue = personalDetail?.fundInvestmentMade ?? "";
        });
      }
    }

    if (personalDetail?.industryOfOccupation != null &&
        personalDetail!.industryOfOccupation!.isNotEmpty) {
      if (!industryOccupationList
          .contains(personalDetail?.industryOfOccupation ?? "")) {
        setState(() {
          industryOccupationList
              .add(personalDetail?.industryOfOccupation ?? "");
          industryOccupationValue = personalDetail?.industryOfOccupation ?? "";
        });
      } else {
        setState(() {
          industryOccupationValue = personalDetail?.industryOfOccupation ?? "";
        });
      }
    }

    if (personalDetail?.purposeOfLoan != null &&
        personalDetail!.purposeOfLoan!.isNotEmpty) {
      var temp = purposeList
          .where((element) =>
              element.purposeMastId.toString() == personalDetail!.purposeOfLoan)
          .toList();
      if (temp.isNotEmpty) {
        setState(() {
          selectPurposeData = temp[0];
        });
      }
    }
  }

  Future<bool?> _showKycDetail(
      BuildContext context,
      DigilokerFetchBody? digilokerFetchBody,
      String? logId,
      String? token) async {
    final _byteImage = const Base64Decoder()
        .convert(digilokerFetchBody?.image?.split(',').last ?? "");
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              color: whiteColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Details",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 18.sp,
                      fontFamily: LocaleKeys.font_family,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Image.memory(
                            _byteImage,
                            height: 120.h,
                            width: 80.w,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${digilokerFetchBody?.address}",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 12.sp,
                            fontFamily: LocaleKeys.font_family,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            Get.back();
                            var result = await _service.digilokerRetry(
                                applicantDetail?.applicantId ?? 0);
                            if (result != null) {
                              if (result.code == 200) {
                                await callDigiloker(
                                    result.body?.digiLockerId ?? 0);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "${result.message}",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }
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
                                "Retry",
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
                            var resultFetch = await _service.digilokerConfirm(
                                applicantDetail?.applicantType ?? "",
                                logId ?? "",
                                applicantDetail?.applicantId ?? 0,
                                token ?? "");
                            if (resultFetch?.code == 200) {
                              Constant.eventBus.fire(KycPageChangeEvent(3));
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
                                "Confirm",
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

  Future<bool> callDigiloker(int digiLockerId) async {
    var map = <String, String>{};
    map['url'] =
        "https://ifagateway.njtechdesk.com/eservices/digi-locker/customer/kyc/open?tranNo=$digiLockerId";
    var results = await Get.toNamed(Routes.DEFAULT_BROWSER, arguments: map);
    if (results is Map<String, String>) {
      var logId = results["logId"];
      var token = results["token"];
      var resultFetch = await _service.digilokerFetch(
          applicantDetail?.applicantType ?? "",
          logId ?? "",
          applicantDetail?.applicantId ?? 0,
          token ?? "");
      if (resultFetch?.code == 200) {
        getAddressList();
        _showKycDetail(context, resultFetch?.body, logId, token);
        return true;
      }
    }
    return false;
  }

  Future<bool> saveAddress(Map<String, Object> body) async {
    var resultFetch = await _service.saveAddress(body);
    if (resultFetch?.code == 200) {
      Constant.eventBus.fire(PageChangeEvent(4));
    }
    return false;
  }
}
