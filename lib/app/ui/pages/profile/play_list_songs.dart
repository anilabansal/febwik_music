import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/config/dimensions.dart';
import 'package:music_app/app/config/widgets/background/custom_background.dart';
import 'package:music_app/app/config/widgets/common_like_button.dart';
import 'package:music_app/app/config/widgets/small_text.dart';
import 'package:music_app/app/config/widgets/vector_asset.dart';
import 'package:music_app/app/services/api.dart';
import 'package:music_app/app/ui/pages/mini_player.dart';
import 'package:music_app/app/ui/theme/colors.dart';
import '../../../config/widgets/show_custom_dailog.dart';
import '../../../controllers/profile_controller/profile_controller.dart';
import '../../../player/getx_player_controller.dart';
import '../home_page/bottom_sheet_player.dart';

class PlayListSongs extends StatefulWidget {
  final String? playListName;

  const PlayListSongs({super.key, this.playListName});

  @override
  State<PlayListSongs> createState() => _PlayListSongsState();
}

class _PlayListSongsState extends State<PlayListSongs> {
  late ScrollController _scrollController;
  int page = 1;
  double height = 357.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<ProfileController>().playListSongApiCall(widget.playListName);
    _scrollController = ScrollController()
      ..addListener(() {
          pagination();
      });

  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (420 - kToolbarHeight);
  }

  pagination() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("reach end");
      // Get.find<GetXPlayerController>().moreArtistSongLoad.value = true;
      page += 1;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.find<GetXPlayerController>().clearPlaylist();
    Get.find<GetXPlayerController>().playlistNotifier.clear();
    Get.find<ProfileController>().playListSongs.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(() {
        return CustomBackground(
          child: Get.find<ProfileController>().isPlayListSongLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Get.find<ProfileController>().playListSongs.isEmpty
                  ? SafeArea(
                      child: Center(
                        child: SmallText(
                          text: "No Data Found!",
                          size: Dimensions.font16,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Column(
                    children: [
                      Expanded(
                        child: Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: CustomScrollView(
                                      shrinkWrap: true,
                                      controller: _scrollController,
                                      slivers: <Widget>[
                                        ///Todo: app bar

                                        SliverAppBar(
                                          pinned: true,
                                          floating: false,
                                          expandedHeight: height,
                                          backgroundColor: _isSliverAppBarExpanded
                                              ? AppColor.searchBarGreyColor
                                              : Colors.transparent,
                                          leading: GestureDetector(
                                            onTap: () {

                                             Navigator.pop(context);
                                            },
                                            child: const Icon(
                                              Icons.arrow_back,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                          flexibleSpace: FlexibleSpaceBar(
                                            collapseMode: CollapseMode.parallax,
                                            title: _isSliverAppBarExpanded
                                                ? SmallText(
                                                    text: "Playlist Songs",
                                                    overFlow: TextOverflow.ellipsis,
                                                    size: Dimensions.font12,
                                                    color: Colors.white,
                                                  )
                                                : null,
                                            background:

                                                ///TODO: artist image
                                                Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 80.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(20),
                                                        // color: Color(0xff3b2e28),
                                                        color: AppColor
                                                            .searchBarGreyColor,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.fromLTRB(
                                                          15,
                                                          5,
                                                          0,
                                                          5,
                                                        ),
                                                        child: TextFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                            suffixIcon: Icon(
                                                              Icons.search,
                                                              color:
                                                                  AppColor.whiteColor,
                                                            ),
                                                            border: InputBorder.none,
                                                            hintText:
                                                                "Search in Playlist",
                                                            hintStyle: TextStyle(
                                                              fontSize: 15,
                                                              //    fontWeight: FontWeight.w400,
                                                              //
                                                              // -+fontFamily: interFont,
                                                              color:
                                                                  AppColor.whiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            60, 8, 60, 0),
                                                    child: Image.network(
                                                      "${Api.baseUrl}/${Get.find<ProfileController>().playListSongs[0].thumbnail320}",
                                                      // width: MediaQuery.of(context)
                                                      //     .size
                                                      //     .width,
                                                      fit: BoxFit.fill,
                                                      height: 250,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            stretchModes: const [
                                              StretchMode.zoomBackground
                                            ],
                                          ),
                                        ),

                                        ///Todo: silver list

                                        SliverList(
                                          delegate: SliverChildListDelegate([
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                15.0,
                                                20,
                                                15.0,
                                                0,
                                              ),
                                              child: SmallText(
                                                text: "",
                                                overFlow: TextOverflow.ellipsis,
                                                size: Dimensions.font12,
                                                color: Colors.white,
                                              ),
                                            ),

                                            ///Todo: row of icons
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  15.0, 0, 15.0, 0),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.favorite_outline,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  VectorAsset(
                                                    icon: "ic_download",
                                                    size: 22.r,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  VectorAsset(
                                                    icon: "ic_AZ",
                                                    size: 25.r,
                                                    color: Colors.white,
                                                  ),
                                                  const Spacer(),
                                                  const Icon(
                                                    Icons.shuffle,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),

                                                  ///Todo: play songs button
                                                  songPlay()
                                                ],
                                              ),
                                            ),

                                            ///Todo: list of songs
                                            ListView.builder(
                                                padding: EdgeInsets.zero,
                                                itemCount:
                                                    Get.find<ProfileController>()
                                                        .playListSongs
                                                        .length,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  var list =
                                                      Get.find<ProfileController>()
                                                          .playListSongs;
                                                  List<dynamic> artistNames =
                                                      list[index]
                                                          .artists!
                                                          .map(
                                                              (artist) => artist.name)
                                                          .toList();
                                                  return GestureDetector(
                                                    onTap: () {
                                                      print("123456");
                                                      Get.find<GetXPlayerController>()
                                                          .selectedSong
                                                          .value = list[index].name!;
                                                      List<MediaItem> playlist = [];
                                                      for (int i = 0;
                                                          i < list.length;
                                                          i++) {
                                                        print(
                                                            "artist isLike ${list[i].isFavourite}");
                                                        playlist.add(
                                                          MediaItem(
                                                            id: list[i].id.toString(),
                                                            title: list[i].name!,
                                                            artist:
                                                                artistNames.join(','),
                                                            artUri: Uri.parse(
                                                                "${Api.baseUrl}/${list[i].thumbnail320}"),
                                                            //audioList[index].artUri,
                                                            extras: {
                                                              'url':
                                                                  "${Api.baseUrl}/${list[i].songFile}",
                                                              'isFavourite':
                                                                  list[i].isFavourite,
                                                            },
                                                          ),
                                                        );
                                                        Get.find<
                                                                GetXPlayerController>()
                                                            .clearPlaylist();
                                                        Get.find<
                                                                GetXPlayerController>()
                                                            .add(
                                                          playlist,
                                                          index,
                                                        );
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(8.0),
                                                      child: ListTile(
                                                        minLeadingWidth: 0,
                                                        contentPadding:
                                                            const EdgeInsets.only(
                                                          left: 5,
                                                        ),
                                                        title: Row(
                                                          children: [
                                                            Container(
                                                              height: 50.h,
                                                              width: 50.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                  color: AppColor
                                                                      .orangeColor,
                                                                  width: 3.w,
                                                                ),
                                                                shape:
                                                                    BoxShape.circle,
                                                                gradient:
                                                                    const LinearGradient(
                                                                  colors: [
                                                                    AppColor
                                                                        .orangeColor,
                                                                    AppColor
                                                                        .pinkColor,
                                                                  ],
                                                                ),
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                    "${Api.baseUrl}/${list[index].thumbnail128}",
                                                                  ),
                                                                  fit: BoxFit.fill,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    // width: 250,

                                                                    // width: MediaQuery.of(context).size.width-150,
                                                                    child: SmallText(
                                                                      text: list[index]
                                                                              .name ??
                                                                          "",
                                                                      overFlow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      size: Dimensions
                                                                          .font15,
                                                                      color: Get.find<GetXPlayerController>()
                                                                                  .selectedSong
                                                                                  .value ==
                                                                              list[index]
                                                                                  .name
                                                                          ? AppColor
                                                                              .orangeColor
                                                                          : AppColor
                                                                              .whiteTextColor,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 238,
                                                                    child: SmallText(
                                                                      text: artistNames
                                                                          .join(','),
                                                                      overFlow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      size: Dimensions
                                                                          .font12,
                                                                      color: Colors
                                                                          .white54,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: GetBuilder<
                                                                ProfileController>(
                                                            builder:
                                                                (profileController) {
                                                          return GetBuilder<
                                                                  GetXPlayerController>(
                                                              builder: (controller) {
                                                            return Wrap(
                                                              children: [
                                                                ///TODO: like button
                                                                commonLikeButton(
                                                                    onTap: () {
                                                                      ///Todo: like of songs update method call
                                                                      profileController
                                                                          .updateViewMoreLikeUnlikeSongs(
                                                                              index);
                                                                      controller
                                                                          .updateMediaItemLikeSong();

                                                                      ///Todo: like unlike api call
                                                                      controller
                                                                          .likeUnlikeSongsApiCall(
                                                                        {
                                                                          "song_id": Get.find<
                                                                                  ProfileController>()
                                                                              .playListSongs[
                                                                                  index]
                                                                              .id
                                                                        },
                                                                      );
                                                                    },
                                                                    isSelected: (Get.find<
                                                                                    ProfileController>()
                                                                                .playListSongs[
                                                                                    index]
                                                                                .isFavourite ==
                                                                            1 ||
                                                                        (controller.currentSongIdNotifier
                                                                                    .value ==
                                                                                Get.find<ProfileController>()
                                                                                    .playListSongs[
                                                                                        index]
                                                                                    .id
                                                                                    .toString() &&
                                                                            controller
                                                                                    .isFavouriteSong
                                                                                    .value ==
                                                                                1))),
                                                                ///TODO: triple dots
                                                                showPopupMenu(
                                                                    context),
                                                              ],
                                                            );
                                                            // icon-2
                                                          });
                                                        }),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // const MiniPlayer()
                                ],
                              ),
                              Visibility(
                                visible: _isSliverAppBarExpanded ? true : false,
                                child: Positioned(
                                  top: 30,
                                  right: 10,
                                  child: songPlay(),
                                ),
                              )
                            ],
                          ),
                      ),
                      Column(
                        children: [
                          // Get.find<GetXPlayerController>()
                          //     .isCloseNotifier
                          //     .value
                          //     ? SizedBox(height: 60.h)
                          //     :
                          // SizedBox(
                          //   height: 120.h,
                          // ),
                          const MiniPlayer(
                            //callFrom: "artistPage",
                          ),
                          SizedBox(height: 10.h)
                        ],
                      ),
                    ],
                  ),
        );
      }),
    );
  }

  songPlay() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          print("jsdjsahd");
          print(
              "playlist length ${Get.find<ProfileController>().playListSongs.length}");
          if (Get.find<GetXPlayerController>().playlistNotifier.isEmpty) {
            print("abcdef");
            // if (Get.find<GetXPlayerController>()
            //     .playlistNotifier
            //     .isEmpty) {
            var list = Get.find<ProfileController>().playListSongs;
            List<MediaItem> playlist = [];
            for (int i = 0; i < list.length; i++) {
              List<dynamic> artistNames = Get.find<ProfileController>()
                  .playListSongs[i]
                  .artists!
                  .map((artist) => artist.name)
                  .toList();
              playlist.add(
                MediaItem(
                  id: list[i].id.toString(),
                  title: list[i].name!,
                  artist: artistNames.join(','),
                  artUri: Uri.parse("${Api.baseUrl}/${list[i].thumbnail320}"),
                  //audioList[index].artUri,
                  extras: {
                    'url': "${Api.baseUrl}/${list[i].songFile}",
                    'isFavourite': list[i].isFavourite,
                  },
                ),
              );
            }
            Get.find<GetXPlayerController>().clearPlaylist();
            Get.find<GetXPlayerController>().add(
              playlist,
              0,
            );
          }
        },
        child: Get.find<GetXPlayerController>().playlistNotifier.isEmpty
            ? Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.white24,
                  gradient: LinearGradient(
                    colors: [
                      AppColor.orangeColor,
                      AppColor.pinkColor,
                    ],
                  ),
                ),
                child: const Center(
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 30,
                    ),
                  ),
                ),
              )
            : PlayButton(
                width: 50.r,
                height: 50.r,
                iconSize: 30,
              ),
      );
    });
  }
}
