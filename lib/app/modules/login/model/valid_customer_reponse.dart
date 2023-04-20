import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class ValidCustomerResponse {
  String? status;
  String? message;
  int? code;
  ValidCustomerData? body;

  ValidCustomerResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory ValidCustomerResponse.fromJson(dynamic json) =>
      _$ValidCustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValidCustomerResponseToJson(this);
}

ValidCustomerResponse _$ValidCustomerResponseFromJson(
        Map<String, dynamic> json) =>
    ValidCustomerResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$ValidCustomerDataFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$ValidCustomerResponseToJson(
        ValidCustomerResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class ValidCustomerData {
  String? result;

  ValidCustomerData({
    required this.result,
  });

  factory ValidCustomerData.fromJson(dynamic json) =>
      _$ValidCustomerDataFromJson(json);

  Map<String, dynamic> toJson() => _$ValidCustomerDataToJson(this);
}

ValidCustomerData _$ValidCustomerDataFromJson(Map<String, dynamic> json) =>
    ValidCustomerData(result: json['result']);

Map<String, dynamic> _$ValidCustomerDataToJson(ValidCustomerData instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
