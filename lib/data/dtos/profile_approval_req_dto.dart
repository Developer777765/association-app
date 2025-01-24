// To parse this JSON data, do
//
//     final approveProfile = approveProfileFromJson(jsonString);

import 'dart:convert';

ApproveProfile approveProfileFromJson(String str) => ApproveProfile.fromJson(json.decode(str));

String approveProfileToJson(ApproveProfile data) => json.encode(data.toJson());

class ApproveProfile {
    final int? id;

    ApproveProfile({
        this.id,
    });

    factory ApproveProfile.fromJson(Map<String, dynamic> json) => ApproveProfile(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
