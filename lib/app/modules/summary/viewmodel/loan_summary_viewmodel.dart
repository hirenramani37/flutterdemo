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
import 'package:customer/app/modules/security/model/fetch_security_response.dart';
import 'package:customer/app/modules/summary/model/loan_summary_response.dart';
import 'package:customer/network/base_api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanSummaryViewModel extends BaseApiService {
  LoanSummaryViewModel(BuildContext context) : super(context);

  Future<LoanSummaryResponse?> loanSummary() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.loanSummary(token ?? "", loanApplicationId ?? ""),
    );
  }

}
