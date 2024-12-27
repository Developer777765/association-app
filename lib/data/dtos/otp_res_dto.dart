// To parse this JSON data, do
//
//     final getOtpRes = getOtpResFromJson(jsonString);

import 'dart:convert';

GetOtpRes getOtpResFromJson(String str) => GetOtpRes.fromJson(json.decode(str));

String getOtpResToJson(GetOtpRes data) => json.encode(data.toJson());

class GetOtpRes {
    final String? status;
    final String? statusCode;
    final String? result;

    GetOtpRes({
        this.status,
        this.statusCode,
        this.result,
    });

    factory GetOtpRes.fromJson(Map<String, dynamic> json) => GetOtpRes(
        status: json["status"],
        statusCode: json["statusCode"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "result": result,
    };
}
