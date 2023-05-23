// To parse this JSON data, do
//
//     final transactionHistoryModel = transactionHistoryModelFromJson(jsonString);

import 'dart:convert';

TransactionHistoryModel transactionHistoryModelFromJson(String str) => TransactionHistoryModel.fromJson(json.decode(str));

String transactionHistoryModelToJson(TransactionHistoryModel data) => json.encode(data.toJson());

class TransactionHistoryModel {
    TransactionHistoryModel({
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
    dynamic country;
    dynamic currency;
    dynamic issueRate;
    dynamic issueRate1;
    dynamic issueRate2;
    dynamic paymentRate;
    String? phoneNo;
    dynamic emailAddress;
    dynamic subject;
    dynamic message;
    dynamic policyDetail;
    dynamic tremsAndConditions;
    DateTime? publishingDate;
    dynamic items;
    List<Remittance>? remittances;
    DateTime? endDate;
    DateTime? startDate;
    bool? includeLastTran;
    dynamic lastRemitDate;
    dynamic lastRemitAmount;
    dynamic cancelReason;
    dynamic correctionReason;
    bool? kyc;
    dynamic fileName;
    String? remitterName;
    CountryIsoCode? countryIsoCode;
    String? remitterSurname;
    String? currencyIsoCode;
    String? siteRef;
    dynamic notifyTo;
    dynamic notificationMessage;
    dynamic notificationTitle;
    int? processId;
    String? remAddress;
    String? billingCity;
    String? remEmailAddress;
    String? remZipCode;
    String? remProvince;
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

    factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) => TransactionHistoryModel(
        itemId: json["itemID"],
        franchiseGroupId: json["franchiseGroupID"],
        sequenceId: json["sequenceID"],
        exchangeId: json["exchangeID"],
        country: json["country"],
        currency: json["currency"],
        issueRate: json["issueRate"],
        issueRate1: json["issueRate1"],
        issueRate2: json["issueRate2"],
        paymentRate: json["paymentRate"],
        phoneNo: json["phoneNo"],
        emailAddress: json["emailAddress"],
        subject: json["subject"],
        message: json["message"],
        policyDetail: json["policyDetail"],
        tremsAndConditions: json["tremsAndConditions"],
        publishingDate: DateTime.parse(json["publishingDate"]),
        items: json["items"],
        remittances: List<Remittance>.from(json["remittances"].map((x) => Remittance.fromJson(x))),
        endDate: DateTime.parse(json["endDate"]),
        startDate: DateTime.parse(json["startDate"]),
        includeLastTran: json["includeLastTran"],
        lastRemitDate: json["lastRemitDate"],
        lastRemitAmount: json["lastRemitAmount"],
        cancelReason: json["cancelReason"],
        correctionReason: json["correctionReason"],
        kyc: json["kyc"],
        fileName: json["fileName"],
        remitterName: json["remitterName"],
        countryIsoCode: countryIsoCodeValues.map[json["countryIsoCode"]],
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
        "country": country,
        "currency": currency,
        "issueRate": issueRate,
        "issueRate1": issueRate1,
        "issueRate2": issueRate2,
        "paymentRate": paymentRate,
        "phoneNo": phoneNo,
        "emailAddress": emailAddress,
        "subject": subject,
        "message": message,
        "policyDetail": policyDetail,
        "tremsAndConditions": tremsAndConditions,
        "publishingDate": publishingDate!.toIso8601String(),
        "items": items,
        "remittances": List<dynamic>.from(remittances!.map((x) => x.toJson())),
        "endDate": endDate!.toIso8601String(),
        "startDate": startDate!.toIso8601String(),
        "includeLastTran": includeLastTran,
        "lastRemitDate": lastRemitDate,
        "lastRemitAmount": lastRemitAmount,
        "cancelReason": cancelReason,
        "correctionReason": correctionReason,
        "kyc": kyc,
        "fileName": fileName,
        "remitterName": remitterName,
        "countryIsoCode": countryIsoCodeValues.reverse[countryIsoCode],
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

enum CountryIsoCode { IT }

final countryIsoCodeValues = EnumValues({
    "IT": CountryIsoCode.IT
});

class Filter {
    Filter();

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Remittance {
    Remittance({
        this.ttid,
        this.remittanceNoPrefix,
        this.adjustedDcAmount,
        this.beneAccNo,
        this.benePhone,
        this.beneAccTypeId,
        this.beneAmount,
        this.beneBankName,
        this.beneBankBranchId,
        this.beneBankId,
        this.beneBranchName,
        this.beneBrnAddress,
        this.beneCountryId,
        this.beneCurrencyId,
        this.beneDocId,
        this.beneDocNo,
        this.beneficiaryId,
        this.relationId,
        this.benePayeeModeId,
        this.subCompanyBranchId,
        this.companyId,
        this.subCompanyId,
        this.debitCardId,
        this.discountedComm,
        this.edRate,
        this.encashedPoint,
        this.encashedPointAmount,
        this.equiAmount,
        this.equiCommission,
        this.taxAmount,
        this.calcCommission,
        this.exchangeId,
        this.franchiseId,
        this.instrumentDetail,
        this.instrumentTypeId,
        this.maturityDate,
        this.issueDate,
        this.srcCurrencyIsoCode,
        this.ofrdCurrencyId,
        this.ofrdAmount,
        this.ofrdCommission,
        this.othrRcvdAmount,
        this.othrRcvdCommission,
        this.othrRcvdCurrencyId,
        this.pdRate,
        this.purposeDetail,
        this.purposeId,
        this.remarks,
        this.remitterDocId,
        this.remitterDocNo,
        this.remitterDocValidUpto,
        this.remitterId,
        this.incomeSourceId,
        this.remitterTypeId,
        this.respFranchiseId,
        this.beneficiarySurname,
        this.beneficiaryName,
        this.mcAddress,
        this.ipAddress,
        this.amlRemBhvClsId,
        this.amlRemBhvClsValue,
        this.amlOpVoteClsId,
        this.amlOpVoteClsValue,
        this.amlCoopClsId,
        this.amlCoopClsValue,
        this.amlOpTypeClsId,
        this.amlOpTypeClsValue,
        this.fldPsfx,
        this.cdType,
        this.cardType,
        this.cardCharge,
        this.cdNo,
        this.cdExp,
        this.cdSecCode,
        this.cachetoken,
        this.beneCurrencyCode,
        this.remittanceNo,
        this.modeDetail,
        this.issueTime,
        this.exportedDate,
        this.exportedTime,
        this.confirmedDate,
        this.confirmedTime,
        this.confirmedDocType,
        this.confirmedDocNo,
        this.cancelledAppliedDate,
        this.cancelledAuthorisedDate,
        this.cancelledRefundedDate,
        this.holdStatus,
        this.remPayRefNo,
        this.remPayReqRefNo,
        this.errorCode,
        this.lastStatus,
        this.cantRepay,
        this.stPayRefStatus,
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

    int? ttid;
    String? remittanceNoPrefix;
    dynamic adjustedDcAmount;
    String? beneAccNo;
    String? benePhone;
    dynamic beneAccTypeId;
    dynamic beneAmount;
    String? beneBankName;
    dynamic beneBankBranchId;
    dynamic beneBankId;
    String? beneBranchName;
    String? beneBrnAddress;
    int? beneCountryId;
    int? beneCurrencyId;
    dynamic beneDocId;
    String? beneDocNo;
    int? beneficiaryId;
    dynamic relationId;
    int? benePayeeModeId;
    int? subCompanyBranchId;
    int? companyId;
    int? subCompanyId;
    dynamic debitCardId;
    dynamic discountedComm;
    dynamic edRate;
    dynamic encashedPoint;
    dynamic encashedPointAmount;
    dynamic equiAmount;
    dynamic equiCommission;
    dynamic taxAmount;
    dynamic calcCommission;
    dynamic exchangeId;
    int? franchiseId;
    String? instrumentDetail;
    int? instrumentTypeId;
    DateTime? maturityDate;
    DateTime? issueDate;
    dynamic srcCurrencyIsoCode;
    int? ofrdCurrencyId;
    dynamic ofrdAmount;
    dynamic ofrdCommission;
    dynamic othrRcvdAmount;
    dynamic othrRcvdCommission;
    int? othrRcvdCurrencyId;
    dynamic pdRate;
    String? purposeDetail;
    int? purposeId;
    String? remarks;
    dynamic remitterDocId;
    String? remitterDocNo;
    DateTime? remitterDocValidUpto;
    int? remitterId;
    dynamic incomeSourceId;
    int? remitterTypeId;
    dynamic respFranchiseId;
    String? beneficiarySurname;
    String? beneficiaryName;
    String? mcAddress;
    String? ipAddress;
    dynamic amlRemBhvClsId;
    int? amlRemBhvClsValue;
    dynamic amlOpVoteClsId;
    int? amlOpVoteClsValue;
    dynamic amlCoopClsId;
    int? amlCoopClsValue;
    dynamic amlOpTypeClsId;
    int? amlOpTypeClsValue;
    dynamic fldPsfx;
    dynamic cdType;
    String? cardType;
    dynamic cardCharge;
    dynamic cdNo;
    dynamic cdExp;
    dynamic cdSecCode;
    dynamic cachetoken;
    dynamic beneCurrencyCode;
    String? remittanceNo;
    String? modeDetail;
    String? issueTime;
    dynamic exportedDate;
    String? exportedTime;
    dynamic confirmedDate;
    String? confirmedTime;
    String? confirmedDocType;
    String? confirmedDocNo;
    dynamic cancelledAppliedDate;
    dynamic cancelledAuthorisedDate;
    dynamic cancelledRefundedDate;
    int? holdStatus;
    String? remPayRefNo;
    String? remPayReqRefNo;
    int? errorCode;
    String? lastStatus;
    bool? cantRepay;
    dynamic stPayRefStatus;
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

    factory Remittance.fromJson(Map<String, dynamic> json) => Remittance(
        ttid: json["ttid"],
        remittanceNoPrefix: json["remittanceNoPrefix"],
        adjustedDcAmount: json["adjustedDCAmount"],
        beneAccNo: json["beneAccNo"],
        benePhone: json["benePhone"],
        beneAccTypeId: json["beneAccTypeID"],
        beneAmount: json["beneAmount"],
        beneBankName: json["beneBankName"],
        beneBankBranchId: json["beneBankBranchID"],
        beneBankId: json["beneBankID"],
        beneBranchName: json["beneBranchName"],
        beneBrnAddress: json["beneBrnAddress"],
        beneCountryId: json["beneCountryID"],
        beneCurrencyId: json["beneCurrencyID"],
        beneDocId: json["beneDocID"],
        beneDocNo: json["beneDocNo"],
        beneficiaryId: json["beneficiaryID"],
        relationId: json["relationID"],
        benePayeeModeId: json["benePayeeModeID"],
        subCompanyBranchId: json["subCompanyBranchID"],
        companyId: json["companyID"],
        subCompanyId: json["subCompanyID"],
        debitCardId: json["debitCardID"],
        discountedComm: json["discountedComm"],
        edRate: json["edRate"],
        encashedPoint: json["encashedPoint"],
        encashedPointAmount: json["encashedPointAmount"],
        equiAmount: json["equiAmount"],
        equiCommission: json["equiCommission"],
        taxAmount: json["taxAmount"],
        calcCommission: json["calcCommission"],
        exchangeId: json["exchangeID"],
        franchiseId: json["franchiseID"],
        instrumentDetail: json["instrumentDetail"],
        instrumentTypeId: json["instrumentTypeID"],
        maturityDate: json["maturityDate"] != null ? DateTime.parse(json["maturityDate"]) : null,
        issueDate: json["issueDate"] != null ? DateTime.parse(json["issueDate"]) : null,
        srcCurrencyIsoCode: json["srcCurrencyISOCode"],
        ofrdCurrencyId: json["ofrdCurrencyID"],
        ofrdAmount: json["ofrdAmount"],
        ofrdCommission: json["ofrdCommission"],
        othrRcvdAmount: json["othrRcvdAmount"],
        othrRcvdCommission: json["othrRcvdCommission"],
        othrRcvdCurrencyId: json["othrRcvdCurrencyID"],
        pdRate: json["pdRate"],
        purposeDetail: json["purposeDetail"],
        purposeId: json["purposeID"],
        remarks: json["remarks"],
        remitterDocId: json["remitterDocID"],
        remitterDocNo: json["remitterDocNo"],
        remitterDocValidUpto: json["remitterDocValidUpto"] != null ? DateTime.parse(json["remitterDocValidUpto"]) : null,
        remitterId: json["remitterID"],
        incomeSourceId: json["incomeSourceID"],
        remitterTypeId: json["remitterTypeID"],
        respFranchiseId: json["respFranchiseID"],
        beneficiarySurname: json["beneficiarySurname"],
        beneficiaryName: json["beneficiaryName"],
        mcAddress: json["mcAddress"],
        ipAddress: json["ipAddress"],
        amlRemBhvClsId: json["amlRemBhvClsID"],
        amlRemBhvClsValue: json["amlRemBhvClsValue"],
        amlOpVoteClsId: json["amlOpVoteClsID"],
        amlOpVoteClsValue: json["amlOpVoteClsValue"],
        amlCoopClsId: json["amlCoopClsID"],
        amlCoopClsValue: json["amlCoopClsValue"],
        amlOpTypeClsId: json["amlOpTypeClsID"],
        amlOpTypeClsValue: json["amlOpTypeClsValue"],
        fldPsfx: json["fldPsfx"],
        cdType: json["cdType"],
        cardType: json["cardType"],
        cardCharge: json["cardCharge"],
        cdNo: json["cdNo"],
        cdExp: json["cdExp"],
        cdSecCode: json["cdSecCode"],
        cachetoken: json["cachetoken"],
        beneCurrencyCode: json["beneCurrencyCode"],
        remittanceNo: json["remittanceNo"],
        modeDetail: json["modeDetail"],
        issueTime: json["issueTime"],
        exportedDate: json["exportedDate"],
        exportedTime: json["exportedTime"],
        confirmedDate: json["confirmedDate"],
        confirmedTime: json["confirmedTime"],
        confirmedDocType: json["confirmedDocType"],
        confirmedDocNo: json["confirmedDocNo"],
        cancelledAppliedDate: json["cancelledAppliedDate"],
        cancelledAuthorisedDate: json["cancelledAuthorisedDate"],
        cancelledRefundedDate: json["cancelledRefundedDate"],
        holdStatus: json["holdStatus"],
        remPayRefNo: json["remPayRefNo"],
        remPayReqRefNo: json["remPayReqRefNo"],
        errorCode: json["errorCode"],
        lastStatus: json["lastStatus"],
        cantRepay: json["cantRepay"],
        stPayRefStatus: json["stPayRefStatus"] != null ? json["stPayRefStatus"] : null,
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
        "ttid": ttid,
        "remittanceNoPrefix": countryIsoCodeValues.reverse[remittanceNoPrefix],
        "adjustedDCAmount": adjustedDcAmount,
        "beneAccNo": beneAccNo,
        "benePhone": benePhone,
        "beneAccTypeID": beneAccTypeId,
        "beneAmount": beneAmount,
        "beneBankName": beneBankName,
        "beneBankBranchID": beneBankBranchId,
        "beneBankID": beneBankId,
        "beneBranchName": beneBranchName,
        "beneBrnAddress": beneBrnAddress,
        "beneCountryID": beneCountryId,
        "beneCurrencyID": beneCurrencyId,
        "beneDocID": beneDocId,
        "beneDocNo": beneDocNo,
        "beneficiaryID": beneficiaryId,
        "relationID": relationId,
        "benePayeeModeID": benePayeeModeId,
        "subCompanyBranchID": subCompanyBranchId,
        "companyID": companyId,
        "subCompanyID": subCompanyId,
        "debitCardID": debitCardId,
        "discountedComm": discountedComm,
        "edRate": edRate,
        "encashedPoint": encashedPoint,
        "encashedPointAmount": encashedPointAmount,
        "equiAmount": equiAmount,
        "equiCommission": equiCommission,
        "taxAmount": taxAmount,
        "calcCommission": calcCommission,
        "exchangeID": exchangeId,
        "franchiseID": franchiseId,
        "instrumentDetail": instrumentDetail,
        "instrumentTypeID": instrumentTypeId,
        "maturityDate": maturityDate?.toIso8601String(),
        "issueDate": issueDate?.toIso8601String(),
        "srcCurrencyISOCode": srcCurrencyIsoCode,
        "ofrdCurrencyID": ofrdCurrencyId,
        "ofrdAmount": ofrdAmount,
        "ofrdCommission": ofrdCommission,
        "othrRcvdAmount": othrRcvdAmount,
        "othrRcvdCommission": othrRcvdCommission,
        "othrRcvdCurrencyID": othrRcvdCurrencyId,
        "pdRate": pdRate,
        "purposeDetail": purposeDetail,
        "purposeID": purposeId,
        "remarks": remarks,
        "remitterDocID": remitterDocId,
        "remitterDocNo": remitterDocNo,
        "remitterDocValidUpto": remitterDocValidUpto?.toIso8601String(),
        "remitterID": remitterId,
        "incomeSourceID": incomeSourceId,
        "remitterTypeID": remitterTypeId,
        "respFranchiseID": respFranchiseId,
        "beneficiarySurname": beneficiarySurname,
        "beneficiaryName": beneficiaryName,
        "mcAddress": mcAddress,
        "ipAddress": ipAddress,
        "amlRemBhvClsID": amlRemBhvClsId,
        "amlRemBhvClsValue": amlRemBhvClsValue,
        "amlOpVoteClsID": amlOpVoteClsId,
        "amlOpVoteClsValue": amlOpVoteClsValue,
        "amlCoopClsID": amlCoopClsId,
        "amlCoopClsValue": amlCoopClsValue,
        "amlOpTypeClsID": amlOpTypeClsId,
        "amlOpTypeClsValue": amlOpTypeClsValue,
        "fldPsfx": fldPsfx,
        "cdType": cdType,
        "cardType": cardType,
        "cardCharge": cardCharge,
        "cdNo": cdNo,
        "cdExp": cdExp,
        "cdSecCode": cdSecCode,
        "cachetoken": cachetoken,
        "beneCurrencyCode": beneCurrencyCode,
        "remittanceNo": remittanceNo,
        "modeDetail": modeDetailValues.reverse[modeDetail],
        "issueTime": issueTime,
        "exportedDate": exportedDate,
        "exportedTime": exportedTime,
        "confirmedDate": confirmedDate,
        "confirmedTime": confirmedTime,
        "confirmedDocType": confirmedDocType,
        "confirmedDocNo": confirmedDocNo,
        "cancelledAppliedDate": cancelledAppliedDate,
        "cancelledAuthorisedDate": cancelledAuthorisedDate,
        "cancelledRefundedDate": cancelledRefundedDate,
        "holdStatus": holdStatus,
        "remPayRefNo": remPayRefNo,
        "remPayReqRefNo": remPayReqRefNo,
        "errorCode": errorCode,
        "lastStatus": lastStatus,
        "cantRepay": cantRepay,
        "stPayRefStatus": stPayRefStatus,
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



enum BeneficiaryName { S }
enum LastStatus { ISSUED }



enum ModeDetail { MOBILE_WALLET }

final modeDetailValues = EnumValues({
    "MOBILE WALLET": ModeDetail.MOBILE_WALLET
});

class EnumValues<T> {
    Map<String, T> map = {};
    Map<T, String> reverseMap = {};

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap.isEmpty) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
