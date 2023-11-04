import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/player/getx_player_controller.dart';
import 'package:music_app/app/ui/pages/common/connectivity_page.dart';
import 'package:music_app/app/ui/pages/home_page/home_page_view.dart';
import 'package:music_app/app/ui/pages/login_page/login_page.dart';
import 'package:music_app/app/ui/pages/mini_player.dart';
import 'package:music_app/app/ui/pages/profile/profile_page.dart';
import 'package:music_app/app/ui/pages/search_screen/search_screen.dart';
import 'package:music_app/app/ui/theme/colors.dart';
import '../main.dart';
import 'config/widgets/custom_nav_bar.dart';
import 'config/widgets/exist_dialog.dart';
import 'ui/pages/coming_soon.dart';

class MainPage extends StatefulWidget {
  final int selectedIndex;

  const MainPage({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomePage(),
    const SearchScreen(),
    const ConnectivityScreen(),
    // const ComingSoon(),
    const ProfilePage(),
    // const ProfilePage()
  ];

  @override
  void initState() {
    _currentIndex = widget.selectedIndex;
    // _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    // _pageController.dispose();
    super.dispose();
  }

  final _inactiveColor = AppColor.orangeColor;

  // Future<bool> showExitPopup() async {
  //   if (_currentIndex == 0 ) {
  //     if( Get.find<GetXPlayerController>().homeDestinationIndex ==0){
  //       return await showDialog(
  //           barrierColor: Colors.transparent,
  //           barrierDismissible: false,
  //           context: context,
  //           builder: (context) {
  //             return BackdropFilter(
  //               filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
  //               child: const Dialog(
  //                 backgroundColor: AppColor.searchBarGreyColor,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.all(
  //                     Radius.circular(10.0),
  //                   ),
  //                 ),
  //                 child: ExistDialog(),
  //               ),
  //             );
  //           });
  //     }
  //   } else {
  //     if (_currentIndex != 0) {
  //       await Future.delayed(const Duration(milliseconds: 200));
  //       setState(() {
  //         _currentIndex = 0;
  //       });
  //       navigatorKey.currentState!.push(
  //         MaterialPageRoute(
  //           builder: (context) => const HomePage(),
  //         ),
  //       );
  //
  //       return false;
  //     }
  //   }
  //   return false;
  // }

  final List<int> _navigationQueue = [0];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: showExitPopup,
      onWillPop: () async {
        if (_currentIndex == 0) {
          print("empty");
          if (Get.find<GetXPlayerController>().homeDestinationIndex == 0) {
            return await showDialog(
                barrierColor: Colors.transparent,
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: const Dialog(
                      backgroundColor: AppColor.searchBarGreyColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: ExistDialog(),
                    ),
                  );
                });
          } else if (Get.find<GetXPlayerController>().homeDestinationIndex !=
              0) {
            Future.delayed(const Duration(microseconds: 200), () {
              navigatorKey.currentState!.popUntil((route) => route.isFirst);
            });
            setState(() {
              _currentIndex = _navigationQueue.last;
              Get.find<GetXPlayerController>().homeDestinationIndex = 0;
            });
          }
          // return true;
          // Navigator.of(context).maybePop();
        } else {
          setState(() {
            _currentIndex = _navigationQueue.last;
            //   _navigationQueue.removeLast();
          });
          print("not empty");
        }
        return false;
      },

      child: Scaffold(
        backgroundColor: Colors.transparent,
        // body: getBody(),
        body: Navigator(
          key: navigatorKey,
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(builder: (context) {
              return Obx(() {
                return connectionManagerController.isAlertSet.value == true
                    ? const ConnectivityScreen()
                    : _children[_currentIndex];
              });
              // if () {
              //   return const ConnectivityScreen();
              // }
              // else{
              //   return  _children[_currentIndex];
              // }
            });
          },
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const MiniPlayer(),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return CustomNavigationBar(
      containerHeight: 48.h,
      // containerHeight: 55.h,
      backgroundColor: AppColor.darkColor,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 400),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      onItemSelected: (index) {
        setState(() {
          _currentIndex = index;
        });
        if (_currentIndex == index) {
          // If the user taps on the currently selected tab, navigate back to Screen 1
          navigatorKey.currentState?.popUntil((route) => route.isFirst);
        } else {
          if (_currentIndex == 0 && index == 1) {
            // Navigating from detail screen to Screen 2
            navigatorKey.currentState?.push(
              MaterialPageRoute(
                builder: (context) => const ConnectivityScreen(),
                //const SearchPage(),
              ),
            );
          } else if (_currentIndex == 0 && index == 2) {
            // Navigating from detail screen to Screen 2
            navigatorKey.currentState?.push(
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          } else if (_currentIndex == 0 && index == 3) {
            // Navigating from detail screen to Screen 2
            navigatorKey.currentState?.push(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          }
        }
      },

      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: NavBarIcon(
              imgUrl: _currentIndex == 0 ? "home.png" : "home_white.png"),
          title: const Text("Home"),
          activeColor: AppColor.whiteColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: NavBarIcon(
              imgUrl: _currentIndex == 1 ? "search.png" : "search_white.png"),
          title: const Text("Search"),
          activeColor: AppColor.whiteColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: NavBarIcon(
              imgUrl: _currentIndex == 2
                  ? "footer-menu-colored.png"
                  : "footer_navigation.png"),
          title: const Text("library"),
          activeColor: AppColor.whiteColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: NavBarIcon(
              imgUrl: _currentIndex == 3 ? "user.png" : "user_white.png"),
          title: const Text("Profile"),
          activeColor: AppColor.whiteColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({
    Key? key,
    this.height = 24,
    this.width = 24,
    required this.imgUrl,
  }) : super(key: key);
  final double height;
  final double width;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/icon/$imgUrl",
      height: height,
      width: width,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.home_outlined),
    );
  }
}
