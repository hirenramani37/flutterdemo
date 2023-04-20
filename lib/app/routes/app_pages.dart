import 'package:customer/app/modules/bank/view/bank_add_view.dart';
import 'package:customer/app/modules/bank/view/physical_mandate_view.dart';
import 'package:customer/app/modules/ckyc/view/ckyc_view.dart';
import 'package:customer/app/modules/dashboard/view/dashboard_view.dart';
import 'package:customer/app/modules/emi/view/emi_payment_view.dart';
import 'package:customer/app/modules/emi/view/overdue_emi_view.dart';
import 'package:customer/app/modules/emicalculator/view/emi_calculator_view.dart';
import 'package:customer/app/modules/fetchcas/view/fetch_cas_view.dart';
import 'package:customer/app/modules/foreclosure/view/foreclosure_loan_view.dart';
import 'package:customer/app/modules/help/view/help_view.dart';
import 'package:customer/app/modules/interest/view/interest_certificate_view.dart';
import 'package:customer/app/modules/interim/view/interim_valuation_view.dart';
import 'package:customer/app/modules/login/view/login_view.dart';
import 'package:customer/app/modules/mergin/view/margin_shortfall_view.dart';
import 'package:customer/app/modules/pdf/view/pdf_view.dart';
import 'package:customer/app/modules/profile/view/profile_view.dart';
import 'package:customer/app/modules/request/view/request_view.dart';
import 'package:customer/app/modules/servicepayment/view/service_payment_view.dart';
import 'package:customer/app/modules/setting/view/setting_view.dart';
import 'package:customer/app/modules/splash/view/splash_view.dart';
import 'package:customer/app/modules/statement/view/statement_account_view.dart';
import 'package:customer/app/modules/terms/view/terms_view.dart';
import 'package:customer/app/modules/webview/view/default_webview.dart';
import 'package:customer/app/modules/webview/view/html_webview.dart';
import 'package:get/get.dart';

import '../modules/authentication/view/authentication_view.dart';
import '../modules/bank/view/bank_mandate_view.dart';
import '../modules/bank/view/e_mandate_view.dart';
import '../modules/kyc/view/live_photo_view.dart';
import '../modules/otp/view/otp_view.dart';
import '../modules/security/view/security_selection_view.dart';
import '../modules/summary/view/loan_summary_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      //page: () => const EMandateView(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      //page: () => const PhysicalMandateView(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
    ),
    GetPage(
      name: _Paths.HELP,
      page: () => const HelpView(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: _Paths.FETCH_CAS,
      page: () => const FetchCasView(),
    ),
    GetPage(
      name: _Paths.TERM_CONDITION,
      page: () => const TermsView(),
    ),
    GetPage(
      name: _Paths.BANK_ADD,
      page: () => const BankAddView(),
    ),
    GetPage(
      name: _Paths.REQUEST_VIEW,
      page: () => const RequestView(),
    ),
    GetPage(
      name: _Paths.STATEMENT_ACCOUNT,
      page: () => const StatementAccountView(),
    ),
    GetPage(
      name: _Paths.INTERIM_VALUATION,
      page: () => const InterimValuationView(),
    ),
    GetPage(
      name: _Paths.INTEREST_CERTIFICATE,
      page: () => const InterestCertificateView(),
    ),
    GetPage(
      name: _Paths.EMI_CALCULATOR,
      page: () => const EmiCalculatorView(),
    ),
    GetPage(
      name: _Paths.SERVICE_PAYMENT,
      page: () => const ServicePaymentView(),
    ),
    GetPage(
      name: _Paths.OVERDUE_VIEW,
      page: () => const OverdueEMIView(),
    ),
    GetPage(
      name: _Paths.MARGIN_SHORTFALL,
      page: () => const MarginShortfallView(),
    ),
    GetPage(
      name: _Paths.FORECLOSUER_LOAN,
      page: () => const ForeclosureLoanView(),
    ),
    GetPage(
      name: _Paths.EMI_PAYMENT,
      page: () => const EMIPaymentView(),
    ),
    GetPage(
      name: _Paths.CKYC_VIEW,
      page: () => const CKYCView(),
    ),
    GetPage(
      name: _Paths.DEFAULT_BROWSER,
      page: () => InAppBrowser(),
    ),
    GetPage(
      name: _Paths.HTML_BROWSER,
      page: () => HtmlBrowser(),
    ),
    GetPage(
      name: _Paths.PDF_VIEW,
      page: () => const PdfView(),
    ),
    GetPage(
      name: _Paths.LIVE_PHOTOS_VIEW,
      page: () =>  LivePhotoView(null,1),
    ),
    GetPage(
      name: _Paths.SECURITY_SELECTION_VIEW,
      page: () =>  const SecuritySelectionView(null),
    ),
    GetPage(
      name: _Paths.LOAN_SMMARY_VIEW,
      page: () =>  const LoanSummaryView(),
    ),
    GetPage(
      name: _Paths.VIEW_ALL_DOCS,
      page: () =>  const AuthenticationView(),
    ),
    GetPage(
      name: _Paths.PLEDGE_SECURITY,
      page: () =>   OtpView(null),
    ),
    GetPage(
      name: _Paths.BANK_MANDATE,
      page: () =>   BankMandateView(),
    ),
  ];
}
