import 'package:auto_route/auto_route.dart';
import 'package:aj_customer/application/products/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:aj_customer/application/auth/auth_provider.dart';
import 'package:aj_customer/application/core/dependency_registrar.dart';
import 'package:aj_customer/core/routes/routes.gr.dart';
import 'package:provider/provider.dart';

import '../../gen/assets.gen.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        context.read<AuthProvider>().checkUserIsLogged().then((isLogged) {
          if (isLogged) {
            DependencyRegistrar.initializeAllProviders(context);
            context.replaceRoute(OrderOnlineScreenRoute());
            // context.read<ProductsProvider>().getAllCategories();
            // context.read<ProductsProvider>().getAllCategories();
          } else {
            context.replaceRoute(const WelcomeScreenRoute());
          }
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(Assets.images.pattern.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Assets.images.ajLogo.image(
            width: MediaQuery.of(context).size.width * 0.8,
          ),
        ),
      ),
    );
  }
}
