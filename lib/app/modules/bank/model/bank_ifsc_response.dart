import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class BankIfscResponse {
  String? status;
  String? message;
  int? code;
  BankIfscBody? body;

  BankIfscResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory BankIfscResponse.fromJson(dynamic json) =>
      _$BankIfscResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BankIfscResponseToJson(this);
}

BankIfscResponse _$BankIfscResponseFromJson(Map<String, dynamic> json) =>
    BankIfscResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$BankIfscBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$BankIfscResponseToJson(BankIfscResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class BankIfscBody {
  BankIfsc? bank;

  BankIfscBody({
    required this.bank,
  });

  factory BankIfscBody.fromJson(dynamic json) => _$BankIfscBodyFromJson(json);

  Map<String, dynamic> toJson() => _$BankIfscBodyToJson(this);
}

BankIfscBody _$BankIfscBodyFromJson(Map<String, dynamic> json) => BankIfscBody(
      bank: json.containsKey('bank') && json['bank'] != null
          ? _$BankIfscFromJson(json['bank'])
          : null,
    );

Map<String, dynamic> _$BankIfscBodyToJson(BankIfscBody instance) =>
    <String, dynamic>{
      'bank': instance.bank,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class BankIfsc {
  String? bankName;
  String? MICR;
  String? branchName;

  BankIfsc({
    required this.bankName,
    required this.MICR,
    required this.branchName,
  });

  factory BankIfsc.fromJson(dynamic json) => _$BankIfscFromJson(json);

  Map<String, dynamic> toJson() => _$BankIfscToJson(this);
}

BankIfsc _$BankIfscFromJson(Map<String, dynamic> json) => BankIfsc(
      bankName: json['bankName'],
      MICR: json['MICR'],
      branchName: json['branchName'],
    );

Map<String, dynamic> _$BankIfscToJson(BankIfsc instance) => <String, dynamic>{
      'bankName': instance.bankName,
      'MICR': instance.MICR,
      'branchName': instance.branchName,
    };
