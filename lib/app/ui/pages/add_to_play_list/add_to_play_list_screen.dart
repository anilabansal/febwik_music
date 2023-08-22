import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/app/config/widgets/background/custom_background.dart';
import 'package:music_app/app/ui/pages/add_to_play_list/create_play_list_screen.dart';
import 'package:music_app/app/ui/pages/add_to_play_list/my_playlist.dart';
import 'package:music_app/app/ui/theme/colors.dart';
import '../../../config/dimensions.dart';
import '../../../config/widgets/small_text.dart';

class AddToPlayListScreen extends StatelessWidget {
  final String? imagePath;
  final String? songName;
  final String? artistName;
  final String? songId;

  const AddToPlayListScreen(
      {super.key, this.imagePath, this.songName, this.artistName, this.songId});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: SafeArea(
        child: Scaffold(
          body:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            text: "Add to Playlist",
                            size: Dimensions.font14,
                            overFlow: TextOverflow.ellipsis,
                            color: AppColor.whiteColor,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(imagePath!),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SmallText(
                        text: songName!,
                        weight: FontWeight.w500,
                        size: Dimensions.font14,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SmallText(
                        text: artistName!,
                        weight: FontWeight.w500,
                        size: Dimensions.font14,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                        () => CreatePlayListScreen(
                      songId: songId,
                    ),
                  );
                },
                child: Container(
                  // height:  50,
                  width: MediaQuery.sizeOf(context).width,
                  color: AppColor.searchBarGreyColor,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColor.whiteColor,
                        ),
                        SmallText(
                          text: "Create Playlist",
                          weight: FontWeight.w500,
                          color: AppColor.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: MyPlayList(
                  songId: songId,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
