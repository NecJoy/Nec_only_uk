// To parse this JSON data, do
//
//     final getDealingRate = getDealingRateFromJson(jsonString);

import 'dart:convert';

GetDealingRateModel getDealingRateFromJson(String str) => GetDealingRateModel.fromJson(json.decode(str));

String getDealingRateToJson(GetDealingRateModel data) => json.encode(data.toJson());

class GetDealingRateModel {
    GetDealingRateModel({
        this.remitterTypeId,
        this.modeId,
        this.countryId,
        this.currencyId,
        this.city,
        this.subcompanyId,
        this.companyId,
        this.bankId,
        this.selectBank,
        this.beneficiaryId,
        this.status,
        this.remitNoPrefix,
        this.exchangeLcIsoCode,
        this.canChangeCommission,
        this.rate,
        this.operationDate,
        this.amount,
        this.commission,
        this.cardCharge,
        this.fldPsfx,
        this.statusDetail,
        this.cardType,
        this.remitterTypes,
        this.remitterSetup,
        this.countries,
        this.nationalities,
        this.incomeSources,
        this.roadTypes,
        this.cities,
        this.remitterDocumentTypes,
        this.remitterBehaviorClasses,
        this.subGroups,
        this.sectors,
        this.sbSectors,
        this.linkBetweenTPs,
        this.remitter,
        this.beneficiary,
        this.paymentModes,
        this.beneficiaries,
        this.currencies,
        this.subcompaniesCities,
        this.bankCities,
        this.subcompanies,
        this.subcompanyBranches,
        this.beneficiarySetup,
        this.benefBanks,
        this.benefAccTypes,
        this.benefDocTypes,
        this.bankBranches,
        this.relations,
        this.birthCountries,
        this.purposes,
        this.maturityDays,
        this.instrumentTypes,
        this.newTt,
        this.itemId,
        this.docOf,
        this.messageText,
        this.encryptedData,
        this.searchCriteria,
        this.remittanceNo,
        this.siteRef,
        this.remName,
        this.remBirthDate,
        this.remSurname,
        this.remCountryIsoCode,
        this.phoneNo,
        this.remAddress,
        this.remZipCode,
        this.remProvince,
        this.remEmailAddress,
        this.remPhoneNo,
        this.remCity,
        this.processId,
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

    int? remitterTypeId;
    int? modeId;
    int? countryId;
    int? currencyId;
    dynamic city;
    int? subcompanyId;
    int? companyId;
    dynamic bankId;
    bool? selectBank;
    int? beneficiaryId;
    int? status;
    dynamic remitNoPrefix;
    dynamic exchangeLcIsoCode;
    bool? canChangeCommission;
    double? rate;
    DateTime? operationDate;
    double? amount;
    double? commission;
    double? cardCharge;
    String? fldPsfx;
    dynamic statusDetail;
    dynamic cardType;
    dynamic remitterTypes;
    dynamic remitterSetup;
    dynamic countries;
    dynamic nationalities;
    dynamic incomeSources;
    dynamic roadTypes;
    dynamic cities;
    dynamic remitterDocumentTypes;
    dynamic remitterBehaviorClasses;
    dynamic subGroups;
    dynamic sectors;
    dynamic sbSectors;
    dynamic linkBetweenTPs;
    dynamic remitter;
    dynamic beneficiary;
    dynamic paymentModes;
    dynamic beneficiaries;
    dynamic currencies;
    dynamic subcompaniesCities;
    dynamic bankCities;
    dynamic subcompanies;
    dynamic subcompanyBranches;
    dynamic beneficiarySetup;
    dynamic benefBanks;
    dynamic benefAccTypes;
    dynamic benefDocTypes;
    dynamic bankBranches;
    dynamic relations;
    dynamic birthCountries;
    dynamic purposes;
    dynamic maturityDays;
    dynamic instrumentTypes;
    dynamic newTt;
    int? itemId;
    int? docOf;
    dynamic messageText;
    dynamic encryptedData;
    dynamic searchCriteria;
    dynamic remittanceNo;
    dynamic siteRef;
    dynamic remName;
    dynamic remBirthDate;
    dynamic remSurname;
    dynamic remCountryIsoCode;
    dynamic phoneNo;
    dynamic remAddress;
    dynamic remZipCode;
    dynamic remProvince;
    dynamic remEmailAddress;
    dynamic remPhoneNo;
    dynamic remCity;
    int? processId;
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

    factory GetDealingRateModel.fromJson(Map<String, dynamic> json) => GetDealingRateModel(
        remitterTypeId: json["remitterTypeID"],
        modeId: json["modeID"],
        countryId: json["countryID"],
        currencyId: json["currencyID"],
        city: json["city"],
        subcompanyId: json["subcompanyID"],
        companyId: json["companyID"],
        bankId: json["bankID"],
        selectBank: json["selectBank"],
        beneficiaryId: json["beneficiaryID"],
        status: json["status"],
        remitNoPrefix: json["remitNoPrefix"],
        exchangeLcIsoCode: json["exchangeLCIsoCode"],
        canChangeCommission: json["canChangeCommission"],
        rate: json["rate"],
        operationDate: DateTime.parse(json["operationDate"]),
        amount: json["amount"],
        commission: json["commission"],
        cardCharge: json["cardCharge"],
        fldPsfx: json["fldPsfx"],
        statusDetail: json["statusDetail"],
        cardType: json["cardType"],
        remitterTypes: json["remitterTypes"],
        remitterSetup: json["remitterSetup"],
        countries: json["countries"],
        nationalities: json["nationalities"],
        incomeSources: json["incomeSources"],
        roadTypes: json["roadTypes"],
        cities: json["cities"],
        remitterDocumentTypes: json["remitterDocumentTypes"],
        remitterBehaviorClasses: json["remitterBehaviorClasses"],
        subGroups: json["subGroups"],
        sectors: json["sectors"],
        sbSectors: json["sbSectors"],
        linkBetweenTPs: json["linkBetweenTPs"],
        remitter: json["remitter"],
        beneficiary: json["beneficiary"],
        paymentModes: json["paymentModes"],
        beneficiaries: json["beneficiaries"],
        currencies: json["currencies"],
        subcompaniesCities: json["subcompaniesCities"],
        bankCities: json["bankCities"],
        subcompanies: json["subcompanies"],
        subcompanyBranches: json["subcompanyBranches"],
        beneficiarySetup: json["beneficiarySetup"],
        benefBanks: json["benefBanks"],
        benefAccTypes: json["benefAccTypes"],
        benefDocTypes: json["benefDocTypes"],
        bankBranches: json["bankBranches"],
        relations: json["relations"],
        birthCountries: json["birthCountries"],
        purposes: json["purposes"],
        maturityDays: json["maturityDays"],
        instrumentTypes: json["instrumentTypes"],
        newTt: json["newTT"],
        itemId: json["itemID"],
        docOf: json["docOf"],
        messageText: json["messageText"],
        encryptedData: json["encryptedData"],
        searchCriteria: json["searchCriteria"],
        remittanceNo: json["remittanceNo"],
        siteRef: json["siteRef"],
        remName: json["remName"],
        remBirthDate: json["remBirthDate"],
        remSurname: json["remSurname"],
        remCountryIsoCode: json["remCountryIsoCode"],
        phoneNo: json["phoneNo"],
        remAddress: json["remAddress"],
        remZipCode: json["remZipCode"],
        remProvince: json["remProvince"],
        remEmailAddress: json["remEmailAddress"],
        remPhoneNo: json["remPhoneNo"],
        remCity: json["remCity"],
        processId: json["processId"],
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
        "remitterTypeID": remitterTypeId,
        "modeID": modeId,
        "countryID": countryId,
        "currencyID": currencyId,
        "city": city,
        "subcompanyID": subcompanyId,
        "companyID": companyId,
        "bankID": bankId,
        "selectBank": selectBank,
        "beneficiaryID": beneficiaryId,
        "status": status,
        "remitNoPrefix": remitNoPrefix,
        "exchangeLCIsoCode": exchangeLcIsoCode,
        "canChangeCommission": canChangeCommission,
        "rate": rate,
        "operationDate": operationDate?.toIso8601String(),
        "amount": amount,
        "commission": commission,
        "cardCharge": cardCharge,
        "fldPsfx": fldPsfx,
        "statusDetail": statusDetail,
        "cardType": cardType,
        "remitterTypes": remitterTypes,
        "remitterSetup": remitterSetup,
        "countries": countries,
        "nationalities": nationalities,
        "incomeSources": incomeSources,
        "roadTypes": roadTypes,
        "cities": cities,
        "remitterDocumentTypes": remitterDocumentTypes,
        "remitterBehaviorClasses": remitterBehaviorClasses,
        "subGroups": subGroups,
        "sectors": sectors,
        "sbSectors": sbSectors,
        "linkBetweenTPs": linkBetweenTPs,
        "remitter": remitter,
        "beneficiary": beneficiary,
        "paymentModes": paymentModes,
        "beneficiaries": beneficiaries,
        "currencies": currencies,
        "subcompaniesCities": subcompaniesCities,
        "bankCities": bankCities,
        "subcompanies": subcompanies,
        "subcompanyBranches": subcompanyBranches,
        "beneficiarySetup": beneficiarySetup,
        "benefBanks": benefBanks,
        "benefAccTypes": benefAccTypes,
        "benefDocTypes": benefDocTypes,
        "bankBranches": bankBranches,
        "relations": relations,
        "birthCountries": birthCountries,
        "purposes": purposes,
        "maturityDays": maturityDays,
        "instrumentTypes": instrumentTypes,
        "newTT": newTt,
        "itemID": itemId,
        "docOf": docOf,
        "messageText": messageText,
        "encryptedData": encryptedData,
        "searchCriteria": searchCriteria,
        "remittanceNo": remittanceNo,
        "siteRef": siteRef,
        "remName": remName,
        "remBirthDate": remBirthDate,
        "remSurname": remSurname,
        "remCountryIsoCode": remCountryIsoCode,
        "phoneNo": phoneNo,
        "remAddress": remAddress,
        "remZipCode": remZipCode,
        "remProvince": remProvince,
        "remEmailAddress": remEmailAddress,
        "remPhoneNo": remPhoneNo,
        "remCity": remCity,
        "processId": processId,
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
    Map<String, dynamic> toJson() => {};
}
