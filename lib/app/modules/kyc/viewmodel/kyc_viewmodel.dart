import 'dart:io';

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
import 'package:customer/network/base_api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KycViewModel extends BaseApiService {
  KycViewModel(BuildContext context) : super(context);

  Future<PurposeListResponse?> getPurposeList() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return await callApi(
      client.purposeList(token ?? ""),
    );
  }

  Future<ApplicantListResponse?> getApplicantList() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.applicantResponse(token ?? "", loanApplicationId ?? ""),
    );
  }

  Future<AddressListResponse?> getAddressList() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.addressList(token ?? "", loanApplicationId ?? ""),
    );
  }

  Future<PersonalDetailResponse?> getPersonalDetails(int applicantId) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.personalDetails(token ?? "", loanApplicationId ?? "", applicantId),
    );
  }

  Future<ProcessCasResponse?> savePersonalDetails(
      Map<String, Object?> body) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.savePersonalDetails(token ?? "", loanApplicationId ?? "", body),
    );
  }

  Future<ProcessCasResponse?> saveAddress(Map<String, Object?> body) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.saveAddress(token ?? "", loanApplicationId ?? "", body),
    );
  }

  Future<FileUploadResponse?> uploadFile(File path) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return await callApi(
      client.uploadFile(token ?? "", path),
    );
  }

  Future<AddressDetailResponse?> getAddressDetails(int addressId) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.addressDetails(token ?? "", loanApplicationId ?? "", addressId),
    );
  }

  Future<DigilokerRetryResponse?> digilokerRetry(int applicantId) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.digilokerRetry(token ?? "", loanApplicationId ?? "", applicantId),
    );
  }

  Future<DigilokerFetchResponse?> digilokerFetch(String applicantType,
      String digiLockerLogId, int loanApplicantId, String digiToken) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.digilokerFetch(token ?? "", loanApplicationId ?? "", applicantType,
          digiLockerLogId, loanApplicantId, digiToken),
    );
  }

  Future<String?> photoVerificationInitiate(
      String applicantType, int loanApplicantId) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.photoVerificationInitiate(
        token ?? "",
        loanApplicationId ?? "",
        applicantType,
        loanApplicantId,
      ),
    );
  }

  Future<PhotoVerificationResponse?> photoVerificationFetch( String requestNumber) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return await callApi(
      client.photoVerificationFetch(
        token ?? "",
        requestNumber ?? "",
      ),
    );
  }

  Future<FetchFileResponse?> fetchFile(String path) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return await callApi(
      client.fetchFile(
        token ?? "",
        path ?? "",
      ),
    );
  }

  Future<ProcessCasResponse?> updateAction(String requestNumber,String action,int  applicantId) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.updateAction(
        token ?? "",
        action ?? "",
        applicantId ?? 0,
        loanApplicationId ?? "",
        requestNumber ?? "",
      ),
    );
  }

  Future<DigilokerFetchResponse?> digilokerConfirm(String applicantType,
      String digiLockerLogId, int loanApplicantId, String digiToken) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.digilokerConfirm(token ?? "", loanApplicationId ?? "",
          applicantType, digiLockerLogId, loanApplicantId, digiToken),
    );
  }
}
