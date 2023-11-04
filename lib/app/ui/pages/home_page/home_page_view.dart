import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/config/dimensions.dart';
import 'package:music_app/app/player/getx_player_controller.dart';
import 'package:music_app/app/routes/app_pages.dart';
import 'package:music_app/app/services/api.dart';
import 'package:music_app/app/ui/pages/home_page/view_more_detail.dart';
import 'package:music_app/app/ui/theme/index.dart';
import '../../../../main.dart';
import '../../../config/widgets/small_text.dart';
import '../../../config/widgets/background/custom_background.dart';
import '../artist_page/artist_latest_page.dart';
import 'widgets/home_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: SafeArea(
        child: Scaffold(
          body: Obx(() {
            return Get.find<GetXPlayerController>().isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Column(
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
                              const TopStations(
                                title: "Top Stations",
                              ),
                              const TopArtists(),
                              const NewRelease(),

                              // SizedBox(height:70)
                              //   const FreshHits(),
                              //     const PlayList(),
                              //  const TopStations(title: "Fresh Hits",),
                              // SizedBox(height: 60.h)
                              Get.find<GetXPlayerController>()
                                      .isCloseNotifier
                                      .value
                                  ? SizedBox(height: 60.h)
                                  : SizedBox(
                                      height: 120.h,
                                    )
                            ],
                          ),
                        ),
                      ),
                      // const MiniPlayer(),
                    ],
                  );
          }),
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
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(
                  title: controller.playlists[index].name!,
                  onTap: () {
                    controller.playlistNotifier.clear();
                    navigatorKey.currentState?.push(
                      MaterialPageRoute(
                        builder: (context) => ViewMorePage(
                          slug: controller.playlists[index].slug,
                        ),
                      ),
                    );
                  }
                  // title: "New Release",
                  ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 160.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.playlists[index].value!.length,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, j) {
                      var list = controller.playlists[index].value;
                      List<dynamic> artistNames = list![j]
                          .artists!
                          .map((artist) => artist.name)
                          .toList();

                      return PlayerCard(
                        // image: "${list[j].thumbnail320}",
                        image: "${list[j].thumbnail320}",
                        musicName: list[j].name ?? "",
                        artistName: artistNames.join(','),
                        // artistName: "Artist Name",
                        onTap: () {
                          List<MediaItem> playlist = [];
                          debugPrint('tap new re');
                          print(list);
                          controller.printSongsName(list);

                          for (int i = 0; i < list.length; i++) {
                            playlist.add(
                              MediaItem(
                                id: list[i].id.toString(),
                                title: list[i].name!,
                                artist: artistNames.join(','),
                                artUri: Uri.parse("${list[i].thumbnail320}"),
                                //audioList[index].artUri,
                                extras: {
                                  'url': "${list[i].songFile}",
                                  'isFavourite': list[i].isFavourite,
                                },
                              ),
                            );
                          }

                          controller.clearPlaylist();
                          controller.add(
                            playlist,
                            j,
                          );
                          //   Get.toNamed(AppRoutes.bottomPlayer);
                        },
                      );
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
    this.onTap,
  }) : super(key: key);
  final String title;
  final String action;
  final bool showAction;
  final VoidCallback? onTap;

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
            GestureDetector(
              onTap: onTap,
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
        const HeaderSection(
          title: "Trending Playlists",
          showAction: false,
        ),
        SizedBox(
          height: 160.h,
          child: Obx(() {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: controller.trending.length,
                itemBuilder: (context, index) {
                  var list = controller.trending;
                  List<dynamic> artistNames = list[index]
                      .artists!
                      .map((artist) => artist.name)
                      .toList();
                  debugPrint("artist Name --->$artistNames");
                  return Obx(() {
                    return PlayerCard(
                      image: "${list[index].thumbnail320}",
                      musicName: list[index].name ?? "",
                      artistName: artistNames.join(','),
                      // artistName: "Artist Name",
                      onTap: () {
                        List<MediaItem> playlist = [];
                        debugPrint('tap trend');
                        controller.printSongsName(list);

                        for (int i = 0; i < list.length; i++) {
                          playlist.add(
                            MediaItem(
                              id: list[i].id.toString(),
                              title: list[i].name!,
                              artist: artistNames.join(', '),
                              artUri: Uri.parse("${list[i].thumbnail320}"),
                              //audioList[index].artUri,
                              extras: {
                                'url': "${list[i].songFile}",
                                'isFavourite': list[i].isFavourite,
                              },
                            ),
                          );
                        }

                        controller.clearPlaylist();
                        controller.add(
                          playlist,
                          index,
                        );

                        //  Get.toNamed(AppRoutes.bottomPlayer);
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

  const TopStations({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // SizedBox(height: 10.h),
        HeaderSection(title: title!, showAction: false),
        SizedBox(
          height: 160.h,
          child: Obx(() {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: controller.latestRelease.length,
                itemBuilder: (context, index) {
                  var list = controller.latestRelease;
                  debugPrint(
                      "index---->${controller.latestRelease.length - 1}");
                  List<dynamic> artistNames = list[index]
                      .artists!
                      .map((artist) => artist.name)
                      .toList();
                  return Obx(() {
                    return PlayerCard(
                      image: "${list[index].thumbnail320}",
                      musicName: list[index].name ?? "",
                      artistName: artistNames.join(','),
                      onTap: () {
                        List<MediaItem> playlist = [];
                        debugPrint('tap latest');
                        controller.printSongsName(list);
                        for (int i = 0; i < list.length; i++) {
                          debugPrint("isFavourite --->${list[i].isFavourite}");
                          playlist.add(
                            MediaItem(
                              id: list[i].id.toString(),
                              title: list[i].name!,
                              artist: artistNames.join(','),
                              artUri: Uri.parse("${list[i].thumbnail320}"),
                              //audioList[index].artUri,
                              extras: {
                                'url': "${list[i].songFile}",
                                'isFavourite': list[i].isFavourite,
                              },
                            ),
                          );
                        }
                        controller.clearPlaylist();
                        controller.add(
                          playlist,
                          index,
                        );
                        //   Get.toNamed(AppRoutes.bottomPlayer);
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
        const HeaderSection(
          title: "Top Artist Radio",
          showAction: false,
        ),
        Container(
          height: 120.h,
          alignment: Alignment.center,
          color: Colors.white10,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.featuredArtists.length,
              // itemCount: Artists.artistList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    controller.playlistNotifier.clear();
                    navigatorKey.currentState?.push(
                      MaterialPageRoute(
                        builder: (context) => ArtistsPage(
                          id: controller.featuredArtists[index].id,
                        ),
                      ),
                    );
                    // Get.toNamed(AppRoutes.artistPage,
                    //     arguments: controller.featuredArtists[index].id);
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
                            "${controller.featuredArtists[index].image}",
                            // Artists.artistList[index].imgUrl.toString(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 4.h),
                          child: SmallText(
                            text: controller.featuredArtists[index].name!,
                            overFlow: TextOverflow.ellipsis,
                            size: Dimensions.font12,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: EdgeInsets.only(left: 10.w),
                      //     child: SmallText(
                      //       // text: "7 songs",
                      //       text: 'Artist Radio',
                      //       size: Dimensions.font10,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}

// class FreshHits extends GetView<GetXPlayerController> {
//   const FreshHits({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const HeaderSection(
//           title: "Fresh Hits",
//         ),
//         SizedBox(
//           height: 160.h,
//           child: Obx(() {
//             return ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 itemCount: controller.playlistNotifier.length,
//                 itemBuilder: (context, index) {
//                   return Obx(() {
//                     return PlayerCard(
//                       image:
//                       controller.playlistNotifier[index].artUri.toString(),
//                       musicName: controller.playlistNotifier[index].title,
//                       artistName: "Artist Name",
//                       onTap: () => Get.toNamed(AppRoutes.bottomPlayer),
//                     );
//                   });
//                 });
//           }),
//         ),
//       ],
//     );
//   }
// }

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
  const PlayerCard({
    Key? key,
    required this.image,
    required this.musicName,
    required this.artistName,
    required this.onTap,
    // this.widget,
  }) : super(key: key);
  final String image;
  final String musicName;
  final String artistName;
  final VoidCallback onTap;

  // final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              child: SizedBox(
                width: 120.w,
                child: SmallText(
                  text: musicName,
                  size: Dimensions.font12,
                  overFlow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          // widget!
          // Flexible(
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 15.w, top: 4.h),
          //     child: ListView.builder(
          //       shrinkWrap: true,
          //         itemCount: itemCount,
          //         itemBuilder: (context, index){
          //       return SmallText(text: ,
          //         size: Dimensions.font12,
          //         color: Colors.white54,
          //       )
          //     })

          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 15.w, top: 0.h),
              child: SizedBox(
                width: 120.w,
                child: SmallText(
                  text: artistName,
                  size: Dimensions.font12,
                  color: Colors.white54,
                  overFlow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
