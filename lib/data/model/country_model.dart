class CountryModel {
    CountryModel({
        this.countryId,
        this.isoCode,
        this.code4,
        this.code5,
        this.nationality,
        this.riskFactor,
        this.fiscalReference,
        this.callingCode,
        this.phoneNoFormat,
        this.isEuMember,
        this.isCity,
        this.checkBlackList,
        this.remIdPrefix,
        this.currencies,
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

    int? countryId;
    String? isoCode;
    String? code4;
    String? code5;
    String? nationality;
    String? riskFactor;
    String? fiscalReference;
    String? callingCode;
    String? phoneNoFormat;
    bool? isEuMember;
    bool? isCity;
    bool? checkBlackList;
    String? remIdPrefix;
    List<dynamic>? currencies;
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
    Map? validationErrors;
    int? totalPages;
    int? totalRows;
    int? pageSize;
    int? page;
    bool? isAuthenicated;
    String? sortExpression;
    String? sortDirection;
    int? currentPageNumber;
    Map? filter;
    bool? sessionExpired;

    factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        countryId: json["countryID"],
        isoCode: json["isoCode"],
        code4: json["code4"],
        code5: json["code5"],
        nationality: json["nationality"],
        riskFactor: json["riskFactor"],
        fiscalReference: json["fiscalReference"],
        callingCode: json["callingCode"],
        phoneNoFormat: json["phoneNoFormat"],
        isEuMember: json["isEUMember"],
        isCity: json["isCity"],
        checkBlackList: json["checkBlackList"],
        remIdPrefix: json["remIDPrefix"],
        currencies: json["currencies"] != null ? List<dynamic>.from(json["currencies"].map((x) => x)) : null,
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
        returnMessage: json["returnMessage"] != null ? List<dynamic>.from(json["returnMessage"].map((x) => x)) : null,
        validationErrors: Map<String, dynamic>.from(json["validationErrors"]),
        totalPages: json["totalPages"],
        totalRows: json["totalRows"],
        pageSize: json["pageSize"],
        page: json["page"],
        isAuthenicated: json["isAuthenicated"],
        sortExpression: json["sortExpression"],
        sortDirection: json["sortDirection"],
        currentPageNumber: json["currentPageNumber"],
        filter: Map<String, dynamic>.from(json["validationErrors"]),
        sessionExpired: json["sessionExpired"],
    );
    Map<String, dynamic> toJson() => {
        "countryID": countryId,
        "isoCode": isoCode,
        "code4": code4,
        "code5": code5,
        "nationality": nationality,
        "riskFactor": riskFactor,
        "fiscalReference": fiscalReference,
        "callingCode": callingCode,
        "phoneNoFormat": phoneNoFormat,
        "isEUMember": isEuMember,
        "isCity": isCity,
        "checkBlackList": checkBlackList,
        "remIDPrefix": remIdPrefix,
        "currencies": List<dynamic>.from(currencies!.map((x) => x)),
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