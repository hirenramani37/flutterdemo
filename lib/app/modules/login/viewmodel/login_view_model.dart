import 'package:customer/app/modules/login/model/request_otp_response.dart';
import 'package:customer/app/modules/login/model/valid_customer_reponse.dart';
import 'package:customer/app/modules/login/model/validate_otp_response.dart';
import 'package:customer/network/base_api_service.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseApiService {
  LoginViewModel(BuildContext context) : super(context);

  Future<ValidCustomerResponse?> validCustomer(String customerNumber) async {
    return callApi(
      client.validCustomer(
        customerNumber: customerNumber,
      ),
    );
  }

  Future<RequestOtpResponse?> sendOTP(String username) async {
    return callApi(
      client.sendOTP(
        username: username,
      ),
    );
  }

  Future<RequestOtpResponse?> resendOTP(String token,String username) async {
    return callApi(
      client.resendOTP(
        token: token,
        username: username,
      ),
    );
  }

  Future<ValidateOTPResponse?> validateOtp(String otp,String token,String username) async {
    return callApi(
      client.validateOtp(
        otp: otp,
        token: token,
        username: username,
      ),
    );
  }
}
