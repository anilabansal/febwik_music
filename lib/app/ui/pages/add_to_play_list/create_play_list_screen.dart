// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/config/dimensions.dart';
import 'package:music_app/app/player/getx_player_controller.dart';
import 'package:music_app/app/ui/theme/colors.dart';
import '../../../config/widgets/background/custom_background.dart';
import '../../../config/widgets/small_text.dart';

class CreatePlayListScreen extends StatelessWidget {
  final String? songId;

  CreatePlayListScreen({super.key, this.songId});

  var playListController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: SafeArea(
        child: Scaffold(body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Center(
                      child: SmallText(
                        text: "Playlists",
                        size: Dimensions.font14,
                        overFlow: TextOverflow.ellipsis,
                        color: AppColor.whiteColor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SmallText(
                  text: "Great!",
                  size: Dimensions.font18,
                  color: Colors.white54,
                  textAlign: TextAlign.center,
                  overFlow: TextOverflow.visible,
                  softWrap: true,
                ),
                SmallText(
                  text: "Take first step to create your playlist",
                  size: Dimensions.font18,
                  color: Colors.white54,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
                  child: Center(
                    child: TextFormField(
                      controller: playListController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.red,
                        ),
                        errorText:
                            Get.find<GetXPlayerController>().textError.value ==
                                    true
                                ? "Please Name Playlist"
                                : null,
                        hintText: "Name Your Playlist",
                        hintStyle: const TextStyle(
                            color:  AppColor.whiteColor),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.whiteColor),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.whiteColor),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () async {
                    if (playListController.text.trim().isEmpty) {
                      Get.find<GetXPlayerController>().textError.value = true;
                      print('form is invalid');
                      // use the email provided here
                    } else {
                      await Get.find<GetXPlayerController>().addToPlaylist({
                        "playlist_name": playListController.text.trim(),
                        "song_id": songId
                      });
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 50.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [
                          AppColor.orangeColor,
                          AppColor.pinkColor,
                        ],
                      ),
                    ),
                    child: SmallText(
                      text: "Done",
                      size: Dimensions.font18,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          );
        })),
      ),
    );
  }
}
