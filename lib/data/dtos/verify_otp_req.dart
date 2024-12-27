// To parse this JSON data, do
//
//     final verifyOtpReq = verifyOtpReqFromJson(jsonString);

import 'dart:convert';

VerifyOtpReq verifyOtpReqFromJson(String str) => VerifyOtpReq.fromJson(json.decode(str));

String verifyOtpReqToJson(VerifyOtpReq data) => json.encode(data.toJson());

class VerifyOtpReq {
    final String? phno;
    final String? otp;

    VerifyOtpReq({
        this.phno,
        this.otp,
    });

    factory VerifyOtpReq.fromJson(Map<String, dynamic> json) => VerifyOtpReq(
        phno: json["phno"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "phno": phno,
        "otp": otp,
    };
}
