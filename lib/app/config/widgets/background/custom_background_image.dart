import 'package:flutter/material.dart';
import 'package:music_app/app/ui/theme/colors.dart';

class CustomBackgroundImg extends StatelessWidget {
  const CustomBackgroundImg({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/loginbackground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
