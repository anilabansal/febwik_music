import 'package:flutter/material.dart';
import 'package:music_app/app/ui/pages/search_screen/popular_songs.dart';
import 'package:music_app/app/ui/pages/search_screen/trending_list.dart';
import '../../../config/widgets/background/custom_background.dart';
import '../../theme/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  const TrendingList(),
                  const SizedBox(
                    height: 20,
                  ),
                  const PopularSongs(),
                  const SizedBox(height: 60)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
