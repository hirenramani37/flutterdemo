import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class ProductFeatureResponse {
  String? status;
  String? message;
  int? code;
  ProductFeatureBody? body;

  ProductFeatureResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory ProductFeatureResponse.fromJson(dynamic json) =>
      _$ProductFeatureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductFeatureResponseToJson(this);
}

ProductFeatureResponse _$ProductFeatureResponseFromJson(
        Map<String, dynamic> json) =>
    ProductFeatureResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$ProductFeatureBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$ProductFeatureResponseToJson(
        ProductFeatureResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class ProductFeatureBody {
  ProductFeatureChanges? changes;

  ProductFeatureBody({
    required this.changes,
  });

  factory ProductFeatureBody.fromJson(dynamic json) =>
      _$ProductFeatureBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductFeatureBodyToJson(this);
}

ProductFeatureBody _$ProductFeatureBodyFromJson(Map<String, dynamic> json) =>
    ProductFeatureBody(
      changes: json.containsKey('changes') && json['changes'] != null
          ? _$ProductFeatureChangesFromJson(json['changes'])
          : null,
    );

Map<String, dynamic> _$ProductFeatureBodyToJson(ProductFeatureBody instance) =>
    <String, dynamic>{
      'changes': instance.changes,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class ProductFeatureChanges {
  MinMaxLoanData? minMaxLoanAmount;
  double? camsCharges;
  int? disbursementWorkingDays;
  int? emiPerLakhRs;
  int? maxTenure;
  String? processingFees;
  int? documentChargesForEmandate;
  int? documentChargesForPhysicalMandate;
  String? documentChargesForEmandateFormat;
  String? documentChargesForPhysicalMandateFormat;
  String? stepForLoanAmount;
  String? stepForTenure;

  ProductFeatureChanges({
    required this.minMaxLoanAmount,
    required this.camsCharges,
    required this.disbursementWorkingDays,
    required this.emiPerLakhRs,
    required this.maxTenure,
    required this.processingFees,
    required this.documentChargesForEmandate,
    required this.documentChargesForPhysicalMandate,
    required this.documentChargesForEmandateFormat,
    required this.documentChargesForPhysicalMandateFormat,
    required this.stepForLoanAmount,
    required this.stepForTenure,
  });

  factory ProductFeatureChanges.fromJson(dynamic json) =>
      _$ProductFeatureChangesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductFeatureChangesToJson(this);
}

ProductFeatureChanges _$ProductFeatureChangesFromJson(
        Map<String, dynamic> json) =>
    ProductFeatureChanges(
      camsCharges: json['camsCharges'],
      disbursementWorkingDays: json['disbursementWorkingDays'],
      emiPerLakhRs: json['emiPerLakhRs'],
      maxTenure: json['maxTenure'],
      processingFees: json['processingFees'],
      documentChargesForEmandate: json['documentChargesForEmandate'],
      documentChargesForPhysicalMandate:
          json['documentChargesForPhysicalMandate'],
      documentChargesForEmandateFormat:
          json['documentChargesForEmandateFormat'],
      documentChargesForPhysicalMandateFormat:
          json['documentChargesForPhysicalMandateFormat'],
      stepForLoanAmount: json['stepForLoanAmount'],
      stepForTenure: json['stepForTenure'],
      minMaxLoanAmount: json.containsKey('minMaxLoanAmount') &&
              json['minMaxLoanAmount'] != null
          ? _$MinMaxLoanDataFromJson(json['minMaxLoanAmount'])
          : null,
    );

Map<String, dynamic> _$ProductFeatureChangesToJson(
        ProductFeatureChanges instance) =>
    <String, dynamic>{
      'minMaxLoanAmount': instance.minMaxLoanAmount,
      'camsCharges': instance.camsCharges,
      'disbursementWorkingDays': instance.disbursementWorkingDays,
      'emiPerLakhRs': instance.emiPerLakhRs,
      'maxTenure': instance.maxTenure,
      'processingFees': instance.processingFees,
      'documentChargesForEmandate': instance.documentChargesForEmandate,
      'documentChargesForPhysicalMandate':
          instance.documentChargesForPhysicalMandate,
      'documentChargesForEmandateFormat':
          instance.documentChargesForEmandateFormat,
      'documentChargesForPhysicalMandateFormat':
          instance.documentChargesForPhysicalMandateFormat,
      'stepForLoanAmount': instance.stepForLoanAmount,
      'stepForTenure': instance.stepForTenure,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class MinMaxLoanData {
  String? MIN_AMT_FORMAT;
  String? MAX_AMT_FORMATE;
  int? MIN_AMT;
  int? MAX_AMT;

  MinMaxLoanData({
    required this.MIN_AMT_FORMAT,
    required this.MAX_AMT_FORMATE,
    required this.MIN_AMT,
    required this.MAX_AMT,
  });

  factory MinMaxLoanData.fromJson(dynamic json) =>
      _$MinMaxLoanDataFromJson(json);

  Map<String, dynamic> toJson() => _$MinMaxLoanDataToJson(this);
}

MinMaxLoanData _$MinMaxLoanDataFromJson(Map<String, dynamic> json) =>
    MinMaxLoanData(
      MIN_AMT_FORMAT: json['MIN_AMT_FORMAT'],
      MAX_AMT_FORMATE: json['MAX_AMT_FORMATE'],
      MIN_AMT: json['MIN_AMT'],
      MAX_AMT: json['MAX_AMT'],
    );

Map<String, dynamic> _$MinMaxLoanDataToJson(MinMaxLoanData instance) =>
    <String, dynamic>{
      'MIN_AMT_FORMAT': instance.MIN_AMT_FORMAT,
      'MAX_AMT_FORMATE': instance.MAX_AMT_FORMATE,
      'MIN_AMT': instance.MIN_AMT,
      'MAX_AMT': instance.MAX_AMT,
    };
