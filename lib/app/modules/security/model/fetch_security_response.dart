import 'package:customer/app/constant/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class FetchSecurityResponse {
  String? status;
  String? message;
  int? code;
  FetchSecurityBody? body;

  FetchSecurityResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory FetchSecurityResponse.fromJson(dynamic json) =>
      _$FetchSecurityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FetchSecurityResponseToJson(this);
}

FetchSecurityResponse _$FetchSecurityResponseFromJson(
        Map<String, dynamic> json) =>
    FetchSecurityResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$FetchSecurityBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$FetchSecurityResponseToJson(
        FetchSecurityResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class FetchSecurityBody {
  double? existingLimit;
  double? eligibilityAmount;
  List<SecurityData>? dataList = [];
  LoanValidation? loanValidation;
  double? appliedLoanAmount;
  String? loanState;
  String? navDate;

  FetchSecurityBody({
    required this.existingLimit,
    required this.eligibilityAmount,
    required this.dataList,
    required this.loanValidation,
    required this.appliedLoanAmount,
    required this.loanState,
    required this.navDate,
  });

  factory FetchSecurityBody.fromJson(dynamic json) =>
      _$FetchSecurityBodyFromJson(json);

  Map<String, dynamic> toJson() => _$FetchSecurityBodyToJson(this);
}

FetchSecurityBody _$FetchSecurityBodyFromJson(Map<String, dynamic> json) =>
    FetchSecurityBody(
        existingLimit : json['existingLimit'],
        eligibilityAmount : typecast(json, 'eligibilityAmount'),
        dataList : json.containsKey('dataList') && json['dataList'] != null
            ? List<SecurityData>.from(
            json['dataList'].map((x) => SecurityData.fromJson(x)))
            : [],
        loanValidation : json.containsKey('loanValidation') && json['loanValidation'] != null
            ? _$LoanValidationFromJson(json['loanValidation'])
            : null,
        appliedLoanAmount : json['appliedLoanAmount'],
        loanState : json['loanState'],
        navDate : json['navDate'],
    );

Map<String, dynamic> _$FetchSecurityBodyToJson(FetchSecurityBody instance) =>
    <String, dynamic>{
      'existingLimit' : instance.existingLimit,
      'eligibilityAmount' : instance.eligibilityAmount,
      'dataList' : instance.dataList,
      'loanValidation' : instance.loanValidation,
      'appliedLoanAmount' : instance.appliedLoanAmount,
      'loanState' : instance.loanState,
      'navDate' : instance.navDate,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class SecurityData {
  double? total;
  double? selectedTotal;
  double? nav;
  String? schCode;
  String? njSchCode;
  String? rta;
  String? schemeType;
  double? amountPerUnit;
  double? ltvPer;
  double? selectedUnits;
  TextEditingController? selectedUnitsController = TextEditingController();
  String? isEligible;
  String? isin;
  String? folioNo;
  int? customerPortFolioImportId;
  String? securityName;
  double? units;
  String? statementType;
  String? isSelected;
  String? amcCode;
  String? ccode;
  String? subRefNo;
  bool? disabled;
  bool selected = false;

  SecurityData({
    required this.total,
    required this.selectedTotal,
    required this.nav,
    required this.schCode,
    required this.njSchCode,
    required this.rta,
    required this.schemeType,
    required this.amountPerUnit,
    required this.ltvPer,
    required this.selectedUnits,
    required this.isEligible,
    required this.isin,
    required this.folioNo,
    required this.customerPortFolioImportId,
    required this.securityName,
    required this.units,
    required this.statementType,
    required this.isSelected,
    required this.amcCode,
    required this.ccode,
    required this.subRefNo,
    required this.disabled,
  });

  factory SecurityData.fromJson(dynamic json) => _$SecurityDataFromJson(json);

  Map<String, dynamic> toJson() => _$SecurityDataToJson(this);
}

SecurityData _$SecurityDataFromJson(Map<String, dynamic> json) => SecurityData(
      total: typecast(json, 'total'),
      selectedTotal: typecast(json, 'selectedTotal'),
      nav: typecast(json, 'nav'),
      schCode: json['schCode'],
      njSchCode: json['njSchCode'],
      rta: json['rta'],
      schemeType: json['schemeType'],
      amountPerUnit: typecast(json, 'amountPerUnit'),
      ltvPer: typecast(json, 'ltvPer'),
      selectedUnits: typecast(json, 'selectedUnits'),
      isEligible: json['isEligible'],
      isin: json['isin'],
      folioNo: json['folioNo'],
      customerPortFolioImportId: json['customerPortFolioImportId'],
      securityName: json['securityName'],
      units: typecast(json, 'units'),
      statementType: json['statementType'],
      isSelected: json['isSelected'],
      amcCode: json['amcCode'],
      ccode: json['ccode'],
      subRefNo: json['subRefNo'],
      disabled: json['disabled'],
    );

Map<String, dynamic> _$SecurityDataToJson(SecurityData instance) =>
    <String, dynamic>{
      'total': instance.total,
      'selectedTotal': instance.selectedTotal,
      'nav': instance.nav,
      'schCode': instance.schCode,
      'njSchCode': instance.njSchCode,
      'rta': instance.rta,
      'schemeType': instance.schemeType,
      'amountPerUnit': instance.amountPerUnit,
      'ltvPer': instance.ltvPer,
      'selectedUnits': instance.selectedUnits,
      'isEligible': instance.isEligible,
      'isin': instance.isin,
      'folioNo': instance.folioNo,
      'customerPortFolioImportId': instance.customerPortFolioImportId,
      'securityName': instance.securityName,
      'units': instance.units,
      'statementType': instance.statementType,
      'isSelected': instance.isSelected,
      'amcCode': instance.amcCode,
      'ccode': instance.ccode,
      'subRefNo': instance.subRefNo,
      'disabled': instance.disabled,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class LoanValidation {
  double? minAmount;
  double? maxAmount;

  LoanValidation({
    required this.minAmount,
    required this.maxAmount,
  });

  factory LoanValidation.fromJson(dynamic json) =>
      _$LoanValidationFromJson(json);

  Map<String, dynamic> toJson() => _$LoanValidationToJson(this);
}

LoanValidation _$LoanValidationFromJson(Map<String, dynamic> json) =>
    LoanValidation(
      minAmount: json['minAmount'],
      maxAmount: json['maxAmount'],
    );

Map<String, dynamic> _$LoanValidationToJson(LoanValidation instance) =>
    <String, dynamic>{
      'minAmount': instance.minAmount,
      'maxAmount': instance.maxAmount,
    };
