import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:music_app/app/config/dimensions.dart';
import 'package:music_app/app/config/widgets/background/custom_background_image.dart';
import 'package:music_app/app/config/widgets/small_text.dart';
import 'package:music_app/app/config/widgets/text_base.dart';
import '../../../auth_controller/auth_controller.dart';
import '../../theme/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

FocusNode myFocusNode = FocusNode();
LoginRequestData _loginData = LoginRequestData();

class LoginRequestData {
  String mobile = '';
}

class _LoginPageState extends State<LoginPage> {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return
        // SafeArea(
        // child: Scaffold(

        SafeArea(
      child: CustomBackgroundImg(
        child:
            // NestedScrollView(
            // headerSliverBuilder:
            //     (BuildContext context, bool innerBoxIsScrolled) {
            //   return <Widget>[];
            // },
            // body:
            Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 30),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.searchBarGreyColor,
                        ),
                        child: const Icon(Icons.close),
                      ),
                      // Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Icon(
                      //     Icons.arrow_back,
                      //     size: 35,
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextBase(
                      "Login With\nMobile Number",
                      fontWeight: FontWeight.w700,
                      fontSize: 28.sp,
                      color: Colors.white,
                    ),
                    // SmallText(
                    //   text:
                    //       "hhhh",
                    //   overFlow: TextOverflow.ellipsis,
                    //   size: Dimensions.font12,
                    //   color: Colors.white,
                    // ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 10, bottom: 40),
                    child: SmallText(
                      text: "We need to authenticate your mobile number",
                      overFlow: TextOverflow.ellipsis,
                      size: Dimensions.font12,
                      color: Colors.grey,
                    ),
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
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 50.h, horizontal: 10.w),
                            child: TextFormField(
                              controller:
                                  authController.mobilePhoneNumberController,
                              focusNode: myFocusNode,
                              cursorColor: AppColor.whiteColor,
                              // initialValue: 'Input text',
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Mobile Number',
                                  fillColor: AppColor.whiteColor,
                                  labelStyle: const TextStyle(
                                    color: AppColor.orangeColor,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: const BorderSide(
                                          color: AppColor.orangeColor)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: const BorderSide(
                                        color: AppColor.orangeColor,
                                      )),
                                  prefixIcon: const Icon(
                                    Icons.phone_android,
                                    color: AppColor.orangeColor,
                                  )),
                              // va
                              onChanged: (value) {
                                _loginData.mobile = value;
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -12,
                        child: GestureDetector(
                          onTap: () async {
                            await authController.loginScreenApiCall(
                                authController
                                    .mobilePhoneNumberController.value.text);
                          },
                          child: Container(
                            // alignment: Alignment,
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 40.w),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              gradient: const LinearGradient(
                                colors: [
                                  AppColor.orangeColor,
                                  AppColor.pinkColor,
                                ],
                              ),
                            ),
                            child: SmallText(
                              text: "Send OTP",
                              textAlign: TextAlign.center,
                              color: AppColor.blackTextColor,
                              weight: FontWeight.bold,
                              size: Dimensions.font18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // ),
      ),
    );
    //   ),
    // );
  }
}
