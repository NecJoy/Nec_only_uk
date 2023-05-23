// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
    SignUpModel({
        this.loginId,
        this.name,
        this.surName,
        this.birthDate,
        this.email,
        this.mobileNo,
        this.callingCode,
        this.phoneNoFormat,
        this.hasClientId,
        this.clientId,
        this.password,
        this.confirmPassword,
        this.countryId,
        this.allowNotification,
    });

    String? loginId;
    String? name;
    String? surName;
    DateTime? birthDate;
    String? email;
    String? mobileNo;
    String? callingCode;
    String? phoneNoFormat;
    bool? hasClientId;
    String? clientId;
    String? password;
    String? confirmPassword;
    int? countryId;
    bool? allowNotification;

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        loginId: json["loginID"],
        name: json["name"],
        surName: json["surName"],
        birthDate: DateTime.parse(json["birthDate"]),
        email: json["email"],
        mobileNo: json["mobileNo"],
        callingCode: json["callingCode"],
        phoneNoFormat: json["phoneNoFormat"],
        hasClientId: json["hasClientID"],
        clientId: json["clientID"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
        countryId: json["countryID"],
        allowNotification: json["allowNotification"],
    );

    Map<String, dynamic> toJson() => {
        "loginID": loginId,
        "name": name,
        "surName": surName,
        "birthDate": birthDate!.toIso8601String(),
        "email": email,
        "mobileNo": mobileNo,
        "callingCode": callingCode,
        "phoneNoFormat": phoneNoFormat,
        "hasClientID": hasClientId,
        "clientID": clientId,
        "password": password,
        "confirmPassword": confirmPassword,
        "countryID": countryId,
        "allowNotification": allowNotification,
    };
}
