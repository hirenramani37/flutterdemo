import 'package:customer/app/constant/common.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class LoanSanctionResponse {
  String? status;
  String? message;
  int? code;
  LoanSanctionBody? body;

  LoanSanctionResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory LoanSanctionResponse.fromJson(dynamic json) =>
      _$LoanSanctionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoanSanctionResponseToJson(this);
}

LoanSanctionResponse _$LoanSanctionResponseFromJson(Map<String, dynamic> json) =>
    LoanSanctionResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$LoanSanctionBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$LoanSanctionResponseToJson(
    LoanSanctionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class LoanSanctionBody {
  String? requestNumber;

  LoanSanctionBody({
    required this.requestNumber,
  });

  factory LoanSanctionBody.fromJson(dynamic json) =>
      _$LoanSanctionBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoanSanctionBodyToJson(this);
}

LoanSanctionBody _$LoanSanctionBodyFromJson(Map<String, dynamic> json) =>
    LoanSanctionBody(
      requestNumber: json['requestNumber'],
    );

Map<String, dynamic> _$LoanSanctionBodyToJson(LoanSanctionBody instance) =>
    <String, dynamic>{
      'requestNumber': instance.requestNumber,
    };