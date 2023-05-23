// To parse this JSON data, do
//
//     final displayRateModel = displayRateModelFromJson(jsonString);

import 'dart:convert';

DisplayRateModel displayRateModelFromJson(String str) => DisplayRateModel.fromJson(json.decode(str));

String displayRateModelToJson(DisplayRateModel data) => json.encode(data.toJson());

class DisplayRateModel {
    DisplayRateModel({
        this.itemId,
        this.franchiseGroupId,
        this.sequenceId,
        this.exchangeId,
        this.country,
        this.currency,
        this.issueRate,
        this.issueRate1,
        this.issueRate2,
        this.paymentRate,
        this.phoneNo,
        this.emailAddress,
        this.subject,
        this.message,
        this.policyDetail,
        this.tremsAndConditions,
        this.publishingDate,
        this.items,
        this.remittances,
        this.endDate,
        this.startDate,
        this.includeLastTran,
        this.lastRemitDate,
        this.lastRemitAmount,
        this.cancelReason,
        this.correctionReason,
        this.kyc,
        this.fileName,
        this.remitterName,
        this.countryIsoCode,
        this.remitterSurname,
        this.currencyIsoCode,
        this.siteRef,
        this.notifyTo,
        this.notificationMessage,
        this.notificationTitle,
        this.processId,
        this.remAddress,
        this.billingCity,
        this.remEmailAddress,
        this.remZipCode,
        this.remProvince,
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

    int? itemId;
    int? franchiseGroupId;
    int? sequenceId;
    int? exchangeId;
    String? country;
    dynamic currency;
    String? issueRate;
    String? issueRate1;
    String? issueRate2;
    String? paymentRate;
    dynamic phoneNo;
    dynamic emailAddress;
    dynamic subject;
    dynamic message;
    dynamic policyDetail;
    dynamic tremsAndConditions;
    DateTime? publishingDate;
    List<DisplayRateModel>? items;
    dynamic remittances;
    DateTime? endDate;
    DateTime? startDate;
    bool? includeLastTran;
    String? lastRemitDate;
    String? lastRemitAmount;
    dynamic cancelReason;
    dynamic correctionReason;
    bool? kyc;
    dynamic fileName;
    dynamic remitterName;
    dynamic countryIsoCode;
    dynamic remitterSurname;
    dynamic currencyIsoCode;
    dynamic siteRef;
    dynamic notifyTo;
    dynamic notificationMessage;
    dynamic notificationTitle;
    int? processId;
    dynamic remAddress;
    dynamic billingCity;
    dynamic remEmailAddress;
    dynamic remZipCode;
    dynamic remProvince;
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

    factory DisplayRateModel.fromJson(Map<String, dynamic> json) => DisplayRateModel(
        itemId: json["itemID"],
        franchiseGroupId: json["franchiseGroupID"],
        sequenceId: json["sequenceID"],
        exchangeId: json["exchangeID"],
        country: json["country"] == null ? null : json["country"],
        currency: json["currency"] == null ? null : json["currency"],
        issueRate: json["issueRate"] == null ? null : json["issueRate"],
        issueRate1: json["issueRate1"] == null ? null : json["issueRate1"],
        issueRate2: json["issueRate2"] == null ? null : json["issueRate2"],
        paymentRate: json["paymentRate"] == null ? null : json["paymentRate"],
        phoneNo: json["phoneNo"],
        emailAddress: json["emailAddress"],
        subject: json["subject"],
        message: json["message"],
        policyDetail: json["policyDetail"],
        tremsAndConditions: json["tremsAndConditions"],
        publishingDate: DateTime.parse(json["publishingDate"]),
        items: json["items"] == null ? null : List<DisplayRateModel>.from(json["items"].map((x) => DisplayRateModel.fromJson(x))),
        remittances: json["remittances"],
        endDate: DateTime.parse(json["endDate"]),
        startDate: DateTime.parse(json["startDate"]),
        includeLastTran: json["includeLastTran"],
        lastRemitDate: json["lastRemitDate"] == null ? null : json["lastRemitDate"],
        lastRemitAmount: json["lastRemitAmount"] == null ? null : json["lastRemitAmount"],
        cancelReason: json["cancelReason"],
        correctionReason: json["correctionReason"],
        kyc: json["kyc"],
        fileName: json["fileName"],
        remitterName: json["remitterName"],
        countryIsoCode: json["countryIsoCode"],
        remitterSurname: json["remitterSurname"],
        currencyIsoCode: json["currencyIsoCode"],
        siteRef: json["siteRef"],
        notifyTo: json["notifyTo"],
        notificationMessage: json["notificationMessage"],
        notificationTitle: json["notificationTitle"],
        processId: json["processId"],
        remAddress: json["remAddress"],
        billingCity: json["billingCity"],
        remEmailAddress: json["remEmailAddress"],
        remZipCode: json["remZipCode"],
        remProvince: json["remProvince"],
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
        "itemID": itemId,
        "franchiseGroupID": franchiseGroupId,
        "sequenceID": sequenceId,
        "exchangeID": exchangeId,
        "country": country == null ? null : country,
        "currency": currency == null ? null : currency,
        "issueRate": issueRate == null ? null : issueRate,
        "issueRate1": issueRate1 == null ? null : issueRate1,
        "issueRate2": issueRate2 == null ? null : issueRate2,
        "paymentRate": paymentRate == null ? null : paymentRate,
        "phoneNo": phoneNo,
        "emailAddress": emailAddress,
        "subject": subject,
        "message": message,
        "policyDetail": policyDetail,
        "tremsAndConditions": tremsAndConditions,
        "publishingDate": publishingDate?.toIso8601String(),
        "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
        "remittances": remittances,
        "endDate": endDate?.toIso8601String(),
        "startDate": startDate?.toIso8601String(),
        "includeLastTran": includeLastTran,
        "lastRemitDate": lastRemitDate == null ? null : lastRemitDate,
        "lastRemitAmount": lastRemitAmount == null ? null : lastRemitAmount,
        "cancelReason": cancelReason,
        "correctionReason": correctionReason,
        "kyc": kyc,
        "fileName": fileName,
        "remitterName": remitterName,
        "countryIsoCode": countryIsoCode,
        "remitterSurname": remitterSurname,
        "currencyIsoCode": currencyIsoCode,
        "siteRef": siteRef,
        "notifyTo": notifyTo,
        "notificationMessage": notificationMessage,
        "notificationTitle": notificationTitle,
        "processId": processId,
        "remAddress": remAddress,
        "billingCity": billingCity,
        "remEmailAddress": remEmailAddress,
        "remZipCode": remZipCode,
        "remProvince": remProvince,
        "sessionId": sessionId,
        "returnStatus": returnStatus,
        "returnMessage": List<dynamic>.from(returnMessage!.map((x) => x)),
        "validationErrors": validationErrors!.toJson(),
        "totalPages": totalPages,
        "totalRows": totalRows,
        "pageSize": pageSize,
        "page": page,
        "isAuthenicated": isAuthenicated,
        "sortExpression": sortExpression,
        "sortDirection": sortDirection,
        "currentPageNumber": currentPageNumber,
        "filter": filter!.toJson(),
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

class EnumValues<T> {
  late Map<String, T> map;
   late  Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == false) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
