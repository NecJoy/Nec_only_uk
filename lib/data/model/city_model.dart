// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);







class CityModel {
    CityModel({
        this.cityId,
        this.cabCode,
        this.capCode,
        this.provinceCode,
        this.countryCode,
        this.fiscalCodeRef,
        this.pRef,
        this.countryId,
        this.countryName,
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

    int? cityId;
    String? cabCode;
    String? capCode;
    String? provinceCode;
    String? countryCode;
    String? fiscalCodeRef;
    String? pRef;
    int? countryId;
    String? countryName;
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

    factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        cityId: json["cityID"],
        cabCode: json["cabCode"],
        capCode: json["capCode"],
        provinceCode: json["provinceCode"],
        countryCode: json["countryCode"],
        fiscalCodeRef: json["fiscalCodeRef"],
        pRef: json["pRef"],
        countryId: json["countryID"],
        countryName: json["countryName"],
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
        "cityID": cityId,
        "cabCode": cabCode,
        "capCode": capCode,
        "provinceCode": provinceCode,
        "countryCode": countryCode,
        "fiscalCodeRef": fiscalCodeRef,
        "pRef": pRef,
        "countryID": countryId,
        "countryName": countryName,
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
