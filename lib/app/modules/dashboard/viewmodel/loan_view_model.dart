import 'package:customer/app/modules/dashboard/model/dashboard_response.dart';
import 'package:customer/app/modules/dashboard/model/loan_eligible_response.dart';
import 'package:customer/app/modules/dashboard/model/product_feature_response.dart';
import 'package:customer/app/modules/kyc/model/applicant_list_response.dart';
import 'package:customer/network/base_api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanViewModel extends BaseApiService {
  LoanViewModel(BuildContext context) : super(context);

  Future<DashboardResponse?> dashboardData() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return await callApi(
      client.dashboardData(token ?? ""),
    );
  }

  Future<ProductFeatureResponse?> productFeature() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return await callApi(
      client.productFeature(token ?? ""),
    );
  }

  Future<ProductFeatureEligibleResponse?> productFeatureEligible(int consentTimestamp) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.productFeatureEligible(token ?? "",
          loanApplicationId: loanApplicationId ?? "",consentTimestamp: consentTimestamp),
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
}
