import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class PurposeListResponse {
  String? status;
  String? message;
  int? code;
  PurposeListBody? body;

  PurposeListResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory PurposeListResponse.fromJson(dynamic json) =>
      _$PurposeListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PurposeListResponseToJson(this);
}

PurposeListResponse _$PurposeListResponseFromJson(Map<String, dynamic> json) =>
    PurposeListResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$PurposeListBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$PurposeListResponseToJson(
        PurposeListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class PurposeListBody {
  List<PurposeData>? list = [];

  PurposeListBody({
    required this.list,
  });

  factory PurposeListBody.fromJson(dynamic json) =>
      _$PurposeListBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PurposeListBodyToJson(this);
}

PurposeListBody _$PurposeListBodyFromJson(Map<String, dynamic> json) =>
    PurposeListBody(
      list: json.containsKey('list') && json['list'] != null
          ? List<PurposeData>.from(
              json['list'].map((x) => PurposeData.fromJson(x)))
          : [],
    );

Map<String, dynamic> _$PurposeListBodyToJson(PurposeListBody instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class PurposeData {
  int? purposeMastId;
  String? purpose;

  PurposeData({
    required this.purposeMastId,
    required this.purpose,
  });

  factory PurposeData.fromJson(dynamic json) => _$PurposeDataFromJson(json);

  Map<String, dynamic> toJson() => _$PurposeDataToJson(this);
}

PurposeData _$PurposeDataFromJson(Map<String, dynamic> json) => PurposeData(
      purposeMastId: json['purposeMastId'],
      purpose: json['purpose'],
    );

Map<String, dynamic> _$PurposeDataToJson(PurposeData instance) =>
    <String, dynamic>{
      'purposeMastId': instance.purposeMastId,
      'purpose': instance.purpose,
    };
