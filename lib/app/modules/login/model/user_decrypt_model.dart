import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class UserDecryptModel {
  UserDecryptData? data;

  UserDecryptModel({
    required this.data,
  });

  factory UserDecryptModel.fromJson(dynamic json) =>
      _$UserDecryptModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDecryptModelToJson(this);
}

UserDecryptModel _$UserDecryptModelFromJson(Map<String, dynamic> json) =>
    UserDecryptModel(
      data: json.containsKey('data') && json['data'] != null
          ? _$UserDecryptDataFromJson(json['data'])
          : null,
    );

Map<String, dynamic> _$UserDecryptModelToJson(UserDecryptModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class UserDecryptData {
  int? loggedInId;
  String? moduleName;
  UserData? otherData;

  UserDecryptData({
    required this.loggedInId,
    required this.moduleName,
    required this.otherData,
  });

  factory UserDecryptData.fromJson(dynamic json) =>
      _$UserDecryptDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDecryptDataToJson(this);
}

UserDecryptData _$UserDecryptDataFromJson(Map<String, dynamic> json) =>
    UserDecryptData(
      loggedInId: json['loggedInId'],
      moduleName: json['moduleName'],
      otherData: json.containsKey('otherData') && json['otherData'] != null
          ? _$UserDataFromJson(json['otherData'])
          : null,
    );

Map<String, dynamic> _$UserDecryptDataToJson(UserDecryptData instance) =>
    <String, dynamic>{
      'loggedInId': instance.loggedInId,
      'moduleName': instance.moduleName,
      'otherData': instance.otherData,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class UserData {
  String? name;
  String? mobile;
  String? customerNumber;
  String? pan;
  String? email;

  UserData({
    required this.name,
    required this.mobile,
    required this.customerNumber,
    required this.pan,
    required this.email,
  });

  factory UserData.fromJson(dynamic json) => _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      name: json['name'],
      mobile: json['mobile'],
      customerNumber: json['customerNumber'],
      pan: json['pan'],
      email: json['email'],
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'customerNumber': instance.customerNumber,
      'pan': instance.pan,
      'email': instance.email,
    };
