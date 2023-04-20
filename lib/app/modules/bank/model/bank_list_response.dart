import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class BankListResponse {
  String? status;
  String? message;
  int? code;
  BankListBody? body;

  BankListResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory BankListResponse.fromJson(dynamic json) =>
      _$BankListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BankListResponseToJson(this);
}

BankListResponse _$BankListResponseFromJson(Map<String, dynamic> json) =>
    BankListResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$BankListBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$BankListResponseToJson(BankListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class BankListBody {
  List<BankList>? bankList = [];

  BankListBody({
    required this.bankList,
  });

  factory BankListBody.fromJson(dynamic json) => _$BankListBodyFromJson(json);

  Map<String, dynamic> toJson() => _$BankListBodyToJson(this);
}

BankListBody _$BankListBodyFromJson(Map<String, dynamic> json) => BankListBody(
      bankList: json.containsKey('bankList') && json['bankList'] != null
          ? List<BankList>.from(
              json['bankList'].map((x) => BankList.fromJson(x)))
          : [],
    );

Map<String, dynamic> _$BankListBodyToJson(BankListBody instance) =>
    <String, dynamic>{
      'body': instance.bankList,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class BankList {
  String? bankName;
  String? bankId;
  String? ifsc;
  bool? selected;
  String? accNo;

  BankList({
    required this.bankName,
    required this.bankId,
    required this.ifsc,
    required this.selected,
    required this.accNo,
  });

  factory BankList.fromJson(dynamic json) => _$BankListFromJson(json);

  Map<String, dynamic> toJson() => _$BankListToJson(this);
}

BankList _$BankListFromJson(Map<String, dynamic> json) => BankList(
      bankName: json['bankName'],
      bankId: json['bankId'],
      ifsc: json['ifsc'],
      selected: json['selected'],
      accNo: json['accNo'],
    );

Map<String, dynamic> _$BankListToJson(BankList instance) => <String, dynamic>{
      'bankName': instance.bankName,
      'bankId': instance.bankId,
      'ifsc': instance.ifsc,
      'selected': instance.selected,
      'accNo': instance.accNo,
    };
