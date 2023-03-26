import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomSheetAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BottomSheetAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        color: Colors.transparent,
        margin: EdgeInsets.only(top: 0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotatedBox(
              quarterTurns: 1,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
