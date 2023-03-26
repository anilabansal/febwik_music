import 'package:flutter/material.dart';
import 'package:music_app/app/ui/theme/colors.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.darkColor,
        backgroundBlendMode: BlendMode.darken,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.clamp,
          stops: [0.0, 0.4,0.6, 1.0],
          colors: [
            Color.fromARGB(50, 13, 16, 21),
            Color.fromARGB(100, 244, 162, 125),
            Color.fromARGB(100, 244, 162, 125),
            Color.fromARGB(50, 13, 16, 21),
            // Color.fromARGB(100, 244, 162, 125),
          ],
        ),
      ),
      child: child,
      // child: Stack(
      //   children: [child],
      // ),
    );
  }
}
