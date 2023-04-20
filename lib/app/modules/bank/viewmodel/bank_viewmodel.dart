import 'dart:io';

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
import 'package:customer/network/base_api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankViewModel extends BaseApiService {
  BankViewModel(BuildContext context) : super(context);

  Future<BankListResponse?> getBankList() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.bankList(token ?? "", loanApplicationId ?? ""),
    );
  }

  Future<BankIfscResponse?> getIfsc(String ifsc) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return await callApi(client.ifscResponse(token ?? "", ifsc),
        doShowLoader: false);
  }

  Future<ProcessCasResponse?> bankUsedLoan(String bankId) async {
    final prefs = await SharedPreferences.getInstance();
    var loanApplicationId = prefs.getString("loanApplicationId");
    var token = prefs.getString("token");
    return await callApi(client.bankUsedLoan(token ?? "", loanApplicationId??"",bankId));
  }

  Future<BankAddResponse?> addBankData(Map<String, Object?> data) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
        client.addBank(token ?? "", loanApplicationId ?? "", data),
    );
  }

  Future<FileUploadResponse?> uploadFile(File path) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return await callApi(
      client.uploadFile(token ?? "", path),
    );
  }
}
