import 'package:flutter/material.dart';


class CustomOutlineButton extends StatelessWidget {
  final String buttonLevel;
  final Color color;
  final Color? borderColor;
  final VoidCallback onPressed;
  final Color? levelColor;
  final double width;
  const CustomOutlineButton({
    Key? key, 
    required this.buttonLevel, 
    required this.color,
     required this.onPressed, this.levelColor,  this.borderColor, required this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(width, 40),
        backgroundColor: color,
        side:borderColor != null ? BorderSide(
          color: borderColor!,
        ) : BorderSide(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
      ),
      child: Text(buttonLevel, style:Theme.of(context).textTheme.headlineSmall,),
    );
  }
}
