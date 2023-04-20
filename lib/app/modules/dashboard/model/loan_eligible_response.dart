import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class ProductFeatureEligibleResponse {
  String? status;
  String? message;
  int? code;
  ProductFeatureEligibleBody? body;

  ProductFeatureEligibleResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory ProductFeatureEligibleResponse.fromJson(dynamic json) =>
      _$ProductFeatureEligibleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductFeatureEligibleResponseToJson(this);
}

ProductFeatureEligibleResponse _$ProductFeatureEligibleResponseFromJson(
        Map<String, dynamic> json) =>
    ProductFeatureEligibleResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$ProductFeatureEligibleBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$ProductFeatureEligibleResponseToJson(
        ProductFeatureEligibleResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class ProductFeatureEligibleBody {
  bool? securitiesFound;
  int? eligibility;

  ProductFeatureEligibleBody({
    required this.securitiesFound,
    required this.eligibility,
  });

  factory ProductFeatureEligibleBody.fromJson(dynamic json) =>
      _$ProductFeatureEligibleBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductFeatureEligibleBodyToJson(this);
}

ProductFeatureEligibleBody _$ProductFeatureEligibleBodyFromJson(
        Map<String, dynamic> json) =>
    ProductFeatureEligibleBody(
      securitiesFound: json['securitiesFound'],
      eligibility: json['eligibility'],
    );

Map<String, dynamic> _$ProductFeatureEligibleBodyToJson(
        ProductFeatureEligibleBody instance) =>
    <String, dynamic>{
      'securitiesFound': instance.securitiesFound,
      'eligibility': instance.eligibility,
    };
