import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:music_app/app/config/widgets/text_base.dart';
import 'package:music_app/app/player/getx_player_controller.dart';
import 'package:music_app/app/ui/pages/login_page/login_page.dart';
import 'package:music_app/app/ui/pages/mini_player.dart';
import 'package:music_app/app/ui/pages/profile/liked_songs_view.dart';
import 'package:music_app/app/ui/pages/profile/profile_playlist.dart';
import 'package:music_app/dataBase/app_data_base.dart';
import '../../../../main.dart';
import '../../../config/widgets/background/custom_background.dart';
import '../../../config/widgets/exist_dialog.dart';
import '../../../config/widgets/vector_asset.dart';
import '../../../controllers/profile_controller/profile_controller.dart';
import '../../theme/colors.dart';
import '../coming_soon.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // Get.lazyPut(() => ProfileController());
    ProfileController profileController = Get.put(ProfileController());
    return CustomBackground(
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                Center(
                  child: TextBase(
                    "My Profile",
                    fontWeight: FontWeight.w700,
                    fontSize: 25.sp,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      child: Card(
                        color: AppColor.cardBackground,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: AppColor.cardBackground,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  navigatorKey.currentState?.push(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 60,
                                    ),
                                    const VectorAsset(
                                      icon: "ic_editPencil",
                                      size: 15,
                                    ),
                                    Center(
                                      child: TextBase(
                                        "Palak Sharma",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            CommonContainer(
                              icon: const Icon(
                                Icons.favorite_outline,
                                color: Colors.white,
                              ),
                              text: "Liked Song",
                              onTap: () {
                                if (AppLocalStorage().userId == 0) {
                                  Get.to(const LoginPage());
                                } else {
                                  // Get.to(() => const ComingSoon());
                                  Get.to(const LikeSongsListView());
                                  // return;
                                }
                              },
                            ),
                            CommonContainer(
                                icon: const VectorAsset(
                                  icon: "ic_clock",
                                  size: 20,
                                ),
                                text: "Recently Played",
                                onTap: () {
                                  if (AppLocalStorage().userId == 0) {
                                    Get.to(const LoginPage());
                                  } else {
                                    Get.to(() => const ComingSoon());
                                    // return;
                                  }
                                }),
                            CommonContainer(
                                icon: const VectorAsset(
                                  icon: "ic_playList",
                                  size: 20,
                                ),
                                text: "Playlist",
                                onTap: () {
                                  if (AppLocalStorage().userId == 0) {
                                    Get.to(const LoginPage());
                                  } else {
                                    Get.to(() => const ProfilePlayList());
                                  }
                                }),
                            // GetBuilder<AppLocalStorage>(
                            //     builder: (appLocalStorage) {
                            // return
                            Obx(
                              () => Visibility(
                                visible: AppLocalStorage().userId != 0,
                                child: CommonContainer(
                                  icon: const VectorAsset(
                                    icon: "ic_logout",
                                    size: 20,
                                  ),
                                  text: "Logout",
                                  onTap: () {
                                    showDialog(
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
                                              child: ExistDialog(
                                                  callFrom:"logOut",
                                                dialogHeaderText: "Logout",
                                                dialogText: "Do you want to Logout an App",
                                              ),
                                            ),
                                          );
                                        });
                                    // Fluttertoast.showToast(
                                    //     msg: "Logout Successfully!",
                                    //     textColor: Colors.white,
                                    //     backgroundColor: AppColor.orangeColor);
                                    // AppLocalStorage().clearData();
                                    // AppLocalStorage().setUserId(0);
                                  },
                                ),
                              ),
                            ),

                            // }),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: -30,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 60,
                        ),
                      ),
                    ),
                    // Get.find<GetXPlayerController>().isCloseNotifier.value
                    //     ? const SizedBox(height: 55)
                    //     : const SizedBox(height: 0),
                    //
                    // ///Todo: mini player
                    // const MiniPlayer(
                    //     //callFrom: "artistPage",
                    //     ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommonContainer extends StatelessWidget {
  final Widget? icon;
  final String? text;
  final void Function()? onTap;

  const CommonContainer({Key? key, this.icon, this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 0.5, color: AppColor.orangeColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                icon!,
                const SizedBox(
                  width: 12,
                ),
                TextBase(text!,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                    color: Colors.white,
                    textAlign: TextAlign.center),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                  size: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
