import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../core/values/app_color.dart';

class DatePicked extends StatelessWidget {
  final String? level;
  final Function()? onTap;
  final Widget? date;
  const DatePicked({
    Key? key,
    this.level,
    this.onTap,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(child: Text(level!,style: Theme.of(context).textTheme.titleSmall)),
            SizedBox(height: 5),
            Container(
              width: Get.width/2.7,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide( color: AppColor.kSeagreyColor,width:2.5),
                ),
              ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icon/calendar.svg'),
                    SizedBox( width: 7),
                    Container(
                    height: 35,
                    width: 1.5,
                    color: AppColor.kSeagreyColor,
                    ),
                    SizedBox(width: 5),
                    Container(child: date!),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}


