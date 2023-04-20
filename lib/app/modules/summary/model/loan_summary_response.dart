import 'package:customer/app/constant/common.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class LoanSummaryResponse {
  String? status;
  String? message;
  int? code;
  LoanSummaryBody? body;

  LoanSummaryResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory LoanSummaryResponse.fromJson(dynamic json) =>
      _$LoanSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoanSummaryResponseToJson(this);
}

LoanSummaryResponse _$LoanSummaryResponseFromJson(Map<String, dynamic> json) =>
    LoanSummaryResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$LoanSummaryBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$LoanSummaryResponseToJson(
        LoanSummaryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class LoanSummaryBody {
  LoanSummaryData? data;

  LoanSummaryBody({
    required this.data,
  });

  factory LoanSummaryBody.fromJson(dynamic json) =>
      _$LoanSummaryBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoanSummaryBodyToJson(this);
}

LoanSummaryBody _$LoanSummaryBodyFromJson(Map<String, dynamic> json) =>
    LoanSummaryBody(
      data: json.containsKey('data') && json['data'] != null
          ? _$LoanSummaryDataFromJson(json['data'])
          : null,
    );

Map<String, dynamic> _$LoanSummaryBodyToJson(LoanSummaryBody instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class LoanSummaryData {
  String? applicantName;
  double? portfolioValue;
  double? eligibleLoanAmount;
  LoanSecurityData? cams;
  LoanSecurityData? kfin;
  String? providerName;
  String? bankName;
  String? accountType;
  String? accountNumber;
  double? appliedLoanAmount;
  int? tenure;
  double? rateOfInterest;
  double? emiAmount;
  double? physicalMandateFees;
  double? documentationFees;
  double? processingFees;
  double? camsProcessingCharges;
  double? aprPercent;
  double? emandateFees;

  LoanSummaryData({
    required this.applicantName,
    required this.portfolioValue,
    required this.eligibleLoanAmount,
    required this.cams,
    required this.kfin,
    required this.providerName,
    required this.bankName,
    required this.accountType,
    required this.accountNumber,
    required this.appliedLoanAmount,
    required this.tenure,
    required this.rateOfInterest,
    required this.emiAmount,
    required this.physicalMandateFees,
    required this.documentationFees,
    required this.processingFees,
    required this.camsProcessingCharges,
    required this.aprPercent,
    required this.emandateFees,
  });

  factory LoanSummaryData.fromJson(dynamic json) =>
      _$LoanSummaryDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoanSummaryDataToJson(this);
}

LoanSummaryData _$LoanSummaryDataFromJson(Map<String, dynamic> json) =>
    LoanSummaryData(
      applicantName: json['applicantName'],
      portfolioValue: typecast(json, 'portfolioValue'),
      eligibleLoanAmount: typecast(json, 'eligibleLoanAmount'),
      cams: json.containsKey('cams') && json['cams'] != null
          ? _$LoanSecurityDataFromJson(json['cams'])
          : null,
      kfin: json.containsKey('kfin') && json['kfin'] != null
          ? _$LoanSecurityDataFromJson(json['kfin'])
          : null,
      providerName: json['providerName'],
      bankName: json['bankName'],
      accountType: json['accountType'],
      accountNumber: json['accountNumber'],
      appliedLoanAmount: typecast(json, 'appliedLoanAmount'),
      tenure: json['tenure'],
      rateOfInterest: typecast(json, 'rateOfInterest'),
      emiAmount: typecast(json, 'emiAmount'),
      physicalMandateFees: typecast(json, 'physicalMandateFees'),
      documentationFees: typecast(json, 'documentationFees'),
      processingFees: typecast(json, 'processingFees'),
      camsProcessingCharges: typecast(json, 'camsProcessingCharges'),
      aprPercent: typecast(json, 'aprPercent'),
      emandateFees: typecast(json, 'emandateFees'),
    );

Map<String, dynamic> _$LoanSummaryDataToJson(LoanSummaryData instance) =>
    <String, dynamic>{
      'applicantName': instance.applicantName,
      'portfolioValue': instance.portfolioValue,
      'eligibleLoanAmount': instance.eligibleLoanAmount,
      'cams': instance.cams,
      'kfin': instance.kfin,
      'providerName': instance.providerName,
      'bankName': instance.bankName,
      'accountType': instance.accountType,
      'accountNumber': instance.accountNumber,
      'appliedLoanAmount': instance.appliedLoanAmount,
      'tenure': instance.tenure,
      'rateOfInterest': instance.rateOfInterest,
      'emiAmount': instance.emiAmount,
      'physicalMandateFees': instance.physicalMandateFees,
      'documentationFees': instance.documentationFees,
      'processingFees': instance.processingFees,
      'camsProcessingCharges': instance.camsProcessingCharges,
      'aprPercent': instance.aprPercent,
      'emandateFees': instance.emandateFees,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class LoanSecurityData {
  int? numberOfSecurities;
  double? unitesPledged;
  double? totalValueOfPledgedSecurities;

  LoanSecurityData({
    required this.numberOfSecurities,
    required this.unitesPledged,
    required this.totalValueOfPledgedSecurities,
  });

  factory LoanSecurityData.fromJson(dynamic json) =>
      _$LoanSecurityDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoanSecurityDataToJson(this);
}

LoanSecurityData _$LoanSecurityDataFromJson(Map<String, dynamic> json) =>
    LoanSecurityData(
      numberOfSecurities: json['numberOfSecurities'],
      unitesPledged: typecast(json, 'unitesPledged'),
      totalValueOfPledgedSecurities:
          typecast(json, 'totalValueOfPledgedSecurities'),
    );

Map<String, dynamic> _$LoanSecurityDataToJson(LoanSecurityData instance) =>
    <String, dynamic>{
      'numberOfSecurities': instance.numberOfSecurities,
      'unitesPledged': instance.unitesPledged,
      'totalValueOfPledgedSecurities': instance.totalValueOfPledgedSecurities,
    };
