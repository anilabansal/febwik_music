import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/player/getx_player_controller.dart';
import '../../../../config/widgets/audio_video_progress_bar.dart';
import '../../../theme/colors.dart';

class CustomSlider extends GetView<GetXPlayerController> {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.fromLTRB(10,0,10,0),
        child: ProgressBar(
          progress: controller.progressNotifier.value.current,
          buffered: controller.progressNotifier.value.buffered,
          total: controller.progressNotifier.value.total,
          onSeek: controller.seek,
          barHeight: 3,
          barCapShape: BarCapShape.round,
          baseBarColor: Colors.white38,
          bufferedBarColor: Colors.white12,
          // progressBarColor: Colors.white,
          progressBarColor: AppColor.sliderColor,
          // thumbColor: Colors.white,
          thumbColor: AppColor.sliderColor,
          timeLabelTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
            color: Colors.white38,
          ),
          timeLabelPadding: 10.0,
          thumbRadius: 4,
          thumbGlowRadius: 10,
        ),
      ),
    );
  }
}
