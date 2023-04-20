import 'package:customer/app/modules/emi/model/know_emi_response.dart';
import 'package:customer/network/base_api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KnowEmiViewModel extends BaseApiService {
  KnowEmiViewModel(BuildContext context) : super(context);

  Future<KnowEmiResponse?> knowYourEmi(
      dynamic emiTenure, dynamic loanAmount) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var loanApplicationId = prefs.getString("loanApplicationId");
    return await callApi(
      client.knowYourEmi(token ?? "",
          loanApplicationId: loanApplicationId ?? "",
          emiTenure: emiTenure,
          loanAmount: loanAmount),
    );
  }
}
