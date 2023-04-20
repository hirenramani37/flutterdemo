import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class DashboardResponse {
  String? status;
  String? message;
  int? code;
  DashboardBody? body;

  DashboardResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory DashboardResponse.fromJson(dynamic json) =>
      _$DashboardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardResponseToJson(this);
}

DashboardResponse _$DashboardResponseFromJson(Map<String, dynamic> json) =>
    DashboardResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$DashboardBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$DashboardResponseToJson(DashboardResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class DashboardBody {
  DashboardData? data;

  DashboardBody({
    required this.data,
  });

  factory DashboardBody.fromJson(dynamic json) => _$DashboardBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardBodyToJson(this);
}

DashboardBody _$DashboardBodyFromJson(Map<String, dynamic> json) =>
    DashboardBody(
      data: json.containsKey('data') && json['data'] != null
          ? _$DashboardDataFromJson(json['data'])
          : null,
    );

Map<String, dynamic> _$DashboardBodyToJson(DashboardBody instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class DashboardData {
  String? buttonText;
  String? appStatus;
  LoanStateData? loan;

  DashboardData({
    required this.buttonText,
    required this.appStatus,
    required this.loan,
  });

  factory DashboardData.fromJson(dynamic json) => _$DashboardDataFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);
}

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    DashboardData(
      buttonText: json['buttonText'],
      appStatus: json['appStatus'],
      loan: json.containsKey('loan') && json['loan'] != null
          ? _$LoanStateDataFromJson(json['loan'])
          : null,
    );

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'buttonText': instance.buttonText,
      'appStatus': instance.appStatus,
      'loan': instance.loan,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class LoanStateData {
  String? loanApplicationId;
  String? loanStatus;
  String? lastSubmittedStage;

  LoanStateData({
    required this.loanApplicationId,
    required this.loanStatus,
    required this.lastSubmittedStage,
  });

  factory LoanStateData.fromJson(dynamic json) => _$LoanStateDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoanStateDataToJson(this);
}

LoanStateData _$LoanStateDataFromJson(Map<String, dynamic> json) =>
    LoanStateData(
      loanApplicationId: json['loanApplicationId'],
      loanStatus: json['loanStatus'],
      lastSubmittedStage: json['lastSubmittedStage'],
    );

Map<String, dynamic> _$LoanStateDataToJson(LoanStateData instance) =>
    <String, dynamic>{
      'loanApplicationId': instance.loanApplicationId,
      'loanStatus': instance.loanStatus,
      'lastSubmittedStage': instance.lastSubmittedStage,
    };
