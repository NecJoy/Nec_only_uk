import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'custom_button.dart';
import '../core/values/app_color.dart';

class DatePicker {
  static Future<dynamic> datePiker({
    BuildContext? context, 
    DateTime? initialDateTime,
    DateTime? minimumDate,
    DateTime? maximumDate,
    required int minimumYear,
    required int? maximumYear,
    required void Function(DateTime) onDateTimeChanged,
    required VoidCallback onPressed,
    }) {
    return showCupertinoModalPopup(
    barrierDismissible: false,
    context: context!,
    builder: (_) => Container(
      height: 260,
      color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 200,
            child: CupertinoDatePicker(
              minimumDate: maximumDate,
              maximumDate: maximumDate,
              mode: CupertinoDatePickerMode.date,
                minimumYear: minimumYear,
                dateOrder: DatePickerDateOrder.dmy,
                maximumYear: maximumYear,
                initialDateTime: initialDateTime,
                onDateTimeChanged: onDateTimeChanged,
            ),
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              CustomButton(
                borderRadius: 0.0,
                buttonLevel: 'done'.tr,
                onPressed: onPressed,
                color: AppColor.kPrimaryColor,
              ),
            ],
          ),
         ],
       ),
     ),
   );
  }
}


