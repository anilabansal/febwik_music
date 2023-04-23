// ignore_for_file: unrelated_type_equality_checks

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/config/dimensions.dart';
import 'package:music_app/app/models/artist.dart';
import 'package:music_app/app/player/getx_player_controller.dart';
import 'package:music_app/app/routes/app_pages.dart';
import 'package:music_app/app/services/api.dart';
import 'package:music_app/app/ui/theme/index.dart';
import '../../../config/widgets/small_text.dart';
import '../../../config/widgets/background/custom_background.dart';
import '../mini_player.dart';
import 'widgets/home_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: SafeArea(
        child: Scaffold(
          body: Obx(() {
            return    Get.put(GetXPlayerController()).isLoading.value?
                const CircularProgressIndicator():
              Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const HomeAppbar(),
                        const TrendingSongs(),
                        const TopStations(title: "Top Stations",),
                        const TopArtists(),
                        const NewRelease(),
                        //   const FreshHits(),
                        //     const PlayList(),
                        //  const TopStations(title: "Fresh Hits",),
                        SizedBox(height: 60.h)
                      ],
                    ),
                  ),
                ),
                const MiniPlayer(),
              ],
            );
          })

        ),
      ),
    );
  }
}

class NewRelease extends GetView<GetXPlayerController> {
  const NewRelease({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.playlists.length,
        itemBuilder: (context, index) {
          return  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HeaderSection(
                title: "New Release",
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 160.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                   shrinkWrap: true,
                    itemCount:controller.playlists[index].value!.length ,
                   // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, j) {
                      var list = controller.playlists[index].value;
                      // return Obx(() {
                        return PlayerCard(
                          image: "${Api.baseUrl}/${list![j].thumbnail128}",
                          musicName: list[j].name ?? "",
                          artistName: "Artist Name",
                          onTap: () {
                            List<MediaItem> playlist = [];
                            print('tap new re');
                            print(list);
                            controller.printSongsName(list);

                            for (int i = 0; i < list.length; i++) {
                              playlist.add(
                                MediaItem(
                                  id: list[i].id.toString(),
                                  title: list[i].name!,
                                  artUri: Uri.parse(
                                      "${Api.baseUrl}/${list[i].thumbnail128}"),
                                  //audioList[index].artUri,
                                  extras: {
                                    'url': "${Api.baseUrl}/${list[i].songFile}",
                                  },
                                ),
                              );
                            }

                            controller.clearPlaylist();
                            controller.add(playlist, j);
                            Get.toNamed(AppRoutes.bottomPlayer);
                          },
                        );
                      // });
                    }),
              ),
            ],
          );

        });
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    Key? key,
    required this.title,
    this.action = "View All",
    this.showAction = true,
  }) : super(key: key);
  final String title;
  final String action;
  final bool showAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Dimensions.height10,
          left: Dimensions.width10,
          right: Dimensions.width10,
          bottom: Dimensions.height15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmallText(
            text: title,
            textAlign: TextAlign.left,
            weight: FontWeight.w500,
            size: Dimensions.font16,
          ),
          if (showAction)
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  gradient: const LinearGradient(
                    colors: [
                      AppColor.orangeColor,
                      AppColor.pinkColor,
                    ],
                  ),
                ),
                child: SmallText(
                  text: "See More",
                  textAlign: TextAlign.center,
                  color: AppColor.blackTextColor,
                  weight: FontWeight.bold,
                  size: Dimensions.font12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TrendingSongs extends GetView<GetXPlayerController> {
  const TrendingSongs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10.h),
        const HeaderSection(title: "Trending Playlists"),
        SizedBox(
          height: 160.h,
          child: Obx(() {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: controller.latestRelease.length,
                itemBuilder: (context, index) {
                  var list = controller.latestRelease;
                  print("index---->${controller.latestRelease.length - 1}");
                  return Obx(() {
                    return PlayerCard(
                      image: "${Api.baseUrl}/${list[index].thumbnail128}",
                      musicName: list[index].name ?? "",
                      artistName: "Artist Name",
                      onTap: () {
                        List<MediaItem> playlist = [];
                        print('tap trend');
                        controller.printSongsName(list);
                        for (int i = 0; i < list.length; i++) {
                          playlist.add(
                            MediaItem(
                              id: list[i].id.toString(),
                              title: list[i].name!,
                              artUri: Uri.parse(
                                  "${Api.baseUrl}/${list[i].thumbnail128}"),
                              //audioList[index].artUri,
                              extras: {
                                'url': "${Api.baseUrl}/${list[i].songFile}",
                              },
                            ),
                          );
                        }
                        // for (int j = 0; j<index; j++) {
                        //   playlist.add(MediaItem(
                        //     id: list[j].id.toString(),
                        //     title: list[j].name!,
                        //     artUri:Uri.parse("${Api.baseUrl}/${list[j].thumbnail128}"),
                        //     //audioList[index].artUri,
                        //     extras: {
                        //       'url':  "${Api.baseUrl}/${list[j].songFile}",
                        //     },
                        //   ),);
                        // }

                        controller.clearPlaylist();
                        controller.add(playlist, index,);
                        Get.toNamed(AppRoutes.bottomPlayer);
                      },
                    );
                  });
                });
          }),
        ),
      ],
    );
  }
}

