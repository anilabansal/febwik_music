import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final LocalNotificationService _localNotificationService =
  LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _localNotificationService;
  }

  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    // final IOSInitializationSettings initializationSettingsIOS =
    // IOSInitializationSettings(
    //   requestSoundPermission: true,
    //   requestBadgePermission: true,
    //   requestAlertPermission: true,
    //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    // );
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:onDidReceiveLocalNotification
    );
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
   //  iOS: initializationSettingsIOS,
     iOS: initializationSettingsDarwin,
      macOS: null,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
     // onDidReceiveNotificationResponse:onDidReceiveLocalNotification
      // onSelectNotification: selectNotification
      onDidReceiveNotificationResponse:  selectNotification
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void selectNotification(NotificationResponse notificationResponse) {
    switch (notificationResponse.notificationResponseType) {

      case NotificationResponseType.selectedNotification:
      // if (notificationResponse.actionId == navigationActionId) {
      //   selectNotificationSubject.add(notificationResponse.payload);
      // }
      //   if(notificationResponse.payload!=null && notificationResponse.payload!.isNotEmpty ){
          print('=========> Notification Clicked - ${notificationResponse.payload.toString()}');
          final data = json.decode(notificationResponse.payload!);
        // }
        break;
      case NotificationResponseType.selectedNotificationAction:
        // TODO: Handle this case.
        break;
    }


  }

  // void selectNotification(String? payload) async {
  //   ///Handle notification tapped logic here
  //   print('=========> Notification Clicked - ${payload.toString()}');
  //
  //   final data = json.decode(payload!);
  //
  // }

  void onDidReceiveLocalNotification(
      int id, String? payload, String? payload1, String? payload2) async {
    ///Handle notification logic here
  }

  showNotification({
    int id = 123,
    String? title,
    String? message,
    String? image,
    Map<String, dynamic>? payload,
  }) async {
    ///Create channel specifics for iOS
    //  IOSNotificationDetails iOSPlatformChannelSpecifics =
    //     IOSNotificationDetails(
    //        subtitle:""
    //
    //     );

    ///Create channel specifics for android
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails(
      'Booking table',
      'Booking table',
      channelDescription: 'Booking table',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    ///create platform channel specifics
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      //  iOS: iOSPlatformChannelSpecifics,
    );

    ///show notification
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      message,
      platformChannelSpecifics,
      payload: json.encode(payload),
    );
  }
}