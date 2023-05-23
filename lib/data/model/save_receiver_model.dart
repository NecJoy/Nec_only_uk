
import 'dart:convert';


SaveReceiverModel saveReceiverModelFromJson(String str) => SaveReceiverModel.fromJson(json.decode(str));

String saveReceiverModelToJson(SaveReceiverModel data) => json.encode(data.toJson());

class SaveReceiverModel {
    SaveReceiverModel({
        this.beneficiary,
    });

    Beneficiary? beneficiary;

    factory SaveReceiverModel.fromJson(Map<String, dynamic> json) => SaveReceiverModel(
        beneficiary: Beneficiary.fromJson(json["Beneficiary"]),
    );

    Map<String, dynamic> toJson() => {
        "Beneficiary": beneficiary!.toJson(),
    };
}

class Beneficiary {
    Beneficiary({
        this.beneficiaryId,
        this.remitterId,
        this.name,
        this.surname,
        this.countryId,
        this.countryName,
        this.subCompanyId,
        this.subCompanyCode,
        this.currencyId,
        this.currencyName,
        this.currencyIsoCode,
        this.companyId,
        this.modeId,
        this.modeName,
        this.subCompanyBranchId,
        this.subCompanyBranchCode,
        this.relationId,
        this.phoneNo,
        this.birthDate,
        this.returnMessage,
        this.emailAddress,
        this.zipCode,
        this.address1,
        this.address2,
        this.addressLine,
        this.sex,
        this.nationality,
        this.nationalityID,
        this.accountNo,
        this.bankName,
        this.bankBranchAddr,
        this.bankCity,
        this.bankBranchName,
        this.subcompanyCity,
        this.subCompanyName,
        this.subCompanyBranchName,
        this.beneficiaryBankName,
        this.accountTypeId,
        this.accountCode,
        this.bankBranchCode,
        this.bankBranchId,
        this.bankCode,
        this.bankId,
    });

    int? beneficiaryId;
    int? remitterId;
    String? name;
    String? surname;
    int? countryId;
    int? subCompanyId;
    dynamic subCompanyCode;
    int? currencyId;
    String? currencyName;
    String? currencyIsoCode;
    int? companyId;
    int? modeId;
    String? modeName;
    int? subCompanyBranchId;
    dynamic subCompanyBranchCode;
    int? relationId;
    String? phoneNo;
    DateTime? birthDate;
    String? returnMessage;
    String? emailAddress;
    String? zipCode;
    String? countryName;
    String? address1;
    String? address2;
    String? addressLine;
    String? sex;
    String? nationality;
    int? nationalityID;
    String? accountNo;
    dynamic bankName;
    String? bankBranchAddr;
    dynamic bankCity;
    String? bankBranchName;
    String? subcompanyCity;
    String? subCompanyName;
    String? subCompanyBranchName;
    String? beneficiaryBankName;
    int? accountTypeId;
    String? accountCode;
    dynamic bankBranchCode;
    int? bankBranchId;
    dynamic bankCode;
    int? bankId;
    


    factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
        beneficiaryId: json["beneficiaryID"],
        remitterId: json["remitterId"],
        name: json["name"],
        surname: json["surname"],
        countryId: json["countryId"],
        subCompanyId: json["subCompanyId"],
        subCompanyCode: json["subCompanyCode"],
        currencyId: json["currencyId"],
        currencyName:json["currencyName"],
        currencyIsoCode: json["currencyISOCode"],
        companyId: json["companyId"],
        modeId: json["modeId"],
        modeName: json["modeName"],
        subCompanyBranchId: json["subCompanyBranchId"],
        subCompanyBranchCode: json["subCompanyBranchCode"],
        relationId: json["relationId"],
        phoneNo: json["phoneNo"],
        birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
        returnMessage: json["returnMessage"],
        emailAddress: json["emailAddress"],
        zipCode: json["zipCode"],
        countryName: json["countryName"],
        address1: json["address1"],
        address2: json["address2"],
        addressLine: json["addressLine"],
        sex: json["sex"],
        nationality: json["nationality"],
        nationalityID: json["nationalityId"],
        accountNo: json["accountNo"],
        bankName: json["bankName"],
        bankBranchAddr: json["bankBranchAddr"],
        bankCity: json["bankCity"],
        bankBranchName: json["bankBranchName"],
        subcompanyCity: json["subcompanyCity"],
        subCompanyName: json["subCompanyName"],
        subCompanyBranchName: json["subCompanyBranchName"],
        beneficiaryBankName: json["beneficiaryBankName"],
        accountCode: json["accountCode"],
        accountTypeId: json[" accountTypeID"],
        bankBranchCode: json["bankBranchCode"],
        bankBranchId: json["bankBranchID"],
        bankCode: json["bankCode"],
        bankId: json["bankID"],
        
    );

    Map<String, dynamic> toJson() => {
        "beneficiaryID": beneficiaryId,
        "remitterId": remitterId,
        "name": name,
        "surname": surname,
        "countryId": countryId,
        "subCompanyId": subCompanyId,
        "subCompanyCode": subCompanyCode,
        "currencyId": currencyId,
        "currencyName" :currencyName,
        "currencyISOCode": currencyIsoCode,
        "companyId": companyId,
        "modeId": modeId,
        "modeName":modeName,
        "subCompanyBranchId": subCompanyBranchId,
        "subCompanyBranchCode" : subCompanyBranchCode,
        "relationId": relationId,
        "phoneNo": phoneNo,
        "birthDate": birthDate?.toIso8601String(),
        "returnMessage": returnMessage,
        "emailAddress": emailAddress,
        "zipCode": zipCode,
        "countryName": countryName,
        "address1": address1,
        "address2": address2,
        "addressLine": addressLine,
        "sex": sex,
        "nationality": nationality,
        "nationalityId" : nationalityID,
        "accountNo": accountNo,
        "bankName": bankName,
        "bankBranchAddr": bankBranchAddr,
        "bankCity": bankCity,
        "bankBranchName": bankBranchName,
        "subcompanyCity": subcompanyCity,
        "subCompanyName": subCompanyName,
        "subCompanyBranchName": subCompanyBranchName,
        "beneficiaryBankName": beneficiaryBankName,
        "accountCode": accountCode ,
        "accountTypeID" : accountTypeId,
        "bankBranchCode" : bankBranchCode,
        "bankBranchID":bankBranchId,
        "bankCode": bankCode,
        "bankID" :bankId
    };
}





class GetReceiverDataModel {
    GetReceiverDataModel({
        this.beneficiaryId,
        this.exchangeId,
        this.remitterId,
        this.modeId,
        this.modeName,
        this.countryId,
        this.countryName,
        this.companyId,
        this.subCompanyId,
        this.subCompanyCode,
        this.subCompanyName,
        this.subCompanyBranchId,
        this.subCompanyBranchCode,
        this.subCompanyBranchName,
        this.currencyId,
        this.currencyName,
        this.currencyIsoCode,
        this.surname,
        this.name,
        this.otherName,
        this.fullName,
        this.birthCountryId,
        this.birthCity,
        this.birthProvince,
        this.birthDate,
        this.sex,
        this.relationId,
        this.nationality,
        this.nationalityId,
        this.profession,
        this.designation,
        this.fatherSurname,
        this.fatherName,
        this.motherSurname,
        this.motherName,
        this.phoneNo,
        this.emailAddress,
        this.documentIssueDate,
        this.documentValidUpto,
        this.documentIssuedBy,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.zipCode,
        this.addressCountry,
        this.documentId,
        this.documentCode,
        this.documentNo,
        this.accountTypeId,
        this.accountCode,
        this.accountNo,
        this.bankId,
        this.bankCode,
        this.bankName,
        this.bankBranchId,
        this.bankBranchCode,
        this.bankBranchName,
        this.bankBranchAddr,
        this.canIssueUnlimited,
        this.limitAmount,
        this.status,
        this.subcompanyCity,
        this.bankCity,
        this.statusDetail,
        this.beneficiaryBankName,
        this.addressLine,
        this.fullAddress,
        this.detail,
        this.detail1,
        this.detail2,
        this.detail3,
        this.detail4,
        this.detail5,
        this.detail6,
        this.lstBlChkDate,
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
        this.baseKey,
    });

