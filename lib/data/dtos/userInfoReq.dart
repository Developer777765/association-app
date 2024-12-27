// To parse this JSON data, do
//
//     final userInfoReq = userInfoReqFromJson(jsonString);

import 'dart:convert';

UserInfoReq userInfoReqFromJson(String str) => UserInfoReq.fromJson(json.decode(str));

String userInfoReqToJson(UserInfoReq data) => json.encode(data.toJson());

class UserInfoReq {
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
    final String? modifiedBy;
    final String? modifiedDate;

    UserInfoReq({
        this.name,
        this.sex,
        this.dob,
        this.address,
        this.phno,
        this.spousePhNo,
        this.fatherPhNo,
        this.email,
        this.photo,
        this.uploadLocation,
        this.maritalStatus,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
    });

    factory UserInfoReq.fromJson(Map<String, dynamic> json) => UserInfoReq(
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
    );

    Map<String, dynamic> toJson() => {
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
    };
}
