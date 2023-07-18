import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/app/config/widgets/background/custom_background.dart';

import '../../config/widgets/text_base.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: TextBase("Coming Soon",
                    fontWeight: FontWeight.w700,
                    fontSize: 25.sp,
                    color: Colors.white,
                    textAlign: TextAlign.center),
              ),),
        ),
      ),
    );
  }
}
