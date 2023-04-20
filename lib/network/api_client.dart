import 'dart:io';

import 'package:customer/app/modules/authentication/model/agreement_verified.dart';
import 'package:customer/app/modules/authentication/model/cams_status_response.dart';
import 'package:customer/app/modules/authentication/model/cams_url_response.dart';
import 'package:customer/app/modules/authentication/model/docs_view_response.dart';
import 'package:customer/app/modules/authentication/model/download_mandate_response.dart';
import 'package:customer/app/modules/authentication/model/mandate_response.dart';
import 'package:customer/app/modules/authentication/model/pledge_docs_response.dart';
import 'package:customer/app/modules/bank/model/bank_add_response.dart';
import 'package:customer/app/modules/bank/model/bank_ifsc_response.dart';
import 'package:customer/app/modules/bank/model/bank_list_response.dart';
import 'package:customer/app/modules/bank/view/bank_add_view.dart';
import 'package:customer/app/modules/dashboard/model/dashboard_response.dart';
import 'package:customer/app/modules/dashboard/model/loan_eligible_response.dart';
import 'package:customer/app/modules/dashboard/model/product_feature_response.dart';
import 'package:customer/app/modules/emi/model/know_emi_response.dart';
import 'package:customer/app/modules/fetchcas/model/file_upload_response.dart';
import 'package:customer/app/modules/fetchcas/model/process_cas_response.dart';
import 'package:customer/app/modules/fetchcas/model/request_cas_response.dart';
import 'package:customer/app/modules/kyc/model/address_detail_response.dart';
import 'package:customer/app/modules/kyc/model/address_list_response.dart';
import 'package:customer/app/modules/kyc/model/applicant_list_response.dart';
import 'package:customer/app/modules/kyc/model/digiloker_fetch_response.dart';
import 'package:customer/app/modules/kyc/model/digiloker_retry_response.dart';
import 'package:customer/app/modules/kyc/model/fetch_file_response.dart';
import 'package:customer/app/modules/kyc/model/personal_detail_response.dart';
import 'package:customer/app/modules/kyc/model/photo_verification_response.dart';
import 'package:customer/app/modules/kyc/model/purpose_list_response.dart';
import 'package:customer/app/modules/login/model/request_otp_response.dart';
import 'package:customer/app/modules/login/model/valid_customer_reponse.dart';
import 'package:customer/app/modules/login/model/validate_otp_response.dart';
import 'package:customer/app/modules/otp/model/kfin_otp_response.dart';
import 'package:customer/app/modules/otp/model/kfin_verification_response.dart';
import 'package:customer/app/modules/security/model/fetch_security_response.dart';
import 'package:customer/app/modules/summary/model/loan_sanction_response.dart';
import 'package:customer/app/modules/summary/model/loan_summary_response.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:dio/dio.dart';
import 'package:dio_proxy_adapter/dio_proxy_adapter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:retrofit/retrofit.dart';
import '../app/modules/authentication/model/initateAgreement_response.dart';
import '../app/modules/authentication/model/response_e_mandate.dart';
import '../app/modules/authentication/model/upload_mandate_final.dart';
import 'interceptor/api_interceptor.dart';
import 'interceptor/cache_interceptor.dart';
part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  static late ApiClient _instance;
  static late Dio dio;
  static const bool doWriteLog = true;
  static const bool doEncryption = false;

  static ApiClient get instance => _instance;

  factory ApiClient._private(Dio dio, {String baseUrl}) = _ApiClient;

  static Future<void> init() async {
    var options = BaseOptions(
      baseUrl: LocaleKeys.baseApi,
      connectTimeout: 30000,
      receiveTimeout: 60000,
      sendTimeout: 60000,
      headers: {
        "Content-Type": "application/json",
        "Accept": 'application/json'
      },
    );
    dio = Dio(options);
    dio.useProxy('3.111.130.52:8080');
    // dio.useProxy('https://3.111.130.52:8080');
    // dio.useProxy(const bool.hasEnvironment('http://3.111.130.52:8080') ? const String.fromEnvironment('http://3.111.130.52:8080') : null);
    dio.interceptors.addAll([
      ApiInterceptor(doEncryption: doEncryption, doWriteLog: doWriteLog),
      CacheInterceptor(),
    ]);
    _instance = ApiClient._private(dio, baseUrl: LocaleKeys.baseApi);
  }

  @POST(LocaleKeys.validCustomer)
  Future<ValidCustomerResponse> validCustomer(
      {@Field("customerNumber") required String customerNumber});

  @POST(LocaleKeys.requestOTP)
  Future<RequestOtpResponse> sendOTP(
      {@Field("username") required String username});

  @POST(LocaleKeys.resendOTP)
  Future<RequestOtpResponse> resendOTP({
    @Field("token") required String token,
    @Field("username") required String username,
  });

  @POST(LocaleKeys.validateOTP)
  Future<ValidateOTPResponse> validateOtp({
    @Field("otp") required String otp,
    @Field("token") required String token,
    @Field("username") required String username,
  });

  @POST(LocaleKeys.dashboardData)
  Future<DashboardResponse> dashboardData(String token);

  @POST(LocaleKeys.productFeatureEligible)
  Future<ProductFeatureEligibleResponse> productFeatureEligible(String token,
      {@Field("loanApplicationId") required String loanApplicationId,
      @Field("consentTimestamp") required int consentTimestamp});

  @GET(LocaleKeys.productFeature)
  Future<ProductFeatureResponse> productFeature(String token);

  @GET(LocaleKeys.requestCas)
  Future<RequestCasResponse> requestCas(String token,
      {@Field("loanApplicationId") required String loanApplicationId});

  @GET(LocaleKeys.purposeLists)
  Future<PurposeListResponse> purposeList(String token);

  @POST(LocaleKeys.processCas)
  Future<ProcessCasResponse> processCas(String token,
      {@Field("loanApplicationId") required String loanApplicationId});

  @POST(LocaleKeys.knowYourEmi)
  Future<KnowEmiResponse> knowYourEmi(String token,
      {@Field("loanApplicationId") required String loanApplicationId,
      @Field("emiTenure") required dynamic emiTenure,
      @Field("loanAmount") required dynamic loanAmount});

  @POST(LocaleKeys.fileUpload)
  @MultiPart()
  Future<FileUploadResponse> uploadFile(
      String token, @Part(name: "file") File document);

  @POST(LocaleKeys.saveKnowYourEmi)
  Future<ProcessCasResponse> saveEmis(String token,
      {@Field("loanApplicationId") required String loanApplicationId,
      @Field("loanAmount") required double loanAmount,
      @Field("tenureAmount") required int tenureAmount});

  @GET(LocaleKeys.applicantList)
  Future<ApplicantListResponse> applicantResponse(
      String token, String loanApplicationId);

  @GET(LocaleKeys.bankList)
  Future<BankListResponse> bankList(String token, String loanApplicationId);

  @POST(LocaleKeys.addBank)
  Future<BankAddResponse> addBank(String token, String loanApplicationId, Map<String, Object?> body);

  @GET(LocaleKeys.ifsc)
  Future<BankIfscResponse> ifscResponse(String token, String ifsc);

  @POST(LocaleKeys.bankUsedLoan)
  Future<ProcessCasResponse> bankUsedLoan(String token,String loanApplicationId, String bankId);

  @GET(LocaleKeys.addressList)
  Future<AddressListResponse> addressList(
      String token, String loanApplicationId);

  @GET(LocaleKeys.fetchAllSecurity)
  Future<FetchSecurityResponse> fetchAllSecurity(
      String token, String loanApplicationId);

  @POST(LocaleKeys.personalDetail)
  Future<PersonalDetailResponse> personalDetails(
      String token, String loanApplicationId, int applicantId);

  @POST(LocaleKeys.addressDetails)
  Future<AddressDetailResponse> addressDetails(
      String token, String loanApplicationId, int applicantId);

  @POST(LocaleKeys.savePersonalDetails)
  Future<ProcessCasResponse> savePersonalDetails(
      String token, String loanApplicationId, Map<String, Object?> body);

  @POST(LocaleKeys.addressSave)
  Future<ProcessCasResponse> saveAddress(
      String token, String loanApplicationId, Map<String, Object?> body);

  @POST(LocaleKeys.digilokerRetry)
  Future<DigilokerRetryResponse> digilokerRetry(
      String token, String loanApplicationId, int applicantId);

  @POST(LocaleKeys.digilokerFetch)
  Future<DigilokerFetchResponse> digilokerFetch(
      String token,
      String loanApplicationId,
      String applicantType,
      String digiLockerLogId,
      int loanApplicantId,
      String digiToken);

  @POST(LocaleKeys.photoVerificationInitiate)
  Future<String> photoVerificationInitiate(String token,
      String loanApplicationId, String applicantType, int loanApplicantId);

  @GET(LocaleKeys.photoVerificationFetch)
  Future<PhotoVerificationResponse> photoVerificationFetch(
      String token, String requestNumber);

  @POST(LocaleKeys.fetchFile)
  Future<FetchFileResponse> fetchFile(String token, String path);

  @POST(LocaleKeys.photoApprove)
  Future<ProcessCasResponse> updateAction(String token, String action,
      int applicantId, String loanApplicationId, String requestNumber);

  @POST(LocaleKeys.digilokerConfirm)
  Future<DigilokerFetchResponse> digilokerConfirm(
      String token,
      String loanApplicationId,
      String applicantType,
      String digiLockerLogId,
      int loanApplicantId,
      String digiToken);

  @POST(LocaleKeys.saveSecurity)
  Future<ProcessCasResponse> saveSelectedSecurity(String token, String loanApplicationId, Map<String, Object> data);

  @GET(LocaleKeys.loanSummary)
  Future<LoanSummaryResponse> loanSummary(String token, String loanApplicationId);

  @GET(LocaleKeys.pledgeAllDoc)
  Future<PledgeDocsResponse> pledgeDocs(String token, String loanApplicationId);

  @POST(LocaleKeys.loanSanction)
  Future<LoanSanctionResponse> loanSanction(String token, String loanApplicationId);

  @POST(LocaleKeys.pledgeDocShow)
  Future<PledgeDocViewResponse> pledgeDocView(String token, String loanApplicationId, String type, String pledgeId);

  @POST(LocaleKeys.kfinRequestOtp)
  Future<KfinOtpResponse> kfinOtpRequest(String token, String loanApplicationId);

  @POST(LocaleKeys.kfinValidateOtp)
  Future<KfinVerificationResponse> kfinVerifyOtp(String token, String loanApplicationId, Map<String, String> data);

  @POST(LocaleKeys.requestCamsUrl)
  Future<CamsUrlResponse> requestCamsUrl(String token, String loanApplicationId);

  @POST(LocaleKeys.camsStatus)
  Future<CamsStatusResponse> checkCamsStatus(String token, String loanApplicationId, String sessionId);

  @POST(LocaleKeys.pledgeAgreementInitate)
  Future<InitateAgreementResponse> agreementInitate(String token,String loanApplicationId,DateTime date,String esignId,String esignPdfId);

  @POST(LocaleKeys.pledgeAgreementVerifyOtp)
  Future<AgreementVerified> agreementVerifyOtp(String token, String loanApplicationId, DateTime date, String esignId, String esignPdfId,int otpNew,String tokenNew);

  @GET(LocaleKeys.mandateAllowedTypes)
  Future<MandateResponse> mandateAllowedTypes(String token,String loanApplicationId);

  @GET(LocaleKeys.eMandate)
  Future<ResponseEMandate> eMandate(String token,String loanApplicationId);

  @GET(LocaleKeys.downloadMandate)
  Future<DownloadMandateResponse> downloadMandate(String token,String loanApplicationId);

  @POST(LocaleKeys.fileUploadMandate)
  @MultiPart()
  Future<FileUploadResponse> uploadFileMandate(String token, @Part(name: "file") File document);

  @POST(LocaleKeys.fileUploadMandate)
  Future<UploadMandateFinal> fileUpload(String token,String? loanApplicationId,String filePath);

  @GET(LocaleKeys.loanApplicationStatus)
  Future<ResponseEMandate> loanStatus(String token,String loanApplicationId);

}
