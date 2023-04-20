import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class ValidateOTPResponse {
  String? status;
  String? message;
  int? code;
  ValidateOTPData? body;

  ValidateOTPResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory ValidateOTPResponse.fromJson(dynamic json) =>
      _$ValidateOTPResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateOTPResponseToJson(this);
}

ValidateOTPResponse _$ValidateOTPResponseFromJson(
    Map<String, dynamic> json) =>
    ValidateOTPResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$ValidateOTPDataFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$ValidateOTPResponseToJson(
    ValidateOTPResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class ValidateOTPData {
  String? token;
  String? accountStatus;

  ValidateOTPData({
    required this.token,
    required this.accountStatus,
  });

  factory ValidateOTPData.fromJson(dynamic json) =>
      _$ValidateOTPDataFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateOTPDataToJson(this);
}

ValidateOTPData _$ValidateOTPDataFromJson(
    Map<String, dynamic> json) =>
    ValidateOTPData(
      token: json['token'],
      accountStatus: json['accountStatus'],
    );

Map<String, dynamic> _$ValidateOTPDataToJson(
    ValidateOTPData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'accountStatus': instance.accountStatus,
    };