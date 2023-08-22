import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/app/player/getx_player_controller.dart';
import 'package:music_app/app/ui/pages/profile/play_list_songs.dart';

import '../../../config/widgets/small_text.dart';
import '../../theme/colors.dart';

class MyPlayList extends StatefulWidget {
  final String? songId;
  final bool? isBackIconVisible;
  final String? callFrom;

  const MyPlayList(
      {super.key, this.songId, this.isBackIconVisible, this.callFrom});

  @override
  State<MyPlayList> createState() => _MyPlayListState();
}

class _MyPlayListState extends State<MyPlayList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<GetXPlayerController>().getPlayListApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Get.find<GetXPlayerController>().isPlayListLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColor.whiteColor,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Visibility(
                        visible: widget.isBackIconVisible ?? false,
                        child: GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const SmallText(
                        text: "MY PLAYLIST",
                        weight: FontWeight.w500,
                        color: AppColor.whiteColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: Get.find<GetXPlayerController>()
                          .createdPlayList
                          .length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (widget.callFrom == "profile") {
                                    print(
                                        "song slug ${Get.find<GetXPlayerController>().createdPlayList[index].name}");
                                    Get.to(
                                      () => PlayListSongs(
                                        playListName:
                                            Get.find<GetXPlayerController>()
                                                .createdPlayList[index]
                                                .slug,
                                      ),
                                    );
                                  } else {
                                    await Get.find<GetXPlayerController>()
                                        .addToPlaylist({
                                      "playlist_id":
                                          Get.find<GetXPlayerController>()
                                              .createdPlayList[index]
                                              .id
                                              .toString(),
                                      "song_id": widget.songId
                                    });
                                  }
                                },
                                child: SmallText(
                                  text: Get.find<GetXPlayerController>()
                                      .createdPlayList[index]
                                      .name
                                      .toString(),
                                  color: AppColor.whiteColor,
                                  size: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            );
    });
  }
}
