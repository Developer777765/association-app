// To parse this JSON data, do
//
//     final postalCodeRequest = postalCodeRequestFromJson(jsonString);

import 'dart:convert';

PostalCodeRequest postalCodeRequestFromJson(String str) => PostalCodeRequest.fromJson(json.decode(str));

String postalCodeRequestToJson(PostalCodeRequest data) => json.encode(data.toJson());

class PostalCodeRequest {
    final int? postalCode;

    PostalCodeRequest({
        this.postalCode,
    });

    factory PostalCodeRequest.fromJson(Map<String, dynamic> json) => PostalCodeRequest(
        postalCode: json["postalCode"],
    );

    Map<String, dynamic> toJson() => {
        "postalCode": postalCode,
    };
}
