import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class RequestCasResponse {
  String? status;
  String? message;
  int? code;
  RequestCasBody? body;

  RequestCasResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory RequestCasResponse.fromJson(dynamic json) =>
      _$RequestCasResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestCasResponseToJson(this);
}

RequestCasResponse _$RequestCasResponseFromJson(Map<String, dynamic> json) =>
    RequestCasResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$RequestCasBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$RequestCasResponseToJson(RequestCasResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class RequestCasBody {
  String? email;

  RequestCasBody({
    required this.email,
  });

  factory RequestCasBody.fromJson(dynamic json) =>
      _$RequestCasBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RequestCasBodyToJson(this);
}

RequestCasBody _$RequestCasBodyFromJson(Map<String, dynamic> json) =>
    RequestCasBody(
      email: json['email'],
    );

Map<String, dynamic> _$RequestCasBodyToJson(RequestCasBody instance) =>
    <String, dynamic>{
      'email': instance.email,
    };
