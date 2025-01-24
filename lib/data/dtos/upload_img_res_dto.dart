// To parse this JSON data, do
//
//     final profilePicUploadRes = profilePicUploadResFromJson(jsonString);

import 'dart:convert';

ProfilePicUploadRes profilePicUploadResFromJson(String str) =>
    ProfilePicUploadRes.fromJson(json.decode(str));

String profilePicUploadResToJson(ProfilePicUploadRes data) =>
    json.encode(data.toJson());

class ProfilePicUploadRes {
  final String status;
  final String statusCode;
  final Result result;

  ProfilePicUploadRes({
    required this.status,
    required this.statusCode,
    required this.result,
  });

  factory ProfilePicUploadRes.fromJson(Map<String, dynamic> json) =>
      ProfilePicUploadRes(
        status: json["status"],
        statusCode: json["statusCode"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "result": result.toJson(),
      };
}

class Result {
  final String fileName;
  final String uniqId;

  Result({
    required this.fileName,
    required this.uniqId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        fileName: json["fileName"],
        uniqId: json["uniqId"],
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "uniqId": uniqId,
      };
}
