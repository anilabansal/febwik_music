import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/app/ui/pages/home_page/home_page_view.dart';
import 'package:music_app/app/ui/pages/profile/profile_page.dart';

import 'config/widgets/custom_nav_bar.dart';
import 'ui/pages/search/search_page.dart';
import 'ui/theme/colors.dart';

class MainPage extends StatefulWidget {
  final int seletedIndex;
  const MainPage({Key? key, this.seletedIndex = 0}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  @override
  void initState() {
    _currentIndex = widget.seletedIndex;
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  final _inactiveColor = AppColor.orangeColor;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _pageController.jumpToPage(0);
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          body: getBody(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: _buildBottomBar()),
    );
  }

  Widget _buildBottomBar() {
    return CustomNavigationBar(
      containerHeight: 55.h,
      backgroundColor: AppColor.darkColor,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 400),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      onItemSelected: (index) => setState(() {
        _currentIndex = index;
        _pageController.animateToPage(_currentIndex,
            duration: const Duration(microseconds: 500), curve: Curves.easeIn);
      }),
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
              imgUrl: _currentIndex == 2 ? "user.png" : "user_white.png"),
          title: const Text("Profile"),
          activeColor: AppColor.whiteColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
// // exit dialog
//   Future<bool> _exitDialog() async {
//     return await Get.defaultDialog(
//       contentPadding: const EdgeInsets.only(bottom: 0),
//       radius: Dimensions.radius20,
//       title: "Alert",
//       middleText: "Do you want to exit from app?",
//       actions: [
//         Container(
//           decoration: BoxDecoration(
//             color: AppColor.lightGreyColor,
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(Dimensions.radius20),
//               bottomRight: Radius.circular(Dimensions.radius20),
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context, false);
//                 },
//                 child: SmallText(
//                   text: "Stay",
//                   size: Dimensions.font16,
//                   color: AppColor.amberColor,
//                 ),
//               ),
//               Container(
//                 width: 2,
//                 height: Dimensions.height30,
//                 color: AppColor.mediumGreyColor,
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context, true);
//                 },
//                 child: SmallText(
//                   text: "Yes",
//                   size: Dimensions.font16,
//                   color: AppColor.redColor,
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }

  //====Body===
  Widget getBody() {
    List<Widget> pages = const [HomePage(), SearchPage(), ProfilePage()];
    return PageView(
      pageSnapping: false,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (value) => setState(() => _currentIndex = value),
      controller: _pageController,
      children: pages,
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
