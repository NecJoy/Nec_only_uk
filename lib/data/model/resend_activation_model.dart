// To parse this JSON data, do
//
//     final resendActivationModel = resendActivationModelFromJson(jsonString);

import 'dart:convert';

ResendActivationModel resendActivationModelFromJson(String str) => ResendActivationModel.fromJson(json.decode(str));

String resendActivationModelToJson(ResendActivationModel data) => json.encode(data.toJson());

class ResendActivationModel {
    ResendActivationModel({
        this.loginId,
        this.birthDate,
    });

    String? loginId;
    DateTime? birthDate;

    factory ResendActivationModel.fromJson(Map<String, dynamic> json) => ResendActivationModel(
        loginId: json["loginID"],
        birthDate: DateTime.parse(json["birthDate"]),
    );

    Map<String, dynamic> toJson() => {
        "loginID": loginId,
        "birthDate": birthDate?.toIso8601String(),
    };
}
