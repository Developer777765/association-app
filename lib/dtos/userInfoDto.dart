// To parse this JSON data, do
//
//     final userInfoResult = userInfoResultFromJson(jsonString);

import 'dart:convert';

UserInfoResult userInfoResultFromJson(String str) => UserInfoResult.fromJson(json.decode(str));

String userInfoResultToJson(UserInfoResult data) => json.encode(data.toJson());

class UserInfoResult {
    final String? status;
    final String? statusCode;
    final List<Result>? result;

    UserInfoResult({
        this.status,
        this.statusCode,
        this.result,
    });

    factory UserInfoResult.fromJson(Map<String, dynamic> json) => UserInfoResult(
        status: json["status"],
        statusCode: json["statusCode"],
        result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
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
    final String? uploadLocation;
    final String? createdBy;
    final String? createdDate;
    final dynamic modifiedBy;
    final dynamic modifiedDate;

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
        this.uploadLocation,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
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
        uploadLocation: json["uploadLocation"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"],
        modifiedBy: json["modifiedBy"],
        modifiedDate: json["modifiedDate"],
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
        "uploadLocation": uploadLocation,
        "createdBy": createdBy,
        "createdDate": createdDate,
        "modifiedBy": modifiedBy,
        "modifiedDate": modifiedDate,
    };
}