    int? beneficiaryId;
    int? exchangeId;
    int? remitterId;
    int? modeId;
    String? modeName;
    dynamic countryId;
    String? countryName;
    int? companyId;
    int? subCompanyId;
    String? subCompanyCode;
    String? subCompanyName;
    int? subCompanyBranchId;
    String? subCompanyBranchCode;
    String? subCompanyBranchName;
    int? currencyId;
    String? currencyName;
    String? currencyIsoCode;
    String? surname;
    String? name;
    String? otherName;
    String? fullName;
    int? birthCountryId;
    String? birthCity;
    String? birthProvince;
    DateTime? birthDate;
    String? sex;
    int? relationId;
    String? nationality;
    int? nationalityId;
    String? profession;
    String? designation;
    String? fatherSurname;
    String? fatherName;
    String? motherSurname;
    String? motherName;
    String? phoneNo;
    String? emailAddress;
    String? documentIssueDate;
    String? documentValidUpto;
    String? documentIssuedBy;
    String? address1;
    String? address2;
    String? city;
    String? state;
    String? zipCode;
    String? addressCountry;
    int? documentId;
    String? documentCode;
    String? documentNo;
    int? accountTypeId;
    String? accountCode;
    String? accountNo;
    int? bankId;
    String? bankCode;
    String? bankName;
    int? bankBranchId;
    String? bankBranchCode;
    String? bankBranchName;
    String? bankBranchAddr;
    bool? canIssueUnlimited;
    dynamic limitAmount;
    int? status;
    String? subcompanyCity;
    String? bankCity;
    dynamic statusDetail;
    String? beneficiaryBankName;
    String? addressLine;
    String? fullAddress;
    String? detail;
    String? detail1;
    String? detail2;
    String? detail3;
    String? detail4;
    String? detail5;
    String? detail6;
    DateTime? lstBlChkDate;
    String? sessionId;
    bool? returnStatus;
    String? returnMessage;
    dynamic validationErrors;
    int? totalPages;
    int? totalRows;
    int? pageSize;
    int? page;
    bool? isAuthenicated;
    String? sortExpression;
    String? sortDirection;
    int? currentPageNumber;
    dynamic filter;
    bool? sessionExpired;
    String? baseKey;

    factory GetReceiverDataModel.fromJson(Map<String, dynamic> json) => GetReceiverDataModel(
        beneficiaryId: json["beneficiaryID"],
        exchangeId: json["exchangeID"],
        remitterId: json["remitterID"],
        modeId: json["modeID"],
        modeName: json["modeName"],
        countryId: json["countryID"],
        countryName: json["countryName"],
        companyId: json["companyID"],
        subCompanyId: json["subCompanyID"],
        subCompanyCode: json["subCompanyCode"],
        subCompanyName: json["subCompanyName"],
        subCompanyBranchId: json["subCompanyBranchID"],
        subCompanyBranchCode: json["subCompanyBranchCode"],
        subCompanyBranchName: json["subCompanyBranchName"],
        currencyId: json["currencyID"],
        currencyName: json["currencyName"],
        currencyIsoCode: json["currencyISOCode"],
        surname: json["surname"],
        name: json["name"],
        otherName: json["otherName"],
        fullName: json["fullName"],
        birthCountryId: json["birthCountryID"],
        birthCity: json["birthCity"],
        birthProvince: json["birthProvince"],
        birthDate: json["birthDate"],
        sex: json["sex"],
        relationId: json["relationID"],
        nationality: json["nationality"],
        nationalityId: json["nationalityID"],
        profession: json["profession"],
        designation: json["designation"],
        fatherSurname: json["fatherSurname"],
        fatherName: json["fatherName"],
        motherSurname: json["motherSurname"],
        motherName: json["motherName"],
        phoneNo: json["phoneNo"],
        emailAddress: json["emailAddress"],
        documentIssueDate: json["documentIssueDate"],
        documentValidUpto: json["documentValidUpto"],
        documentIssuedBy: json["documentIssuedBy"],
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
        addressCountry: json["addressCountry"],
        documentId: json["documentID"],
        documentCode: json["documentCode"],
        documentNo: json["documentNo"],
        accountTypeId: json["accountTypeID"],
        accountCode: json["accountCode"],
        accountNo: json["accountNo"],
        bankId: json["bankID"],
        bankCode: json["bankCode"],
        bankName: json["bankName"],
        bankBranchId: json["bankBranchID"],
        bankBranchCode: json["bankBranchCode"],
        bankBranchName: json["bankBranchName"],
        bankBranchAddr: json["bankBranchAddr"],
        canIssueUnlimited: json["canIssueUnlimited"],
        limitAmount: json["limitAmount"],
        status: json["status"],
        subcompanyCity: json["subcompanyCity"],
        bankCity: json["bankCity"],
        statusDetail: json["statusDetail"],
        beneficiaryBankName: json["beneficiaryBankName"],
        addressLine: json["addressLine"],
        fullAddress: json["fullAddress"],
        detail: json["detail"],
        detail1: json["detail1"],
        detail2: json["detail2"],
        detail3: json["detail3"],
        detail4: json["detail4"],
        detail5: json["detail5"],
        detail6: json["detail6"],
        lstBlChkDate: DateTime.parse(json["lstBLChkDate"]),
        sessionId: json["sessionId"],
        returnStatus: json["returnStatus"],
        returnMessage: json["returnMessage"],
        validationErrors: json["validationErrors"],
        totalPages: json["totalPages"],
        totalRows: json["totalRows"],
        pageSize: json["pageSize"],
        page: json["page"],
        isAuthenicated: json["isAuthenicated"],
        sortExpression: json["sortExpression"],
        sortDirection: json["sortDirection"],
        currentPageNumber: json["currentPageNumber"],
        sessionExpired: json["sessionExpired"],
        baseKey: json["baseKey"],
    );

