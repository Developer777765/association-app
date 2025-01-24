import 'dart:convert';
import 'dart:io';

ProfilePicUploadReq profilePicUploadReqFromJson(String str) =>
    ProfilePicUploadReq.fromJson(json.decode(str));

String profilePicUploadReqToJson(ProfilePicUploadReq data) =>
    json.encode(data.toJson());

class ProfilePicUploadReq {
  final File? uploadFile;
  final String? companyName;
  final int? companyId;
  final String? unitId;
  final String? category;
  final String? keyValue;
  final int? keyId;
  final String? fileType;
  final String? createdBy;
  final String? path;
  final String? fileName;

  ProfilePicUploadReq(
      {this.uploadFile,
      this.companyName,
      this.companyId,
      this.unitId,
      this.category,
      this.keyValue,
      this.keyId,
      this.fileType,
      this.createdBy,
      this.path,
      this.fileName});

  factory ProfilePicUploadReq.fromJson(Map<String, dynamic> json) =>
      ProfilePicUploadReq(
          uploadFile: json["uploadFile"],
          companyName: json["companyName"],
          companyId: json["companyId"],
          unitId: json["unitId"],
          category: json["category"],
          keyValue: json["keyValue"],
          keyId: json["keyId"],
          fileType: json["fileType"],
          createdBy: json["createdBy"],
          path: json["path"],
          fileName: json['fileName']);

  Map<String, dynamic> toJson() => {
        "uploadFile": uploadFile,
        "companyName": companyName,
        "companyId": companyId,
        "unitId": unitId,
        "category": category,
        "keyValue": keyValue,
        "keyId": keyId,
        "fileType": fileType,
        "createdBy": createdBy,
        "path": path,
        "fileName": fileName
      };
}
