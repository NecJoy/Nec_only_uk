// // To parse this JSON data, do
// //
// //     final saveProfileModel = saveProfileModelFromJson(jsonString);

import 'dart:convert';

SaveProfileModel saveProfileModelFromJson(String str) => SaveProfileModel.fromJson(json.decode(str));

String saveProfileModelToJson(SaveProfileModel data) => json.encode(data.toJson());

class SaveProfileModel {
    SaveProfileModel({
        required this.remitter,
    });

    RemitterModel remitter;

    factory SaveProfileModel.fromJson(Map<String, dynamic> json) => SaveProfileModel(
        remitter: RemitterModel.fromJson(json["Remitter"]),
    );

    Map<String, dynamic> toJson() => {
        "Remitter": remitter.toJson(),
    };
}

class RemitterModel {
    RemitterModel({
        this.remitterId,
        this.code,
        this.name,
        this.otherName,
        this.remitterTypeId,
        this.exchangeID,
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
        this.maritualStatus,
        this.incomeSourceId,
        this.yearlyIncome,
        this.hasTaxInpsNo,
        this.taxInpsNo,
        this.taxRate,
        this.fiscalCode,
        this.fatherSurname,
        this.fatherName,
        this.motherSurname,
        this.motherName,
        this.pep,
        this.roadType,
        this.address1,
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
        this.docName,
        this.docId,
        this.docCode,
        this.documentNo,
        this.docIssueDate,
        this.docValidUpto,
        this.issuingAuthority,
        this.docIssuePlaceIsCity,
        this.docIssuePlace,
        this.docIssuePlaceId,
        this.status,
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
    });

    int? remitterId;
    String? code;
    String? name;
    String? otherName;
    int? remitterTypeId;
    int? exchangeID;
    String? surname;
    String? businessName;
    String? birthCountry;
    int? birthCountryId;
    String? birthCity;
    String? birthProvince;
    DateTime? birthDate;
    String? profession;
    String? designation;
    String? employer;
    String? nationality;
    int? nationalityCountryId;
    String? sex;
    String? maritualStatus;
    int? incomeSourceId;
    int? yearlyIncome;
    bool? hasTaxInpsNo;
    String? taxInpsNo;
    int? taxRate;
    String? fiscalCode;
    String? fatherSurname;
    String? fatherName;
    String? motherSurname;
    String? motherName;
    bool? pep;
    String? roadType;
    String? address1;
    String? address2;
    int? countryId;
    String? countryCode;
    String? countryName;
    String? provinceCode;
    String? province;
    String? zipCode;
    String? capCode;
    dynamic cityId;
    dynamic cityCode;
    String? phoneNo;
    dynamic emailAddress;
    String? docName;
    int? docId;
    String? docCode;
    String? documentNo;
    DateTime? docIssueDate;
    DateTime? docValidUpto;
    String? issuingAuthority;
    int? docIssuePlaceIsCity;
    String? docIssuePlace;
    int? docIssuePlaceId;
    int? status;
    DateTime? renewalDate;
    int? behaviorClassId;
    int? behaviorClassValue;
    int? tpLinkId;
    String? tpLinkCode;
    String? tpFiscalCode;
    int? subGroupId;
    String? subGroupCode;
    int? sectorId;
    String? sectorCode;
    int? sbSectorId;
    String? sbSectorCode;

