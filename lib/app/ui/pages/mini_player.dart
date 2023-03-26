import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/config/widgets/small_text.dart';

import '../../config/widgets/vector_asset.dart';
import '../../player/getx_player_controller.dart';
import '../../routes/app_pages.dart';
import 'player_page/widgets/custom_slider.dart';

class MiniPlayer extends GetView<GetXPlayerController> {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isCloseNotifier.value
          ? const SizedBox.shrink()
          : GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.bottomPlayer);
                // Get.bottomSheet(
                //   const BottomSheetPlayer(),
                //   backgroundColor: Colors.white,
                //   isScrollControlled: true,
                //   enterBottomSheetDuration: const Duration(milliseconds: 500),
                //   exitBottomSheetDuration: const Duration(milliseconds: 500),
                // );
              },
              child: Column(
                children: [
                  const MiniPlayerContainer(),
                  SizedBox(
                    height: 8.h,
                    child: const CustomSlider(),
                  ),
                  SizedBox(height: 60.h)
                ],
              ),
            );
    });
  }
}

class MiniPlayerContainer extends GetView<GetXPlayerController> {
  const MiniPlayerContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: Get.width,
        height: 70,
        alignment: Alignment.center,
        color: Colors.black38,
        child: Row(
          children: [
            const MiniArtImage(),
            const Expanded(
              child: MiniArtistAndSongName(),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.w),
              child: Row(
                children: [
                  // const MiniPreviousSongButton(),
                  const BackwordSongButton(),
                  SizedBox(width: 15.w),
                  const MiniPlayButton(),
                  SizedBox(width: 15.w),
                  controller.playButtonNotifier.value == ButtonState.paused
                      ? const MiniCloseSongButton()
                      : const MiniNextSongButton(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class MiniArtImage extends GetView<GetXPlayerController> {
  const MiniArtImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Obx(
            () => Image.network(
              controller.currentSongArtNotifier.value,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class MiniPlayButton extends GetView<GetXPlayerController> {
  const MiniPlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.playButtonNotifier.value) {
        case ButtonState.loading:
          return Container(
            width: 50.r,
            height: 50.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white24,
            ),
            child: const Center(
                child: CircularProgressIndicator(
              color: Colors.white54,
              strokeWidth: 2,
            )),
          );
        case ButtonState.paused:
          return Container(
            width: 50.r,
            height: 50.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white24,
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 30.h,
                onPressed: controller.play,
              ),
            ),
          );
        case ButtonState.playing:
          return Container(
            width: 50.r,
            height: 50.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white24,
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 26.h,
                onPressed: controller.pause,
              ),
            ),
          );
        case ButtonState.idle:
          return const MiniCloseSongButton();
      }
    });
  }
}

class MiniCloseSongButton extends GetView<GetXPlayerController> {
  const MiniCloseSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.isCloseNotifier.value = true;
        },
        child: Icon(
          Icons.close,
          color: (controller.isLastSongNotifier.value)
              ? Colors.white54
              : Colors.white,
          size: 26.h,
        ),
      ),
    );
  }
}

class MiniNextSongButton extends GetView<GetXPlayerController> {
  const MiniNextSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: (controller.isLastSongNotifier.value) ? null : controller.next,
        child: VectorAsset(
          icon: 'ic_forward',
          size: 26.r,
          color: (controller.isLastSongNotifier.value)
              ? Colors.white54
              : Colors.white,
        ),
      ),
    );
  }
}

class MiniArtistAndSongName extends GetView<GetXPlayerController> {
  const MiniArtistAndSongName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallText(
              text: controller.currentSongTitleNotifier.value,
              weight: FontWeight.bold,
            ),
            SizedBox(height: 3.r),
            SmallText(
              text: "artist name",
              weight: FontWeight.w500,
              size: 13.sp,
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}

/*-----------------------*/

class MiniPreviousSongButton extends GetView<GetXPlayerController> {
  const MiniPreviousSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap:
            (controller.isFirstSongNotifier.value) ? null : controller.previous,
        child: VectorAsset(
          icon: 'ic_backward',
          size: 26.r,
          color: (controller.isFirstSongNotifier.value)
              ? Colors.white54
              : Colors.white,
        ),
      ),
    );
  }
}

class BackwordSongButton extends GetView<GetXPlayerController> {
  const BackwordSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: (controller.playlistNotifier.isNotEmpty)
            ? controller.backwordSeek10Sec
            : null,
        child: Transform.scale(
          scaleX: -1,
          child: const Icon(
            Icons.forward_10_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
