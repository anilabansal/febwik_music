import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/app/config/dimensions.dart';
import 'package:music_app/app/ui/theme/index.dart';

import '../../../../config/widgets/circle_appbar_icon.dart';
import '../../../../config/widgets/small_text.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: preferredSize.height/1.8,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10.w),
                child: AppbarIcon(
                  onTap: () {
                    debugPrint('TODO');
                  },
                  icon: 'assets/icon/notification.png',
                  heroTag: 'notification_icon',
                  iconSize: 20.r,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: Dimensions.height5,horizontal: Dimensions.width10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  border: Border.all(color: AppColor.whiteColor),
                ),
                child: SmallText(
                  text: "Music",
                  color: AppColor.whiteTextColor,
                  size: Dimensions.font16,
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10.w),
                child: AppbarIcon(
                  onTap: () {
                    debugPrint('TODO');
                  },
                  icon: 'assets/icon/setting.png',
                  heroTag: 'setting_icon',
                  iconSize: 20.r,
                ),
              ),
            ],
          )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
