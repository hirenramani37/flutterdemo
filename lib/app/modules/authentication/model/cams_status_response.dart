import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class CamsStatusResponse {
  String? status;
  String? message;
  int? code;
  CamsStatusBody? body;

  CamsStatusResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory CamsStatusResponse.fromJson(dynamic json) =>
      _$CamsStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CamsStatusResponseToJson(this);
}

CamsStatusResponse _$CamsStatusResponseFromJson(Map<String, dynamic> json) =>
    CamsStatusResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$CamsStatusBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$CamsStatusResponseToJson(CamsStatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class CamsStatusBody {
  String? pledgeStatus;
  CamsStatusData? camsStatus;

  CamsStatusBody({
    required this.pledgeStatus,
    required this.camsStatus,
  });

  factory CamsStatusBody.fromJson(dynamic json) =>
      _$CamsStatusBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CamsStatusBodyToJson(this);
}

CamsStatusBody _$CamsStatusBodyFromJson(Map<String, dynamic> json) =>
    CamsStatusBody(
      pledgeStatus: json['pledgeStatus'],
      camsStatus: json.containsKey('camsStatus') && json['camsStatus'] != null
          ? _$CamsStatusDataFromJson(json['camsStatus'])
          : null,
    );

Map<String, dynamic> _$CamsStatusBodyToJson(CamsStatusBody instance) =>
    <String, dynamic>{
      'pledgeStatus': instance.pledgeStatus,
      'camsStatus': instance.camsStatus,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class CamsStatusData {
  String? ucc;
  String? client_pan;
  String? emailid;
  String? lienrefno;
  String? loanTrnId;
  String? statusData;
  String? status_Code;

  CamsStatusData({
    required this.ucc,
    required this.client_pan,
    required this.emailid,
    required this.lienrefno,
    required this.loanTrnId,
    required this.statusData,
    required this.status_Code,
  });

  factory CamsStatusData.fromJson(dynamic json) =>
      _$CamsStatusDataFromJson(json);

  Map<String, dynamic> toJson() => _$CamsStatusDataToJson(this);
}

CamsStatusData _$CamsStatusDataFromJson(Map<String, dynamic> json) =>
    CamsStatusData(
      ucc: json['ucc'],
      client_pan: json['client_pan'],
      emailid: json['emailid'],
      lienrefno: json['lienrefno'],
      loanTrnId: json['loanTrnId'],
      statusData: json['statusData'],
      status_Code: json['status_Code'],
    );

Map<String, dynamic> _$CamsStatusDataToJson(CamsStatusData instance) =>
    <String, dynamic>{
      'ucc': instance.ucc,
      'client_pan': instance.client_pan,
      'emailid': instance.emailid,
      'lienrefno': instance.lienrefno,
      'loanTrnId': instance.loanTrnId,
      'statusData': instance.statusData,
      'status_Code': instance.status_Code,
    };
