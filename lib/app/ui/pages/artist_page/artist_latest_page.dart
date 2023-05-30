import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/player/getx_player_controller.dart';
import 'package:music_app/app/ui/pages/mini_player.dart';
import '../../../config/dimensions.dart';
import '../../../config/widgets/background/custom_background.dart';
import '../../../config/widgets/small_text.dart';
import '../../../config/widgets/vector_asset.dart';
import '../../../services/api.dart';
import '../../theme/colors.dart';
import '../home_page/bottom_sheet_player.dart';

class ArtistsPage extends StatefulWidget {
  final int? id;

  const ArtistsPage({Key? key, this.id}) : super(key: key);

  @override
  _ArtistsPageState createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  late ScrollController _scrollController;
  int page = 1;
  double height = 357.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<GetXPlayerController>().clearPlaylist();
    Get.find<GetXPlayerController>().artistSongList.clear();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          pagination();
        });
      });
    Get.find<GetXPlayerController>().loadArtistDetailApiCall(widget.id, page);
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
      Get.find<GetXPlayerController>()
          .loadArtistDetailApiCall(widget.id, page)
          .then((value) {
        //  Get.find<GetXPlayerController>().moreArtistSongLoad.value = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Obx(() {
        return CustomBackground(
          child: Get.find<GetXPlayerController>().isArtistLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Get.find<GetXPlayerController>().artistPageData == null
                  ? SmallText(
                      text: "No Data Found!",
                      size: Dimensions.font16,
                      color: Colors.white,
                    )
                  : Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: CustomScrollView(
                                shrinkWrap: true,
                                controller: _scrollController,
                                slivers: <Widget>[
                                  SliverAppBar(
                                    pinned: true,
                                    // snap: true,
                                    floating: false,
                                    expandedHeight: height,
                                    backgroundColor: _isSliverAppBarExpanded
                                        ? AppColor.searchBarGreyColor
                                        : Colors.transparent,
                                    leading: GestureDetector(
                                      onTap: () {
                                        print("sndksk");
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
                                              text: Get.find<
                                                          GetXPlayerController>()
                                                      .artistPageData
                                                      .value
                                                      .singer!
                                                      .name ??
                                                  "",
                                              overFlow: TextOverflow.ellipsis,
                                              size: Dimensions.font12,
                                              color: Colors.white,
                                            )
                                          : null,
                                      background:

                                          ///TODO: artist image
                                          Padding(
                                        padding:
                                            const EdgeInsets.only(top: 40.0),
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
                                                      60, 10, 60, 0),
                                              child: Image.network(
                                                "${Api.baseUrl}/${Get.find<GetXPlayerController>().artistPageData.value.singer!.image}",
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
                                  SliverList(
                                    delegate: SliverChildListDelegate([
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          15.0,
                                          15,
                                          15.0,
                                          0,
                                        ),
                                        child: SmallText(
                                          text: Get.find<GetXPlayerController>()
                                                  .artistPageData
                                                  .value
                                                  .singer!
                                                  .name ??
                                              "",
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
                                          itemCount:
                                              Get.find<GetXPlayerController>()
                                                  .artistSongList
                                                  .length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            List<dynamic> artistNames =
                                                Get.find<GetXPlayerController>()
                                                    .artistSongList[index]
                                                    .artists!
                                                    .map(
                                                        (artist) => artist.name)
                                                    .toList();
                                            var list =
                                                Get.find<GetXPlayerController>()
                                                    .artistSongList;

                                            return GestureDetector(
                                              onTap: () {
                                                List<MediaItem> playlist = [];
                                                print('tap latest');
                                                for (int i = 0;
                                                    i < list.length;
                                                    i++) {
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
                                                      },
                                                    ),
                                                  );
                                                }
                                                Get.find<GetXPlayerController>()
                                                    .clearPlaylist();
                                                Get.find<GetXPlayerController>()
                                                    .add(
                                                  playlist,
                                                  index,
                                                );
                                                //   Get.toNamed(AppRoutes.bottomPlayer);
                                              },
                                              child: ListTile(
                                                minLeadingWidth: 0,
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 5),
                                                title: Row(
                                                  children: [
                                                    Container(
                                                      height: 50.h,
                                                      width: 50.w,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: AppColor
                                                              .orangeColor,
                                                          width: 3.w,
                                                        ),
                                                        shape: BoxShape.circle,
                                                        gradient:
                                                            const LinearGradient(
                                                          colors: [
                                                            AppColor
                                                                .orangeColor,
                                                            AppColor.pinkColor,
                                                          ],
                                                        ),
                                                        image: DecorationImage(
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
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 250,

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
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 15,
                                                              height: 15,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              child: const Icon(
                                                                Icons
                                                                    .arrow_downward,
                                                                size: 10,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
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
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                trailing: Wrap(
                                                  spacing:
                                                      12, // space between two icons
                                                  children: const <Widget>[
                                                    Icon(
                                                      Icons.favorite_outline,
                                                      size: 22,
                                                    ), // icon-1
                                                    Icon(
                                                      Icons.more_vert,
                                                      size: 25,
                                                    ), // icon-2
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                      Get.find<GetXPlayerController>()
                                              .isCloseNotifier
                                              .value
                                          ? const SizedBox(height: 55)
                                          : const SizedBox(height: 0),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                            const MiniPlayer()
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
        );
      })),
    );
  }

  songPlay() {
    return GestureDetector(
      onTap: () {
        if (Get.find<GetXPlayerController>().playlistNotifier.isEmpty) {
          print("abcdef");
          // if (Get.find<GetXPlayerController>()
          //     .playlistNotifier
          //     .isEmpty) {
          var list = Get.find<GetXPlayerController>().artistSongList;
          List<MediaItem> playlist = [];
          for (int i = 0; i < list.length; i++) {
            List<dynamic> artistNames = Get.find<GetXPlayerController>()
                .artistSongList[i]
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
          // SizedBox(
          //         width: 50.r,
          //         height: 50.r,
          //         child: const Center(
          //           child: Icon(
          //             Icons.play_arrow,
          //             size: 40,
          //           ),
          //           // child:VectorAsset(
          //           //   icon: 'ic_musicPlay',
          //           // ),
          //         ),
          //       )
          : PlayButton(
              width: 50.r,
              height: 50.r,
              iconSize: 30,
            ),
    );
  }
}
