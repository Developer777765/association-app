import 'dart:convert';

UserInfoResultForRegister userInfoResultForRegisterFromJson(String str) =>
    UserInfoResultForRegister.fromJson(json.decode(str));

String userInfoResultForRegisterToJson(UserInfoResultForRegister data) =>
    json.encode(data.toJson());

class UserInfoResultForRegister {
  final String? status;
  final String? statusCode;
  final List<Result>? result;

  UserInfoResultForRegister({
    this.status,
    this.statusCode,
    this.result,
  });

  factory UserInfoResultForRegister.fromJson(Map<String, dynamic> json) =>
      UserInfoResultForRegister(
        status: json["status"],
        statusCode: json["statusCode"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
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
  final dynamic modifiedBy;
  final dynamic modifiedDate;
  final bool? isApproval;
  final String? profilePicture;
  final List<dynamic>? tSignIns;

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
    this.tSignIns,
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
        tSignIns: json["tSignIns"] == null
            ? []
            : List<dynamic>.from(json["tSignIns"]!.map((x) => x)),
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
        "tSignIns":
            tSignIns == null ? [] : List<dynamic>.from(tSignIns!.map((x) => x)),
      };
}
