// To parse this JSON data, do
//
//     final checkNumberUniquenessResponse = checkNumberUniquenessResponseFromJson(jsonString);

import 'dart:convert';

CheckNumberUniquenessResponse checkNumberUniquenessResponseFromJson(String str) => CheckNumberUniquenessResponse.fromJson(json.decode(str));

String checkNumberUniquenessResponseToJson(CheckNumberUniquenessResponse data) => json.encode(data.toJson());

class CheckNumberUniquenessResponse {
    final String status;
    final int statusCode;
    final Result result;

    CheckNumberUniquenessResponse({
        required this.status,
        required this.statusCode,
        required this.result,
    });

    factory CheckNumberUniquenessResponse.fromJson(Map<String, dynamic> json) => CheckNumberUniquenessResponse(
        status: json["status"],
        statusCode: json["statusCode"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "result": result.toJson(),
    };
}

class Result {
    final bool isNumberUnique;
    final int userId;

    Result({
        required this.isNumberUnique,
        required this.userId,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        isNumberUnique: json["isNumberUnique"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "isNumberUnique": isNumberUnique,
        "userId": userId,
    };
}
