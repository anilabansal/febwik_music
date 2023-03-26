import 'package:flutter/material.dart';
import 'package:music_app/app/config/dimensions.dart';
import 'package:music_app/app/config/widgets/small_text.dart';

import '../../../config/widgets/background/custom_background.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SmallText(
              text: 'PlaylistPage is working',
              size: Dimensions.font18,
            ),
          ),
        ),
      ),
    );
  }
}