    factory RemitterModel.fromJson(Map<String, dynamic> json) => RemitterModel(
        remitterId: json["RemitterID"],
        code: json["Code"],
        name: json["Name"],
        otherName: json["OtherName"],
        remitterTypeId: json["RemitterTypeID"],
        exchangeID: json["exchangeID"],
        surname: json["Surname"],
        businessName: json["BusinessName"],
        birthCountry: json["BirthCountry"],
        birthCountryId: json["birthCountryID"],
        birthCity: json["BirthCity"],
        birthProvince: json["BirthProvince"],
        birthDate: json["birthDate"] != null ? DateTime.parse(json["birthDate"]): null,
        profession: json["Profession"],
        designation: json["Designation"],
        employer: json["Employer"],
        nationality: json["Nationality"],
        nationalityCountryId: json["NationalityCountryID"],
        sex: json["Sex"],
        maritualStatus: json["MaritualStatus"],
        incomeSourceId: json["IncomeSourceID"],
        yearlyIncome: json["YearlyIncome"],
        hasTaxInpsNo: json["HasTaxINPSNo"],
        taxInpsNo: json["TaxINPSNo"],
        taxRate: json["TaxRate"],
        fiscalCode: json["FiscalCode"],
        fatherSurname: json["FatherSurname"],
        fatherName: json["FatherName"],
        motherSurname: json["MotherSurname"],
        motherName: json["MotherName"],
        pep: json["Pep"],
        roadType: json["RoadType"],
        address1: json["Address1"],
        address2: json["Address2"],
        countryId: json["CountryID"],
        countryCode: json["CountryCode"],
        countryName: json["CountryName"],
        provinceCode: json["ProvinceCode"],
        province: json["Province"],
        zipCode: json["ZipCode"],
        capCode: json["CapCode"],
        docName: json["DocName"],
        cityId: json["CityID"],
        cityCode: json["CityCode"],
        phoneNo: json["PhoneNo"],
        emailAddress: json["EmailAddress"],
        docId: json["DocID"],
        docCode: json["DocCode"],
        documentNo: json["DocumentNo"],
        docIssueDate:json["DocIssueDate"] != null ? DateTime.parse(json["DocIssueDate"]) : null,
        docValidUpto:json["DocValidUpto"]  != null ? DateTime.parse(json["DocValidUpto"]) : null,
        issuingAuthority: json["IssuingAuthority"],
        docIssuePlaceIsCity: json["DocIssuePlaceIsCity"],
        docIssuePlace: json["DocIssuePlace"],
        docIssuePlaceId: json["DocIssuePlaceID"],
        status: json["Status"],
        renewalDate: json["RenewalDate"] != null ? DateTime.parse(json["RenewalDate"]) : null,
        behaviorClassId: json["BehaviorClassID"],
        behaviorClassValue: json["BehaviorClassValue"],
        tpLinkId: json["TpLinkID"],
        tpLinkCode: json["TpLinkCode"],
        tpFiscalCode: json["TpFiscalCode"],
        subGroupId: json["SubGroupID"],
        subGroupCode: json["SubGroupCode"],
        sectorId: json["SectorID"],
        sectorCode: json["SectorCode"],
        sbSectorId: json["SbSectorID"],
        sbSectorCode: json["SBSectorCode"],
    );

    Map<String, dynamic> toJson() => {
        "RemitterID": remitterId,
        "Code": code,
        "Name": name,
        "OtherName": otherName,
        "RemitterTypeID": remitterTypeId,
        "exchangeID" : exchangeID,
        "Surname": surname,
        "BusinessName": businessName,
        "BirthCountry": birthCountry,
        "BirthCountryID": birthCountryId,
        "BirthCity": birthCity,
        "BirthProvince": birthProvince,
        "BirthDate": birthDate!.toIso8601String(),
        "Profession": profession,
        "Designation": designation,
        "Employer": employer,
        "Nationality": nationality,
        "NationalityCountryID": nationalityCountryId,
        "Sex": sex,
        "MaritualStatus": maritualStatus,
        "IncomeSourceID": incomeSourceId,
        "YearlyIncome": yearlyIncome,
        "HasTaxINPSNo": hasTaxInpsNo,
        "TaxINPSNo": taxInpsNo,
        "TaxRate": taxRate,
        "FiscalCode": fiscalCode,
        "FatherSurname": fatherSurname,
        "FatherName": fatherName,
        "MotherSurname": motherSurname,
        "MotherName": motherName,
        "Pep": pep,
        "RoadType": roadType,
        "Address1": address1,
        "Address2": address2,
        "CountryID": countryId,
        "CountryCode": countryCode,
        "CountryName": countryName,
        "ProvinceCode": provinceCode,
        "Province": province,
        "ZipCode": zipCode,
        "CapCode": capCode,
        "CityID": cityId,
        "CityCode": cityCode,
        "PhoneNo": phoneNo,
        "EmailAddress": emailAddress,
        "DocName": docName,
        "DocID": docId,
        "DocCode": docCode,
        "DocumentNo": documentNo,
        "DocIssueDate": docIssueDate != null ? docIssueDate!.toIso8601String() : null,
        "DocValidUpto": docValidUpto != null ?  docValidUpto!.toIso8601String() : null,
        "IssuingAuthority": issuingAuthority,
        "DocIssuePlaceIsCity": docIssuePlaceIsCity,
        "DocIssuePlace": docIssuePlace,
        "DocIssuePlaceID": docIssuePlaceId,
        "Status": status,
        "RenewalDate": renewalDate != null ? renewalDate!.toIso8601String() : null,
        "BehaviorClassID": behaviorClassId,
        "BehaviorClassValue": behaviorClassValue,
        "TpLinkID": tpLinkId,
        "TpLinkCode": tpLinkCode,
        "TpFiscalCode": tpFiscalCode,
        "SubGroupID": subGroupId,
        "SubGroupCode": subGroupCode,
        "SectorID": sectorId,
        "SectorCode": sectorCode,
        "SbSectorID": sbSectorId,
        "SBSectorCode": sbSectorCode,
    };
}