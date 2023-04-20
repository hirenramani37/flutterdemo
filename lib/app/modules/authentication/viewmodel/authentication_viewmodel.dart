import 'dart:io';

import 'package:customer/app/modules/authentication/model/agreement_verified.dart';
import 'package:customer/app/modules/authentication/model/cams_status_response.dart';
import 'package:customer/app/modules/authentication/model/cams_url_response.dart';
import 'package:customer/app/modules/authentication/model/docs_view_response.dart';
import 'package:customer/app/modules/authentication/model/download_mandate_response.dart';
import 'package:customer/app/modules/authentication/model/mandate_response.dart';
import 'package:customer/app/modules/authentication/model/pledge_docs_response.dart';
import 'package:customer/app/modules/authentication/model/response_e_mandate.dart';
import 'package:customer/app/modules/authentication/model/upload_mandate_final.dart';
import 'package:customer/app/modules/bank/model/bank_add_response.dart';
import 'package:customer/app/modules/bank/model/bank_ifsc_response.dart';
import 'package:customer/app/modules/bank/model/bank_list_response.dart';
import 'package:customer/app/modules/fetchcas/model/file_upload_response.dart';
import 'package:customer/app/modules/fetchcas/model/process_cas_response.dart';
import 'package:customer/app/modules/kyc/model/address_detail_response.dart';
import 'package:customer/app/modules/kyc/model/address_list_response.dart';
import 'package:customer/app/modules/kyc/model/applicant_list_response.dart';
import 'package:customer/app/modules/kyc/model/digiloker_fetch_response.dart';
import 'package:customer/app/modules/kyc/model/digiloker_retry_response.dart';
import 'package:customer/app/modules/kyc/model/fetch_file_response.dart';
import 'package:customer/app/modules/kyc/model/personal_detail_response.dart';
import 'package:customer/app/modules/kyc/model/photo_verification_response.dart';
import 'package:customer/app/modules/kyc/model/purpose_list_response.dart';
import 'package:customer/app/modules/otp/model/kfin_otp_response.dart';
import 'package:customer/app/modules/otp/model/kfin_verification_response.dart';
import 'package:customer/app/modules/security/model/fetch_security_response.dart';
import 'package:customer/app/modules/summary/model/loan_summary_response.dart';
import 'package:customer/network/base_api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/initateAgreement_response.dart';

class AuthenticationViewModel extends BaseApiService {
  AuthenticationViewModel(BuildContext context) : super(context);

  Future<PledgeDocsResponse?> pledgeDocs() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.pledgeDocs(token ?? "", loanApplicationId ?? ""),
    );
  }

  Future<PledgeDocViewResponse?> pledgeDocView(String type , String pledgeId) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.pledgeDocView(token ?? "", loanApplicationId ?? "",type,pledgeId),
    );
  }

  Future<KfinOtpResponse?> kfinOtpRequest() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.kfinOtpRequest(token ?? "", loanApplicationId ?? ""),
    );
  }

  Future<KfinVerificationResponse?> kfinVerifyOtp(Map<String, String> data) async{
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.kfinVerifyOtp(token ?? "", loanApplicationId ?? "",data),
    );
  }

  Future<CamsUrlResponse?> requestCamsUrl() async{
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.requestCamsUrl(token ?? "", loanApplicationId ?? ""),
    );
  }

  Future<CamsStatusResponse?> checkCamsStatus(String sessionId) async{
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.checkCamsStatus(token ?? "", loanApplicationId ?? "",sessionId),doShowLoader: false
    );
  }

  Future<InitateAgreementResponse?> agreementInitate(DateTime date,String esignId,String esignPdfId) async{
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
        client.agreementInitate(token ?? "", loanApplicationId ?? "",date,esignId,esignPdfId),doShowLoader: false
    );
  }

  Future<AgreementVerified?> agreementVerifyOtp(DateTime date,String esignId,String esignPdfId,int otpNew,String tokenNew) async{
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
        client.agreementVerifyOtp(token ?? "", loanApplicationId ?? "",date,esignId,esignPdfId,otpNew,tokenNew),doShowLoader: false
    );
  }
/// getMandate
  Future<MandateResponse?> checkMandate() async{
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
        client.mandateAllowedTypes(token ?? "", loanApplicationId ?? ""),doShowLoader: false
    );
  }
 ///e Mandate
  Future<ResponseEMandate?> eMandate() async{
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
        client.eMandate(token ?? "", loanApplicationId ?? ""),doShowLoader: false
    );
  }
///download Mandate
  Future<DownloadMandateResponse?> downloadMandate() async{
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    print("loanApplicationId${loanApplicationId}");
    return await callApi(
        client.downloadMandate(token ?? "", loanApplicationId ?? ""),doShowLoader: false
    );
  }

  ///updateFileMandate
  Future<FileUploadResponse?> uploadFileMandate(File path) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return await callApi(client.uploadFileMandate(token ?? "", path),);
  }

  Future<UploadMandateFinal?> uploadFileFinal(String filePath) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(client.fileUpload(token ?? "", loanApplicationId,filePath),);
  }

  Future<ResponseEMandate?> applicationLoanStatus(String filePath) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(client.loanStatus(token ?? "", loanApplicationId,filePath),);
  }

}
