import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class PhotoVerificationResponse {
  String? status;
  String? message;
  int? code;
  PhotoVerificationBody? body;

  PhotoVerificationResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory PhotoVerificationResponse.fromJson(dynamic json) =>
      _$PhotoVerificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoVerificationResponseToJson(this);
}

PhotoVerificationResponse _$PhotoVerificationResponseFromJson(
    Map<String, dynamic> json) =>
    PhotoVerificationResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$PhotoVerificationBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$PhotoVerificationResponseToJson(
    PhotoVerificationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class PhotoVerificationBody {
  VerificationData? verificationData;

  PhotoVerificationBody({
    required this.verificationData,
  });

  factory PhotoVerificationBody.fromJson(dynamic json) =>
      _$PhotoVerificationBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoVerificationBodyToJson(this);
}

PhotoVerificationBody _$PhotoVerificationBodyFromJson(
    Map<String, dynamic> json) =>
    PhotoVerificationBody(
      verificationData: json.containsKey('verificationData') && json['verificationData'] != null
          ? _$VerificationDataFromJson(json['verificationData'])
          : null,
    );

Map<String, dynamic> _$PhotoVerificationBodyToJson(PhotoVerificationBody instance) =>
    <String, dynamic>{
      'verificationData': instance.verificationData,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class VerificationData {
  int? id;
  int? applicantId;
  String? isConfirmed;
  double? photoMatchPercent;
  String? photoMatchFlag;
  String? isLiveliness;
  String? faceCoverage;
  String? ipvHoApproval;
  String? faceCompareJson;
  String? faceLivenessJson;
  String? status;
  String? trxnno;
  String? estransactionid;
  String? errorcode;
  String? errormessage;
  String? useripadd;
  String? latitude;
  String? longitude;
  String? country;
  String? imagePath;
  String? pdfPath;
  String? createdAt;
  String? updatedAt;

  VerificationData({
    required this.id,
    required this.applicantId,
    required this.isConfirmed,
    required this.photoMatchPercent,
    required this.photoMatchFlag,
    required this.isLiveliness,
    required this.faceCoverage,
    required this.ipvHoApproval,
    required this.faceCompareJson,
    required this.faceLivenessJson,
    required this.status,
    required this.trxnno,
    required this.estransactionid,
    required this.errorcode,
    required this.errormessage,
    required this.useripadd,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.imagePath,
    required this.pdfPath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VerificationData.fromJson(dynamic json) =>
      _$VerificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$VerificationDataToJson(this);
}

VerificationData _$VerificationDataFromJson(
    Map<String, dynamic> json) =>
    VerificationData(
      id: json['id'],
      applicantId: json['applicantId'],
      isConfirmed: json['isConfirmed'],
      photoMatchPercent: json['photoMatchPercent'],
      photoMatchFlag: json['photoMatchFlag'],
      isLiveliness: json['isLiveliness'],
      faceCoverage: json['faceCoverage'],
      ipvHoApproval: json['ipvHoApproval'],
      faceCompareJson: json['faceCompareJson'],
      faceLivenessJson: json['faceLivenessJson'],
      status: json['status'],
      trxnno: json['trxnno'],
      estransactionid: json['estransactionid'],
      errorcode: json['errorcode'],
      errormessage: json['errormessage'],
      useripadd: json['useripadd'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      country: json['country'],
      imagePath: json['imagePath'],
      pdfPath: json['pdfPath'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$VerificationDataToJson(
    VerificationData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'applicantId': instance.applicantId,
      'isConfirmed': instance.isConfirmed,
      'photoMatchPercent': instance.photoMatchPercent,
      'photoMatchFlag': instance.photoMatchFlag,
      'isLiveliness': instance.isLiveliness,
      'faceCoverage': instance.faceCoverage,
      'ipvHoApproval': instance.ipvHoApproval,
      'faceCompareJson': instance.faceCompareJson,
      'faceLivenessJson': instance.faceLivenessJson,
      'status': instance.status,
      'trxnno': instance.trxnno,
      'estransactionid': instance.estransactionid,
      'errorcode': instance.errorcode,
      'errormessage': instance.errormessage,
      'useripadd': instance.useripadd,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'country': instance.country,
      'imagePath': instance.imagePath,
      'pdfPath': instance.pdfPath,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };