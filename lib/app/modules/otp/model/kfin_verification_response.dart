import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class KfinVerificationResponse {
  String? status;
  String? message;
  int? code;
  KfinVerificationBody? body;

  KfinVerificationResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory KfinVerificationResponse.fromJson(dynamic json) =>
      _$KfinVerificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KfinVerificationResponseToJson(this);
}

KfinVerificationResponse _$KfinVerificationResponseFromJson(
        Map<String, dynamic> json) =>
    KfinVerificationResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$KfinVerificationBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$KfinVerificationResponseToJson(
        KfinVerificationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class KfinVerificationBody {
  String? message;

  KfinVerificationBody({
    required this.message,
  });

  factory KfinVerificationBody.fromJson(dynamic json) =>
      _$KfinVerificationBodyFromJson(json);

  Map<String, dynamic> toJson() => _$KfinVerificationBodyToJson(this);
}

KfinVerificationBody _$KfinVerificationBodyFromJson(
        Map<String, dynamic> json) =>
    KfinVerificationBody(
      message: json['message'],
    );

Map<String, dynamic> _$KfinVerificationBodyToJson(
        KfinVerificationBody instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
