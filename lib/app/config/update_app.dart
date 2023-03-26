// import 'package:flutter/material.dart';
// import 'package:new_version_plus/new_version_plus.dart';
// import 'package:ums_app/core/config/app_constant.dart';

// class UpdateApp {
//   final BuildContext context;
//   UpdateApp({required this.context});

//   final newVersion =
//       NewVersionPlus(iOSId: AppConstant.iOSId, androidId: AppConstant.androidId);

//   checkAppUpdate() {
//     if (newVersion.forceAppVersion == null) {
//       basicStatusCheck(newVersion);
//     } else {
//       advancedStatusCheck(newVersion);
//     }
//   }

//   basicStatusCheck(NewVersionPlus newVersion) {
//     newVersion.showAlertIfNecessary(context: context);
//   }

//   advancedStatusCheck(NewVersionPlus newVersion) async {
//     final status = await newVersion.getVersionStatus();
//     if (status != null) {
//       debugPrint(status.releaseNotes);
//       debugPrint(status.appStoreLink);
//       debugPrint(status.localVersion);
//       debugPrint(status.storeVersion);
//       debugPrint(status.canUpdate.toString());
//       newVersion.showUpdateDialog(
//         context: context,
//         versionStatus: status,
//         allowDismissal: false,
//         dialogTitle: 'Update',
//         dialogText:
//             'You should update ${AppConstant.appName} to the latest version.',
//       );
//     }
//   }
// }