    Map<String, dynamic> toJson() => {
        "beneficiaryID": beneficiaryId,
        "exchangeID": exchangeId,
        "remitterID": remitterId,
        "modeID": modeId,
        "modeName": modeName,
        "countryID": countryId,
        "countryName": countryName,
        "companyID": companyId,
        "subCompanyID": subCompanyId,
        "subCompanyCode": subCompanyCode,
        "subCompanyName": subCompanyName,
        "subCompanyBranchID": subCompanyBranchId,
        "subCompanyBranchCode": subCompanyBranchCode,
        "subCompanyBranchName": subCompanyBranchName,
        "currencyID": currencyId,
        "currencyName": currencyName,
        "currencyISOCode": currencyIsoCode,
        "surname": surname,
        "name": name,
        "otherName": otherName,
        "fullName": fullName,
        "birthCountryID": birthCountryId,
        "birthCity": birthCity,
        "birthProvince": birthProvince,
        "birthDate": birthDate?.toIso8601String(),
        "sex": sex,
        "relationID": relationId,
        "nationality": nationality,
        "nationalityID": nationalityId,
        "profession": profession,
        "designation": designation,
        "fatherSurname": fatherSurname,
        "fatherName": fatherName,
        "motherSurname": motherSurname,
        "motherName": motherName,
        "phoneNo": phoneNo,
        "emailAddress": emailAddress,
        "documentIssueDate": documentIssueDate,
        "documentValidUpto": documentValidUpto,
        "documentIssuedBy": documentIssuedBy,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "addressCountry": addressCountry,
        "documentID": documentId,
        "documentCode": documentCode,
        "documentNo": documentNo,
        "accountTypeID": accountTypeId,
        "accountCode": accountCode,
        "accountNo": accountNo,
        "bankID": bankId,
        "bankCode": bankCode,
        "bankName": bankName,
        "bankBranchID": bankBranchId,
        "bankBranchCode": bankBranchCode,
        "bankBranchName": bankBranchName,
        "bankBranchAddr": bankBranchAddr,
        "canIssueUnlimited": canIssueUnlimited,
        "limitAmount": limitAmount,
        "status": status,
        "subcompanyCity": subcompanyCity,
        "bankCity": bankCity,
        "statusDetail": statusDetail,
        "beneficiaryBankName": beneficiaryBankName,
        "addressLine": addressLine,
        "fullAddress": fullAddress,
        "detail": detail,
        "detail1": detail1,
        "detail2": detail2,
        "detail3": detail3,
        "detail4": detail4,
        "detail5": detail5,
        "detail6": detail6,
        "lstBLChkDate": lstBlChkDate?.toIso8601String(),
        "sessionId": sessionId,
        "returnStatus": returnStatus,
        "returnMessage": returnMessage,
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
        "baseKey": baseKey,
    };
}






  