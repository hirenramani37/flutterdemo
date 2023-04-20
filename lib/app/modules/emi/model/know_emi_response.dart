import 'package:customer/app/constant/common.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class KnowEmiResponse {
  String? status;
  String? message;
  int? code;
  KnowEmiBody? body;

  KnowEmiResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory KnowEmiResponse.fromJson(dynamic json) =>
      _$KnowEmiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KnowEmiResponseToJson(this);
}

KnowEmiResponse _$KnowEmiResponseFromJson(Map<String, dynamic> json) =>
    KnowEmiResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$KnowEmiBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$KnowEmiResponseToJson(KnowEmiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class KnowEmiBody {
  KnowEmiConfig? config;

  KnowEmiBody({
    required this.config,
  });

  factory KnowEmiBody.fromJson(dynamic json) => _$KnowEmiBodyFromJson(json);

  Map<String, dynamic> toJson() => _$KnowEmiBodyToJson(this);
}

KnowEmiBody _$KnowEmiBodyFromJson(Map<String, dynamic> json) => KnowEmiBody(
      config: json.containsKey('config') && json['config'] != null
          ? _$KnowEmiConfigFromJson(json['config'])
          : null,
    );

Map<String, dynamic> _$KnowEmiBodyToJson(KnowEmiBody instance) =>
    <String, dynamic>{
      'config': instance.config,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class KnowEmiConfig {
  double? totalPortfolioValue;
  double? securitiesPledged;
  double? availableForPledging;
  double? loanEligibility;
  double? minLoanAmount;
  double? maxLoanAmount;
  double? defaultEmiValue;
  List<int>? availableTenure = [];
  KnowEmiSelected? selected;

  KnowEmiConfig({
    required this.totalPortfolioValue,
    required this.securitiesPledged,
    required this.availableForPledging,
    required this.loanEligibility,
    required this.minLoanAmount,
    required this.maxLoanAmount,
    required this.defaultEmiValue,
    required this.availableTenure,
    required this.selected,
  });

  factory KnowEmiConfig.fromJson(dynamic json) => _$KnowEmiConfigFromJson(json);

  Map<String, dynamic> toJson() => _$KnowEmiConfigToJson(this);
}

KnowEmiConfig _$KnowEmiConfigFromJson(Map<String, dynamic> json) =>
    KnowEmiConfig(
        totalPortfolioValue: typecast(json, 'totalPortfolioValue'),
        securitiesPledged: typecast(json, 'securitiesPledged'),
        availableForPledging: typecast(json, 'availableForPledging'),
        loanEligibility: typecast(json, 'loanEligibility'),
        minLoanAmount: typecast(json, 'minLoanAmount'),
        maxLoanAmount: typecast(json, 'maxLoanAmount'),
        defaultEmiValue: typecast(json, 'defaultEmiValue'),
        availableTenure: json.containsKey('availableTenure') &&
                json['availableTenure'] != null
            ? List<int>.from(json['availableTenure'].map((x) => x))
            : [],
        selected: json.containsKey('selected') && json['selected'] != null
            ? _$KnowEmiSelectedFromJson(json['selected'])
            : null);

Map<String, dynamic> _$KnowEmiConfigToJson(KnowEmiConfig instance) =>
    <String, dynamic>{
      'totalPortfolioValue': instance.totalPortfolioValue,
      'securitiesPledged': instance.securitiesPledged,
      'availableForPledging': instance.availableForPledging,
      'loanEligibility': instance.loanEligibility,
      'minLoanAmount': instance.minLoanAmount,
      'maxLoanAmount': instance.maxLoanAmount,
      'defaultEmiValue': instance.defaultEmiValue,
      'availableTenure': instance.availableTenure,
      'selected': instance.selected,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class KnowEmiSelected {
  String? TENURE;
  double? EMI_AMOUNT;
  double? TOTAL_REPAY_AMOUNT;
  double? EMP_DIFF_RATE;
  double? PROC_FEES;
  int? INT_DET_ID;
  String? PRODUCT_CODE;
  String? INTREST_RATE;
  double? CIBIL_DIFF_RATE;
  double? DOC_FEES;
  String? LOAN_REQUESTED_AMOUNT;
  double? BASE_RATE;
  String? key;

  KnowEmiSelected({
    required this.TENURE,
    required this.EMI_AMOUNT,
    required this.TOTAL_REPAY_AMOUNT,
    required this.EMP_DIFF_RATE,
    required this.PROC_FEES,
    required this.INT_DET_ID,
    required this.PRODUCT_CODE,
    required this.INTREST_RATE,
    required this.CIBIL_DIFF_RATE,
    required this.DOC_FEES,
    required this.LOAN_REQUESTED_AMOUNT,
    required this.BASE_RATE,
    required this.key,
  });

  factory KnowEmiSelected.fromJson(dynamic json) =>
      _$KnowEmiSelectedFromJson(json);

  Map<String, dynamic> toJson() => _$KnowEmiSelectedToJson(this);
}

KnowEmiSelected _$KnowEmiSelectedFromJson(Map<String, dynamic> json) =>
    KnowEmiSelected(
      TENURE: json['TENURE'],
      EMI_AMOUNT: typecast(json, 'EMI_AMOUNT'),
      TOTAL_REPAY_AMOUNT: typecast(json, 'TOTAL_REPAY_AMOUNT'),
      EMP_DIFF_RATE: typecast(json, 'EMP_DIFF_RATE'),
      PROC_FEES: typecast(json, 'PROC_FEES'),
      INT_DET_ID: json['INT_DET_ID'],
      PRODUCT_CODE: json['PRODUCT_CODE'],
      INTREST_RATE: json['INTREST_RATE'],
      CIBIL_DIFF_RATE: typecast(json, 'CIBIL_DIFF_RATE'),
      DOC_FEES: typecast(json, 'DOC_FEES'),
      LOAN_REQUESTED_AMOUNT: json['LOAN_REQUESTED_AMOUNT'],
      BASE_RATE: typecast(json, 'BASE_RATE'),
      key: json['key'],
    );

Map<String, dynamic> _$KnowEmiSelectedToJson(KnowEmiSelected instance) =>
    <String, dynamic>{
      'TENURE': instance.TENURE,
      'EMI_AMOUNT': instance.EMI_AMOUNT,
      'TOTAL_REPAY_AMOUNT': instance.TOTAL_REPAY_AMOUNT,
      'EMP_DIFF_RATE': instance.EMP_DIFF_RATE,
      'PROC_FEES': instance.PROC_FEES,
      'INT_DET_ID': instance.INT_DET_ID,
      'PRODUCT_CODE': instance.PRODUCT_CODE,
      'INTREST_RATE': instance.INTREST_RATE,
      'CIBIL_DIFF_RATE': instance.CIBIL_DIFF_RATE,
      'DOC_FEES': instance.DOC_FEES,
      'LOAN_REQUESTED_AMOUNT': instance.LOAN_REQUESTED_AMOUNT,
      'BASE_RATE': instance.BASE_RATE,
      'key': instance.key,
    };
