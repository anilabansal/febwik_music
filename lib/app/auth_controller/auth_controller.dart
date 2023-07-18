import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../dataBase/app_data_base.dart';
import '../config/widgets/progress_loader.dart';
import '../models/login_modal.dart';
import '../player/getx_playlist_repository.dart';
import '../ui/pages/login_page/otp_page.dart';
import '../ui/theme/colors.dart';

class AuthController extends GetxController {
  ///TODO: login mobile number controller
  var mobilePhoneNumberController = TextEditingController();

  ///TODO: otp verification
  String otp = '';
  var loginDetail = LoginDetail().obs;

  ///TODO: view more button api call

  Future<bool> loginScreenApiCall(phoneNumber) async {
    try {
      if (validationLogin() == "") {
        ProgressDialog.showProgressDialog(Get.context!);
        var response =
            await Get.find<GetXDemoPlaylist>().loginApiCall(phoneNumber);
        dynamic responseData = response.body;
        if (responseData["status"] == 1) {
          Navigator.of(Get.context!).pop();
          Fluttertoast.showToast(
              msg: responseData["otp"].toString(),
              textColor: Colors.white,
              backgroundColor: AppColor.orangeColor);
          print("otp --> ${responseData["otp"]}");
          Get.to(OtpPage(
            mobileNumber: mobilePhoneNumberController.text,
          ),);
          // navigatorKey.currentState?.push(
          //   MaterialPageRoute(
          //     builder: (context) => OtpPage(
          //       mobileNumber: mobilePhoneNumberController.text,
          //     ),
          //   ),
          // );
          return true;
        } else {
          Navigator.of(Get.context!).pop();
          Fluttertoast.showToast(
            msg: responseData["message"],
            textColor: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: validationLogin(),
          textColor: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print("error $e");
    }
    return false;
  }

  ///TODO: otp verification

  Future<bool> otpVerificationApiCall(body) async {
    try {
      if (otpVerification() == "") {
        ProgressDialog.showProgressDialog(Get.context!);

        var response = await Get.find<GetXDemoPlaylist>().otpVerification(body);
        dynamic responseData = response.body;
        if (responseData["status"] == 1) {
          Navigator.of(Get.context!).pop();
          Navigator.of(Get.context!).pop();
          Navigator.of(Get.context!).pop();
          // navigatorKey.currentState?.push(
          //   MaterialPageRoute(
          //     builder: (context) => const ProfilePage(),
          //   ),
          // );
          loginDetail.value = LoginDetail.fromJson(responseData);
          AppLocalStorage().setUserData(loginDetail.value);
          AppLocalStorage().setUserId(responseData["id"]??0);
          AppLocalStorage().setIsLoginUser(true);
          print("userId---->${AppLocalStorage().userDetail!.id}");
        } else {
          Navigator.of(Get.context!).pop();
          Fluttertoast.showToast(
            msg: responseData["message"],
            textColor: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: validationLogin(),
          textColor: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print("error --> $e");
    }
    return false;
  }

  ///TODO: login screen validation
  validationLogin() {
    if (mobilePhoneNumberController.text.trim().isEmpty) {
      return "Please Enter Mobile Number";
    } else {
      return "";
    }
  }

  ///TODO: otp verification validation
  otpVerification() {
    if (otp == "") {
      return "Please Enter Otp";
    } else if (otp.length != 6) {
      return "Please Enter Valid Otp";
    } else {
      return "";
    }
  }
}
