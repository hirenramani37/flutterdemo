import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class DigilokerRetryResponse {
  String? status;
  String? message;
  int? code;
  DigilokerRetryBody? body;

  DigilokerRetryResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory DigilokerRetryResponse.fromJson(dynamic json) =>
      _$DigilokerRetryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DigilokerRetryResponseToJson(this);
}

DigilokerRetryResponse _$DigilokerRetryResponseFromJson(
        Map<String, dynamic> json) =>
    DigilokerRetryResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$DigilokerRetryBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$DigilokerRetryResponseToJson(
        DigilokerRetryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class DigilokerRetryBody {
  int? digiLockerId;

  DigilokerRetryBody({
    required this.digiLockerId,
  });

  factory DigilokerRetryBody.fromJson(dynamic json) =>
      _$DigilokerRetryBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DigilokerRetryBodyToJson(this);
}

DigilokerRetryBody _$DigilokerRetryBodyFromJson(Map<String, dynamic> json) =>
    DigilokerRetryBody(
      digiLockerId: json['digiLockerId'],
    );

Map<String, dynamic> _$DigilokerRetryBodyToJson(DigilokerRetryBody instance) =>
    <String, dynamic>{
      'digiLockerId': instance.digiLockerId,
    };
