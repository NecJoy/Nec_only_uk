// To parse this JSON data, do
//
//     final getRemitterModel = getRemitterModelFromJson(jsonString?);

import 'dart:convert';

GetRemitterModel getRemitterModelFromJson(String? str) => GetRemitterModel.fromJson(json.decode(str!));

String? getRemitterModelToJson(GetRemitterModel data) => json.encode(data.toJson());

class GetRemitterModel {
    GetRemitterModel({
        this.remitterId,
        this.code,
        this.serialNo,
        this.name,
        this.otherName,
        this.fullName,
        this.remitterTypeId,
        this.exchangeId,
        this.exchangeCode,
        this.surname,
        this.businessName,
        this.birthCountry,
        this.birthCountryId,
        this.birthCity,
        this.birthProvince,
        this.birthDate,
        this.profession,
        this.designation,
        this.employer,
        this.nationality,
        this.nationalityCountryId,
        this.sex,
        this.sexLongName,
        this.maritualStatus,
        this.incomeSourceId,
        this.yearlyIncome,
        this.hasTaxInpsNo,
        this.taxInpsNo,
        this.taxRate,
        this.fiscalCode,
        this.fiscalCodeValid,
        this.fatherSurname,
        this.fatherName,
        this.motherSurname,
        this.motherName,
        this.pep,
        this.roadType,
        this.address1,
        this.addressLine,
        this.fullAddress,
        this.address2,
        this.countryId,
        this.countryCode,
        this.countryName,
        this.provinceCode,
        this.province,
        this.zipCode,
        this.capCode,
        this.cityId,
        this.cityCode,
        this.phoneNo,
        this.emailAddress,
        this.docId,
        this.docName,
        this.docCode,
        this.documentNo,
        this.docIssueDate,
        this.docValidUpto,
        this.issuingAuthority,
        this.docIssuePlaceIsCity,
        this.docIssuePlace,
        this.docIssuePlaceId,
        this.status,
        this.statusDescription,
        this.renewalDate,
        this.behaviorClassId,
        this.behaviorClassValue,
        this.tpLinkId,
        this.tpLinkCode,
        this.tpFiscalCode,
        this.subGroupId,
        this.subGroupCode,
        this.sectorId,
        this.sectorCode,
        this.sbSectorId,
        this.sbSectorCode,
        this.firstTranDate,
        this.limitAmount,
        this.canIssueUnlimited,
        this.pointBalance,
        this.detail,
        this.createdAgency,
        this.modifiedAgency,
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
    });

    int? remitterId;
    String? code;
    String? serialNo;
    String? name;
    String? otherName;
    String? fullName;
    int? remitterTypeId;
    int? exchangeId;
    String? exchangeCode;
    String? surname;
    String? businessName;
    String? birthCountry;
    int? birthCountryId;
    String? birthCity;
    String? birthProvince;
    String? birthDate;
    String? profession;
    String? designation;
    String? employer;
    String? nationality;
    int? nationalityCountryId;
    String? sex;
    String? sexLongName;
    String? maritualStatus;
    dynamic incomeSourceId;
    double? yearlyIncome;
    bool? hasTaxInpsNo;
    String? taxInpsNo;
    double? taxRate;
    String? fiscalCode;
    bool? fiscalCodeValid;
    String? fatherSurname;
    String? fatherName;
    String? motherSurname;
    String? motherName;
    bool? pep;
    String? roadType;
    String? address1;
    String? addressLine;
    String? fullAddress;
    String? address2;
    int? countryId;
    String? countryCode;
    String? countryName;
    String? provinceCode;
    String? province;
    String? zipCode;
    String? capCode;
    int? cityId;
    String? cityCode;
    String? phoneNo;
    String? emailAddress;
    int? docId;
    String? docName;
    String? docCode;
    String? documentNo;
    String? docIssueDate;
    String? docValidUpto;
    String? issuingAuthority;
    bool? docIssuePlaceIsCity;
    String? docIssuePlace;
    dynamic docIssuePlaceId;
    int? status;
    String? statusDescription;
    dynamic renewalDate;
    dynamic behaviorClassId;
    int? behaviorClassValue;
    dynamic tpLinkId;
    String? tpLinkCode;
    String? tpFiscalCode;
    dynamic subGroupId;
    String? subGroupCode;
    dynamic sectorId;
    String? sectorCode;
    dynamic sbSectorId;
    String? sbSectorCode;
    dynamic firstTranDate;
    double? limitAmount;
    bool? canIssueUnlimited;
    int? pointBalance;
    String? detail;
    String? createdAgency;
    String? modifiedAgency;
    dynamic sessionId;
    bool? returnStatus;
    List<dynamic>? returnMessage;
    ValidationErrors? validationErrors;
    int? totalPages;
    int? totalRows;
    int? pageSize;
    int? page;
    bool? isAuthenicated;
    String? sortExpression;
    String? sortDirection;
    int? currentPageNumber;

