import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/config/dimensions.dart';
import 'package:music_app/app/config/widgets/background/custom_background.dart';
import 'package:music_app/app/config/widgets/background/custom_background_image.dart';
import 'package:music_app/app/config/widgets/small_text.dart';
import 'package:music_app/app/config/widgets/text_base.dart';
import 'package:music_app/app/routes/app_pages.dart';
import 'package:music_app/app/ui/pages/login_page/otp_page.dart';
import 'package:music_app/main.dart';

import '../../../auth_controller/auth_controller.dart';
import '../../theme/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
FocusNode myFocusNode =  FocusNode();
LoginRequestData _loginData = LoginRequestData();

  class LoginRequestData {
  String mobile = '';
  }

class _LoginPageState extends State<LoginPage> {

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body:CustomBackgroundImg(
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
            ];
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child:  TextBase(
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
                padding: const EdgeInsets.only(left:15.0, top: 10, bottom: 40),
                child:
                SmallText(
                  text: "We need to authenticate your monile number",
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
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),

                    child: Card(
                      color: AppColor.cardBackground,
                      shape:  RoundedRectangleBorder(
                          side:  const BorderSide(
                            color: AppColor.cardBackground,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 50.h, horizontal: 10.w),
                        child: TextFormField(
                          controller:authController.mobilePhoneNumberController ,
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

                              focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide:  const BorderSide(color:  AppColor.orangeColor)
                              ),
                              enabledBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(color:  AppColor.orangeColor,)
                              ),
                              prefixIcon:const Icon(
                                Icons.phone_android,
                                color: AppColor.orangeColor,
                              )
                          ),
                          // va
                          onChanged: (value){
                            print(value);
                            _loginData.mobile = value;
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -12,
                    child: GestureDetector(
                      onTap: () async{
                      await  authController.loginScreenApiCall(authController.mobilePhoneNumberController.value.text);

                        // if(_loginData.mobile.length == 10) {
                        //   // var verifyid;
                        //   await FirebaseAuth.instance.verifyPhoneNumber(
                        //     phoneNumber: '+91'+_loginData.mobile,
                        //     verificationCompleted: (
                        //         PhoneAuthCredential credential) {},
                        //     verificationFailed: (FirebaseAuthException e) {},
                        //     codeSent: (String verificationId,
                        //         int? resendToken) {},
                        //     codeAutoRetrievalTimeout: (String verificationId) {
                        //       // verifyid = verificationId;
                        //       print(verificationId);
                        //       navigatorKey.currentState?.push(
                        //         MaterialPageRoute(
                        //           builder: (context) =>
                        //               OtpPage(verifyid: verificationId),
                        //         ),
                        //       );
                        //     },
                        //   );
                        // }else{
                        //   print('error message for mobile number..');
                        //   print('+91'+_loginData.mobile);
                        // }
                        // // navigatorKey.currentState?.push(
                        // //   MaterialPageRoute(
                        // //     builder: (context) =>
                        // //         OtpPage(verifyid: "bb"),
                        // //   ),
                        // // );
                        // // Get.toNamed(AppRoutes.otpPage);
                      },
                      child: Container(
                        // alignment: Alignment,
                        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 40.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
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


            ],),
        ),
      ),
      ),
    );
  }}

