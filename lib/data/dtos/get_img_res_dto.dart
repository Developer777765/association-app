// To parse this JSON data, do
//
//     final getImgResDto = getImgResDtoFromJson(jsonString);

import 'dart:convert';

GetImgResDto getImgResDtoFromJson(String str) => GetImgResDto.fromJson(json.decode(str));

String getImgResDtoToJson(GetImgResDto data) => json.encode(data.toJson());

class GetImgResDto {
    final String status;
    final String statusCode;
    final Result result;

    GetImgResDto({
        required this.status,
        required this.statusCode,
        required this.result,
    });

    factory GetImgResDto.fromJson(Map<String, dynamic> json) => GetImgResDto(
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
    final String docUniqueId;
    final String docUrl;
    final int docid;
    final int key;

    Result({
        required this.docUniqueId,
        required this.docUrl,
        required this.docid,
        required this.key,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        docUniqueId: json["docUniqueId"],
        docUrl: json["doc_URL"],
        docid: json["docid"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "docUniqueId": docUniqueId,
        "doc_URL": docUrl,
        "docid": docid,
        "key": key,
    };
}