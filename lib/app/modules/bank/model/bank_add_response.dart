import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class BankAddResponse {
  String? status;
  String? message;
  int? code;
  BankAddBody? body;

  BankAddResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory BankAddResponse.fromJson(dynamic json) =>
      _$BankAddResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BankAddResponseToJson(this);
}

BankAddResponse _$BankAddResponseFromJson(Map<String, dynamic> json) =>
    BankAddResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$BankAddBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$BankAddResponseToJson(BankAddResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class BankAddBody {
  int? bankId;
  PennyDropData? pennyDrop;

  BankAddBody({
    required this.bankId,
    required this.pennyDrop,
  });

  factory BankAddBody.fromJson(dynamic json) => _$BankAddBodyFromJson(json);

  Map<String, dynamic> toJson() => _$BankAddBodyToJson(this);
}

BankAddBody _$BankAddBodyFromJson(Map<String, dynamic> json) => BankAddBody(
      bankId: json['bankId'],
      pennyDrop: json.containsKey('pennyDrop') && json['pennyDrop'] != null
          ? _$PennyDropDataFromJson(json['pennyDrop'])
          : null,
    );

Map<String, dynamic> _$BankAddBodyToJson(BankAddBody instance) =>
    <String, dynamic>{
      'bankId': instance.bankId,
      'pennyDrop': instance.pennyDrop,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class PennyDropData {
  int? pennyDropCount;
  PennyDrop? pennyDropResponse;

  PennyDropData({
    required this.pennyDropCount,
    required this.pennyDropResponse,
  });

  factory PennyDropData.fromJson(dynamic json) => _$PennyDropDataFromJson(json);

  Map<String, dynamic> toJson() => _$PennyDropDataToJson(this);
}

PennyDropData _$PennyDropDataFromJson(Map<String, dynamic> json) =>
    PennyDropData(
      pennyDropCount: json['pennyDropCount'],
      pennyDropResponse: json.containsKey('pennyDropResponse') && json['pennyDropResponse'] != null
          ? _$PennyDropFromJson(json['pennyDropResponse'])
          : null,
    );

Map<String, dynamic> _$PennyDropDataToJson(PennyDropData instance) =>
    <String, dynamic>{
      'pennyDropCount': instance.pennyDropCount,
      'pennyDropResponse': instance.pennyDropResponse,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class PennyDrop {
  String? uniqueTrxnRefNo;
  String? pgTrxnRefNo;
  String? trxnStatus;
  String? trxnDate;
  String? beneficiaryAccNo;
  String? beneficiaryIfsc;
  String? beneficiaryName;
  String? bankRefNo;
  String? errorDesc;
  String? checksum;

  PennyDrop({
    required this.uniqueTrxnRefNo,
    required this.pgTrxnRefNo,
    required this.trxnStatus,
    required this.trxnDate,
    required this.beneficiaryAccNo,
    required this.beneficiaryIfsc,
    required this.beneficiaryName,
    required this.bankRefNo,
    required this.errorDesc,
    required this.checksum,
  });

  factory PennyDrop.fromJson(dynamic json) => _$PennyDropFromJson(json);

  Map<String, dynamic> toJson() => _$PennyDropToJson(this);
}

PennyDrop _$PennyDropFromJson(Map<String, dynamic> json) => PennyDrop(
      uniqueTrxnRefNo: json['uniqueTrxnRefNo'],
      pgTrxnRefNo: json['pgTrxnRefNo'],
      trxnStatus: json['trxnStatus'],
      trxnDate: json['trxnDate'],
      beneficiaryAccNo: json['beneficiaryAccNo'],
      beneficiaryIfsc: json['beneficiaryIfsc'],
      beneficiaryName: json['beneficiaryName'],
      bankRefNo: json['bankRefNo'],
      errorDesc: json['errorDesc'],
      checksum: json['checksum'],
    );

Map<String, dynamic> _$PennyDropToJson(PennyDrop instance) => <String, dynamic>{
      'uniqueTrxnRefNo': instance.uniqueTrxnRefNo,
      'pgTrxnRefNo': instance.pgTrxnRefNo,
      'trxnStatus': instance.trxnStatus,
      'trxnDate': instance.trxnDate,
      'beneficiaryAccNo': instance.beneficiaryAccNo,
      'beneficiaryIfsc': instance.beneficiaryIfsc,
      'beneficiaryName': instance.beneficiaryName,
      'bankRefNo': instance.bankRefNo,
      'errorDesc': instance.errorDesc,
      'checksum': instance.checksum,
    };
