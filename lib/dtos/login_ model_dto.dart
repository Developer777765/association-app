// To parse this JSON data, do
//
//     final loginModelDto = loginModelDtoFromJson(jsonString);

import 'dart:convert';

LoginModelDto loginModelDtoFromJson(String str) => LoginModelDto.fromJson(json.decode(str));

String loginModelDtoToJson(LoginModelDto data) => json.encode(data.toJson());

class LoginModelDto {
    final String? status;
    final String? statusCode;
    final List<dynamic>? result;

    LoginModelDto({
        this.status,
        this.statusCode,
        this.result,
    });

    LoginModelDto copyWith({
        String? status,
        String? statusCode,
        List<dynamic>? result,
    }) => 
        LoginModelDto(
            status: status ?? this.status,
            statusCode: statusCode ?? this.statusCode,
            result: result ?? this.result,
        );

    factory LoginModelDto.fromJson(Map<String, dynamic> json) => LoginModelDto(
        status: json["status"],
        statusCode: json["statusCode"],
        result: json["result"] == null ? [] : List<dynamic>.from(json["result"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x)),
    };
}
