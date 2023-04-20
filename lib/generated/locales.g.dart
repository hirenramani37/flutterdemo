// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

// ignore_for_file: lines_longer_than_80_chars
// ignore: avoid_classes_with_only_static_members
class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'en_US': Locales.en_US,
  };
}

class LocaleKeys {
  // String
  static const app_name = 'NJ Customer Loan';
  static const internetMsg = 'Internet not available!';
  static const font_family = 'redhat';

  // Icon
  static const ic_app_icon = 'asset/images/ic_app_icon.png';
  static const ic_login_back = 'asset/images/ic_login_back.png';
  static const ic_bottom_home = 'asset/images/ic_bottom_home.png';
  static const ic_bottom_home_in = 'asset/images/ic_bottom_home_in.png';
  static const ic_bottom_loan = 'asset/images/ic_bottom_loan.png';
  static const ic_bottom_loan_in = 'asset/images/ic_bottom_loan_in.png';
  static const ic_bottom_report = 'asset/images/ic_bottom_report.png';
  static const ic_bottom_report_in = 'asset/images/ic_bottom_report_in.png';
  static const ic_bottom_service = 'asset/images/ic_bottom_service.png';
  static const ic_bottom_service_in = 'asset/images/ic_bottom_service_in.png';
  static const ic_notification = 'asset/images/ic_notification.png';
  static const ic_dummy_brand = 'asset/images/ic_dummy_brand.png';
  static const ic_personal_loan = 'asset/images/ic_personal_loan.png';
  static const ic_loan_against = 'asset/images/ic_loan_against.png';
  static const ic_home_loan = 'asset/images/ic_home_loan.png';
  static const ic_nav_help = 'asset/images/ic_nav_help.png';
  static const ic_nav_loan = 'asset/images/ic_nav_loan.png';
  static const ic_nav_logout = 'asset/images/ic_nav_logout.png';
  static const ic_nav_profile = 'asset/images/ic_nav_profile.png';
  static const ic_nav_report = 'asset/images/ic_nav_report.png';
  static const ic_nav_service = 'asset/images/ic_nav_service.png';
  static const ic_nav_setting = 'asset/images/ic_nav_setting.png';
  static const ic_loan_demat = 'asset/images/ic_loan_demat.png';
  static const ic_loan_physical = 'asset/images/ic_loan_physical.png';
  static const ic_report_emi = 'asset/images/ic_report_emi.png';
  static const ic_service_query = 'asset/images/ic_service_query.png';
  static const ic_service_mandate = 'asset/images/ic_service_mandate.png';
  static const ic_arrow_down = 'asset/images/ic_arrow_down.png';
  static const ic_correct_image = 'asset/images/ic_correct_image.png';
  static const ic_fetch_profile = 'asset/images/ic_fetch_profile.png';
  static const ic_fetch_email = 'asset/images/ic_fetch_email.png';
  static const ic_fetch_back = 'asset/images/ic_fetch_back.png';
  static const ic_fetch_next = 'asset/images/ic_fetch_next.png';
  static const ic_fetch_reset = 'asset/images/ic_fetch_reset.png';
  static const ic_fetch_cancel = 'asset/images/ic_fetch_cancel.png';
  static const ic_calendar = 'asset/images/ic_calendar.png';
  static const ic_bank_dummy = 'asset/images/ic_bank_dummy.png';
  static const ic_eye = 'asset/images/ic_eye.png';
  static const ic_update_kyc = 'asset/images/ic_update_kyc.png';
  static const ic_proceed_same = 'asset/images/ic_proceed_same.png';
  static const ic_delete = 'asset/images/ic_delete.png';

  static const List<String> maritalStatusList = [
    "MARRIED",
    "UNMARRIED",
    "OTHERS"
  ];
  static List<String> politicallyExposedList = [
    "NA",
    "POLITICALLY EXPOSED PERSON",
    "RELATED TO POLITICALLY EXPOSED PERSON"
  ];
  static List<String> sourceServingLoanList = [
    "SALARY",
    "BUSINESS",
    "RENT INCOME",
    "INVESTMENT",
    "SALE OF ASSET",
    "INTEREST/DIVIDEND"
  ];
  static List<String> occupationList = [
    "BUSINESS",
    "PROFESSIONAL",
    "SELF EMPLOYED",
    "HOUSEWIFE",
    "SERVICE - PUBLIC SECTOR",
    "SERVICE - PRIVATE SECTOR",
    "RETIRED",
    "STUDENT",
    "AGRICULTURE",
    "NOT CATEGORISED",
    "SERVICE - GOVERNMENT SECTOR",
    "OTHER",
  ];
  static const List<String> industryOccupationList = [
    "TRAVEL",
    "TELEMARKETERS",
    "CAR/BOAT/PLANE DEALERSHIP",
    "DEALER IN HIGH VALUE OR PRECIOUS GOODS"
  ];
  static const List<String> addressProofList = [
    "Utility Bill",
    "Rent Deed",
    "Self attested Utility bill + NOC of the property owner"
  ];
  static const List<String> accountTypeList = [
    "Savings",
    "Current",
    "NRI - NRO",
    "NRI - NRE",
    "Others"
  ];
  static const List<String> bankDocumentList = [
    "Salary slip latest 3 months",
    "Bank statement-6 months applicant",
    "Form - 16 Latest 2 Years",
    "Balance Sheet-Profit Loss A-C-2YR",
    "ITR- Latest 2YR-individual-Firm-Co",
    "3CB 3CD Should be of last 3 Years",
    "Perfios"
  ];
  static const List<String> purposeList = [
    "Agriculture",
    "Business",
    "Education",
    "Holidays",
    "Marriage",
    "Family & social occasions",
    "Loan/ Credit Cards Repayment",
    "Medical Expenses",
    "Purchase of Vehicle",
    "Property Purchase",
    "Home Improvement",
    "Furniture Acquisition",
    "Consumer Durables / Electronics",
    "Personal Effects",
    "Investment in capital markets"
  ];

