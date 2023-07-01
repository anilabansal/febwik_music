import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../config/widgets/background/custom_background.dart';
import '../../../config/widgets/text_base.dart';
import '../../../services/connectivity.dart';
import '../../theme/colors.dart';

class ConnectivityScreen extends StatelessWidget {
  const ConnectivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConnectionManagerController connectionManagerController = Get.find();
    return CustomBackground(child: SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Center(child: Image.asset("assets/images/wifi-icon.png"),),
         const   SizedBox(height: 30,),
            TextBase(
            "Couldn't connect to the network",
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            const SizedBox(height: 10,),
            TextBase(
              "check your network and try again",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            const SizedBox(height: 40,),
            // Obx((){
            //  return

               TextButton(
                onPressed: () async {
                  print("isAlertSet --->${connectionManagerController.isAlertSet.value }");
                  connectionManagerController.isDeviceConnected =
                  await InternetConnectionChecker().hasConnection;
                  if (!connectionManagerController.isDeviceConnected && connectionManagerController.isAlertSet.value == false) {
                    //Get.back();
                    connectionManagerController.isAlertSet.value = false;
                   print("isAlertSet --->${connectionManagerController.isAlertSet.value }");
                  }
                  else{
                    return;
                  }
                },
                child:  TextBase(
                  "Try again",
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color:AppColor.orangeColor ,
                ),
              )
            // })


          ],
        ),
      ),
    ),);
  }
}
