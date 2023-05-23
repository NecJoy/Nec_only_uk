// To parse this JSON data, do
//
//     final getSubcompaniesBranches = getSubcompaniesBranchesFromJson(jsonString);

import 'dart:convert';

GetSubcompanyBranchModel getSubcompaniesBranchesFromJson(String str) => GetSubcompanyBranchModel.fromJson(json.decode(str));

String getSubcompaniesBranchesToJson(GetSubcompanyBranchModel data) => json.encode(data.toJson());



class GetSubcompanyBranchModel {
    GetSubcompanyBranchModel({
        this.branchId,
        this.code1,
        this.code2,
        this.code3,
        this.name,
        this.roadType,
        this.address1,
        this.address2,
        this.cityId,
        this.cityCode,
        this.cityName,
        this.stateCode,
        this.stateName,
        this.zipCode,
        this.cabCode,
        this.countryId,
        this.countryName,
        this.addressLine,
        this.fullAddress,
        this.sessionId,
        this.returnStatus,
        this.returnMessage,
        this.validationErrors,
        this.totalPages,
        this.totalRows,
        this.pageSize,
        this.page,
        this.isAuthenicated,
        this.sortExpression,
        this.sortDirection,
        this.currentPageNumber,
        this.filter,
        this.sessionExpired,
    });

    int? branchId;
    String? code1;
    String? code2;
    String? code3;
    String? name;
    String? roadType;
    String? address1;
    String? address2;
    int? cityId;
    String? cityCode;
    String? cityName;
    String? stateCode;
    String? stateName;
    String? zipCode;
    String? cabCode;
    int? countryId;
    String? countryName;
    String? addressLine;
    String? fullAddress;
    dynamic sessionId;
    bool? returnStatus;
    List<dynamic>? returnMessage;
    Filter? validationErrors;
    int? totalPages;
    int? totalRows;
    int? pageSize;
    int? page;
    bool? isAuthenicated;
    String? sortExpression;
    String? sortDirection;
    int? currentPageNumber;
    Filter? filter;
    bool? sessionExpired;

    factory GetSubcompanyBranchModel.fromJson(Map<String, dynamic> json) => GetSubcompanyBranchModel(
        branchId: json["branchID"],
        code1: json["code1"],
        code2: json["code2"],
        code3: json["code3"],
        name: json["name"],
        roadType: json["roadType"],
        address1: json["address1"],
        address2: json["address2"],
        cityId: json["cityID"],
        cityCode: json["cityCode"],
        cityName: json["cityName"],
        stateCode: json["stateCode"],
        stateName: json["stateName"],
        zipCode: json["zipCode"],
        cabCode: json["cabCode"],
        countryId: json["countryID"],
        countryName: json["countryName"],
        addressLine: json["addressLine"],
        fullAddress: json["fullAddress"],
        sessionId: json["sessionId"],
        returnStatus: json["returnStatus"],
        returnMessage: List<dynamic>.from(json["returnMessage"].map((x) => x)),
        validationErrors: Filter.fromJson(json["validationErrors"]),
        totalPages: json["totalPages"],
        totalRows: json["totalRows"],
        pageSize: json["pageSize"],
        page: json["page"],
        isAuthenicated: json["isAuthenicated"],
        sortExpression: json["sortExpression"],
        sortDirection: json["sortDirection"],
        currentPageNumber: json["currentPageNumber"],
        filter: Filter.fromJson(json["filter"]),
        sessionExpired: json["sessionExpired"],
    );

    Map<String, dynamic> toJson() => {
        "branchID": branchId,
        "code1": code1,
        "code2": code2,
        "code3": code3,
        "name": name,
        "roadType": roadType,
        "address1": address1,
        "address2": address2,
        "cityID": cityId,
        "cityCode": cityCode,
        "cityName": cityName,
        "stateCode": stateCode,
        "stateName": stateName,
        "zipCode": zipCode,
        "cabCode": cabCode,
        "countryID": countryId,
        "countryName": countryName,
        "addressLine": addressLine,
        "fullAddress": fullAddress,
        "sessionId": sessionId,
        "returnStatus": returnStatus,
        "returnMessage": List<dynamic>.from(returnMessage!.map((x) => x)),
        "validationErrors": validationErrors,
        "totalPages": totalPages,
        "totalRows": totalRows,
        "pageSize": pageSize,
        "page": page,
        "isAuthenicated": isAuthenicated,
        "sortExpression": sortExpression,
        "sortDirection": sortDirection,
        "currentPageNumber": currentPageNumber,
        "filter": filter,
        "sessionExpired": sessionExpired,
    };
}


class Filter {
    Filter();

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    );

    Map<String, dynamic> toJson() => {
    };
}
