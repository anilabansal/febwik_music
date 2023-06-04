import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/app/ui/pages/home_page/home_page_view.dart';
import 'package:music_app/app/ui/pages/login_page/login_page.dart';
import 'package:music_app/app/ui/pages/mini_player.dart';
import 'package:music_app/app/ui/pages/profile/profile_page.dart';
import '../main.dart';
import 'config/widgets/custom_nav_bar.dart';
import 'ui/pages/search/search_page.dart';
import 'ui/theme/colors.dart';

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
    const SearchPage(),
    const ProfilePage(),
    const LoginPage()
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

  // @override
  // void setState(VoidCallback fn) {
  //   super.setState(fn);
  // }

  final _inactiveColor = AppColor.orangeColor;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (navigatorKey.currentState!.canPop()) {
          // If there are screens in the navigation stack, allow navigation
          navigatorKey.currentState!.pop();
          return false;
        } else {
          if (_currentIndex != 0) {
            setState(() {
              _currentIndex = 0;
            });
            navigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );

            return false;
          }
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // body: getBody(),
        body: Navigator(
          key: navigatorKey,
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(
              builder: (context) => _children[_currentIndex],
            );
          },
        ),
        bottomNavigationBar:   Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           const MiniPlayer(),

            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30,8),
              child: ClipRRect(

                borderRadius: BorderRadius.circular(15.r),
                child: BottomNavigationBar(
                    currentIndex: _currentIndex,
                    elevation: 0,
                    onTap : (index) {
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
                            builder: (context) => const SearchPage(),
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
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      }
                    }
                  },

                    selectedLabelStyle: const TextStyle(color: Colors.white),
                     // selectedItemColor:_inactiveColor,
                    // backgroundColor: ColorConstants.kBackGround,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items:  [
                      BottomNavigationBarItem(
                        icon: NavBarIcon(
                            imgUrl: _currentIndex == 0 ? "home.png" : "home_white.png"),
                        label: "Home",

                      ),
                      BottomNavigationBarItem(
                        icon: NavBarIcon(
                            imgUrl: _currentIndex == 1 ? "search.png" : "search_white.png"),
                        label: "Search",

                      ),
                      BottomNavigationBarItem(
                        icon: NavBarIcon(
                            imgUrl: _currentIndex == 2
                                ? "footer_navigation.png"
                                : "footer_navigation.png"),
                        label: "library",
                      ),
                      BottomNavigationBarItem(
                        icon: NavBarIcon(
                            imgUrl: _currentIndex == 3 ? "user.png" : "user_white.png"),
                        label:"Profile",

                      ),

                    ],
                  ),
              ),
            ),
          ],
        )
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.miniCenterDocked,
        // floatingActionButton: _buildBottomBar(),
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
                builder: (context) => const SearchPage(),
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
                builder: (context) =>  LoginPage(),
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
                  ? "footer_navigation.png"
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

// Widget getBody() {
//   List<Widget> pages = const [
//     HomePage(),
//     SearchPage(),
//     ProfilePage(),
//     ProfilePage()
//   ];
//
//   return PageView(
//     pageSnapping: false,
//     physics: const NeverScrollableScrollPhysics(),
//     onPageChanged: (value) => setState(() => _currentIndex = value),
//     controller: _pageController,
//     children: pages,
//   );
// }
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
