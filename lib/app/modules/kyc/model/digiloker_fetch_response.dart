import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class DigilokerFetchResponse {
  String? status;
  String? message;
  int? code;
  DigilokerFetchBody? body;

  DigilokerFetchResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory DigilokerFetchResponse.fromJson(dynamic json) =>
      _$DigilokerFetchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DigilokerFetchResponseToJson(this);
}

DigilokerFetchResponse _$DigilokerFetchResponseFromJson(
        Map<String, dynamic> json) =>
    DigilokerFetchResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$DigilokerFetchBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$DigilokerFetchResponseToJson(
        DigilokerFetchResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class DigilokerFetchBody {
  String? address;
  String? image;

  DigilokerFetchBody({
    required this.address,
    required this.image,
  });

  factory DigilokerFetchBody.fromJson(dynamic json) =>
      _$DigilokerFetchBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DigilokerFetchBodyToJson(this);
}

DigilokerFetchBody _$DigilokerFetchBodyFromJson(Map<String, dynamic> json) =>
    DigilokerFetchBody(
      address: json['address'],
      image: json['image'],
    );

Map<String, dynamic> _$DigilokerFetchBodyToJson(DigilokerFetchBody instance) =>
    <String, dynamic>{
      'address': instance.address,
      'image': instance.image,
    };
