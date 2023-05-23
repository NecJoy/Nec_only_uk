import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:necmoney/core/values/app_color.dart';
import 'package:sizer/sizer.dart';

class CustomListTileButton extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? subTitle;
  final  Function()? onTap;

  const CustomListTileButton({
    Key? key,
    this.icon,
    this.title,
    this.onTap,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  ListTile(
        onTap: onTap,
        leading: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.5,color: AppColor.kGreenColor),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SvgPicture.asset(icon!,width: 3.w ,height:3.h,),
            ),
        ),
        title: Text(
          title!,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        subtitle: subTitle != null? Text(
          subTitle!,
          style: Theme.of(context).textTheme.bodySmall,
        ): null,
        trailing: Icon(
          Icons.arrow_forward_ios,color: AppColor.kPrimaryColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
   
  }
}
