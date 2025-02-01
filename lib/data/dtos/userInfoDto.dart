// // To parse this JSON data, do
// //
// //     final userInfoResult = userInfoResultFromJson(jsonString);

// import 'dart:convert';

// UserInfoResult userInfoResultFromJson(String str) => UserInfoResult.fromJson(json.decode(str));

// String userInfoResultToJson(UserInfoResult data) => json.encode(data.toJson());

// class UserInfoResult {
//     final String? status;
//     final String? statusCode;
//     final Result? result;

//     UserInfoResult({
//         this.status,
//         this.statusCode,
//         this.result,
//     });

//     factory UserInfoResult.fromJson(Map<String, dynamic> json) => UserInfoResult(
//         status: json["status"],
//         statusCode: json["statusCode"],
//         result: json["result"] == null ? null : Result.fromJson(json["result"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "statusCode": statusCode,
//         "result": result?.toJson(),
//     };
// }

// class Result {
//     final int? id;
//     final String? name;
//     final String? sex;
//     final String? dob;
//     final String? address;
//     final String? phno;
//     final String? spousePhNo;
//     final String? fatherPhNo;
//     final String? email;
//     final String? photo;
//     final String? uploadLocation;
//     final bool? maritalStatus;
//     final String? createdBy;
//     final String? createdDate;
//     final dynamic modifiedBy;
//     final dynamic modifiedDate;

//     Result({
//         this.id,
//         this.name,
//         this.sex,
//         this.dob,
//         this.address,
//         this.phno,
//         this.spousePhNo,
//         this.fatherPhNo,
//         this.email,
//         this.photo,
//         this.uploadLocation,
//         this.maritalStatus,
//         this.createdBy,
//         this.createdDate,
//         this.modifiedBy,
//         this.modifiedDate,
//     });

//     factory Result.fromJson(Map<String, dynamic> json) => Result(
//         id: json["id"],
//         name: json["name"],
//         sex: json["sex"],
//         dob: json["dob"],
//         address: json["address"],
//         phno: json["phno"],
//         spousePhNo: json["spousePhNo"],
//         fatherPhNo: json["fatherPhNo"],
//         email: json["email"],
//         photo: json["photo"],
//         uploadLocation: json["upload_Location"],
//         maritalStatus: json["maritalStatus"],
//         createdBy: json["createdBy"],
//         createdDate: json["createdDate"],
//         modifiedBy: json["modifiedBy"],
//         modifiedDate: json["modifiedDate"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "sex": sex,
//         "dob": dob,
//         "address": address,
//         "phno": phno,
//         "spousePhNo": spousePhNo,
//         "fatherPhNo": fatherPhNo,
//         "email": email,
//         "photo": photo,
//         "upload_Location": uploadLocation,
//         "maritalStatus": maritalStatus,
//         "createdBy": createdBy,
//         "createdDate": createdDate,
//         "modifiedBy": modifiedBy,
//         "modifiedDate": modifiedDate,
//     };
// }

// To parse this JSON data, do
//
//     final userInfoResult = userInfoResultFromJson(jsonString);

import 'dart:convert';

UserInfoResult userInfoResultFromJson(String str) =>
    UserInfoResult.fromJson(json.decode(str));

String userInfoResultToJson(UserInfoResult data) => json.encode(data.toJson());

class UserInfoResult {
  final String? status;
  final String? statusCode;
  final Result result;

  UserInfoResult({
    required this.status,
    required this.statusCode,
    required this.result,
  });

  factory UserInfoResult.fromJson(Map<String, dynamic> json) => UserInfoResult(
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
  final int id;
  final String? name;
  final String? sex;
  final String? dob;
  final String? address;
  final String? phno;
  final String? spousePhNo;
  final String? fatherPhNo;
  final String? email;
  final String? photo;
  final String? uploadLocation;
  final bool? maritalStatus;
  final String? createdBy;
  final String? createdDate;
  final dynamic modifiedBy;
  final dynamic modifiedDate;
  final bool? isApproval;
  final String? profilePic;
  final int? uniqueId;

  Result({
    required this.id,
    required this.name,
    required this.sex,
    required this.dob,
    required this.address,
    required this.phno,
    required this.spousePhNo,
    required this.fatherPhNo,
    required this.email,
    required this.photo,
    required this.uploadLocation,
    required this.maritalStatus,
    required this.createdBy,
    required this.createdDate,
    required this.modifiedBy,
    required this.modifiedDate,
    required this.isApproval,
    required this.profilePic,
    required this.uniqueId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        sex: json["sex"],
        dob: json["dob"],
        address: json["address"],
        phno: json["phno"],
        spousePhNo: json["spousePhNo"],
        fatherPhNo: json["fatherPhNo"],
        email: json["email"],
        photo: json["photo"],
        uploadLocation: json["upload_Location"],
        maritalStatus: json["maritalStatus"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"],
        modifiedBy: json["modifiedBy"],
        modifiedDate: json["modifiedDate"],
        isApproval: json["isApproval"],
        profilePic: json["profile_Pic"],
        uniqueId: json["unique_Id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sex": sex,
        "dob": dob,
        "address": address,
        "phno": phno,
        "spousePhNo": spousePhNo,
        "fatherPhNo": fatherPhNo,
        "email": email,
        "photo": photo,
        "upload_Location": uploadLocation,
        "maritalStatus": maritalStatus,
        "createdBy": createdBy,
        "createdDate": createdDate,
        "modifiedBy": modifiedBy,
        "modifiedDate": modifiedDate,
        "isApproval": isApproval,
        "profile_Pic": profilePic,
        "unique_Id": uniqueId,
      };
}
