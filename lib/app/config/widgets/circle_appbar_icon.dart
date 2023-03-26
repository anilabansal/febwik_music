import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/widgets/vector_asset.dart';

class CircleAppbarIcon extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  final double iconSize;
  final String heroTag;

  const CircleAppbarIcon({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.iconSize,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40.r,
          width: 40.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: Colors.white24,
          ),
          child: Center(
            child: VectorAsset(
              icon: icon,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}

class AppbarIcon extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  final double iconSize;
  final String heroTag;

  const AppbarIcon({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.iconSize,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40.r,
          width: 40.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Center(
            child: Image.asset(
              icon,
              height: iconSize,
              width: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
