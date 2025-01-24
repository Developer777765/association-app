// To parse this JSON data, do
//
//     final approveProfileResult = approveProfileResultFromJson(jsonString);

import 'dart:convert';

ApproveProfileResult approveProfileResultFromJson(String str) => ApproveProfileResult.fromJson(json.decode(str));

String approveProfileResultToJson(ApproveProfileResult data) => json.encode(data.toJson());

class ApproveProfileResult {
    final String? status;
    final String? statusCode;
    final dynamic result;

    ApproveProfileResult({
        this.status,
        this.statusCode,
        this.result,
    });

    factory ApproveProfileResult.fromJson(Map<String, dynamic> json) => ApproveProfileResult(
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
