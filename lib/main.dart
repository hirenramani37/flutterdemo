import 'package:customer/app/routes/app_pages.dart';
import 'package:customer/generated/locales.g.dart';
import 'package:customer/network/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

/*class ProxiedHttpOverrides extends HttpOverrides {

  ProxiedHttpOverrides();

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..findProxy = (uri) {
        return "PROXY 3.111.130.52:8080;";
      }
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await ApiClient.init();
  runApp(
    GetMaterialApp(
      title: LocaleKeys.app_name,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      translationsKeys: AppTranslation.translations,
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
    ),
  );
}
