// To parse this JSON data, do
//
//     final updateUserProfileResDto = updateUserProfileResDtoFromJson(jsonString);

import 'dart:convert';

UpdateUserProfileResDto updateUserProfileResDtoFromJson(String str) => UpdateUserProfileResDto.fromJson(json.decode(str));

String updateUserProfileResDtoToJson(UpdateUserProfileResDto data) => json.encode(data.toJson());

class UpdateUserProfileResDto {
    final String? status;
    final String? message;
    final Result? result;

    UpdateUserProfileResDto({
        this.status,
        this.message,
        this.result,
    });

    factory UpdateUserProfileResDto.fromJson(Map<String, dynamic> json) => UpdateUserProfileResDto(
        status: json["status"],
        message: json["message"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result?.toJson(),
    };
}

class Result {
    final int? id;
    final String? name;
    final String? sex;
    final String? dob;
    final String? address;
    final String? phoneNumber;
    final String? fatherNumber;
    final String? spouseNumber;
    final String? email;
    final String? photo;
    final bool? maritalStatus;
    final String? uploadLocation;
    final String? createdBy;
    final String? createdDate;
    final String? modifiedBy;
    final String? modifiedDate;
    final bool? isApproval;
    final String? profilePicture;
    final int? uniqueId;
    final List<dynamic>? tSignIn;

    Result({
        this.id,
        this.name,
        this.sex,
        this.dob,
        this.address,
        this.phoneNumber,
        this.fatherNumber,
        this.spouseNumber,
        this.email,
        this.photo,
        this.maritalStatus,
        this.uploadLocation,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.isApproval,
        this.profilePicture,
        this.uniqueId,
        this.tSignIn,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        sex: json["sex"],
        dob: json["dob"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        fatherNumber: json["fatherNumber"],
        spouseNumber: json["spouseNumber"],
        email: json["email"],
        photo: json["photo"],
        maritalStatus: json["maritalStatus"],
        uploadLocation: json["uploadLocation"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"],
        modifiedBy: json["modifiedBy"],
        modifiedDate: json["modifiedDate"],
        isApproval: json["isApproval"],
        profilePicture: json["profilePicture"],
        uniqueId: json["uniqueId"],
        tSignIn: json["tSignIn"] == null ? [] : List<dynamic>.from(json["tSignIn"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sex": sex,
        "dob": dob,
        "address": address,
        "phoneNumber": phoneNumber,
        "fatherNumber": fatherNumber,
        "spouseNumber": spouseNumber,
        "email": email,
        "photo": photo,
        "maritalStatus": maritalStatus,
        "uploadLocation": uploadLocation,
        "createdBy": createdBy,
        "createdDate": createdDate,
        "modifiedBy": modifiedBy,
        "modifiedDate": modifiedDate,
        "isApproval": isApproval,
        "profilePicture": profilePicture,
        "uniqueId": uniqueId,
        "tSignIn": tSignIn == null ? [] : List<dynamic>.from(tSignIn!.map((x) => x)),
    };
}
