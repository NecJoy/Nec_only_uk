class BankNameModel {
    BankNameModel({
        this.accountTypeId,
        this.code4,
        this.countryId,
        this.companyId,
        this.subcompanyId,
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
        this.bankId,
        this.selectBranch,
    });

    int? accountTypeId;
    String? code4;
    int? countryId;
    int? companyId;
    int? subcompanyId;
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
    int? bankId;
    bool? selectBranch;

    factory BankNameModel.fromJson(Map<String, dynamic> json) => BankNameModel(
        accountTypeId: json["accountTypeID"] == null ? null : json["accountTypeID"],
        code4: json["code4"],
        countryId: json["countryID"],
        companyId: json["companyID"] == null ? null : json["companyID"],
        subcompanyId: json["subcompanyID"] == null ? null : json["subcompanyID"],
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
        bankId: json["bankID"] == null ? null : json["bankID"],
        selectBranch: json["selectBranch"] == null ? null : json["selectBranch"],
    );

    Map<String, dynamic> toJson() => {
        "accountTypeID": accountTypeId == null ? null : accountTypeId,
        "code4": code4,
        "countryID": countryId,
        "companyID": companyId == null ? null : companyId,
        "subcompanyID": subcompanyId == null ? null : subcompanyId,
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
        "bankID": bankId == null ? null : bankId,
        "selectBranch": selectBranch == null ? null : selectBranch,
    };
}

class Filter {
    Filter();

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    );

    Map<String, dynamic> toJson() => {
    };
}