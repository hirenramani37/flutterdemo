import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String getLocale(
  BuildContext context, {
  Locale? selectedLocale,
}) {
  if (selectedLocale != null) {
    return '${selectedLocale.languageCode}_${selectedLocale.countryCode}';
  }
  var locale = Localizations.localeOf(context);
  if (locale == null) {
    return Intl.systemLocale;
  }
  return '${locale.languageCode}_${locale.countryCode}';
}

String getIndianCurrencyInShorthand({required double amount}) {
  final inrShortCutFormatInstance =
      NumberFormat.compactSimpleCurrency(locale: 'en_IN', name: "");
  var inrShortCutFormat = inrShortCutFormatInstance.format(amount);
  if (inrShortCutFormat.contains('T')) {
    return inrShortCutFormat.replaceAll(RegExp(r'T'), 'k');
  }
  return inrShortCutFormat;
}

String moneyFormat(dynamic price) {
  final indianRupeesFormat = NumberFormat.currency(
    name: "INR",
    locale: 'en_IN',
    decimalDigits: 2, // change it to get decimal places
    symbol: '₹',
  );
  return indianRupeesFormat.format(price);
}

String moneyFormatWithoutDecimal(dynamic price) {
  final indianRupeesFormat = NumberFormat.currency(
    name: "INR",
    locale: 'en_IN',
    decimalDigits: 0, // change it to get decimal places
    symbol: '₹',
  );
  return indianRupeesFormat.format(price);
}

String moneyFormatWithoutSign(dynamic price) {
  final indianRupeesFormat = NumberFormat.currency(
    name: "INR",
    locale: 'en_IN',
    decimalDigits: 0, // change it to get decimal places
    symbol: '',
  );
  return indianRupeesFormat.format(price);
}

String moneyFormatWithoutSign2(dynamic price) {
  final indianRupeesFormat = NumberFormat.currency(
    name: "INR",
    locale: 'en_IN',
    decimalDigits: 2, // change it to get decimal places
    symbol: '',
  );
  return indianRupeesFormat.format(price);
}

String moneyFormatWithoutSign3(dynamic price) {
  final indianRupeesFormat = NumberFormat.currency(
    name: "INR",
    locale: 'en_IN',
    decimalDigits: 3, // change it to get decimal places
    symbol: '',
  );
  return indianRupeesFormat.format(price);
}