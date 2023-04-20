import 'package:customer/app/modules/kyc/model/personal_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class AddressDetailResponse {
  String? status;
  String? message;
  int? code;
  AddressDetailBody? body;

  AddressDetailResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory AddressDetailResponse.fromJson(dynamic json) =>
      _$AddressDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDetailResponseToJson(this);
}

AddressDetailResponse _$AddressDetailResponseFromJson(
        Map<String, dynamic> json) =>
    AddressDetailResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$AddressDetailBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$AddressDetailResponseToJson(
        AddressDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class AddressDetailBody {
  bool? isPartial;
  AddressData? applicantDetails;

  AddressDetailBody({
    required this.isPartial,
    required this.applicantDetails,
  });

  factory AddressDetailBody.fromJson(dynamic json) =>
      _$AddressDetailBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDetailBodyToJson(this);
}

AddressDetailBody _$AddressDetailBodyFromJson(Map<String, dynamic> json) =>
    AddressDetailBody(
      isPartial: json['isPartial'],
      applicantDetails: json.containsKey('applicantDetails') &&
              json['applicantDetails'] != null
          ? _$AddressDataFromJson(json['applicantDetails'])
          : null,
    );

Map<String, dynamic> _$AddressDetailBodyToJson(AddressDetailBody instance) =>
    <String, dynamic>{
      'isPartial': instance.isPartial,
      'applicantDetails': instance.applicantDetails,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class AddressData {
  String? address;
  String? country;
  String? state;
  String? city;
  String? pincode;
  String? addressProofType;
  String? addressProofFile;
  String? addressType;
  List<ConsentData>? consentList = [];
  int? applicantId;
  int? addressId;

  AddressData({
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.pincode,
    required this.addressProofType,
    required this.addressProofFile,
    required this.addressType,
    required this.consentList,
    required this.applicantId,
    required this.addressId,
  });

  factory AddressData.fromJson(dynamic json) => _$AddressDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataToJson(this);
}

AddressData _$AddressDataFromJson(Map<String, dynamic> json) => AddressData(
      address: json['address'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      pincode: json['pincode'],
      addressProofType: json['addressProofType'],
      addressProofFile: json['addressProofFile'],
      addressType: json['addressType'],
      consentList:
          json.containsKey('consentList') && json['consentList'] != null
              ? List<ConsentData>.from(
                  json['consentList'].map((x) => ConsentData.fromJson(x)))
              : [],
      applicantId: json['applicantId'],
      addressId: json['addressId'],
    );

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'address': instance.address,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'pincode': instance.pincode,
      'addressProofType': instance.addressProofType,
      'addressProofFile': instance.addressProofFile,
      'addressType': instance.addressType,
      'consentList': instance.consentList,
      'applicantId': instance.applicantId,
      'addressId': instance.addressId,
    };
