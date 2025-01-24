// To parse this JSON data, do
//
//     final checkNumberUniquenessResponse = checkNumberUniquenessResponseFromJson(jsonString);

import 'dart:convert';

CheckNumberUniquenessResponse checkNumberUniquenessResponseFromJson(String str) => CheckNumberUniquenessResponse.fromJson(json.decode(str));

String checkNumberUniquenessResponseToJson(CheckNumberUniquenessResponse data) => json.encode(data.toJson());

class CheckNumberUniquenessResponse {
    final String? status;
    final int? statusCode;
    final bool? isUnique;

    CheckNumberUniquenessResponse({
        this.status,
        this.statusCode,
        this.isUnique,
    });

    factory CheckNumberUniquenessResponse.fromJson(Map<String, dynamic> json) => CheckNumberUniquenessResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        isUnique: json["isUnique"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "isUnique": isUnique,
    };
}