    factory GetRemitterModel.fromJson(Map<String?, dynamic> json) => GetRemitterModel(
        remitterId: json["remitterID"],
        code: json["code"],
        serialNo: json["serialNo"],
        name: json["name"],
        otherName: json["otherName"],
        fullName: json["fullName"],
        remitterTypeId: json["remitterTypeID"],
        exchangeId: json["exchangeID"],
        exchangeCode: json["exchangeCode"],
        surname: json["surname"],
        businessName: json["businessName"],
        birthCountry: json["birthCountry"],
        birthCountryId: json["birthCountryID"],
        birthCity: json["birthCity"],
        birthProvince: json["birthProvince"],
        birthDate: json["birthDate"],
        profession: json["profession"],
        designation: json["designation"],
        employer: json["employer"],
        nationality: json["nationality"],
        nationalityCountryId: json["nationalityCountryID"],
        sex: json["sex"],
        sexLongName: json["sexLongName"],
        maritualStatus: json["maritualStatus"],
        incomeSourceId: json["incomeSourceID"],
        yearlyIncome: json["yearlyIncome"],
        hasTaxInpsNo: json["hasTaxINPSNo"],
        taxInpsNo: json["taxINPSNo"],
        taxRate: json["taxRate"],
        fiscalCode: json["fiscalCode"],
        fiscalCodeValid: json["fiscalCodeValid"],
        fatherSurname: json["fatherSurname"],
        fatherName: json["fatherName"],
        motherSurname: json["motherSurname"],
        motherName: json["motherName"],
        pep: json["pep"],
        roadType: json["roadType"],
        address1: json["address1"],
        addressLine: json["addressLine"],
        fullAddress: json["fullAddress"],
        address2: json["address2"],
        countryId: json["countryID"],
        countryCode: json["countryCode"],
        countryName: json["countryName"],
        provinceCode: json["provinceCode"],
        province: json["province"],
        zipCode: json["zipCode"],
        capCode: json["capCode"],
        cityId: json["cityID"],
        cityCode: json["cityCode"],
        phoneNo: json["phoneNo"],
        emailAddress: json["emailAddress"],
        docId: json["docID"],
        docName: json["docName"],
        docCode: json["docCode"],
        documentNo: json["documentNo"],
        docIssueDate: json["docIssueDate"],
        docValidUpto: json["docValidUpto"],
        issuingAuthority: json["issuingAuthority"],
        docIssuePlaceIsCity: json["docIssuePlaceIsCity"],
        docIssuePlace: json["docIssuePlace"],
        docIssuePlaceId: json["docIssuePlaceID"],
        status: json["status"],
        statusDescription: json["statusDescription"],
        renewalDate: json["renewalDate"],
        behaviorClassId: json["behaviorClassID"],
        behaviorClassValue: json["behaviorClassValue"],
        tpLinkId: json["tpLinkID"],
        tpLinkCode: json["tpLinkCode"],
        tpFiscalCode: json["tpFiscalCode"],
        subGroupId: json["subGroupID"],
        subGroupCode: json["subGroupCode"],
        sectorId: json["sectorID"],
        sectorCode: json["sectorCode"],
        sbSectorId: json["sbSectorID"],
        sbSectorCode: json["sbSectorCode"],
        firstTranDate: json["firstTranDate"],
        limitAmount: json["limitAmount"],
        canIssueUnlimited: json["canIssueUnlimited"],
        pointBalance: json["point?Balance"],
        detail: json["detail"],
        createdAgency: json["createdAgency"],
        modifiedAgency: json["modifiedAgency"],
        sessionId: json["sessionId"],
        returnStatus: json["returnStatus"],
        returnMessage: List<dynamic>.from(json["returnMessage"].map((x) => x)),
        validationErrors: ValidationErrors.fromJson(json["validationErrors"]),
        totalPages: json["totalPages"],
        totalRows: json["totalRows"],
        pageSize: json["pageSize"],
        page: json["page"],
        isAuthenicated: json["isAuthenicated"],
        sortExpression: json["sortExpression"],
        sortDirection: json["sortDirection"],
        currentPageNumber: json["currentPageNumber"],
    );

