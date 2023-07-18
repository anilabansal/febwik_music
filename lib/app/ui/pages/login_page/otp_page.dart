import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/app/config/dimensions.dart';
import 'package:music_app/app/config/widgets/background/custom_background_image.dart';
import 'package:music_app/app/config/widgets/small_text.dart';
import 'package:music_app/app/config/widgets/text_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';
import '../../../auth_controller/auth_controller.dart';
import '../../theme/colors.dart';

class OtpPage extends StatefulWidget {
  final String? mobileNumber;
  const OtpPage({ Key? key, this.mobileNumber}) : super(key: key);
  @override
  State<OtpPage> createState() => _OtpPageState();
}
// OtpRequestData _otpData = OtpRequestData();
//
// class OtpRequestData {
//   String otp = '';
// }
FocusNode myFocusNode =  FocusNode();
final FirebaseAuth auth = FirebaseAuth.instance;

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {

    AuthController authController = Get.put(AuthController());
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20.sp, color: AppColor.whiteColor, fontWeight: FontWeight.w200),
        decoration:const BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.orangeColor)))
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return SafeArea(
      child: Scaffold(body:CustomBackgroundImg(
        child: NestedScrollView(
            physics:const NeverScrollableScrollPhysics(),
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // SliverAppBar(
              //   title: SmallText(
              //     text:
              //         "lllll",
              //     size: Dimensions.font16,
              //   ),
              //   pinned: true,
              //   elevation: 0,
              //   centerTitle: false,
              //   flexibleSpace: FlexibleSpaceBar(
              //     collapseMode: CollapseMode.pin,
              //
              //   ),
              //
              // ),
            ];
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child:  TextBase(
                  "Enter 6 Digit\nSecurity Code",
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
                  text: "Enter the code received on ${widget.mobileNumber}",
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
                          side: const BorderSide(
                            color: AppColor.cardBackground,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // padding: EdgeInsets.symmetric(horizontal: 15.h),
                            padding:const EdgeInsets.only(left: 15, top: 20),
                            // margin: EdgeInsets.only(left: 15, top: 20),
                            child: SmallText(
                              text: "Enter Code",
                              overFlow: TextOverflow.ellipsis,
                              size: Dimensions.font12,
                              color: AppColor.orangeColor,
                            ),
                          ),

                          SizedBox(
                            // width: 50,
                            // height: 90,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 10.w),
                              child: Pinput(
                                defaultPinTheme: defaultPinTheme,
                                // validator: (s) {
                                //   return s?.length == 6 ? null : 'Pin is incorrect';
                                // },
                                length: 6,
                                // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                showCursor: true,
                                // onCompleted: (pin) {
                                //   print("pin"+pin);
                                // },
                                onChanged: (pin){
                                  print("pin"+pin);
                                  authController.otp = pin;
                                },
                              ),
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: const [
                          //     // Otp(),
                          //     // Otp(),
                          //     // Otp(),
                          //     // Otp(),
                          //     // Otp(),
                          //     // Otp(),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -12,
                    child: GestureDetector(
                      onTap: () async{
                      await  authController.otpVerificationApiCall({
                          "contact_no": widget.mobileNumber,
                          "otp" : authController.otp,
                        });

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
                          text: "Verify",
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
              Padding(
                padding: const EdgeInsets.only(left:0.0, top: 60, bottom: 0),
                child:
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallText(
                      text: "Didn't receive code? ",
                      overFlow: TextOverflow.ellipsis,
                      size: Dimensions.font14,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: (){
                        authController.loginScreenApiCall(authController.mobilePhoneNumberController.value.text);
                      },
                      child: SmallText(
                        text: "Resend",
                        overFlow: TextOverflow.ellipsis,
                        size: Dimensions.font14,
                        color: AppColor.orangeColor,
                      ),
                    )
                  ],
                ),
              ),

            ],),
        ),
      ),
      ),
    );
  }}
// For otp filed.
// class Otp extends StatelessWidget {
//   const Otp({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return SizedBox(
//       width: 50,
//       height: 90,
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
//         child: TextFormField(
//           cursorColor: AppColor.whiteColor,
//           keyboardType: TextInputType.number,
//           style: Theme.of(context).textTheme.headline6,
//           textAlign: TextAlign.center,
//           inputFormatters: [
//             LengthLimitingTextInputFormatter(1),
//             FilteringTextInputFormatter.digitsOnly,
//           ],
//           onChanged: (value) {
//             if (value.length == 1) {
//               FocusScope.of(context).nextFocus();
//             }
//             if (value.isEmpty) {
//               FocusScope.of(context).previousFocus();
//             }
//             _otpData.otp = value;
//             print(value);
//           },
//           decoration: const InputDecoration(
//             // hintText: ('0'),
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: AppColor.orangeColor),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: AppColor.whiteColor),
//               ),
//             // border: OutlineInputBorder(
//             // ),
//           ),
//           onSaved: (value) {},
//         ),
//       ),
//     );
//   }
// }

