import 'dart:io';

import 'package:customer/app/modules/emi/model/know_emi_response.dart';
import 'package:customer/app/modules/fetchcas/model/file_upload_response.dart';
import 'package:customer/app/modules/fetchcas/model/process_cas_response.dart';
import 'package:customer/app/modules/fetchcas/model/request_cas_response.dart';
import 'package:customer/app/modules/summary/model/loan_sanction_response.dart';
import 'package:customer/network/base_api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchCasViewModel extends BaseApiService {
  FetchCasViewModel(BuildContext context) : super(context);

  Future<RequestCasResponse?> requestCas() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.requestCas(token ?? "",loanApplicationId: loanApplicationId??""),
    );
  }

  Future<ProcessCasResponse?> processCas() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.processCas(token ?? "",loanApplicationId: loanApplicationId??""),
    );
  }

  Future<LoanSanctionResponse?> loanSanction() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.loanSanction(token ?? "", loanApplicationId??""),
    );
  }

  Future<FileUploadResponse?> uploadFile(File path) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return await callApi(
      client.uploadFile(token ?? "", path),
    );
  }

  Future<ProcessCasResponse?> saveEmis(double loanAmount, int tenureAmount) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.saveEmis(token ?? "",loanApplicationId: loanApplicationId??"",loanAmount : loanAmount,tenureAmount:tenureAmount),
    );
  }

}