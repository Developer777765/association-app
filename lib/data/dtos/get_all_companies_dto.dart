// To parse this JSON data, do
//     final getAllCompaniesResponseDto = getAllCompaniesResponseDtoFromJson(jsonString);

import 'dart:convert';

GetAllCompaniesResponseDto getAllCompaniesResponseDtoFromJson(String str) => GetAllCompaniesResponseDto.fromJson(json.decode(str));

String getAllCompaniesResponseDtoToJson(GetAllCompaniesResponseDto data) => json.encode(data.toJson());

class GetAllCompaniesResponseDto {
    final String? status;
    final String? statusCode;
    final List<Result>? result;

    GetAllCompaniesResponseDto({
        this.status,
        this.statusCode,
        this.result,
    });

    factory GetAllCompaniesResponseDto.fromJson(Map<String, dynamic> json) => GetAllCompaniesResponseDto(
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
    final int? uniqueId;
    final String? companyName;

    Result({
        this.uniqueId,
        this.companyName,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        uniqueId: json["uniqueId"],
        companyName: json["companyName"],
    );

    Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "companyName": companyName,
    };
}
