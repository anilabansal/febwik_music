import 'package:flutter/material.dart';
import '../../ui/theme/colors.dart';
import '../dimensions.dart';

class SmallText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final double height;
  final int maxLine;
  final TextAlign textAlign;
  final TextOverflow overFlow;
  final TextDecoration textDecoration;
  final FontWeight weight;
  final bool? softWrap;
  const SmallText(
      {Key? key,
      this.color = AppColor.whiteTextColor,
      required this.text,
      this.size = 0,
      this.height = 1.2,
      this.maxLine = 1,
      this.weight = FontWeight.w500,
      this.textAlign = TextAlign.start,
      this.textDecoration = TextDecoration.none,
      this.overFlow = TextOverflow.ellipsis,
        this.softWrap=false,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontSize: size == 0 ? Dimensions.font20 : size,
          fontFamily: 'HindSiliguri',
          fontWeight: weight,
          decoration: textDecoration,
          height: height,),
      overflow: overFlow,
      softWrap: softWrap,
    );
  }
}
