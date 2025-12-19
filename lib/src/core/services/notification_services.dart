import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin _notificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
}

class NotificationServices {

  static final NotificationServices instance = NotificationServices._private();

  NotificationServices._private();

  Future<void> init() async {
    final isGranted = await _requestNotificationPermission();

    if (isGranted != true) return;
    _setUpHandler();
  }

  Future<void> _setUpHandler() async {
    final androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');

    final iOSSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initializationSettings = InitializationSettings(
      android: androidSetting,
      iOS: iOSSettings,
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: notificationTapBackground,
    );

    _createExpenseChannel();
  }

  Future<void> _createExpenseChannel() async {
    final expenseChannel = AndroidNotificationChannel(
      "expense_1",
      "Expense",
      description: "Get expense updates from your app",
      importance: Importance.high,
    );

    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(expenseChannel);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final android = AndroidNotificationDetails(
      "expense_1",
      "Expense",
      icon: '@mipmap/ic_launcher',
      channelDescription: "Get expense updates from your app",
      priority: Priority.high,
    );

    final iOS = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentBanner: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(android: android, iOS: iOS);

    _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: body,
    );
  }

  /// Requests notification permissions for the platform.
  Future<bool?> _requestNotificationPermission() async {
    if (Platform.isIOS) {
      // Request permissions for iOS.
      return await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isAndroid) {
      // Request permissions for Android.
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      return await androidImplementation?.requestNotificationsPermission();
    }

    return false;
  }
}
