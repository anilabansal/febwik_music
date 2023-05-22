// import 'package:flutter/material.dart';
// import 'package:music_app/app/ui/pages/artist_page/artists_page.dart';
// import 'package:music_app/app/ui/pages/home_page/home_page_view.dart';
//
// import 'package:music_app/app/ui/pages/profile/profile_page.dart';
// import 'package:music_app/app/ui/pages/search/search_page.dart';
//
// import '../main.dart';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _currentIndex = 0;
//
//   final List<Widget> _children = [
//     HomePage(),
//     SearchPage(),
//     ProfilePage(),
//   ];
//
//
//
//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   void navigateToDetailScreen() {
//     navigatorKey.currentState?.push(
//       MaterialPageRoute(
//         builder: (context) => ArtistsPage(),
//       ),
//     );
//   }
//
//   void _navigateBack() {
//     navigatorKey.currentState?.pop();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Navigator(
//             key: navigatorKey,
//             onGenerateRoute: (routeSettings) {
//               return MaterialPageRoute(
//                 builder: (context) => _children[_currentIndex],
//               );
//             },
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: BottomNavigationBar(
//               onTap: _onTabTapped,
//               currentIndex: _currentIndex,
//               items: const [
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: 'First',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.search),
//                   label: 'Second',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.settings),
//                   label: 'Third',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
