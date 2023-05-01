import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/config/dimensions.dart';
import 'package:music_app/app/config/widgets/small_text.dart';
import 'package:music_app/app/models/artist.dart';
import '../../../config/widgets/background/custom_background.dart';
import '../../theme/colors.dart';

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({Key? key}) : super(key: key);

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  final ScrollController _scrollController = ScrollController();
  int index = Get.arguments ?? 0;
  double height = 200;
  bool showButton = false;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
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
    Artists artist = Artists.artistList[index];
    return SafeArea(
      child: Scaffold(
        body: CustomBackground(
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: SmallText(
                    text: artist.title ?? "",
                    size: Dimensions.font16,
                  ),
                  pinned: true,
                  elevation: 0,
                  centerTitle: false,
                  expandedHeight: height,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Image.network(
                      artist.imgUrl ?? "",
                      fit: BoxFit.fill,
                      height: height,
                    ),
                  ),
                  actions: [
                    showButton
                        ? Icon(
                            Icons.play_circle,
                            size: Dimensions.iconSize20,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                // const Align(
                //     alignment: Alignment.topLeft, child: Icon(Icons.arrow_back)),

              ];
            },
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: Artists.artistList.length,
              itemBuilder: (BuildContext context, int index) {
                return
                  ListTile(
                  leading: Container(
                    height: 80.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColor.orangeColor, width: 3.w),
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          AppColor.orangeColor,
                          AppColor.pinkColor,
                        ],
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          Artists.artistList[index].imgUrl.toString(),
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  // title: Text('Item $index'),
                  title: SmallText(
                    text: 'Item $index',
                    overFlow: TextOverflow.ellipsis,
                    size: Dimensions.font12,
                  ),
                  subtitle: SmallText(
                    text: "artist name",
                    overFlow: TextOverflow.ellipsis,
                    size: Dimensions.font10,
                    color: Colors.white54,
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
