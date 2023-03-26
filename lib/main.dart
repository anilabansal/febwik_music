import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/player/getx_audio_handler.dart';
import 'app/player/getx_player_controller.dart';
import 'app/player/getx_playlist_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/routes/app_pages.dart';
import 'app/ui/theme/index.dart';

void main() async {
  await Get.putAsync(() => GetXAudioHandler().init());
  await Get.putAsync(() => GetXDemoPlaylist().init());
  await Get.putAsync(() => GetXPlayerController().init());
  runApp(const App());
}


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, widget) => GetMaterialApp(
        title: 'Music Player',
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: ThemeMode.dark,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        builder: (context, widget) {
          // ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
      ),
    );
  }
}