  // Api Constant
  static const baseApi = "https://ifagateway.njtechdesk.com/customer/";
  static const validCustomer = "customer/validate-customer-number";
  static const requestOTP = "customer/login/request-otp";
  static const resendOTP = "customer/login/resend-otp";
  static const validateOTP = "customer/login/validate-otp";
  static const dashboardData = "customer/dashboard";
  static const productFeature = "customer/loan-journey/product-features";
  static const productFeatureEligible = "customer/loan-journey/product-features/";
  static const requestCas = "customer/request-cas/";
  static const purposeLists = "customer/loan-journey/e-kyc/personal-details/purpose-list";
  static const processCas = "customer/process-file/";
  static const knowYourEmi = "customer/loan-journey/emi-config/emi-options/";
  static const saveKnowYourEmi = "customer/loan-journey/emi-config/emi-options/save/";
  static const fileUpload = "common/fileUpload/true";
  static const applicantList = "customer/loan-journey/e-kyc/personal-details/";
  static const bankList = "customer/list-banks/";
  static const ifsc = "https://ifagateway.njtechdesk.com/core/common/bank-details/";
  static const bankUsedLoan = "customer/bank/map/";
  static const addressList = "customer/loan-journey/e-kyc/address-details/";
  static const personalDetail = "customer/loan-journey/e-kyc/personal-details/";
  static const addressDetails = "customer/loan-journey/e-kyc/address-details/";
  static const savePersonalDetails = "customer/loan-journey/e-kyc/personal-details/";
  static const addBank = "customer/bank/";
  static const digilokerRetry = "customer/loan-journey/e-kyc/digi-locker/re-try";
  static const digilokerFetch = "customer/loan-journey/e-kyc/digi-locker/fetch";
  static const photoVerificationInitiate = "customer/loan-journey/e-kyc/photo-verification/initiate";
  static const photoVerificationFetch = "customer/loan-journey/e-kyc/photo-verification/fetch/";
  static const digilokerConfirm = "customer/loan-journey/e-kyc/digi-locker/confirm";
  static const addressSave = "customer/loan-journey/e-kyc/address-details/";
  static const fetchFile = "common/fetchFile";
  static const photoApprove = "customer/loan-journey/e-kyc/photo-verification/approve";
  static const fetchAllSecurity = "customer/securities-selection/fetch-all/";
  static const saveSecurity = "customer/securities-selection/save/";
  static const loanSummary = "customer/loan-journey/summary/";
  static const loanSanction = "customer/loan-journey/sanction/";
  static const pledgeAllDoc = "customer/loan-journey/pledge/view-all-doc-list/";
  static const pledgeDocShow = "customer/loan-journey/pledge/view-doc/";
  static const kfinRequestOtp = "customer/loan-journey/pledge/kfin/request-otp/";
  static const kfinValidateOtp = "customer/loan-journey/pledge/kfin/validate-otp/";
  static const requestCamsUrl = "customer/loan-journey/pledge/cams/initate/";
  static const camsStatus = "customer/loan-journey/pledge/cams/status-check/";
  static const pledgeAgreementInitate = "customer/customer/loan-journey/pledge/agreement/initate/";
  static const pledgeAgreementVerifyOtp = "customer/loan-journey/pledge/agreement/verify-otp/";
  static const mandateAllowedTypes = "customer/loan-journey/mandate/allowed-types/";
  static const eMandate = "customer/loan-journey/mandate/e-mandate/";
  static const downloadMandate = "customer/loan-journey/mandate/physical-mandate/download-mandate-image/";
  static const fileUploadMandate = "common/fileUpload/false";
  static const uploadFinalMandate = "customer/loan-journey/mandate/physical-mandate/apply-mandate/";
  static const loanApplicationStatus = "summary/loan-application-status";
}

class Locales {
  static const en_US = {
    LocaleKeys.app_name: 'Maintenance',
  };
}
