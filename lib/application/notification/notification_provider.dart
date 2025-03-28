import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:aj_customer/application/core/base_controller.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@LazySingleton()
class NotificationProvider extends ChangeNotifier with BaseController {
  bool _isPermissionGranted = false;

  bool get isPermissionGranted => _isPermissionGranted;

  List<String> _notifications = [];

  List<String> get notifications => _notifications;

  @override
  Future<void> init() async {
    requestNotificationPermission();
    await initializeNotifications();
    return super.init();
  }

  Future<void> initializeNotifications() async {
    // Initialize Awesome Notifications
    AwesomeNotifications().initialize(
      // Set the icon for Android notifications
      null,
      [
        NotificationChannel(
          channelKey: 'order_notification',
          channelName: 'Order Notifications',
          channelDescription: 'Notification channel for order-related updates',
          defaultColor: Colors.deepPurple,
          ledColor: Colors.white,
          importance: NotificationImportance.High,
        ),
      ],
      // Configure the app to show notifications while in foreground
      debug: true,
    );
  }

  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      final status = await Permission.notification.request();

      if (status.isGranted) {
        _isPermissionGranted = true;
        notifyListeners();
      } else {
        _isPermissionGranted = false;
        notifyListeners();
      }
    }
  }

  void addNotification(String message) {
    _notifications.add(message);
    notifyListeners();
  }

  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }

  void showNotification(String title, String body) async {
    try {
      // Create and display the notification
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(), // Unique notification ID
          channelKey: 'order_notification',
          title: title,
          body: body,
          notificationLayout: NotificationLayout.Default,
        ),
      );

      // Add the notification message to the list (if needed)
      // addNotification("$title: $body");
    } catch (e) {
      log("Error showing notification: $e");
    }
  }

  // Generate a unique ID for each notification
  int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }
}
