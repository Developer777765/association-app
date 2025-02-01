// To parse this JSON data, do
//
//     final getImgReqDto = getImgReqDtoFromJson(jsonString);

import 'dart:convert';

GetImgReqDto getImgReqDtoFromJson(String str) =>
    GetImgReqDto.fromJson(json.decode(str));

String getImgReqDtoToJson(GetImgReqDto data) => json.encode(data.toJson());

class GetImgReqDto {
  final String uniqueId;
  final int companyId;
  final String category;
  final int keyId;

  GetImgReqDto({
    required this.uniqueId,
    required this.companyId,
    required this.category,
    required this.keyId,
  });

  factory GetImgReqDto.fromJson(Map<String, dynamic> json) => GetImgReqDto(
        uniqueId: json["uniqueId"],
        companyId: json["companyID"],
        category: json["category"],
        keyId: json["keyID"],
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "companyID": companyId,
        "category": category,
        "keyID": keyId,
      };
}
