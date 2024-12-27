// To parse this JSON data, do
//
//     final getOtpReq = getOtpReqFromJson(jsonString);

import 'dart:convert';

GetOtpReq getOtpReqFromJson(String str) => GetOtpReq.fromJson(json.decode(str));

String getOtpReqToJson(GetOtpReq data) => json.encode(data.toJson());

class GetOtpReq {
    final String? phno;
    final String? otp;

    GetOtpReq({
        this.phno,
        this.otp,
    });

    factory GetOtpReq.fromJson(Map<String, dynamic> json) => GetOtpReq(
        phno: json["phno"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "phno": phno,
        "otp": otp,
    };
}
