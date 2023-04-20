import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class FetchFileResponse {
  String? status;
  String? message;
  int? code;
  FetchFileBody? body;

  FetchFileResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory FetchFileResponse.fromJson(dynamic json) =>
      _$FetchFileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FetchFileResponseToJson(this);
}

FetchFileResponse _$FetchFileResponseFromJson(
    Map<String, dynamic> json) =>
    FetchFileResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$FetchFileBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$FetchFileResponseToJson(
    FetchFileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class FetchFileBody {
  String? base64;
  String? extension;

  FetchFileBody({
    required this.base64,
    required this.extension,
  });

  factory FetchFileBody.fromJson(dynamic json) =>
      _$FetchFileBodyFromJson(json);

  Map<String, dynamic> toJson() => _$FetchFileBodyToJson(this);
}

FetchFileBody _$FetchFileBodyFromJson(
    Map<String, dynamic> json) =>
    FetchFileBody(
      base64: json['base64'],
      extension: json['extension'],
    );

Map<String, dynamic> _$FetchFileBodyToJson(
    FetchFileBody instance) =>
    <String, dynamic>{
      'base64': instance.base64,
      'extension': instance.extension,
    };