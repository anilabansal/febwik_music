import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/player/getx_audio_handler.dart';
import 'app/player/getx_player_controller.dart';
import 'app/player/getx_playlist_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/routes/app_pages.dart';
import 'app/services/connectivity.dart';
import 'app/ui/pages/add_to_play_list/add_to_play_list_screen.dart';
import 'app/ui/pages/splash/splash_screen.dart';
import 'app/ui/share_demo.dart';
import 'app/ui/theme/index.dart';
import 'dataBase/app_data_base.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
ConnectionManagerController connectionManagerController =
    Get.put(ConnectionManagerController());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Get.putAsync(() => GetXAudioHandler().init());
  await Get.putAsync(() => GetXDemoPlaylist().init());
  await Get.putAsync(() => GetXPlayerController().init());
  connectionManagerController.getConnectivity();
  await GetStorage().initStorage;
  AppLocalStorage().init();
  // await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // connectionManagerController.getConnectivity();
    // connectionManagerController.connectivity.onConnectivityChanged.listen(connectionManagerController.updateState);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      Get.find<GetXPlayerController>().stopSongs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, widget) => GetMaterialApp(
        title: 'Music Player',
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        //  //themeMode: ThemeMode.dark,
        // initialRoute:AppPages.INITIAL,
        //   getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        // home:   Home(),
        home: const SplashScreen(),
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
