import 'package:customer/app/modules/kyc/model/digiloker_retry_response.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class ProcessCasResponse {
  String? status;
  String? message;
  int? code;
  DigilokerRetryBody? body;

  ProcessCasResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory ProcessCasResponse.fromJson(dynamic json) =>
      _$ProcessCasResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessCasResponseToJson(this);
}

ProcessCasResponse _$ProcessCasResponseFromJson(Map<String, dynamic> json) =>
    ProcessCasResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? DigilokerRetryBody.fromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$ProcessCasResponseToJson(ProcessCasResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };