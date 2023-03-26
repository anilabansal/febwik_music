import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/app/ui/theme/colors.dart';
import 'package:music_app/app/ui/theme/fonts.dart';

// ignore: non_constant_identifier_names
Widget TextBase(
  String text, {
  double? fontSize,
  double? height,
  double leftPading = 0,
  double rightPading = 0,
  FontWeight fontWeight = FontWeight.normal,
  Color color = AppColor.whiteTextColor,
  TextAlign textAlign = TextAlign.left,
  TextDirection textDirection = TextDirection.ltr,
  int? maxLines,
  bool softWrap = true,
  TextOverflow overflow = TextOverflow.clip,
  TextDecoration decoration = TextDecoration.none,
}) {
  return Container(
    padding: EdgeInsets.only(left: leftPading,right: rightPading),
    child: Text(
      text,
      style: TextStyle(
          fontSize: fontSize ?? 16.sp,
          fontWeight: fontWeight,
          height: height,
          color: color,
          fontFamily: Fonts.Montserrat,
          decoration: decoration),
      textDirection: textDirection,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
    ),
  );
}
