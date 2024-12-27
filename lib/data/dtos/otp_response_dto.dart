// To parse this JSON data, do
//
//     final otpResponse = otpResponseFromJson(jsonString);

import 'dart:convert';

OtpResponse otpResponseFromJson(String str) => OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
    final String? status;
    final String? statusCode;
    final List<Result>? result;

    OtpResponse({
        this.status,
        this.statusCode,
        this.result,
    });

    factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
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
    final String? phoneNumber;
    final String? otp;
    final String? createdBy;
    final String? createdDate;
    final String? modifiedBy;
    final String? modifiedDate;

    Result({
        this.id,
        this.phoneNumber,
        this.otp,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        phoneNumber: json["phoneNumber"],
        otp: json["otp"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"],
        modifiedBy: json["modifiedBy"],
        modifiedDate: json["modifiedDate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "phoneNumber": phoneNumber,
        "otp": otp,
        "createdBy": createdBy,
        "createdDate": createdDate,
        "modifiedBy": modifiedBy,
        "modifiedDate": modifiedDate,
    };
}
