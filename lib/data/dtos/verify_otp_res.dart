// To parse this JSON data, do
//
//     final verifyOtpRes = verifyOtpResFromJson(jsonString);

import 'dart:convert';

VerifyOtpRes verifyOtpResFromJson(String str) => VerifyOtpRes.fromJson(json.decode(str));

String verifyOtpResToJson(VerifyOtpRes data) => json.encode(data.toJson());

class VerifyOtpRes {
    final String? status;
    final String? statusCode;
    final Result? verifyOtpResult;

    VerifyOtpRes({
        this.status,
        this.statusCode,
        this.verifyOtpResult,
    });

    factory VerifyOtpRes.fromJson(Map<String, dynamic> json) => VerifyOtpRes(
        status: json["status"],
        statusCode: json["statusCode"],
        verifyOtpResult: json["result"] == null ? null : Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "result": verifyOtpResult?.toJson(),
    };
}

class Result {
    final String? message;
    final int? userId;

    Result({
        this.message,
        this.userId,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        message: json["message"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "userId": userId,
    };
}
