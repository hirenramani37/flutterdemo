import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class AddressListResponse {
  String? status;
  String? message;
  int? code;
  AddressListBody? body;

  AddressListResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory AddressListResponse.fromJson(dynamic json) =>
      _$AddressListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressListResponseToJson(this);
}

AddressListResponse _$AddressListResponseFromJson(Map<String, dynamic> json) =>
    AddressListResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$AddressListBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$AddressListResponseToJson(
        AddressListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class AddressListBody {
  List<AddressDetail>? applicantDetails = [];

  AddressListBody({
    required this.applicantDetails,
  });

  factory AddressListBody.fromJson(dynamic json) =>
      _$AddressListBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddressListBodyToJson(this);
}

AddressListBody _$AddressListBodyFromJson(Map<String, dynamic> json) =>
    AddressListBody(
      applicantDetails: json.containsKey('applicantDetails') &&
              json['applicantDetails'] != null
          ? List<AddressDetail>.from(
              json['applicantDetails'].map((x) => AddressDetail.fromJson(x)))
          : [],
    );

Map<String, dynamic> _$AddressListBodyToJson(AddressListBody instance) =>
    <String, dynamic>{
      'applicantDetails': instance.applicantDetails,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class AddressDetail {
  String? addressType;
  int?    addressId;
  int?    applicantId;
  String? applicantType;

  AddressDetail({
    required this.addressType,
    required this.addressId,
    required this.applicantId,
    required this.applicantType,
  });

  factory AddressDetail.fromJson(dynamic json) =>
      _$AddressDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDetailToJson(this);
}

AddressDetail _$AddressDetailFromJson(Map<String, dynamic> json) =>
    AddressDetail(
      addressType: json['addressType'],
      addressId: json['addressId'],
      applicantId: json['applicantId'],
      applicantType: json['applicantType'],
    );

Map<String, dynamic> _$AddressDetailToJson(AddressDetail instance) =>
    <String, dynamic>{
      'addressType': instance.addressType,
      'addressId': instance.addressId,
      'applicantId': instance.applicantId,
      'applicantType': instance.applicantType,
    };
