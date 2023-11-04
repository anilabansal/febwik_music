import 'package:flutter/material.dart';
import '../../../config/widgets/small_text.dart';
import '../../theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/dimensions.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmallText(
          text: "Trending",
          textAlign: TextAlign.left,
          weight: FontWeight.w500,
          size: Dimensions.font16,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 400,
          child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                    minLeadingWidth: 0,
                    contentPadding: const EdgeInsets.only(
                      left: 5,
                    ),
                    title: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          /// song image
                          Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.orangeColor,
                                width: 3.w,
                              ),
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [
                                  AppColor.orangeColor,
                                  AppColor.pinkColor,
                                ],
                              ),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/image3.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallText(
                                  text: "Arjit Singh",
                                  overFlow: TextOverflow.ellipsis,
                                  size: Dimensions.font15,
                                  color: AppColor.whiteTextColor,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 238,
                                      child: SmallText(
                                        text: 'Artist',
                                        overFlow: TextOverflow.ellipsis,
                                        size: Dimensions.font12,
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const Icon(
                      Icons.more_vert,
                      size: 25,
                    ));
              }),
        )
      ],
    );
  }
}
