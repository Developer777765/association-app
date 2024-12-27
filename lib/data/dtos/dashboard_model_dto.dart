
import 'dart:convert';

DashboardModelDto dashboardModelDtoFromJson(String str) => DashboardModelDto.fromJson(json.decode(str));

String dashboardModelDtoToJson(DashboardModelDto data) => json.encode(data.toJson());

class DashboardModelDto {
    final String? status;
    final String? statusCode;
    final List<DashboardResult>? result;

    DashboardModelDto({
        this.status,
        this.statusCode,
        this.result,
    });

    DashboardModelDto copyWith({
        String? status,
        String? statusCode,
        List<DashboardResult>? result,
    }) => 
        DashboardModelDto(
            status: status ?? this.status,
            statusCode: statusCode ?? this.statusCode,
            result: result ?? this.result,
        );

    factory DashboardModelDto.fromJson(Map<String, dynamic> json) => DashboardModelDto(
        status: json["status"],
        statusCode: json["statusCode"],
        result: json["result"] == null ? [] : List<DashboardResult>.from(json["result"]!.map((x) => DashboardResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class DashboardResult {
    final int? id;
    final String? dbmasterName;
    final dynamic image;
    final bool? isActive;
    final dynamic createdBy;
    final String? createdDate;
    final dynamic modifiedBy;
    final dynamic modifiedDate;
    final String? companyId;

    DashboardResult({
        this.id,
        this.dbmasterName,
        this.image,
        this.isActive,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.companyId,
    });

    DashboardResult copyWith({
        int? id,
        String? dbmasterName,
        dynamic image,
        bool? isActive,
        dynamic createdBy,
        String? createdDate,
        dynamic modifiedBy,
        dynamic modifiedDate,
        String? companyId,
    }) => 
        DashboardResult(
            id: id ?? this.id,
            dbmasterName: dbmasterName ?? this.dbmasterName,
            image: image ?? this.image,
            isActive: isActive ?? this.isActive,
            createdBy: createdBy ?? this.createdBy,
            createdDate: createdDate ?? this.createdDate,
            modifiedBy: modifiedBy ?? this.modifiedBy,
            modifiedDate: modifiedDate ?? this.modifiedDate,
            companyId: companyId ?? this.companyId,
        );

    factory DashboardResult.fromJson(Map<String, dynamic> json) => DashboardResult(
        id: json["id"],
        dbmasterName: json["dbmasterName"],
        image: json["image"],
        isActive: json["isActive"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"],
        modifiedBy: json["modifiedBy"],
        modifiedDate: json["modifiedDate"],
        companyId: json["companyId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dbmasterName": dbmasterName,
        "image": image,
        "isActive": isActive,
        "createdBy": createdBy,
        "createdDate": createdDate,
        "modifiedBy": modifiedBy,
        "modifiedDate": modifiedDate,
        "companyId": companyId,
    };
}
