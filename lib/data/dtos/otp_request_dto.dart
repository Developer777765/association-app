// To parse this JSON data, do
//
//     final otpRequestDto = otpRequestDtoFromJson(jsonString);

import 'dart:convert';

OtpRequestDto otpRequestDtoFromJson(String str) => OtpRequestDto.fromJson(json.decode(str));

String otpRequestDtoToJson(OtpRequestDto data) => json.encode(data.toJson());

class OtpRequestDto {
    final String? phno;
    final String? otp;
    final String? createdBy;
    final String? createdDate;
    final String? modifiedBy;
    final String? modifiedDate;

    OtpRequestDto({
        this.phno,
        this.otp,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
    });

    factory OtpRequestDto.fromJson(Map<String, dynamic> json) => OtpRequestDto(
        phno: json["phno"],
        otp: json["otp"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"],
        modifiedBy: json["modifiedBy"],
        modifiedDate: json["modifiedDate"],
    );

    Map<String, dynamic> toJson() => {
        "phno": phno,
        "otp": otp,
        "createdBy": createdBy,
        "createdDate": createdDate,
        "modifiedBy": modifiedBy,
        "modifiedDate": modifiedDate,
    };
}