class TopStations extends GetView<GetXPlayerController> {
  final String? title;
  const TopStations({Key? key,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10.h),
         HeaderSection(title: title!),
        SizedBox(
          height: 160.h,
          child: Obx(() {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: controller.latestRelease.length,
                itemBuilder: (context, index) {
                  var list = controller.latestRelease;
                  print("index---->${controller.latestRelease.length - 1}");
                  return Obx(() {
                    return PlayerCard(
                      image: "${Api.baseUrl}/${list[index].thumbnail128}",
                      musicName: list[index].name ?? "",
                      artistName: "Artist Name",
                      onTap: () {
                        List<MediaItem> playlist = [];
                        print('tap latest');
                        controller.printSongsName(list);
                        for (int i = 0; i < list.length; i++) {
                          playlist.add(
                            MediaItem(
                              id: list[i].id.toString(),
                              title: list[i].name!,
                              artUri: Uri.parse(
                                  "${Api.baseUrl}/${list[i].thumbnail128}"),
                              //audioList[index].artUri,
                              extras: {
                                'url': "${Api.baseUrl}/${list[i].songFile}",
                              },
                            ),
                          );
                        }
                        // for (int j = 0; j<index; j++) {
                        //   playlist.add(MediaItem(
                        //     id: list[j].id.toString(),
                        //     title: list[j].name!,
                        //     artUri:Uri.parse("${Api.baseUrl}/${list[j].thumbnail128}"),
                        //     //audioList[index].artUri,
                        //     extras: {
                        //       'url':  "${Api.baseUrl}/${list[j].songFile}",
                        //     },
                        //   ),);
                        // }

                        controller.clearPlaylist();
                        controller.add(playlist, index,);
                        Get.toNamed(AppRoutes.bottomPlayer);
                      },
                    );
                  });
                });
          }),
        ),
      ],
    );
  }
}

class TopArtists extends GetView<GetXPlayerController> {
  const TopArtists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderSection(title: "Top Artist Radio"),
        Container(
          height: 140.h,
          alignment: Alignment.center,
          color: Colors.white10,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Artists.artistList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.artistPage, arguments: index);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.w,
                        margin: EdgeInsets.only(left: 5.w, top: 10.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.orangeColor, width: 3.w),
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              AppColor.orangeColor,
                              AppColor.pinkColor,
                            ],
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            Artists.artistList[index].imgUrl.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 4.h),
                          child: SmallText(
                            text: Artists.artistList[index].title ?? "",
                            size: Dimensions.font12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: SmallText(
                           // text: "7 songs",
                            text: 'Artist Radio',
                            size: Dimensions.font10,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class FreshHits extends GetView<GetXPlayerController> {
  const FreshHits({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderSection(
          title: "Fresh Hits",
        ),
        SizedBox(
          height: 160.h,
          child: Obx(() {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: controller.playlistNotifier.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return PlayerCard(
                      image:
                          controller.playlistNotifier[index].artUri.toString(),
                      musicName: controller.playlistNotifier[index].title,
                      artistName: "Artist Name",
                      onTap: () => Get.toNamed(AppRoutes.bottomPlayer),
                    );
                  });
                });
          }),
        ),
      ],
    );
  }
}

class PlayList extends GetView<GetXPlayerController> {
  const PlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderSection(title: "Playlist", showAction: false),
        SizedBox(
          height: 160.h,
          child: Obx(() {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: controller.playlists.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return PlayerCard(
                      image:
                          "http://65.2.183.74/storage/7/conversions/62541b21309a5_20210110_121942_0000-mediumthumb.jpg",
                      musicName: controller.playlists[index].name ?? "",
                      artistName: "Artist Name",
                      onTap: () => Get.toNamed(AppRoutes.bottomPlayer),
                    );
                  });
                });
          }),
        ),
      ],
    );
  }
}

class PlayerCard extends StatelessWidget {
  const PlayerCard(
      {Key? key,
      required this.image,
      required this.musicName,
      required this.artistName,
      required this.onTap})
      : super(key: key);
  final String image;
  final String musicName;
  final String artistName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110.h,
            width: 120.w,
            margin: EdgeInsets.only(left: 10.w, right: 5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(style: BorderStyle.none),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  image,
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 15.w, top: 4.h),
              child: SmallText(
                text: musicName,
                size: Dimensions.font12,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 15.w, top: 4.h),
              child: SmallText(
                text: artistName,
                size: Dimensions.font10,
                color: Colors.white54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// InkWell(
//                 onTap: () => controller.play,
//                 child: MusicListItem(
//                   image: controller.playlistNotifier[index].artUri.toString(),
//                   musicName: controller.playlistNotifier[index].title,
//                   artistName: 'artist name',
//                   onTap: () => Get.toNamed(AppRoutes.bottomPlayer),
//                   onTapPause: controller.playlistNotifier[index].title ==
//                           controller.currentSongTitleNotifier.toString()
//                       ? controller.playButtonNotifier == ButtonState.playing
//                           ? controller.pause
//                           : controller.play
//                       : () {},
//                   isCurrent: controller.playlistNotifier[index].title ==
//                           controller.currentSongTitleNotifier.toString()
//                       ? true
//                       : false,
//                   isPlaying:
//                       controller.playButtonNotifier == ButtonState.playing
//                           ? true
//                           : false,
//                 ),
//               ),
