import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../main.dart';
import 'local_notification.dart';

class FCMService {
  static final FCMService _fcmService = FCMService._internal();

  factory FCMService() {
    return _fcmService;
  }
  FCMService._internal();
  FirebaseMessaging? _messaging;
  init() {
    _messaging = FirebaseMessaging.instance;
  }
  Future<String?> getFCMToken() async {
    String? token;
    await _messaging!.getToken().then((value) {
      token = value!;
    });
    print('============FCM Token ---> $token');
    return token;
  }

  showForGroundMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.toString());
      // print(message.notification!.body);
      _handleNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
      _handleMessageClick(message);
    });
  }

  _handleNotification(RemoteMessage remoteMessage) {
    print("noti-----${remoteMessage.data["title"]}");
    LocalNotificationService().showNotification(
        id: Random().nextInt(1000),
    title: remoteMessage.data["title"],
    message: remoteMessage.data["body"],
    payload: remoteMessage.data,
    );
  }

  _handleMessageClick(RemoteMessage message) {
    print('=========> Notification Clicked - ${message.toString()}');

  }
}