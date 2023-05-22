import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/player/getx_player_controller.dart';
import 'package:music_app/app/ui/pages/player_page/widgets/custom_slider.dart';
import '../../../config/widgets/background/custom_background.dart';
import '../../../config/widgets/text_base.dart';
import '../../../config/widgets/vector_asset.dart';
import '../../theme/colors.dart';
import 'widgets/bottom_sheet_appbar.dart';

class BottomSheetPlayer extends StatelessWidget {
  BottomSheetPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        body: Stack(
          children: [
            //const Positioned.fill(child: CustomBackground()),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BottomSheetAppbar(), //
                    SizedBox(height: 30.h),
                    const ArtImage(),
                    //SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        RepeatButton(),
                        Icon(Icons.add),
                        Icon(Icons.favorite_border_outlined,
                            ),
                        ShuffleButton(),
                        Icon(Icons.share, ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                     const CustomSlider(
                      callFrom: "bottomSheet",
                    ),
                    SizedBox(height: 20.h),
                    const ArtistAndSongName(),
                    SizedBox(height: 20.h),
                    //const Spacer(flex: 1),
                    // player controller buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        //const RepeatButton(),
                        // SizedBox(width: 10.r),
                        PreviousSongButton(),
                        // SizedBox(width: 10.r),
                        // const BackwordSongButton(),
                        // SizedBox(width: 10.r),
                        PlayButton(),
                        // SizedBox(width: 10.r),
                        // const ForwordSongButton(),
                        // SizedBox(width: 10.r),
                        NextSongButton(),
                        //SizedBox(width: 10.r),
                        //const ShuffleButton(),
                      ],
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArtImage extends GetView<GetXPlayerController> {
  const ArtImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Obx(
          () => Image.network(
            // "${Api.baseUrl}/${controller.latestRelease[index!].thumbnail128}",
            controller.currentSongArtNotifier.value,
            fit: BoxFit.fill,
            width: Get.width,
            height: Get.height / 3,
            // width: Get.width / 0.9,
          ),
        ),
      ),
    );
  }
}

class ArtistAndSongName extends GetView<GetXPlayerController> {
  const ArtistAndSongName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              TextBase(
              controller.currentSongTitleNotifier.value,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 3.r),
            TextBase(
              controller.currentSongArtistNotifier.value,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}

class RepeatButton extends GetView<GetXPlayerController> {
  const RepeatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Icon icon;
      switch (controller.repeatButtonNotifier.value) {
        case RepeatState.off:
          // icon = const Icon(Icons.repeat, color: Colors.white54);
          icon = const Icon(Icons.repeat,);
          break;
        case RepeatState.repeatSong:
          icon = const Icon(Icons.repeat_one,color: AppColor.orangeColor,);
          break;
        case RepeatState.repeatPlaylist:
          icon = const Icon(Icons.repeat);
          break;
      }
      return IconButton(
        icon: icon,
        onPressed: controller.repeat,
      );
    });
  }
}

class PreviousSongButton extends GetView<GetXPlayerController> {
  const PreviousSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: (controller.isFirstSongNotifier.value)
            ?
            // null
            controller.startFromEnd
            : controller.previous,
        child: VectorAsset(
          // icon: 'ic_backward',
          icon: 'ic_left',
          size: 20.r,
          color:
              // (controller.isFirstSongNotifier.value)
              //     ? Colors.white54
              //     :
              Colors.white,
        ),
      ),
    );
  }
}

class PlayButton extends GetView<GetXPlayerController> {
  final double? width;
  final double? height;
  final double? iconSize;
  const PlayButton({Key? key, this.height, this.width, this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.playButtonNotifier.value) {
        case ButtonState.loading:
          return Container(
            width: width??80.r,
            height:height?? 80.r,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColor.orangeColor,
                    AppColor.pinkColor,
                  ],
                ),
                // color: Colors.white24,
                ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white54,
                strokeWidth: 2,
              ),
            ),
          );
        case ButtonState.paused:
          return Container(
            width: width??80.r,
            height:height?? 80.r,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                // color: Colors.white24,
              gradient: LinearGradient(
                colors: [
                  AppColor.orangeColor,
                  AppColor.pinkColor,
                ],
              ),),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.play_arrow,
                ),
                iconSize: iconSize??40.0,
                onPressed: controller.play,
              ),
            ),
          );
        case ButtonState.playing:
          return Container(
            width:width?? 80.r,
            height:height?? 80.r,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColor.orangeColor,
                    AppColor.pinkColor,
                  ],
                )
                // color: Colors.white24,
                ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.pause,
                ),
                iconSize:iconSize?? 40.0,
                onPressed: controller.pause,
              ),
            ),
          );
        case ButtonState.idle:
          return Container(
            width:width?? 80.r,
            height:height??80.r,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColor.orangeColor,
                    AppColor.pinkColor,
                  ],
                )
                // color: Colors.white24,
                ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.pause,
                ),
                iconSize: iconSize??40.0,
                onPressed: controller.pause,
              ),
            ),
          );
      }
    });
  }
}

class NextSongButton extends GetView<GetXPlayerController> {
  const NextSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: (controller.isLastSongNotifier.value)
            ?
            // null
            controller.startFromStarting
            : controller.next,
        child: VectorAsset(
          // icon: 'ic_forward',
          icon: "ic_right",
          size: 20.r,
          color:
              // (controller.isLastSongNotifier.value)
              //     ? Colors.white54:
              Colors.white,
        ),
      ),
    );
  }
}

class ForwordSongButton extends GetView<GetXPlayerController> {
  const ForwordSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: (controller.playlistNotifier.isNotEmpty)
            ? controller.forwordSeek10Sec
            : null,
        child: const Icon(
          Icons.forward_10,
          color: Colors.white,
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

class ShuffleButton extends GetView<GetXPlayerController> {
  const ShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IconButton(
        icon: (controller.isShuffleModeEnabledNotifier.value)
            ? const Icon(Icons.shuffle, color: AppColor.orangeColor,)
            : const Icon(Icons.shuffle,),
        onPressed: controller.shuffle,
      ),
    );
  }
}
