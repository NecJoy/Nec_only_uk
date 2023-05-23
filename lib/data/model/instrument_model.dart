// To parse this JSON data, do
//
//     final instrumentModel = instrumentModelFromJson(jsonString);

import 'dart:convert';

InstrumentModel instrumentModelFromJson(String str) => InstrumentModel.fromJson(json.decode(str));

String instrumentModelToJson(InstrumentModel data) => json.encode(data.toJson());

class InstrumentModel {
    InstrumentModel({
        this.instrumentTypeId,
        this.code4,
        this.exchangeId,
        this.remitterTypeId,
        this.isCash,
        this.minimumAmout,
        this.group1LimitDays,
        this.group1LimitAmount,
        this.group2LimitDays,
        this.group2LimitAmount,
        this.group3LimitDays,
        this.group3LimitAmount,
        this.group4LimitDays,
        this.group4LimitAmount,
        this.status,
        this.code1,
        this.code2,
        this.code3,
        this.name,
        this.sequenceId,
        this.nameCode,
        this.codeName,
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

    int? instrumentTypeId;
    String? code4;
    int? exchangeId;
    int? remitterTypeId;
    bool? isCash;
    double? minimumAmout;
    int? group1LimitDays;
    double? group1LimitAmount;
    int? group2LimitDays;
    double? group2LimitAmount;
    int? group3LimitDays;
    double? group3LimitAmount;
    int? group4LimitDays;
    double? group4LimitAmount;
    int? status;
    String? code1;
    String? code2;
    String? code3;
    String? name;
    int? sequenceId;
    String? nameCode;
    String? codeName;
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

    factory InstrumentModel.fromJson(Map<String, dynamic> json) => InstrumentModel(
        instrumentTypeId: json["instrumentTypeID"],
        code4: json["code4"],
        exchangeId: json["exchangeID"],
        remitterTypeId: json["remitterTypeID"],
        isCash: json["isCash"],
        minimumAmout: json["minimumAmout"],
        group1LimitDays: json["group1LimitDays"],
        group1LimitAmount: json["group1LimitAmount"],
        group2LimitDays: json["group2LimitDays"],
        group2LimitAmount: json["group2LimitAmount"],
        group3LimitDays: json["group3LimitDays"],
        group3LimitAmount: json["group3LimitAmount"],
        group4LimitDays: json["group4LimitDays"],
        group4LimitAmount: json["group4LimitAmount"],
        status: json["status"],
        code1: json["code1"],
        code2: json["code2"],
        code3: json["code3"],
        name: json["name"],
        sequenceId: json["sequenceID"],
        nameCode: json["nameCode"],
        codeName: json["codeName"],
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
        "instrumentTypeID": instrumentTypeId,
        "code4": code4,
        "exchangeID": exchangeId,
        "remitterTypeID": remitterTypeId,
        "isCash": isCash,
        "minimumAmout": minimumAmout,
        "group1LimitDays": group1LimitDays,
        "group1LimitAmount": group1LimitAmount,
        "group2LimitDays": group2LimitDays,
        "group2LimitAmount": group2LimitAmount,
        "group3LimitDays": group3LimitDays,
        "group3LimitAmount": group3LimitAmount,
        "group4LimitDays": group4LimitDays,
        "group4LimitAmount": group4LimitAmount,
        "status": status,
        "code1": code1,
        "code2": code2,
        "code3": code3,
        "name": name,
        "sequenceID": sequenceId,
        "nameCode": nameCode,
        "codeName": codeName,
        "sessionId": sessionId,
        "returnStatus": returnStatus,
        "returnMessage": List<dynamic>.from(returnMessage!.map((x) => x)),
        "validationErrors": validationErrors?.toJson(),
        "totalPages": totalPages,
        "totalRows": totalRows,
        "pageSize": pageSize,
        "page": page,
        "isAuthenicated": isAuthenicated,
        "sortExpression": sortExpression,
        "sortDirection": sortDirection,
        "currentPageNumber": currentPageNumber,
        "filter": filter?.toJson(),
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
