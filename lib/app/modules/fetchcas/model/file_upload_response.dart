import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class FileUploadResponse {
  String? status;
  String? message;
  int? code;
  FileUploadBody? body;

  FileUploadResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.body,
  });

  factory FileUploadResponse.fromJson(dynamic json) =>
      _$FileUploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FileUploadResponseToJson(this);
}

FileUploadResponse _$FileUploadResponseFromJson(Map<String, dynamic> json) =>
    FileUploadResponse(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      body: json.containsKey('body') && json['body'] != null
          ? _$FileUploadBodyFromJson(json['body'])
          : null,
    );

Map<String, dynamic> _$FileUploadResponseToJson(FileUploadResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'code': instance.code,
      'body': instance.body,
    };

@JsonSerializable(fieldRename: FieldRename.none)
class FileUploadBody {
  String? filePath;
  String? fileName;
  String? fileType;

  FileUploadBody({
    required this.filePath,
    required this.fileName,
    required this.fileType,
  });

  factory FileUploadBody.fromJson(dynamic json) =>
      _$FileUploadBodyFromJson(json);

  Map<String, dynamic> toJson() => _$FileUploadBodyToJson(this);
}

FileUploadBody _$FileUploadBodyFromJson(Map<String, dynamic> json) =>
    FileUploadBody(
      filePath: json['filePath'],
      fileName: json['fileName'],
      fileType: json['fileType'],
    );

Map<String, dynamic> _$FileUploadBodyToJson(FileUploadBody instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'fileName': instance.fileName,
      'fileType': instance.fileType,
    };
