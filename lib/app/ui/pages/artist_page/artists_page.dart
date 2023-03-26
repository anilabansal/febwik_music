import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/app/config/dimensions.dart';
import 'package:music_app/app/config/widgets/small_text.dart';
import 'package:music_app/app/models/artist.dart';

import '../../../config/widgets/background/custom_background.dart';

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
              ];
            },
            body: ListView.builder(
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