    Map<String?, dynamic> toJson() => {
        "remitterID": remitterId,
        "code": code,
        "serialNo": serialNo,
        "name": name,
        "otherName": otherName,
        "fullName": fullName,
        "remitterTypeID": remitterTypeId,
        "exchangeID": exchangeId,
        "exchangeCode": exchangeCode,
        "surname": surname,
        "businessName": businessName,
        "birthCountry": birthCountry,
        "birthCountryID": birthCountryId,
        "birthCity": birthCity,
        "birthProvince": birthProvince,
        "birthDate": birthDate,
        "profession": profession,
        "designation": designation,
        "employer": employer,
        "nationality": nationality,
        "nationalityCountryID": nationalityCountryId,
        "sex": sex,
        "sexLongName": sexLongName,
        "maritualStatus": maritualStatus,
        "incomeSourceID": incomeSourceId,
        "yearlyIncome": yearlyIncome,
        "hasTaxINPSNo": hasTaxInpsNo,
        "taxINPSNo": taxInpsNo,
        "taxRate": taxRate,
        "fiscalCode": fiscalCode,
        "fiscalCodeValid": fiscalCodeValid,
        "fatherSurname": fatherSurname,
        "fatherName": fatherName,
        "motherSurname": motherSurname,
        "motherName": motherName,
        "pep": pep,
        "roadType": roadType,
        "address1": address1,
        "addressLine": addressLine,
        "fullAddress": fullAddress,
        "address2": address2,
        "countryID": countryId,
        "countryCode": countryCode,
        "countryName": countryName,
        "provinceCode": provinceCode,
        "province": province,
        "zipCode": zipCode,
        "capCode": capCode,
        "cityID": cityId,
        "cityCode": cityCode,
        "phoneNo": phoneNo,
        "emailAddress": emailAddress,
        "docID": docId,
        "docName": docName,
        "docCode": docCode,
        "documentNo": documentNo,
        "docIssueDate": docIssueDate,
        "docValidUpto": docValidUpto,
        "issuingAuthority": issuingAuthority,
        "docIssuePlaceIsCity": docIssuePlaceIsCity,
        "docIssuePlace": docIssuePlace,
        "docIssuePlaceID": docIssuePlaceId,
        "status": status,
        "statusDescription": statusDescription,
        "renewalDate": renewalDate,
        "behaviorClassID": behaviorClassId,
        "behaviorClassValue": behaviorClassValue,
        "tpLinkID": tpLinkId,
        "tpLinkCode": tpLinkCode,
        "tpFiscalCode": tpFiscalCode,
        "subGroupID": subGroupId,
        "subGroupCode": subGroupCode,
        "sectorID": sectorId,
        "sectorCode": sectorCode,
        "sbSectorID": sbSectorId,
        "sbSectorCode": sbSectorCode,
        "firstTranDate": firstTranDate,
        "limitAmount": limitAmount,
        "canIssueUnlimited": canIssueUnlimited,
        "pointBalance": pointBalance,
        "detail": detail,
        "createdAgency": createdAgency,
        "modifiedAgency": modifiedAgency,
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
    };
}

class ValidationErrors {
    ValidationErrors();

    factory ValidationErrors.fromJson(Map<String?, dynamic> json) => ValidationErrors(
    );

    Map<String?, dynamic> toJson() => {
    };
}
