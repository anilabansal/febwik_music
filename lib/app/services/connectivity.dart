import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


  class ConnectionManagerController extends GetxController {

   StreamSubscription? subscription;
  bool isDeviceConnected = false;
   RxBool isAlertSet = false.obs;

  // getConnectivity() =>
  //     subscription = Connectivity().onConnectivityChanged.listen(
  //           (ConnectivityResult result) async {
  //         isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //         if (!isDeviceConnected && isAlertSet.value == false) {
  //           showDialogBox();
  //           // setState(() => isAlertSet = true);
  //         }
  //       },
  //     );


   getConnectivity() async {
     var connectivityResult = await (Connectivity().checkConnectivity());
     isDeviceConnected = await InternetConnectionChecker().hasConnection;

     if (connectivityResult == ConnectivityResult.none && !isDeviceConnected && isAlertSet.value == false) {
       // Get.to(const ConnectivityScreen());
       // showDialogBox();
        isAlertSet.value = true;
       print("isAlertSet --->${isAlertSet.value }");
     }

     subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
       isDeviceConnected = await InternetConnectionChecker().hasConnection;

       if (result != ConnectivityResult.none && isDeviceConnected && isAlertSet.value == true) {
         isAlertSet.value = false;
         print("isAlertSet --->${isAlertSet.value }");
       } else if (result == ConnectivityResult.none && !isDeviceConnected && isAlertSet.value == false) {
         // Get.to(const ConnectivityScreen());
         // showDialogBox();
         isAlertSet.value = true;
         print("isAlertSet --->${isAlertSet.value }");
       }
     });
   }

   // showDialogBox() {
   //   showCupertinoDialog<String>(
   //     context: Get.context!,
   //     builder: (BuildContext context) => CupertinoAlertDialog(
   //       title: const Text('No Connection'),
   //       content: const Text('Please check your internet connectivity'),
   //       actions: <Widget>[
   //         TextButton(
   //           onPressed: () async {
   //             Navigator.pop(context, 'Cancel');
   //             isAlertSet.value = false;
   //             isDeviceConnected =
   //             await InternetConnectionChecker().hasConnection;
   //             if (!isDeviceConnected && isAlertSet.value == false) {
   //               showDialogBox();
   //               isAlertSet.value = false;
   //               // setState(() => isAlertSet = true);
   //             }
   //           },
   //           child: const Text('OK'),
   //         ),
   //       ],
   //     ),
   //   );
   // }

  // //0 = No Internet, 1 = WIFI Connected ,2 = Mobile Data Connected.
  // var connectionType = 0.obs;
  //
  // final Connectivity connectivity = Connectivity();
  //
  // late StreamSubscription _streamSubscription;
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   getConnectivityType();
  //   // _streamSubscription =
  //       connectivity.onConnectivityChanged.listen(updateState);
  // }
  //
  // Future<void> getConnectivityType() async {
  //   late ConnectivityResult connectivityResult;
  //   try {
  //     connectivityResult = await (connectivity.checkConnectivity());
  //   } on PlatformException catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  //   return updateState(connectivityResult);
  // }
  //
  // updateState(ConnectivityResult result) {
  //   switch (result) {
  //     case ConnectivityResult.wifi:
  //       connectionType.value = 1;
  //       break;
  //     case ConnectivityResult.mobile:
  //       connectionType.value = 2;
  //
  //       break;
  //     case ConnectivityResult.none:
  //       connectionType.value = 0;
  //       break;
  //     default:
  //       //showSnackBar(title: 'Error', message: 'Failed to get connection type');
  //       break;
  //   }
  // }
  //
  // @override
  // void onClose() {
  //   _streamSubscription.cancel();
  // }
}