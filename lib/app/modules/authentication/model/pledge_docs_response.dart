import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class PledgeDocsResponse {
  String? status;
  String? message;
  int? code;
  PledgeDocsBody? body;

  PledgeDocsResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory PledgeDocsResponse.fromJson(dynamic json) =>
      _$PledgeDocsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PledgeDocsResponseToJson(this);
}

PledgeDocsResponse _$PledgeDocsResponseFromJson(Map<String, dynamic> json) =>
    PledgeDocsResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$PledgeDocsBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$PledgeDocsResponseToJson(PledgeDocsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class PledgeDocsBody {
  List<String>? RTA = [];
  List<PledgeDocsData>? data = [];

  PledgeDocsBody({
    required this.RTA,
    required this.data,
  });

  factory PledgeDocsBody.fromJson(dynamic json) =>
      _$PledgeDocsBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PledgeDocsBodyToJson(this);
}

PledgeDocsBody _$PledgeDocsBodyFromJson(Map<String, dynamic> json) =>
    PledgeDocsBody(
      RTA:  json.containsKey('RTA') && json['RTA'] != null
          ? List<String>.from(
          json['RTA'].map((x) => x.toString() ))
          : [],
      data:  json.containsKey('data') && json['data'] != null
          ? List<PledgeDocsData>.from(
          json['data'].map((x) => PledgeDocsData.fromJson(x)))
          : [],
    );

Map<String, dynamic> _$PledgeDocsBodyToJson(PledgeDocsBody instance) =>
    <String, dynamic>{
      'RTA': instance.RTA,
      'data': instance.data,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class PledgeDocsData {
  String? RTA;
  String? NAME;
  String? ESA;
  String? ESP_KFIN;
  String? ESP_CAMS;
  String? EMA;
  String? ESIGN_ID_A;
  String? ESIGN_PDF_ID_A;
  String? ESIGN_ID_P_KFIN;
  String? ESIGN_ID_P_CAMS;
  String? ESIGN_PDF_ID_P_KFIN;
  String? ESIGN_PDF_ID_P_CAMS;
  String? PAN;
  String? COMP_NAME;
  String? MOBILE;
  String? APPLCNT_ID;
  String? PLG_APPLICNT_ID;
  String? BOID;

  PledgeDocsData({
    required this.RTA,
    required this.NAME,
    required this.ESA,
    required this.ESP_KFIN,
    required this.ESP_CAMS,
    required this.EMA,
    required this.ESIGN_ID_A,
    required this.ESIGN_PDF_ID_A,
    required this.ESIGN_ID_P_KFIN,
    required this.ESIGN_ID_P_CAMS,
    required this.ESIGN_PDF_ID_P_KFIN,
    required this.ESIGN_PDF_ID_P_CAMS,
    required this.PAN,
    required this.COMP_NAME,
    required this.MOBILE,
    required this.APPLCNT_ID,
    required this.PLG_APPLICNT_ID,
    required this.BOID,
  });

  factory PledgeDocsData.fromJson(dynamic json) =>
      _$PledgeDocsDataFromJson(json);

  Map<String, dynamic> toJson() => _$PledgeDocsDataToJson(this);
}

PledgeDocsData _$PledgeDocsDataFromJson(Map<String, dynamic> json) =>
    PledgeDocsData(
      RTA: json['RTA'],
      NAME: json['NAME'],
      ESA: json['ESA'],
      ESP_KFIN: json['ESP_KFIN'],
      ESP_CAMS: json['ESP_CAMS'],
      EMA: json['EMA'],
      ESIGN_ID_A: json['ESIGN_ID_A'],
      ESIGN_PDF_ID_A: json['ESIGN_PDF_ID_A'],
      ESIGN_ID_P_KFIN: json['ESIGN_ID_P_KFIN'],
      ESIGN_ID_P_CAMS: json['ESIGN_ID_P_CAMS'],
      ESIGN_PDF_ID_P_KFIN: json['ESIGN_PDF_ID_P_KFIN'],
      ESIGN_PDF_ID_P_CAMS: json['ESIGN_PDF_ID_P_CAMS'],
      PAN: json['PAN'],
      COMP_NAME: json['COMP_NAME'],
      MOBILE: json['MOBILE'],
      APPLCNT_ID: json['APPLCNT_ID'],
      PLG_APPLICNT_ID: json['PLG_APPLICNT_ID'],
      BOID: json['BOID'],
    );

Map<String, dynamic> _$PledgeDocsDataToJson(PledgeDocsData instance) =>
    <String, dynamic>{
      'RTA': instance.RTA,
      'NAME': instance.NAME,
      'ESA': instance.ESA,
      'ESP_KFIN': instance.ESP_KFIN,
      'ESP_CAMS': instance.ESP_CAMS,
      'EMA': instance.EMA,
      'ESIGN_ID_A': instance.ESIGN_ID_A,
      'ESIGN_PDF_ID_A': instance.ESIGN_PDF_ID_A,
      'ESIGN_ID_P_KFIN': instance.ESIGN_ID_P_KFIN,
      'ESIGN_ID_P_CAMS': instance.ESIGN_ID_P_CAMS,
      'ESIGN_PDF_ID_P_KFIN': instance.ESIGN_PDF_ID_P_KFIN,
      'ESIGN_PDF_ID_P_CAMS': instance.ESIGN_PDF_ID_P_CAMS,
      'PAN': instance.PAN,
      'COMP_NAME': instance.COMP_NAME,
      'MOBILE': instance.MOBILE,
      'APPLCNT_ID': instance.APPLCNT_ID,
      'PLG_APPLICNT_ID': instance.PLG_APPLICNT_ID,
      'BOID': instance.BOID,
    };
