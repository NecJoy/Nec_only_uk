// To parse this JSON data, do
//
//     final trackTransaction = trackTransactionFromJson(jsonString);

import 'dart:convert';

TrackTransactionModel trackTransactionFromJson(String str) => TrackTransactionModel.fromJson(json.decode(str));

String trackTransactionToJson(TrackTransactionModel data) => json.encode(data.toJson());

class TrackTransactionModel {
    TrackTransactionModel({
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

    dynamic ttid;
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
    dynamic beneCountryId;
    dynamic beneCurrencyId;
    dynamic beneDocId;
    String? beneDocNo;
    dynamic beneficiaryId;
    dynamic relationId;
    dynamic benePayeeModeId;
    dynamic subCompanyBranchId;
    dynamic companyId;
    dynamic subCompanyId;
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
    dynamic franchiseId;
    String? instrumentDetail;
    dynamic instrumentTypeId;
    DateTime? maturityDate;
    DateTime? issueDate;
    String? srcCurrencyIsoCode;
    dynamic ofrdCurrencyId;
    dynamic ofrdAmount;
    dynamic ofrdCommission;
    dynamic othrRcvdAmount;
    dynamic othrRcvdCommission;
    dynamic othrRcvdCurrencyId;
    dynamic pdRate;
    String? purposeDetail;
    dynamic purposeId;
    String? remarks;
    dynamic remitterDocId;
    String? remitterDocNo;
    DateTime? remitterDocValidUpto;
    dynamic remitterId;
    dynamic incomeSourceId;
    dynamic remitterTypeId;
    dynamic respFranchiseId;
    String? beneficiarySurname;
    String? beneficiaryName;
    String? mcAddress;
    String? ipAddress;
    dynamic amlRemBhvClsId;
    dynamic amlRemBhvClsValue;
    dynamic amlOpVoteClsId;
    dynamic amlOpVoteClsValue;
    dynamic amlCoopClsId;
    dynamic amlCoopClsValue;
    dynamic amlOpTypeClsId;
    dynamic amlOpTypeClsValue;
    dynamic fldPsfx;
    dynamic cdType;
    String? cardType;
    dynamic cardCharge;
    dynamic cdNo;
    dynamic cdExp;
    dynamic cdSecCode;
    dynamic cachetoken;
    String? beneCurrencyCode;
    String? remittanceNo;
    String? modeDetail;
    String? issueTime;
    dynamic exportedDate;
    dynamic exportedTime;
    dynamic confirmedDate;
    dynamic confirmedTime;
    dynamic confirmedDocType;
    dynamic confirmedDocNo;
    dynamic cancelledAppliedDate;
    dynamic cancelledAuthorisedDate;
    dynamic cancelledRefundedDate;
    dynamic holdStatus;
    String? remPayRefNo;
    String? remPayReqRefNo;
    dynamic errorCode;
    String? lastStatus;
    bool? cantRepay;
    dynamic stPayRefStatus;
    dynamic sessionId;
    bool? returnStatus;
    List<dynamic>? returnMessage;
    Filter? validationErrors;
    dynamic totalPages;
    dynamic totalRows;
    dynamic pageSize;
    dynamic page;
    bool? isAuthenicated;
    String? sortExpression;
    String? sortDirection;
    dynamic currentPageNumber;
    Filter? filter;
    bool? sessionExpired;

    factory TrackTransactionModel.fromJson(Map<String, dynamic> json) => TrackTransactionModel(
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
        maturityDate: DateTime.parse(json["maturityDate"]),
        issueDate: DateTime.parse(json["issueDate"]),
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
        remitterDocValidUpto: DateTime.parse(json["remitterDocValidUpto"]),
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
        stPayRefStatus: json["stPayRefStatus"],
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
        "remittanceNoPrefix": remittanceNoPrefix,
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
        "modeDetail": modeDetail,
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
