
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AlertDialogs {
  static void _showToast(
    String message, {
    BuildContext? context,
    String title = "Message",
    ToastificationType type = ToastificationType.info,
    Icon? icon,
    Duration autoCloseDuration = const Duration(seconds: 3),
  }) {
    toastification.show(
      context: context,
      title: Text(title),
      description: Text(message),
      autoCloseDuration: autoCloseDuration,
      alignment: Alignment.topCenter,
      showProgressBar: false,
      type: type,
      icon: icon,
      borderSide: const BorderSide(
        color: Color.fromRGBO(195, 195, 195, 1),
        width: 1.0,
      ),
      dragToClose: true,
      closeButtonShowType: CloseButtonShowType.none,
    );
  }

  static void showSuccess(String message, {BuildContext? context}) {
    _showToast(message, context: context, type: ToastificationType.success);
  }

  static void showInfo(String message, {BuildContext? context}) {
    _showToast(message, context: context, type: ToastificationType.info);
  }

  static void showWarning(String message, {BuildContext? context}) {
    _showToast(message, context: context, type: ToastificationType.warning);
  }

  static void showError(String message, {BuildContext? context}) {
    _showToast(message, context: context, type: ToastificationType.error);
  }

  static void showCustom(
    String message, {
    BuildContext? context,
    String title = "Message",
    required Icon icon,
    Duration? autoCloseDuration,
  }) {
    _showToast(
      message,
      context: context,
      title: title,
      icon: icon,
      autoCloseDuration: autoCloseDuration ?? const Duration(seconds: 3),
    );
  }
}
