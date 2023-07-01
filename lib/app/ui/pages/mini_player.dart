import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/config/widgets/small_text.dart';
import '../../config/widgets/vector_asset.dart';
import '../../player/getx_player_controller.dart';
import '../../routes/app_pages.dart';
import '../theme/colors.dart';
import 'player_page/widgets/custom_slider.dart';


class MiniPlayer extends StatelessWidget {
  final String? callFrom;
  const MiniPlayer({Key? key,this.callFrom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetXPlayerController controller = Get.find();
    // Get.find<GetXPlayerController>().
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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8,),
         // padding:  EdgeInsets.only(bottom:  callFrom=="artistPage"?15:70.0),
          child: Container(
            //  margin: const EdgeInsets.only(bottom: 10),
            //   decoration:  BoxDecoration(
            //     borderRadius: const BorderRadius.only(
            //         topRight: Radius.circular(15),
            //         topLeft: Radius.circular(15)
            //     ),
            //   border: Border.all(color:AppColor.darkColor ),
            //    color: AppColor.darkColor,
            //     //color: Colors.green
            //   ),
            color: AppColor.searchBarGreyColor,
            //color: AppColor.darkColor,
            child: Column(
              children: [
                const MiniPlayerContainer(),
                SizedBox(
                  height: 0.h,
                  child: const CustomSlider(),
                ),
                // SizedBox(height: 55.h)
                SizedBox(height:0.h)
              ],
            ),
          ),
        ),
      );
    });
  }
}

// class MiniPlayer extends GetView<GetXPlayerController> {
//
//   const MiniPlayer({Key? key, }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return controller.isCloseNotifier.value
//           ? const SizedBox.shrink()
//           : GestureDetector(
//               onTap: () {
//                 Get.toNamed(AppRoutes.bottomPlayer);
//                 // Get.bottomSheet(
//                 //   const BottomSheetPlayer(),
//                 //   backgroundColor: Colors.white,
//                 //   isScrollControlled: true,
//                 //   enterBottomSheetDuration: const Duration(milliseconds: 500),
//                 //   exitBottomSheetDuration: const Duration(milliseconds: 500),
//                 // );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 70.0),
//                 child: Container(
//                 //  margin: const EdgeInsets.only(bottom: 10),
//                 //   decoration:  BoxDecoration(
//                 //     borderRadius: const BorderRadius.only(
//                 //         topRight: Radius.circular(15),
//                 //         topLeft: Radius.circular(15)
//                 //     ),
//                 //   border: Border.all(color:AppColor.darkColor ),
//                 //    color: AppColor.darkColor,
//                 //     //color: Colors.green
//                 //   ),
//                   color: AppColor.searchBarGreyColor,
//                   //color: AppColor.darkColor,
//                   child: Column(
//                     children: [
//                       const MiniPlayerContainer(),
//                       SizedBox(
//                         height: 0.h,
//                         child: const CustomSlider(),
//                       ),
//                    // SizedBox(height: 55.h)
//                       SizedBox(height: 0.h)
//                     ],
//                   ),
//                 ),
//               ),
//             );
//     });
//   }
// }




class MiniPlayerContainer extends GetView<GetXPlayerController> {
  const MiniPlayerContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: Get.width,
        // height: 55,
        height: 57,
        alignment: Alignment.center,

     //  color: Colors.black38,
        child: Row(
          children: [
            const MiniArtImage(),
            const Flexible(
              child:
              MiniArtistAndSongName(),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.w),
              child: Row(
                children: [
                  // const MiniPreviousSongButton(),
                  const LikeSongButton(),
                 // const BackwordSongButton(),
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
        child: ClipOval(
          // borderRadius: BorderRadius.circular(10.r),
          // borderRadius: BorderRadius.circular(20.r),
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
            // width: 50.r,
            // height: 50.r,
            width: 35.r,
            height: 35.r,
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
            ),),
          );
        case ButtonState.paused:
          return Container(
            width: 35.r,
            height: 35.r,
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
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.play_arrow),
                // iconSize: 30.h,
                // iconSize: 15.h,
                iconSize: 20.h,
                onPressed: controller.play,
              ),
            ),
          );
        case ButtonState.playing:
          return Container(
            // width: 50.r,
            // height: 50.r,
            width: 35.r,
            height: 35.r,
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
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.pause),
               iconSize: 20.h,
               //  iconSize: 15.h,
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
          controller.selectedSong.value="";
        },
        child: Icon(
          Icons.close,
          color: (controller.isLastSongNotifier.value)
              ? Colors.white54
              : Colors.white,
          size: 20.h,
          // size: 20.h,
          // size: 26.h,
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
        // onTap: (controller.isLastSongNotifier.value) ? null : controller.next,
        onTap: (controller.isLastSongNotifier.value)
            // ? null
            ? controller.startFromStarting
            : controller.next,
        child: VectorAsset(
          icon: 'ic_right',
          size: 20.r,

          // size: 26.r,
          // color: (controller.isLastSongNotifier.value)
          //     ? Colors.white54
          //     : Colors.white,
          color: Colors.white,
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
            SizedBox(
              width:180.h,
              child: SmallText(
                text: controller.currentSongTitleNotifier.value,
                //weight: FontWeight.bold,
                weight: FontWeight.bold,
                size: 18,
                overFlow: TextOverflow.ellipsis,
              ),
            ),
            //SizedBox(height: 3.r),
            SizedBox(
             width: 150.h,
              child: SmallText(
              //  text: "artist name",
                text: controller.currentSongArtistNotifier.value,
                weight: FontWeight.w500,
                size: 12.sp,
                color: Colors.white54,
                overFlow: TextOverflow.ellipsis,
              ),
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
        onTap: (controller.isFirstSongNotifier.value)
            ?
            // null
            controller.startFromEnd
            : controller.previous,
        child: VectorAsset(
          icon: 'ic_backward',
          size: 26.r,
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

class LikeSongButton extends GetView<GetXPlayerController> {
  const LikeSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return const Icon(Icons.favorite_border_outlined,color: Colors.white, size: 25,);
  }
}

// class BackwordSongButton extends GetView<GetXPlayerController> {
//   const BackwordSongButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => GestureDetector(
//         onTap: (controller.playlistNotifier.isNotEmpty)
//             ? controller.backwordSeek10Sec
//             : null,
//         child: Transform.scale(
//           scaleX: -1,
//           child: const Icon(
//             Icons.forward_10_outlined,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
