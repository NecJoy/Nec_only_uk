// To parse this JSON data, do
//
//     final remitterDocumentTypesModel = remitterDocumentTypesModelFromJson(jsonString);

import 'dart:convert';

RemitterDocumentTypesModel remitterDocumentTypesModelFromJson(String str) => RemitterDocumentTypesModel.fromJson(json.decode(str));

String remitterDocumentTypesModelToJson(RemitterDocumentTypesModel data) => json.encode(data.toJson());

class RemitterDocumentTypesModel {
    RemitterDocumentTypesModel({
        this.documentId,
        this.code4,
        this.documentUsedOn,
        this.remitterTypeId,
        this.exchangeId,
        this.validity,
        this.isEuMember,
        this.donotCheckDocValidity,
        this.willGenIssuingAuthority,
        this.prefix,
        this.mappingField,
        this.postfix,
        this.documentFormat,
        this.allowReverseOrder,
        this.isExactFormatLength,
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

    int? documentId;
    String? code4;
    int? documentUsedOn;
    int? remitterTypeId;
    int? exchangeId;
    int? validity;
    bool? isEuMember;
    bool? donotCheckDocValidity;
    bool? willGenIssuingAuthority;
    String? prefix;
    int? mappingField;
    String? postfix;
    String? documentFormat;
    bool? allowReverseOrder;
    bool? isExactFormatLength;
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

    factory RemitterDocumentTypesModel.fromJson(Map<String, dynamic> json) => RemitterDocumentTypesModel(
        documentId: json["documentID"],
        code4: json["code4"],
        documentUsedOn: json["documentUsedOn"],
        remitterTypeId: json["remitterTypeID"],
        exchangeId: json["exchangeID"],
        validity: json["validity"],
        isEuMember: json["isEUMember"],
        donotCheckDocValidity: json["donotCheckDocValidity"],
        willGenIssuingAuthority: json["willGenIssuingAuthority"],
        prefix: json["prefix"],
        mappingField: json["mappingField"],
        postfix: json["postfix"],
        documentFormat: json["documentFormat"],
        allowReverseOrder: json["allowReverseOrder"],
        isExactFormatLength: json["isExactFormatLength"],
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
        "documentID": documentId,
        "code4": code4,
        "documentUsedOn": documentUsedOn,
        "remitterTypeID": remitterTypeId,
        "exchangeID": exchangeId,
        "validity": validity,
        "isEUMember": isEuMember,
        "donotCheckDocValidity": donotCheckDocValidity,
        "willGenIssuingAuthority": willGenIssuingAuthority,
        "prefix": prefix,
        "mappingField": mappingField,
        "postfix": postfix,
        "documentFormat": documentFormat,
        "allowReverseOrder": allowReverseOrder,
        "isExactFormatLength": isExactFormatLength,
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
