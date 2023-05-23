// To parse this JSON data, do
//
//     final getSubcompanyModel = getSubcompanyModelFromJson(jsonString);

import 'dart:convert';

SubcompanyModel getSubcompanyModelFromJson(String str) => SubcompanyModel.fromJson(json.decode(str));

String getSubcompanyModelToJson(SubcompanyModel data) => json.encode(data.toJson());



class SubcompanyModel {
    SubcompanyModel({
        this.subcompanyId,
        this.companyId,
        this.code1,
        this.code2,
        this.code3,
        this.name,
        this.roadType,
        this.address1,
        this.address2,
        this.cityId,
        this.bankId,
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
        this.selectBank,
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

    int? subcompanyId;
    int? companyId;
    String? code1;
    String? code2;
    String? code3;
    String? name;
    String? roadType;
    String? address1;
    String? address2;
    int? cityId;
    int? bankId;
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
    bool? selectBank;
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

    factory SubcompanyModel.fromJson(Map<String, dynamic> json) => SubcompanyModel(
        subcompanyId: json["subcompanyID"],
        companyId: json["companyID"],
        code1: json["code1"],
        code2: json["code2"],
        code3: json["code3"],
        name: json["name"],
        roadType: json["roadType"],
        address1: json["address1"],
        address2: json["address2"],
        cityId: json["cityID"],
        bankId: json["bankID"] == null ? null : json["bankID"],
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
        selectBank: json["selectBank"],
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
        "subcompanyID": subcompanyId,
        "companyID": companyId,
        "code1": code1,
        "code2": code2,
        "code3": code3,
        "name": name,
        "roadType": roadType,
        "address1": address1,
        "address2": address2,
        "cityID": cityId,
        "bankID": bankId == null ? null : bankId,
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
        "selectBank": selectBank,
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
    factory Filter.fromJson(Map<String, dynamic> json) => Filter();
}
