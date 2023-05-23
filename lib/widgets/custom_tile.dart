import 'package:flutter/material.dart';
import '../core/values/app_color.dart';
import 'package:get/get.dart';
class CustomTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String currency;
  final String trailing;
  const CustomTile({
    Key? key,  required this.title,  required this.subTitle,  required this.trailing, required this.currency
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: AppColor.kSecondaryColor,
                fontSize: 17,
                fontWeight: FontWeight.w500
               ),
              ),
             RichText(
              text:  TextSpan(
                children: <TextSpan>[
                   TextSpan(
                    text: subTitle,
                    style:  TextStyle(
                      color: AppColor.kBlackColor,
                      fontSize:  24,
                    ),
                   ),
                   TextSpan(text: "  "),
                   TextSpan(
                      text: currency,
                      style: TextStyle(
                        color: AppColor.kGreyColor,
                        fontSize: 14
                      )
                    ),
                  ],
                ),
              )
            ],
          ),
          Text(
            trailing.tr, style: TextStyle(
            color: AppColor.kGreyColor,
            fontSize: 17,
            fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}
