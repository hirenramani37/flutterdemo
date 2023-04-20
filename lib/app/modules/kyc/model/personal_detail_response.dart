import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class PersonalDetailResponse {
  String? status;
  String? message;
  int? code;
  PersonalDetailBody? body;

  PersonalDetailResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory PersonalDetailResponse.fromJson(dynamic json) =>
      _$PersonalDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalDetailResponseToJson(this);
}

PersonalDetailResponse _$PersonalDetailResponseFromJson(
        Map<String, dynamic> json) =>
    PersonalDetailResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$PersonalDetailBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$PersonalDetailResponseToJson(
        PersonalDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class PersonalDetailBody {
  PersonalDetail? applicantDetails;

  PersonalDetailBody({
    required this.applicantDetails,
  });

  factory PersonalDetailBody.fromJson(dynamic json) =>
      _$PersonalDetailBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalDetailBodyToJson(this);
}

PersonalDetailBody _$PersonalDetailBodyFromJson(Map<String, dynamic> json) =>
    PersonalDetailBody(
      applicantDetails: json.containsKey('applicantDetails') &&
              json['applicantDetails'] != null
          ? _$PersonalDetailFromJson(json['applicantDetails'])
          : null,
    );

Map<String, dynamic> _$PersonalDetailBodyToJson(PersonalDetailBody instance) =>
    <String, dynamic>{
      'applicantDetails': instance.applicantDetails,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class PersonalDetail {
  String? applicantName;
  String? fatherName;
  String? dateOfBirth;
  String? maritalStatus;
  String? pan;
  String? gender;
  String? nationality;
  String? taxStatus;
  String? occupation;
  String? politicallyExposed;
  String? relationPep;
  String? fundServingLoan;
  String? fundInvestmentMade;
  num? netWorth;
  String? industryOfOccupation;
  String? mobile;
  String? landline;
  String? camsMobile;
  String? kfinMobile;
  String? alternateContact;
  String? emailId;
  String? monthlyIncome;
  String? purposeOfLoan;
  String? ekycXmlPath;
  String? ekycXmlPassword;
  List<ConsentData>? consentList = [];
  String? ckycNo;
  int? applicantId;
  int? applicantType;
  String? digiLockerStatus;

  PersonalDetail({
    required this.applicantName,
    required this.fatherName,
    required this.dateOfBirth,
    required this.maritalStatus,
    required this.pan,
    required this.gender,
    required this.nationality,
    required this.taxStatus,
    required this.occupation,
    required this.politicallyExposed,
    required this.relationPep,
    required this.fundServingLoan,
    required this.fundInvestmentMade,
    required this.netWorth,
    required this.industryOfOccupation,
    required this.mobile,
    required this.landline,
    required this.camsMobile,
    required this.kfinMobile,
    required this.alternateContact,
    required this.emailId,
    required this.monthlyIncome,
    required this.purposeOfLoan,
    required this.ekycXmlPath,
    required this.ekycXmlPassword,
    required this.consentList,
    required this.ckycNo,
    required this.applicantId,
    required this.applicantType,
    required this.digiLockerStatus,
  });

  factory PersonalDetail.fromJson(dynamic json) =>
      _$PersonalDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalDetailToJson(this);
}

PersonalDetail _$PersonalDetailFromJson(Map<String, dynamic> json) =>
    PersonalDetail(
      applicantName: json['applicantName'],
      fatherName: json['fatherName'],
      dateOfBirth: json['dateOfBirth'],
      maritalStatus: json['maritalStatus'],
      pan: json['pan'],
      gender: json['gender'],
      nationality: json['nationality'],
      taxStatus: json['taxStatus'],
      occupation: json['occupation'],
      politicallyExposed: json['politicallyExposed'],
      relationPep: json['relationPep'],
      fundServingLoan: json['fundServingLoan'],
      fundInvestmentMade: json['fundInvestmentMade'],
      netWorth: json['netWorth'],
      industryOfOccupation: json['industryOfOccupation'],
      mobile: json['mobile'],
      landline: json['landline'],
      camsMobile: json['camsMobile'],
      kfinMobile: json['kfinMobile'],
      alternateContact: json['alternateContact'],
      emailId: json['emailId'],
      monthlyIncome: json['monthlyIncome'],
      purposeOfLoan: json['purposeOfLoan'],
      ekycXmlPath: json['ekycXmlPath'],
      ekycXmlPassword: json['ekycXmlPassword'],
      consentList:
          json.containsKey('consentList') && json['consentList'] != null
              ? List<ConsentData>.from(
                  json['consentList'].map((x) => ConsentData.fromJson(x)))
              : [],
      ckycNo: json['ckycNo'],
      applicantId: json['applicantId'],
      applicantType: json['applicantType'],
      digiLockerStatus: json.containsKey("digiLockerStatus") ? json['digiLockerStatus'] : "",
    );

Map<String, dynamic> _$PersonalDetailToJson(PersonalDetail instance) =>
    <String, dynamic>{
      'applicantName': instance.applicantName,
      'fatherName': instance.fatherName,
      'dateOfBirth': instance.dateOfBirth,
      'maritalStatus': instance.maritalStatus,
      'pan': instance.pan,
      'gender': instance.gender,
      'nationality': instance.nationality,
      'taxStatus': instance.taxStatus,
      'occupation': instance.occupation,
      'politicallyExposed': instance.politicallyExposed,
      'relationPep': instance.relationPep,
      'fundServingLoan': instance.fundServingLoan,
      'fundInvestmentMade': instance.fundInvestmentMade,
      'netWorth': instance.netWorth,
      'industryOfOccupation': instance.industryOfOccupation,
      'mobile': instance.mobile,
      'landline': instance.landline,
      'camsMobile': instance.camsMobile,
      'kfinMobile': instance.kfinMobile,
      'alternateContact': instance.alternateContact,
      'emailId': instance.emailId,
      'monthlyIncome': instance.monthlyIncome,
      'purposeOfLoan': instance.purposeOfLoan,
      'ekycXmlPath': instance.ekycXmlPath,
      'ekycXmlPassword': instance.ekycXmlPassword,
      'consentList': instance.consentList,
      'ckycNo': instance.ckycNo,
      'applicantId': instance.applicantId,
      'applicantType': instance.applicantType,
      'digiLockerStatus': instance.digiLockerStatus,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class ConsentData {
  String? consentMessage;
  String? ipAddress;
  int? consentTimestamp;

  ConsentData({
    required this.consentMessage,
    required this.ipAddress,
    required this.consentTimestamp,
  });

  factory ConsentData.fromJson(dynamic json) => _$ConsentDataFromJson(json);

  Map<String, dynamic> toJson() => _$ConsentDataToJson(this);
}

ConsentData _$ConsentDataFromJson(Map<String, dynamic> json) => ConsentData(
      consentMessage: json['consentMessage'],
      ipAddress: json['ipAddress'],
      consentTimestamp: json['consentTimestamp'],
    );

Map<String, dynamic> _$ConsentDataToJson(ConsentData instance) =>
    <String, dynamic>{
      'consentMessage': instance.consentMessage,
      'ipAddress': instance.ipAddress,
      'consentTimestamp': instance.consentTimestamp,
    };
