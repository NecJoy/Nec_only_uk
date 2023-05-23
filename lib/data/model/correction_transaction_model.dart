// To parse this JSON data, do
//
//     final correctionTransactionModel = correctionTransactionModelFromJson(jsonString);

import 'dart:convert';

CorrectionTransactionModel correctionTransactionModelFromJson(String str) => CorrectionTransactionModel.fromJson(json.decode(str));

String correctionTransactionModelToJson(CorrectionTransactionModel data) => json.encode(data.toJson());

class CorrectionTransactionModel {
    CorrectionTransactionModel({
        this.itemId,
        this.correctionReason,
    });

    int? itemId;
    String? correctionReason;

    factory CorrectionTransactionModel.fromJson(Map<String, dynamic> json) => CorrectionTransactionModel(
        itemId: json["itemID"],
        correctionReason: json["correctionReason"],
    );

    Map<String, dynamic> toJson() => {
        "itemID": itemId,
        "correctionReason": correctionReason,
    };
}
