// To parse this JSON data, do
//
//     final postalCodeResponse = postalCodeResponseFromJson(jsonString);

import 'dart:convert';

List<PostalCodeResponse> postalCodeResponseFromJson(String str) => List<PostalCodeResponse>.from(json.decode(str).map((x) => PostalCodeResponse.fromJson(x)));

String postalCodeResponseToJson(List<PostalCodeResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostalCodeResponse {
    final String? message;
    final String? status;
    final List<PostOffice>? postOffice;

    PostalCodeResponse({
        this.message,
        this.status,
        this.postOffice,
    });

    factory PostalCodeResponse.fromJson(Map<String, dynamic> json) => PostalCodeResponse(
        message: json["Message"],
        status: json["Status"],
        postOffice: json["PostOffice"] == null ? [] : List<PostOffice>.from(json["PostOffice"]!.map((x) => PostOffice.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Message": message,
        "Status": status,
        "PostOffice": postOffice == null ? [] : List<dynamic>.from(postOffice!.map((x) => x.toJson())),
    };
}

class PostOffice {
    final String? name;
    final dynamic description;
    final String? branchType;
    final String? deliveryStatus;
    final String? circle;
    final String? district;
    final String? division;
    final String? region;
    final String? block;
    final String? state;
    final String? country;
    final String? pincode;

    PostOffice({
        this.name,
        this.description,
        this.branchType,
        this.deliveryStatus,
        this.circle,
        this.district,
        this.division,
        this.region,
        this.block,
        this.state,
        this.country,
        this.pincode,
    });

    factory PostOffice.fromJson(Map<String, dynamic> json) => PostOffice(
        name: json["Name"],
        description: json["Description"],
        branchType: json["BranchType"],
        deliveryStatus: json["DeliveryStatus"],
        circle: json["Circle"],
        district: json["District"],
        division: json["Division"],
        region: json["Region"],
        block: json["Block"],
        state: json["State"],
        country: json["Country"],
        pincode: json["Pincode"],
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "Description": description,
        "BranchType": branchType,
        "DeliveryStatus": deliveryStatus,
        "Circle": circle,
        "District": district,
        "Division": division,
        "Region": region,
        "Block": block,
        "State": state,
        "Country": country,
        "Pincode": pincode,
    };
}
