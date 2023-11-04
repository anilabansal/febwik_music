import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/dimensions.dart';
import '../../../config/widgets/small_text.dart';
import '../../theme/colors.dart';

class PopularSongs extends StatelessWidget {
  const PopularSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmallText(
          text: "Popular Songs",
          textAlign: TextAlign.left,
          weight: FontWeight.w500,
          size: Dimensions.font16,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 550,
          child: GridView(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              // crossAxisCount: 2,
              // mainAxisSpacing: 30,
              // crossAxisSpacing:8,

              crossAxisCount: 3,
              crossAxisSpacing: 0,
              mainAxisSpacing: 8,
              childAspectRatio: 1.3,
            ),
            shrinkWrap: true,
            children: List.generate(
              15,
              (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 110.h,
                      width: 120.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/image6.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SmallText(
                      text: "Arjit Singh",
                      overFlow: TextOverflow.ellipsis,
                      size: Dimensions.font15,
                      color: AppColor.whiteTextColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SmallText(
                      text: 'Artist',
                      overFlow: TextOverflow.ellipsis,
                      size: Dimensions.font12,
                      color: Colors.white54,
                    ),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
