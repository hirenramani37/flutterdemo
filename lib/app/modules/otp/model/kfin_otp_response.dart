import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class KfinOtpResponse {
  String? status;
  String? message;
  int? code;
  KfinOtpBody? body;

  KfinOtpResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory KfinOtpResponse.fromJson(dynamic json) =>
      _$KfinOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KfinOtpResponseToJson(this);
}

KfinOtpResponse _$KfinOtpResponseFromJson(Map<String, dynamic> json) =>
    KfinOtpResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$KfinOtpBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$KfinOtpResponseToJson(KfinOtpResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class KfinOtpBody {
  String? token;
  OtpAuthPortfolio? otpAuthPortfolio;

  KfinOtpBody({
    required this.token,
    required this.otpAuthPortfolio,
  });

  factory KfinOtpBody.fromJson(dynamic json) => _$KfinOtpBodyFromJson(json);

  Map<String, dynamic> toJson() => _$KfinOtpBodyToJson(this);
}

KfinOtpBody _$KfinOtpBodyFromJson(Map<String, dynamic> json) => KfinOtpBody(
      token: json['token'],
      otpAuthPortfolio: json.containsKey('otpAuthPortfolio') &&
              json['otpAuthPortfolio'] != null
          ? _$OtpAuthPortfolioFromJson(json['otpAuthPortfolio'])
          : null,
    );

Map<String, dynamic> _$KfinOtpBodyToJson(KfinOtpBody instance) =>
    <String, dynamic>{
      'token': instance.token,
      'otpAuthPortfolio': instance.otpAuthPortfolio,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class OtpAuthPortfolio {
  String? lienBankAcc;
  String? requestId;
  String? kfinRefNo;
  String? ucc;

  OtpAuthPortfolio({
    required this.lienBankAcc,
    required this.requestId,
    required this.kfinRefNo,
    required this.ucc,
  });

  factory OtpAuthPortfolio.fromJson(dynamic json) =>
      _$OtpAuthPortfolioFromJson(json);

  Map<String, dynamic> toJson() => _$OtpAuthPortfolioToJson(this);
}

OtpAuthPortfolio _$OtpAuthPortfolioFromJson(Map<String, dynamic> json) =>
    OtpAuthPortfolio(
      lienBankAcc: json['lienBankAcc'],
      requestId: json['requestId'],
      kfinRefNo: json['kfinRefNo'],
      ucc: json['ucc'],
    );

Map<String, dynamic> _$OtpAuthPortfolioToJson(OtpAuthPortfolio instance) =>
    <String, dynamic>{
      'lienBankAcc': instance.lienBankAcc,
      'requestId': instance.requestId,
      'kfinRefNo': instance.kfinRefNo,
      'ucc': instance.ucc,
    };
