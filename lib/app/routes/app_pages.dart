import 'package:get/get.dart';
import 'package:music_app/app/main_page.dart';
import 'package:music_app/app/ui/pages/home_page/bottom_sheet_player.dart';
import 'package:music_app/app/ui/pages/home_page/home_page_view.dart';
import 'package:music_app/app/ui/pages/player_page/player_page_view.dart';

import '../ui/pages/artist_page/artists_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = AppRoutes.mainPage;

  static final routes = [
    GetPage(
      name: _Paths.mainPage,
      page: () => const MainPage(),
    ),
    GetPage(
      name: _Paths.homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: _Paths.playerPage,
      page: () => const PlayerPage(),
    ),
    GetPage(
      name: _Paths.bottomPlayer,
      page: () => const BottomSheetPlayer(),
        transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: _Paths.artistPage,
      page: () => const ArtistsPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
