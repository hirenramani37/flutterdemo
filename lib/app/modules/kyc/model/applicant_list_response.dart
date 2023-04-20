import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class ApplicantListResponse {
  String? status;
  String? message;
  int? code;
  ApplicantListBody? body;

  ApplicantListResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory ApplicantListResponse.fromJson(dynamic json) =>
      _$ApplicantListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicantListResponseToJson(this);
}

ApplicantListResponse _$ApplicantListResponseFromJson(
        Map<String, dynamic> json) =>
    ApplicantListResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$ApplicantListBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$ApplicantListResponseToJson(
        ApplicantListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class ApplicantListBody {
  double? emiAmount;
  List<ApplicantDetail>? applicantDetails = [];

  ApplicantListBody({
    required this.emiAmount,
    required this.applicantDetails,
  });

  factory ApplicantListBody.fromJson(dynamic json) =>
      _$ApplicantListBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicantListBodyToJson(this);
}

ApplicantListBody _$ApplicantListBodyFromJson(Map<String, dynamic> json) =>
    ApplicantListBody(
      emiAmount: json['emiAmount'],
      applicantDetails: json.containsKey('applicantDetails') &&
              json['applicantDetails'] != null
          ? List<ApplicantDetail>.from(
              json['applicantDetails'].map((x) => ApplicantDetail.fromJson(x)))
          : [],
    );

Map<String, dynamic> _$ApplicantListBodyToJson(ApplicantListBody instance) =>
    <String, dynamic>{
      'emiAmount': instance.emiAmount,
      'applicantDetails': instance.applicantDetails,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class ApplicantDetail {
  bool? existingKyc;
  String? loanApplicationId;
  String? applicantType;
  String? personalDetails;
  int? photoVerificationRequestNumber;
  dynamic addressDetails;
  String? photoVerification;
  int? applicantId;

  ApplicantDetail({
    required this.existingKyc,
    required this.loanApplicationId,
    required this.applicantType,
    required this.personalDetails,
    required this.photoVerificationRequestNumber,
    required this.addressDetails,
    required this.photoVerification,
    required this.applicantId,
  });

  factory ApplicantDetail.fromJson(dynamic json) =>
      _$ApplicantDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicantDetailToJson(this);
}

ApplicantDetail _$ApplicantDetailFromJson(Map<String, dynamic> json) =>
    ApplicantDetail(
      existingKyc: json['existingKyc'],
      loanApplicationId: json['loanApplicationId'],
      applicantType: json['applicantType'],
      personalDetails: json['personalDetails'],
      photoVerificationRequestNumber: json['photoVerificationRequestNumber'],
      addressDetails: json['addressDetails'],
      photoVerification: json['photoVerification'],
      applicantId: json['applicantId'],
    );

Map<String, dynamic> _$ApplicantDetailToJson(ApplicantDetail instance) =>
    <String, dynamic>{
      'existingKyc': instance.existingKyc,
      'loanApplicationId': instance.loanApplicationId,
      'applicantType': instance.applicantType,
      'personalDetails': instance.personalDetails,
      'photoVerificationRequestNumber': instance.photoVerificationRequestNumber,
      'addressDetails': instance.addressDetails,
      'photoVerification': instance.photoVerification,
      'applicantId': instance.applicantId,
    };
