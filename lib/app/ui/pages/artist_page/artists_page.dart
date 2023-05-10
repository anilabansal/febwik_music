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
  const ArtistsPage({Key? key}) : super(key: key);

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  final ScrollController _scrollController = ScrollController();
  int id = Get.arguments ?? 0;

  // double height = 200;
  double height = 450;
  bool showButton = false;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    Get.find<GetXPlayerController>().loadArtistDetailApiCall(id);

    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >= height) {
      setState(() {
        showButton = true;
      });
    } else {
      setState(() {
        showButton = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Artists artist = Artists.artistList[index];
    return SafeArea(
      child: Scaffold(body: Obx(() {
        return Get.find<GetXPlayerController>().isArtistLoading.value
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
                : CustomBackground(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            //  foregroundColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            // title: SmallText(
                            //   text: Get.find<GetXPlayerController>()
                            //           .artistPageData
                            //           .value
                            //           .singer!
                            //           .name ??
                            //       "",
                            //   size: Dimensions.font16,
                            // ),
                            pinned: true,
                            elevation: 0,
                            centerTitle: false,
                            expandedHeight: height,
                            //  expandedHeight: 450,
                            // flexibleSpace: FlexibleSpaceBar(
                            //   collapseMode: CollapseMode.pin,
                            //   background: Image.network("${Api.baseUrl}/${Get.find<GetXPlayerController>().artistPageData.value.singer!.image}",
                            //   fit: BoxFit.fill,
                            //     height: height,
                            //   ),
                            // ),
                            flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.pin,
                              background: Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: Column(
                                  children: [
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
                                          color: AppColor.searchBarGreyColor
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 0, 0, 0),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              suffixIcon: Icon(
                                                Icons.search,
                                                color: Colors.grey,
                                              ),
                                              border: InputBorder.none,
                                              hintText: "Search in Playlist",
                                              hintStyle: TextStyle(
                                                fontSize: 18,
                                                //    fontWeight: FontWeight.w400,
                                                //
                                                // -+fontFamily: interFont,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          60, 10, 60, 0),
                                      child: Image.network(
                                        "${Api.baseUrl}/${Get.find<GetXPlayerController>().artistPageData.value.singer!.image}",
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.fill,
                                        height: 300,
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
                          Padding(
                            padding: const EdgeInsets.all(15.0),
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
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                VectorAsset(
                                  icon: "ic_download",
                                  size: 20.r,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                VectorAsset(
                                  icon: "ic_AZ",
                                  size: 20.r,
                                  color: Colors.white,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.shuffle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),

                                ///Todo: play songs button
                                Get.find<GetXPlayerController>()
                                        .playlistNotifier
                                        .isEmpty
                                    ? GestureDetector(
                                        onTap: () {
                                          print("abcdef");
                                          // if (Get.find<GetXPlayerController>()
                                          //     .playlistNotifier
                                          //     .isEmpty) {
                                          var list =
                                              Get.find<GetXPlayerController>()
                                                  .artistPageData
                                                  .value
                                                  .songs!;
                                          List<MediaItem> playlist = [];
                                          for (int i = 0;
                                              i < list.length;
                                              i++) {
                                            playlist.add(
                                              MediaItem(
                                                id: list[i].id.toString(),
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
                                          Get.find<GetXPlayerController>()
                                              .clearPlaylist();
                                          Get.find<GetXPlayerController>().add(
                                            playlist,
                                            0,
                                          );
                                          // }
                                          // else if (Get.find<
                                          //         GetXPlayerController>()
                                          //     .playlistNotifier
                                          //     .isNotEmpty) {
                                          //   print("continue--->");
                                          // }
                                        },
                                        child: SizedBox(
                                          width: 50.r,
                                          height: 50.r,
                                          child: const VectorAsset(
                                            icon: 'ic_musicPlay',
                                          ),
                                        ),
                                      )
                                    : PlayButton(
                                        width: 50.r,
                                        height: 50.r,
                                      ),
                              ],
                            ),
                          ),

                          ///Todo: list of songs of artist
                          // Expanded(
                          //   child:
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                // itemCount: 100,
                                itemCount: Get.find<GetXPlayerController>()
                                    .artistPageData
                                    .value
                                    .songs!
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  List<dynamic> artistNames =
                                  Get.find<GetXPlayerController>()
                                      .artistPageData
                                      .value
                                      .songs![index].artists!.map((artist) => artist.name).toList();
                                  return GestureDetector(
                                    onTap: () {
                                      var list = Get.find<GetXPlayerController>()
                                          .artistPageData
                                          .value
                                          .songs!;
                                      List<MediaItem> playlist = [];
                                      print('tap latest');
                                      for (int i = 0; i < list.length; i++) {
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
                                      Get.find<GetXPlayerController>().add(
                                        playlist,
                                        index,
                                      );
                                      //   Get.toNamed(AppRoutes.bottomPlayer);
                                    },
                                    child: ListTile(
                                      // minLeadingWidth : 0,
                                      contentPadding: const EdgeInsets.all(5),
                                      leading: Container(
                                        height: 80.h,
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColor.orangeColor,
                                            width: 3.w,
                                          ),
                                          shape: BoxShape.circle,
                                          gradient: const LinearGradient(
                                            colors: [
                                              AppColor.orangeColor,
                                              AppColor.pinkColor,
                                            ],
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "${Api.baseUrl}/${Get.find<GetXPlayerController>().artistPageData.value.songs![index].thumbnail128}",
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      // title: Text('Item $index'),
                                      title: SizedBox(
                                        width: MediaQuery.of(context).size.width-150,
                                        child: SmallText(
                                          text:
                                          Get.find<GetXPlayerController>()
                                                  .artistPageData
                                                  .value
                                                  .songs![index]
                                                  .name
                                              ??
                                              "",
                                          overFlow: TextOverflow.ellipsis,
                                          size: Dimensions.font12,
                                        ),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Container(
                                            width: 15,
                                            height: 15,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green,
                                            ),
                                            child: const Icon(
                                              Icons.arrow_downward,
                                              size: 10,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          // Container(
                                          //   width: 50,
                                          //   height: 15,
                                          //   decoration: const BoxDecoration(
                                          //     gradient: LinearGradient(
                                          //       colors: [
                                          //         AppColor.orangeColor,
                                          //         AppColor.pinkColor,
                                          //       ],
                                          //     ),
                                          //
                                          //     // color: Colors.white24,
                                          //   ),
                                          //   child: Center(
                                          //     child: SmallText(
                                          //       text: "LYRICS",
                                          //       overFlow: TextOverflow.ellipsis,
                                          //       size: Dimensions.font10,
                                          //       color: Colors.black54,
                                          //     ),
                                          //   ),
                                          // ),
                                          // const SizedBox(
                                          //   width: 5,
                                          // ),

                                          SizedBox(
                                            width: MediaQuery.of(context).size.width-205,
                                            child: SmallText(
                                              text: "${artistNames.join(',')}jdfkjgksfjgkrsjghk;sjsh;ofkfkjosdjckldsjlk",
                                              overFlow: TextOverflow.ellipsis,
                                              size: Dimensions.font10,
                                              color: Colors.white54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // trailing:   const Icon(
                                      //   Icons.favorite_outline,
                                      //   color: Colors.white,
                                      // ),
                                      trailing: Wrap(
                                        spacing: 12, // space between two icons
                                        children: const <Widget>[
                                          Icon(
                                            Icons.favorite_outline,
                                            size: 20,
                                          ), // icon-1
                                          Icon(
                                            Icons.more_vert,
                                            size: 20,
                                          ), // icon-2
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          // ),

                          ///Todo: mini player
                          const MiniPlayer(
                            callFrom: "artistPage",
                          ),
                        ],
                      ),
                    ),
                  );
      })),
    );
  }
}
