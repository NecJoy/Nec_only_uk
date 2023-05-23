// To parse this JSON data, do
//
//     final cancelTransactionModel = cancelTransactionModelFromJson(jsonString);

import 'dart:convert';

CancelTransactionModel cancelTransactionModelFromJson(String str) => CancelTransactionModel.fromJson(json.decode(str));

String cancelTransactionModelToJson(CancelTransactionModel data) => json.encode(data.toJson());

class CancelTransactionModel {
    CancelTransactionModel({
        this.itemId,
        this.cancelReason,
    });

    int? itemId;
    String? cancelReason;

    factory CancelTransactionModel.fromJson(Map<String, dynamic> json) => CancelTransactionModel(
        itemId: json["itemID"],
        cancelReason: json["cancelReason"],
    );

    Map<String, dynamic> toJson() => {
        "itemID": itemId,
        "cancelReason": cancelReason,
    };
}
