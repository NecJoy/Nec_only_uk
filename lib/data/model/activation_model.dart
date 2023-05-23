// To parse this JSON data, do
//
//     final activationModel = activationModelFromJson(jsonString);

import 'dart:convert';

ActivationModel activationModelFromJson(String str) => ActivationModel.fromJson(json.decode(str));

String activationModelToJson(ActivationModel data) => json.encode(data.toJson());

class ActivationModel {
    ActivationModel({
        this.loginId,
        this.birthDate,
        this.authCode,
    });

    String? loginId;
    DateTime? birthDate;
    String? authCode;

    factory ActivationModel.fromJson(Map<String, dynamic> json) => ActivationModel(
        loginId: json["loginID"],
        birthDate: DateTime.parse(json["birthDate"]),
        authCode: json["authCode"],
    );

    Map<String, dynamic> toJson() => {
        "loginID": loginId,
        "birthDate": birthDate?.toIso8601String(),
        "authCode": authCode,
    };
}
