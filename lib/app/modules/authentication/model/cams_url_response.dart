import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class CamsUrlResponse {
  String? status;
  String? message;
  int? code;
  CamsUrlBody? body;

  CamsUrlResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory CamsUrlResponse.fromJson(dynamic json) =>
      _$CamsUrlResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CamsUrlResponseToJson(this);
}

CamsUrlResponse _$CamsUrlResponseFromJson(Map<String, dynamic> json) =>
    CamsUrlResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$CamsUrlBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$CamsUrlResponseToJson(CamsUrlResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class CamsUrlBody {
  String? redirectLink;

  CamsUrlBody({
    required this.redirectLink,
  });

  factory CamsUrlBody.fromJson(dynamic json) => _$CamsUrlBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CamsUrlBodyToJson(this);
}

CamsUrlBody _$CamsUrlBodyFromJson(Map<String, dynamic> json) => CamsUrlBody(
      redirectLink: json['redirectLink'],
    );

Map<String, dynamic> _$CamsUrlBodyToJson(CamsUrlBody instance) =>
    <String, dynamic>{
      'redirectLink': instance.redirectLink,
    };
