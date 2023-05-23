
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/values/app_color.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final double height;
  final String? title;
  final Color? backgroundColor;
  final Color? iconColor;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool? automaticallyImplyLeading;
  CustomAppBar({
    this.title,
    this.height = kToolbarHeight,
    this.backgroundColor,
    this.iconColor,
    this.leading,
    this.actions,
    this.centerTitle,
    this.automaticallyImplyLeading
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      elevation: 0,
      centerTitle: centerTitle ?? false,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      backgroundColor: backgroundColor ?? AppColor.kPrimaryColor,
      leading: leading ?? IconButton(
        onPressed: (){
          Get.back();
        }, 
        icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back, color: iconColor ?? AppColor.kWhiteColor),
      ),
      title: title != null ? Text(title!, style: Theme.of(context).textTheme.displayMedium,) : null,
      actions: actions,
    );
  }
}