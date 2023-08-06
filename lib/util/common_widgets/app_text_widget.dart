import 'package:crypto_assignment/app/app_config.dart';
import 'package:crypto_assignment/util/colors.dart';
import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
   String? text;
   double? size;
   FontWeight? fontWeight;
   Color? color;
   double? wordSpacing;
   VoidCallback? onClick;

   AppTextWidget({
    @required this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.wordSpacing,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: onClick == null
          ? Text(
        text ?? "",
        style: TextStyle(
          fontSize: size ?? appConfig.defaultTextSize,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color ?? AppColors.black,
          wordSpacing: wordSpacing ?? appConfig.defaultWordspacing,
        ),
      )
          : TextButton(
        onPressed: () {
          onClick?.call();
        },
        child: Text(
          text ?? "",
          style: TextStyle(
            fontSize: size ?? appConfig.defaultTextSize,
            fontWeight: fontWeight ?? FontWeight.normal,
            color: color ?? AppColors.black,
            wordSpacing: wordSpacing ?? appConfig.defaultWordspacing,
          ),
        ),
      ),
    );
  }
}