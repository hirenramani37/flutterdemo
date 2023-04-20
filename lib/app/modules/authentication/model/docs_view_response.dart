import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class PledgeDocViewResponse {
  String? status;
  String? message;
  int? code;
  PledgeDocViewBody? body;

  PledgeDocViewResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory PledgeDocViewResponse.fromJson(dynamic json) =>
      _$PledgeDocViewResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PledgeDocViewResponseToJson(this);
}

PledgeDocViewResponse _$PledgeDocViewResponseFromJson(Map<String, dynamic> json) =>
    PledgeDocViewResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$PledgeDocViewBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$PledgeDocViewResponseToJson(PledgeDocViewResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class PledgeDocViewBody {
  String? base64;

  PledgeDocViewBody({
    required this.base64,
  });

  factory PledgeDocViewBody.fromJson(dynamic json) =>
      _$PledgeDocViewBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PledgeDocViewBodyToJson(this);
}

PledgeDocViewBody _$PledgeDocViewBodyFromJson(Map<String, dynamic> json) =>
    PledgeDocViewBody(
      base64: json['base64'],
    );

Map<String, dynamic> _$PledgeDocViewBodyToJson(PledgeDocViewBody instance) =>
    <String, dynamic>{
      'base64': instance.base64,
    };