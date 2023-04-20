import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class RequestOtpResponse {
  String? status;
  String? message;
  int? code;
  RequestOtpData? body;

  RequestOtpResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory RequestOtpResponse.fromJson(dynamic json) =>
      _$RequestOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOtpResponseToJson(this);
}

RequestOtpResponse _$RequestOtpResponseFromJson(Map<String, dynamic> json) =>
    RequestOtpResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$RequestOtpDataFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$RequestOtpResponseToJson(RequestOtpResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class RequestOtpData {
  bool? sentStatus;
  String? timestamp;
  String? token;
  int? otp;

  RequestOtpData({
    required this.sentStatus,
    required this.timestamp,
    required this.token,
    required this.otp,
  });

  factory RequestOtpData.fromJson(dynamic json) =>
      _$RequestOtpDataFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOtpDataToJson(this);
}

RequestOtpData _$RequestOtpDataFromJson(Map<String, dynamic> json) =>
    RequestOtpData(
      sentStatus: json['sentStatus'],
      timestamp: json['timestamp'],
      token: json['token'],
      otp: json['otp'],
    );

Map<String, dynamic> _$RequestOtpDataToJson(RequestOtpData instance) =>
    <String, dynamic>{
      'sentStatus': instance.sentStatus,
      'timestamp': instance.timestamp,
      'token': instance.token,
      'otp': instance.otp,
    };
