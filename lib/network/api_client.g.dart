part of 'api_client.dart';

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  @override
  Future<ValidCustomerResponse> validCustomer(
      {required String customerNumber}) async {
    final _data = {'customerNumber': customerNumber};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ValidCustomerResponse>(Options(method: 'POST')
            .compose(_dio.options, LocaleKeys.validCustomer, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ValidCustomerResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RequestOtpResponse> sendOTP({required String username}) async {
    final _data = {'username': username};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RequestOtpResponse>(Options(method: 'POST')
            .compose(_dio.options, LocaleKeys.requestOTP, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RequestOtpResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RequestOtpResponse> resendOTP(
      {required String token, required String username}) async {
    final _data = {'username': username, 'token': token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RequestOtpResponse>(Options(method: 'POST')
            .compose(_dio.options, LocaleKeys.resendOTP, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RequestOtpResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ValidateOTPResponse> validateOtp({required String otp,
    required String token,
    required String username}) async {
    final _data = {'otp': otp, 'username': username, 'token': token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ValidateOTPResponse>(Options(method: 'POST')
            .compose(_dio.options, LocaleKeys.validateOTP, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ValidateOTPResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DashboardResponse> dashboardData(String token) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DashboardResponse>(
            Options(method: 'POST', headers: _header)
                .compose(_dio.options, LocaleKeys.dashboardData)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DashboardResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProcessCasResponse> bankUsedLoan(String token,
      String loanApplicationId, String bankId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        ProcessCasResponse>(Options(
        method: 'POST', headers: _header)
        .compose(_dio.options,
        "${LocaleKeys.bankUsedLoan}$bankId/loan-application/$loanApplicationId")
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProcessCasResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProductFeatureResponse> productFeature(String token) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProductFeatureResponse>(
            Options(method: 'GET', headers: _header)
                .compose(_dio.options, LocaleKeys.productFeature)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProductFeatureResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProductFeatureEligibleResponse> productFeatureEligible(String token,
      {required String loanApplicationId,
        required int consentTimestamp}) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {
      'consentList': [
        {
          'consentMessage':
          'Provide my/our explicit consent to NJ Capital Private Limited (NJC) to retrieve my/our KYC detail(s)/data  from CKYC.\nProvide the  consent to update the detail(s)/data available with CKYC database if required under relevant regulation(s).\nAuthorize NJC to obtain information/data concerning me/us from one or more credit bureau(s), bank(s) and any such agencies as may be necessary in order to carry out my /our credit appraisal / affordability assessment while processing  my/our loan Application.\nUnderstand and confirm that the Loan application may be rejected and that the terms of the Loan are derived from my/our credit appraisal/ affordability assessment. The eligibility criteria of the Loan shall solely be determined by NJC and may be amended from time to time.',
          'consentTimestamp': consentTimestamp,
          'ipAddress': ''
        }
      ]
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProductFeatureEligibleResponse>(
            Options(method: 'POST', headers: _header)
                .compose(_dio.options,
                "${LocaleKeys.productFeatureEligible}$loanApplicationId",
                data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProductFeatureEligibleResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProcessCasResponse> savePersonalDetails(String token,
      String loanApplicationId, Map<String, Object?> body) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProcessCasResponse>(
            Options(method: 'POST', headers: _header)
                .compose(_dio.options,
                "${LocaleKeys.savePersonalDetails}$loanApplicationId",
                data: body)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProcessCasResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BankAddResponse> addBank(String token, String loanApplicationId,
      Map<String, Object?> body) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BankAddResponse>(
            Options(method: 'POST', headers: _header)
                .compose(
                _dio.options, "${LocaleKeys.addBank}$loanApplicationId",
                data: body)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BankAddResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProcessCasResponse> saveAddress(String token, String loanApplicationId,
      Map<String, Object?> body) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProcessCasResponse>(
            Options(method: 'POST', headers: _header)
                .compose(
                _dio.options, "${LocaleKeys.addressSave}$loanApplicationId",
                data: body)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProcessCasResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PurposeListResponse> purposeList(String token) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PurposeListResponse>(
            Options(method: 'GET', headers: _header)
                .compose(_dio.options, LocaleKeys.purposeLists)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PurposeListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApplicantListResponse> applicantResponse(String token,
      String loanApplicationId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApplicantListResponse>(Options(
            method: 'GET', headers: _header)
            .compose(
            _dio.options, "${LocaleKeys.applicantList}$loanApplicationId")
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApplicantListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FetchSecurityResponse> fetchAllSecurity(String token,
      String loanApplicationId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FetchSecurityResponse>(
            Options(method: 'GET', headers: _header)
                .compose(_dio.options,
                "${LocaleKeys.fetchAllSecurity}$loanApplicationId")
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FetchSecurityResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BankListResponse> bankList(String token,
      String loanApplicationId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BankListResponse>(Options(
            method: 'GET', headers: _header)
            .compose(_dio.options, "${LocaleKeys.bankList}$loanApplicationId")
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BankListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BankIfscResponse> ifscResponse(String token, String ifsc) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BankIfscResponse>(
            Options(method: 'GET', headers: _header)
                .compose(_dio.options, ifsc)
                .copyWith(baseUrl: LocaleKeys.ifsc)));
    final value = BankIfscResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddressListResponse> addressList(String token,
      String loanApplicationId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddressListResponse>(
            Options(method: 'GET', headers: _header)
                .compose(
                _dio.options, "${LocaleKeys.addressList}$loanApplicationId")
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddressListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RequestCasResponse> requestCas(String token,
      {required String loanApplicationId}) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RequestCasResponse>(Options(
            method: 'GET', headers: _header)
            .compose(_dio.options, "${LocaleKeys.requestCas}$loanApplicationId")
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RequestCasResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProcessCasResponse> processCas(String token,
      {required String loanApplicationId}) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProcessCasResponse>(Options(
            method: 'POST', headers: _header)
            .compose(_dio.options, "${LocaleKeys.processCas}$loanApplicationId")
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProcessCasResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProcessCasResponse> saveEmis(String token,
      {required String loanApplicationId,
        required double loanAmount,
        required int tenureAmount}) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {'emiTenure': tenureAmount, 'loanAmount': loanAmount};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProcessCasResponse>(Options(
            method: 'POST', headers: _header)
            .compose(
            _dio.options, "${LocaleKeys.saveKnowYourEmi}$loanApplicationId",
            data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProcessCasResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DigilokerRetryResponse> digilokerRetry(String token,
      String loanApplicationId, int applicantId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {
      'applicantId': applicantId,
      'loanApplicationId': loanApplicationId
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DigilokerRetryResponse>(
            Options(method: 'POST', headers: _header)
                .compose(_dio.options, LocaleKeys.digilokerRetry, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DigilokerRetryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DigilokerFetchResponse> digilokerFetch(String token,
      String loanApplicationId,
      String applicantType,
      String digiLockerLogId,
      int loanApplicantId,
      String digiToken) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {
      'applicantType': applicantType,
      'digiLockerLogId': digiLockerLogId,
      'loanApplicantId': loanApplicantId,
      'loanApplicationId': loanApplicationId,
      'token': digiToken
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DigilokerFetchResponse>(
            Options(method: 'POST', headers: _header)
                .compose(_dio.options, LocaleKeys.digilokerFetch, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DigilokerFetchResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String> photoVerificationInitiate(String token,
      String loanApplicationId,
      String applicantType,
      int loanApplicantId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {
      'applicantType': applicantType,
      'loanApplicantId': loanApplicantId,
      'loanApplicationDraftId': loanApplicationId,
    };
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'POST', headers: _header)
            .compose(_dio.options, LocaleKeys.photoVerificationInitiate,
            queryParameters: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<PhotoVerificationResponse> photoVerificationFetch(String token,
      String requestNumber) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PhotoVerificationResponse>(
            Options(method: 'GET', headers: _header)
                .compose(_dio.options,
                "${LocaleKeys.photoVerificationFetch}$requestNumber")
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PhotoVerificationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FetchFileResponse> fetchFile(String token, String path) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {
      'path': path,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FetchFileResponse>(Options(
            method: 'POST', headers: _header)
            .compose(_dio.options, LocaleKeys.fetchFile, queryParameters: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FetchFileResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProcessCasResponse> updateAction(String token, String action,
      int applicantId, String loanApplicationId, String requestNumber) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {
      'action': action,
      'applicantId': applicantId,
      'loanApplicationId': loanApplicationId,
      'requestNumber': requestNumber,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProcessCasResponse>(
            Options(method: 'POST', headers: _header)
                .compose(_dio.options, LocaleKeys.photoApprove, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProcessCasResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DigilokerFetchResponse> digilokerConfirm(String token,
      String loanApplicationId,
      String applicantType,
      String digiLockerLogId,
      int loanApplicantId,
      String digiToken) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {
      'applicantType': applicantType,
      'digiLockerLogId': digiLockerLogId,
      'loanApplicantId': loanApplicantId,
      'loanApplicationId': loanApplicationId,
      'token': digiToken
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DigilokerFetchResponse>(
            Options(method: 'POST', headers: _header)
                .compose(_dio.options, LocaleKeys.digilokerConfirm, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DigilokerFetchResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<KnowEmiResponse> knowYourEmi(String token,
      {required String loanApplicationId,
        required dynamic emiTenure,
        required dynamic loanAmount}) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {'emiTenure': emiTenure, 'loanAmount': loanAmount};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<KnowEmiResponse>(
            Options(method: 'POST', headers: _header)
                .compose(
                _dio.options, "${LocaleKeys.knowYourEmi}$loanApplicationId",
                data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = KnowEmiResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PersonalDetailResponse> personalDetails(String token,
      String loanApplicationId, int applicantId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PersonalDetailResponse>(Options(
            method: 'POST', headers: _header)
            .compose(_dio.options,
            "${LocaleKeys.personalDetail}$loanApplicationId/$applicantId")
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PersonalDetailResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddressDetailResponse> addressDetails(String token,
      String loanApplicationId, int applicantId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddressDetailResponse>(Options(
            method: 'POST', headers: _header)
            .compose(_dio.options,
            "${LocaleKeys.addressDetails}$loanApplicationId/$applicantId")
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddressDetailResponse.fromJson(_result.data!);
    return value;
  }

  @POST(LocaleKeys.fileUpload)
  @MultiPart()
  @override
  Future<FileUploadResponse> uploadFile(String token, @Part(name: "file") File document) async {
    final _header = {'Authorization': "Bearer $token"};

    var formData = FormData.fromMap({});
    var file = await MultipartFile.fromFile(document.path,
        filename: basename(document.path),
        contentType: MediaType("pdf", basename(document.path)));

    formData.files.add(MapEntry('file', file));

    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FileUploadResponse>(
            Options(method: 'POST', headers: _header)
                .compose(_dio.options, LocaleKeys.fileUpload, data: formData)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FileUploadResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProcessCasResponse> saveSelectedSecurity(String token,
      String loanApplicationId, Map<String, Object> data) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProcessCasResponse>(Options(
            method: 'POST', headers: _header)
            .compose(
            _dio.options, "${LocaleKeys.saveSecurity}$loanApplicationId",
            data: data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProcessCasResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoanSummaryResponse> loanSummary(String token,
      String loanApplicationId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoanSummaryResponse>(
            Options(method: 'GET', headers: _header)
                .compose(
                _dio.options, "${LocaleKeys.loanSummary}$loanApplicationId")
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoanSummaryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoanSanctionResponse> loanSanction(String token,
      String loanApplicationId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoanSanctionResponse>(Options(
            method: 'POST', headers: _header)
            .compose(
            _dio.options, "${LocaleKeys.loanSanction}$loanApplicationId")
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoanSanctionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PledgeDocsResponse> pledgeDocs(String token,
      String loanApplicationId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PledgeDocsResponse>(Options(
            method: 'GET', headers: _header)
            .compose(
            _dio.options, "${LocaleKeys.pledgeAllDoc}$loanApplicationId")
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PledgeDocsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PledgeDocViewResponse> pledgeDocView(String token,
      String loanApplicationId, String type, String pledgeId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {'documentType': type, 'esignPldgPdfId': pledgeId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PledgeDocViewResponse>(Options(
            method: 'POST', headers: _header)
            .compose(
            _dio.options, "${LocaleKeys.pledgeDocShow}$loanApplicationId",
            data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PledgeDocViewResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<KfinOtpResponse> kfinOtpRequest(String token,
      String loanApplicationId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<KfinOtpResponse>(Options(
            method: 'POST', headers: _header)
            .compose(
            _dio.options, "${LocaleKeys.kfinRequestOtp}$loanApplicationId")
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = KfinOtpResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<KfinVerificationResponse> kfinVerifyOtp(String token,
      String loanApplicationId, Map<String, String> data) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<KfinVerificationResponse>(Options(
            method: 'POST', headers: _header)
            .compose(
            _dio.options, "${LocaleKeys.kfinValidateOtp}$loanApplicationId",
            data: data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = KfinVerificationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CamsUrlResponse> requestCamsUrl(String token,
      String loanApplicationId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CamsUrlResponse>(Options(
            method: 'POST', headers: _header)
            .compose(
            _dio.options, "${LocaleKeys.requestCamsUrl}$loanApplicationId")
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CamsUrlResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CamsStatusResponse> checkCamsStatus(String token, String loanApplicationId, String sessionId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {'sessionId': sessionId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CamsStatusResponse>(Options(
            method: 'POST', headers: _header)
            .compose(_dio.options, "${LocaleKeys.camsStatus}$loanApplicationId",
            data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CamsStatusResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<InitateAgreementResponse> agreementInitate(String token,
      String loanApplicationId, DateTime date, String esignId,
      String esignPdfId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {
      "consent": {
        "consentMessage": "",
        "consentTimestamp": date.millisecondsSinceEpoch,
        "ipAddress": ""
      },
      "esignId": esignId,
      "esignPdfId": esignPdfId,
      "otp": 0,
      "token": ""
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<InitateAgreementResponse>(Options(
            method: 'POST', headers: _header)
            .compose(_dio.options,
            "${LocaleKeys.pledgeAgreementInitate}$loanApplicationId",
            data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = InitateAgreementResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AgreementVerified> agreementVerifyOtp(String token,
      String loanApplicationId, DateTime date, String esignId,
      String esignPdfId, int otpNew, String tokenNew) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {
      "consent": {
        "consentMessage": "",
        "consentTimestamp": date.millisecondsSinceEpoch,
        "ipAddress": ""
      },
      "esignId": esignId,
      "esignPdfId": esignPdfId,
      "otp": otpNew,
      "token": tokenNew
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AgreementVerified>(Options(
            method: 'POST', headers: _header)
            .compose(_dio.options,
            "${LocaleKeys.pledgeAgreementVerifyOtp}$loanApplicationId",
            data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AgreementVerified.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MandateResponse> mandateAllowedTypes(String token, String loanApplicationId) async {
    // String token, String loanApplicationId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MandateResponse>(Options(
            method: 'GET', headers: _header)
            .compose(
            _dio.options, "${LocaleKeys.mandateAllowedTypes}$loanApplicationId")
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MandateResponse.fromJson(_result.data!);
    return value;
    // }
  }

  @override
  Future<ResponseEMandate> eMandate(String token, String loanApplicationId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseEMandate>(Options(
            method: 'GET', headers: _header)
            .compose(
            _dio.options, "${LocaleKeys.eMandate}$loanApplicationId")
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseEMandate.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DownloadMandateResponse> downloadMandate(String token, String loanApplicationId) async {
    final _header = {'Authorization': "Bearer $token"};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DownloadMandateResponse>(Options(
            method: 'GET', headers: _header)
            .compose(
            _dio.options, "${LocaleKeys.downloadMandate}$loanApplicationId")
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DownloadMandateResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FileUploadResponse> uploadFileMandate(String token, File document) async {
    final _header = {'Authorization': "Bearer $token"};

    var formData = FormData.fromMap({});
    var file = await MultipartFile.fromFile(document.path,
        filename: basename(document.path),
        contentType: MediaType("pdf", basename(document.path)));

    formData.files.add(MapEntry('file', file));

    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FileUploadResponse>(
            Options(method: 'POST', headers: _header)
                .compose(_dio.options, LocaleKeys.fileUploadMandate, data: formData)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FileUploadResponse.fromJson(_result.data!);
    return value;

  }

  @override
  Future<UploadMandateFinal> fileUpload(String token, String? loanApplicationId,String filePath) async {
    final _header = {'Authorization': "Bearer $token"};
    final _data = {'signedImagePath': filePath};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UploadMandateFinal>(Options(
            method: 'POST', headers: _header)
            .compose(_dio.options, "${LocaleKeys.uploadFinalMandate}$loanApplicationId",
            data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UploadMandateFinal.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResponseEMandate> loanStatus(String token, String loanApplicationId) {
    // TODO: implement loanStatus
    throw UnimplementedError();
  }



}
