// To parse this JSON data, do
//
//     final checkNumberUniquenessReq = checkNumberUniquenessReqFromJson(jsonString);

import 'dart:convert';

CheckNumberUniquenessReq checkNumberUniquenessReqFromJson(String str) =>
    CheckNumberUniquenessReq.fromJson(json.decode(str));

String checkNumberUniquenessReqToJson(CheckNumberUniquenessReq data) =>
    json.encode(data.toJson());

class CheckNumberUniquenessReq {
  final String? mobileNumber;
  final int? uniqueId;
  CheckNumberUniquenessReq({
    this.uniqueId,
    this.mobileNumber,
  });

  factory CheckNumberUniquenessReq.fromJson(Map<String, dynamic> json) =>
      CheckNumberUniquenessReq(
        uniqueId: json["uniqueId"],
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "mobileNumber": mobileNumber,
      };
}
