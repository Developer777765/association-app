// To parse this JSON data, do
//
//     final getOtpReq = getOtpReqFromJson(jsonString);

import 'dart:convert';

GetOtpReq getOtpReqFromJson(String str) => GetOtpReq.fromJson(json.decode(str));

String getOtpReqToJson(GetOtpReq data) => json.encode(data.toJson());

class GetOtpReq {
    final String? phno;

    GetOtpReq({
        this.phno,
    });

    factory GetOtpReq.fromJson(Map<String, dynamic> json) => GetOtpReq(
        phno: json["phno"],
    );

    Map<String, dynamic> toJson() => {
        "phno": phno,
    };
}
