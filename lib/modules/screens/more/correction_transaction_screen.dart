import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../core/values/app_color.dart';
import '../../../data/model/correction_transaction_model.dart';
import '../../../modules/controller/transaction_history_controller.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../core/utils/validator.dart';

class CorrectionTransaction extends StatelessWidget {
  CorrectionTransaction({Key? key}) : super(key: key);
  final TransactionHistoryController _transactionHistoryController = Get.put(TransactionHistoryController());
  @override
  Widget build(BuildContext context) {
    _transactionHistoryController.correctionReasonController.clear();
    final arguments = Get.arguments as int;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Apply TT Correction",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _transactionHistoryController.formKey,
            child: Column(
              children: [
                TextFormField(
                  minLines: 2,
                  maxLines: 5,
                  controller: _transactionHistoryController.correctionReasonController,
                  keyboardType: TextInputType.multiline,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                 validator: (value) => Validator.textAreaValidator(value :value , errorText:  "Correction Reason"),
                  decoration: InputDecoration(
                    hintText: 'Correction Reason',
                    hintStyle: TextStyle(
                      color: Colors.grey
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    CustomButton(
                      buttonLevel: "Submit",
                      color: AppColor.kPrimaryColor,
                      onPressed: () {
                        final correctionTransactionModel = CorrectionTransactionModel(
                          itemId: arguments,
                          correctionReason: _transactionHistoryController.correctionReasonController.value.text, 
                        );
                        if (_transactionHistoryController.formKey.currentState!.validate()) {
                            _transactionHistoryController.formKey.currentState!.save();
                          _transactionHistoryController.correctionTransaction(correctionTransactionModel);
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}