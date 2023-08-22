import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/config/dimensions.dart';
import 'package:music_app/app/config/widgets/small_text.dart';
import '../../../config/widgets/background/custom_background.dart';
import '../../../config/widgets/vector_asset.dart';
import '../../../player/getx_player_controller.dart';
import '../../../services/api.dart';
import '../../theme/colors.dart';
import '../home_page/bottom_sheet_player.dart';
import '../mini_player.dart';

class ArtistsPage extends StatefulWidget {
  final int? id;

  const ArtistsPage({Key? key, this.id}) : super(key: key);

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  ScrollController _scrollController = ScrollController();

  // int id = Get.arguments ?? 0;
  // double height = 470;
  double height = 380;
  bool showButton = false;
  bool lastStatus = true;
  int page = 1;

  @override
  void initState() {
    Get.find<GetXPlayerController>().clearPlaylist();
    Get.find<GetXPlayerController>().artistSongList.clear();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _scrollController.addListener(() {
      _scrollListener;
      pagination();
    });
    Get.find<GetXPlayerController>().loadArtistDetailApiCall(widget.id, page);

    super.initState();
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController.hasClients &&
        _scrollController.offset > (height - kToolbarHeight);
  }

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
      pagination();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
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
    // Artists artist = Artists.artistList[index];
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
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
                    :
            Stack(
                      children: [
                        NestedScrollView(
                          controller: _scrollController,
                            headerSliverBuilder:
                                (BuildContext context, bool innerBoxIsScrolled) {
                              return [
                                SliverAppBar(
                                  backgroundColor:
                                      _isShrink ? Colors.black : Colors.transparent,
                                  //  foregroundColor: Colors.transparent,
                                  //backgroundColor: Colors.transparent,

                                  title: _isShrink
                                      ?
                                  SmallText(
                                    text: Get.find<GetXPlayerController>()
                                        .artistPageData
                                        .value
                                        .singer!
                                        .name ??
                                        "",
                                    overFlow: TextOverflow.ellipsis,
                                    size: Dimensions.font12,
                                    color: Colors.white,
                                  )
                                      // Row(
                                      //         children: [
                                      // Center(
                                      //     child: SizedBox(
                                      //       width: 70,
                                      //       height: 70,
                                      //       child: Image.network(
                                      //         "${Api.baseUrl}/${Get.find<GetXPlayerController>().artistPageData.value.singer!.image}",
                                      //         fit: BoxFit.fill,
                                      //       ),
                                      //     ),
                                      //   )
                                      //   ],
                                      // )
                                      : null,
                                  pinned: true,
                                  elevation: 0,
                                  centerTitle: false,
                                  collapsedHeight: 80,
                                  //collapsedHeight: 100,
                                  //  expandedHeight: MediaQuery.of(context).size.height*0.35,
                                  expandedHeight: height,

                                  flexibleSpace: FlexibleSpaceBar(
                                    collapseMode: CollapseMode.parallax,
                                    background: Padding(
                                      padding: const EdgeInsets.only(top: 50.0),
                                      child: Column(
                                        children: [
                                          ///TODO: Search bar
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width:
                                                  MediaQuery.of(context).size.width,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                // color: Color(0xff3b2e28),
                                                color: AppColor.searchBarGreyColor,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                  15,
                                                  5,
                                                  0,
                                                  5,
                                                ),
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                    suffixIcon: Icon(
                                                      Icons.search,
                                                      color: AppColor.whiteColor,
                                                    ),
                                                    border: InputBorder.none,
                                                    hintText: "Search in Playlist",
                                                    hintStyle: TextStyle(
                                                      fontSize: 15,
                                                      //    fontWeight: FontWeight.w400,
                                                      //
                                                      // -+fontFamily: interFont,
                                                      color: AppColor.whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          ///TODO: artist image
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                60, 10, 60, 0),
                                            child: Image.network(
                                              "${Api.baseUrl}/${Get.find<GetXPlayerController>().artistPageData.value.singer!.image}",
                                              width:
                                                  MediaQuery.of(context).size.width,
                                              fit: BoxFit.fill,
                                              height: 250,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ];
                            },
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _isShrink
                                    ? Container()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15.0, 15, 15.0, 0),
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

                                                GestureDetector(
                                                  onTap: () {
                                                    if (Get.find<
                                                            GetXPlayerController>()
                                                        .playlistNotifier
                                                        .isEmpty) {
                                                      print("abcdef");
                                                      // if (Get.find<GetXPlayerController>()
                                                      //     .playlistNotifier
                                                      //     .isEmpty) {
                                                      var list = Get.find<
                                                              GetXPlayerController>()
                                                          .artistPageData
                                                          .value
                                                          .songs!;
                                                      List<MediaItem> playlist = [];
                                                      for (int i = 0;
                                                          i < list.length;
                                                          i++) {
                                                        playlist.add(
                                                          MediaItem(
                                                            id: list[i]
                                                                .id
                                                                .toString(),
                                                            title: list[i].name!,
                                                            artist: "",
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
                                                      Get.find<
                                                              GetXPlayerController>()
                                                          .clearPlaylist();
                                                      Get.find<
                                                              GetXPlayerController>()
                                                          .add(
                                                        playlist,
                                                        0,
                                                      );
                                                    }
                                                  },
                                                  child: Get.find<
                                                              GetXPlayerController>()
                                                          .playlistNotifier
                                                          .isEmpty
                                                      ? SizedBox(
                                                          width: 50.r,
                                                          height: 50.r,
                                                          child: const VectorAsset(
                                                            icon: 'ic_musicPlay',
                                                          ),
                                                        )
                                                      : PlayButton(
                                                          width: 50.r,
                                                          height: 50.r,
                                                        ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                ///Todo: list of songs of artist

                                Flexible(
                                  child: Padding(
                                    padding:  EdgeInsets.only(top: _isShrink
                                        ?80.0: 0.0),
                                    child: CustomScrollView(
                                      shrinkWrap: true,
                                      //  scrollBehavior: const ConstantScrollBehavior(),
                                      slivers: [
                                         SliverList(
                                              delegate: SliverChildBuilderDelegate(
                                                childCount:
                                                    Get.find<GetXPlayerController>()
                                                        .artistSongList
                                                        .length,
                                                (BuildContext context, int index) {
                                                  List<dynamic> artistNames =
                                                      Get.find<GetXPlayerController>()
                                                          .artistSongList[index]
                                                          .artists!
                                                          .map((artist) => artist.name)
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
                                                            artist: artistNames.join(','),
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
                                                          const EdgeInsets.only(left: 5),
                                                      title: Row(
                                                        children: [
                                                          Container(
                                                            height: 50.h,
                                                            width: 50.w,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color:
                                                                    AppColor.orangeColor,
                                                                width: 3.w,
                                                              ),
                                                              shape: BoxShape.circle,
                                                              gradient:
                                                                  const LinearGradient(
                                                                colors: [
                                                                  AppColor.orangeColor,
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
                                                                MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: 250,

                                                                // width: MediaQuery.of(context).size.width-150,
                                                                child: SmallText(
                                                                  text:
                                                                      list[index].name ??
                                                                          "",
                                                                  overFlow: TextOverflow
                                                                      .ellipsis,
                                                                  size: Dimensions.font15,
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
                                                                      shape:
                                                                          BoxShape.circle,
                                                                      color: Colors.green,
                                                                    ),
                                                                    child: const Icon(
                                                                      Icons
                                                                          .arrow_downward,
                                                                      size: 10,
                                                                      color: Colors.black,
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
                                                                      color:
                                                                          Colors.white54,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: const Wrap(
                                                        spacing:
                                                            12, // space between two icons
                                                        children: <Widget>[
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
                                                },
                                              ),


                                         ) ],
                                    ),
                                  ),
                                ),

                                Get.find<GetXPlayerController>()
                                        .isCloseNotifier
                                        .value
                                    ? const SizedBox(height: 55)
                                    : const SizedBox(height: 0),

                                ///Todo: mini player
                                const MiniPlayer(
                                    //callFrom: "artistPage",
                                    ),
                              ],
                            ),
                          ),

                        // Positioned(
                        //   top: 60,
                        //   right: 0,
                        //   child: Container(
                        //     height: 50,
                        //     width: 50,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: Colors.red
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
          );
        }),
      ),
    );
  }
}
