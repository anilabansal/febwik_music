import 'package:flutter/material.dart';
import 'package:music_app/app/config/widgets/background/custom_background.dart';
import '../add_to_play_list/my_playlist.dart';

class ProfilePlayList extends StatelessWidget {
  const ProfilePlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  SafeArea(
        child: CustomBackground(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: MyPlayList(
              isBackIconVisible: true,
              callFrom: "profile",
            ),
          ),
        ),
      ),
    );
  }
}
