import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:bamboo_basket_customer_app/application/core/dependency_registrar.dart';
import 'package:bamboo_basket_customer_app/core/constants/app_identifiers.dart';
import 'package:bamboo_basket_customer_app/core/routes/routes.dart';
import 'package:bamboo_basket_customer_app/core/theme/app_theme.dart';
import 'package:bamboo_basket_customer_app/domain/dependency_injection/injection_config.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import 'application/notification/notification_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  Stripe.publishableKey = AppIdentifiers.stripeTestPublishableKey;
  configureInjection();

  // FirebaseMessaging.instance.getToken().then((token) => log(token.toString(), name: "FCM_TKN"));
  if (Platform.isIOS) {
    FirebaseMessaging.instance
        .getAPNSToken()
        .then((token) => log(token.toString(), name: "FCM_TKN"));
  } else if (Platform.isAndroid) {
    FirebaseMessaging.instance
        .getToken()
        .then((token) => log(token.toString(), name: "FCM_TKN"));
  }
  // FirebaseMessaging.onMessage.listen((message) {
  //   if (message.data["title"] != null || message.data["body"] != null) {
  //     NotificationProvider().showNotification(
  //       message.data["title"],
  //       message.data["body"],
  //     );
  //   }
  // });

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(const MyApp()));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.data["title"] != null || message.data["body"] != null) {
    NotificationProvider().showNotification(
      message.data["title"],
      message.data["body"],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _appRouter = AppRouter();

  MaterialApp _buildMaterialApp(BuildContext context) {
    return MaterialApp.router(
      title: AppIdentifiers.kApplicationName,
      debugShowCheckedModeBanner: false,
      theme: appTheme(context),
      routerConfig: _appRouter.config(),
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(0.95)),
            child: ToastificationWrapper(child: child!));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: DependencyRegistrar.providers,
      child: Builder(
        builder: (context) => _buildMaterialApp(context),
      ),
    );
  }
}
