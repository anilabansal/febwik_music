import 'package:flutter/material.dart';
import 'package:music_app/app/config/widgets/small_text.dart';
import '../../ui/theme/colors.dart';
import '../dimensions.dart';

showPopupMenu(context) {
  return PopupMenuButton(
      child: Container(
        height: 25,
        width: 25,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.more_vert,
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        side: BorderSide(
          color: AppColor.orangeColor,
        ),
      ),
      // icon: const Icon(
      //   Icons.more_vert,
      //   color: AppColor.whiteColor,
      //   size: 25,
      // ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Row(
              children: [
                const Icon(
                  Icons.music_note,
                  color: AppColor.orangeColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                SmallText(
                  text: "Add Playlist",
                  textAlign: TextAlign.center,
                  color: AppColor.whiteColor,
                  weight: FontWeight.bold,
                  size: Dimensions.font12,
                )
              ],
            ),
            value: '1',
          ),
          PopupMenuItem(
              child: Row(
                children: [
                  const Icon(
                    Icons.remove_circle_outline,
                    color: AppColor.orangeColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SmallText(
                    text: "Remove Playlist",
                    textAlign: TextAlign.center,
                    color: AppColor.whiteColor,
                    weight: FontWeight.bold,
                    size: Dimensions.font12,
                  )
                ],
              ),
              value: '2'),
          PopupMenuItem<String>(
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: AppColor.orangeColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SmallText(
                    text: "Like",
                    textAlign: TextAlign.center,
                    color: AppColor.whiteColor,
                    weight: FontWeight.bold,
                    size: Dimensions.font12,
                  )
                ],
              ),
              value: '3'),
          PopupMenuItem<String>(
              child: Row(
                children: [
                  const Icon(
                    Icons.share,
                    color: AppColor.orangeColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SmallText(
                    text: "Share",
                    textAlign: TextAlign.center,
                    color: AppColor.whiteColor,
                    weight: FontWeight.bold,
                    size: Dimensions.font12,
                  )
                ],
              ),
              value: '4'),
        ];
      });
}
