
import 'dart:convert';

GetRegisterModelDto getRegisterModelDtoFromJson(String str) => GetRegisterModelDto.fromJson(json.decode(str));

String getRegisterModelDtoToJson(GetRegisterModelDto data) => json.encode(data.toJson());

class GetRegisterModelDto {
    final String? status;
    final String? statusCode;
    final RegisterResult? result;

    GetRegisterModelDto({
        this.status,
        this.statusCode,
        this.result,
    });

    GetRegisterModelDto copyWith({
        String? status,
        String? statusCode,
        RegisterResult? result,
    }) => 
        GetRegisterModelDto(
            status: status ?? this.status,
            statusCode: statusCode ?? this.statusCode,
            result: result ?? this.result,
        );

    factory GetRegisterModelDto.fromJson(Map<String, dynamic> json) => GetRegisterModelDto(
        status: json["status"],
        statusCode: json["statusCode"],
        result: json["result"] == null ? null : RegisterResult.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "result": result?.toJson(),
    };
}

class RegisterResult {
    final String? name;
    final String? sex;
    final String? dob;
    final String? address;
    final String? phno;
    final String? photo;
    final String? uploadLocation;
    final String? createdBy;
    final String? createdDate;
    final dynamic modifiedBy;
    final dynamic modifiedDate;

    RegisterResult({
        this.name,
        this.sex,
        this.dob,
        this.address,
        this.phno,
        this.photo,
        this.uploadLocation,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
    });

    RegisterResult copyWith({
        String? name,
        String? sex,
        String? dob,
        String? address,
        String? phno,
        String? photo,
        String? uploadLocation,
        String? createdBy,
        String? createdDate,
        dynamic modifiedBy,
        dynamic modifiedDate,
    }) => 
        RegisterResult(
            name: name ?? this.name,
            sex: sex ?? this.sex,
            dob: dob ?? this.dob,
            address: address ?? this.address,
            phno: phno ?? this.phno,
            photo: photo ?? this.photo,
            uploadLocation: uploadLocation ?? this.uploadLocation,
            createdBy: createdBy ?? this.createdBy,
            createdDate: createdDate ?? this.createdDate,
            modifiedBy: modifiedBy ?? this.modifiedBy,
            modifiedDate: modifiedDate ?? this.modifiedDate,
        );

    factory RegisterResult.fromJson(Map<String, dynamic> json) => RegisterResult(
        name: json["name"],
        sex: json["sex"],
        dob: json["dob"],
        address: json["address"],
        phno: json["phno"],
        photo: json["photo"],
        uploadLocation: json["upload_Location"],
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
        "photo": photo,
        "upload_Location": uploadLocation,
        "createdBy": createdBy,
        "createdDate": createdDate,
        "modifiedBy": modifiedBy,
        "modifiedDate": modifiedDate,
    };
}
