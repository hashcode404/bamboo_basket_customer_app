import 'package:bamboo_basket_customer_app/application/home/home_provider.dart';
import 'package:bamboo_basket_customer_app/application/promotion/promotions_provider.dart';
import 'package:bamboo_basket_customer_app/application/search/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:bamboo_basket_customer_app/application/auth/auth_provider.dart';
import 'package:bamboo_basket_customer_app/application/core/time_dropdown_provider.dart';
import 'package:bamboo_basket_customer_app/application/notification/notification_provider.dart';
import 'package:bamboo_basket_customer_app/application/shop/shop_provider.dart';
import 'package:bamboo_basket_customer_app/domain/dependency_injection/injection_config.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../cart/cart_provider.dart';
import '../order/order_provider.dart';
import '../payment/payment_provider.dart';
import '../products/products_provider.dart';
import '../table/table_provider.dart';
import '../user/user_provider.dart';

class DependencyRegistrar {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => getIt<AuthProvider>()),
    ChangeNotifierProvider(create: (context) => getIt<ProductsProvider>()),
    ChangeNotifierProvider(create: (context) => getIt<CartProvider>()),
    ChangeNotifierProvider(create: (context) => getIt<UserProvider>()),
    ChangeNotifierProvider(create: (context) => getIt<OrderProvider>()),
    ChangeNotifierProvider(create: (context) => getIt<PaymentProvider>()),
    ChangeNotifierProvider(create: (context) => getIt<ShopProvider>()),
    ChangeNotifierProvider(create: (context) => getIt<TableProvider>()),
    ChangeNotifierProvider(
      create: (context) => TimeDropdownProvider()..generateTimeSlots(),
    ),
    ChangeNotifierProvider(create: (context) => getIt<NotificationProvider>()),
    ChangeNotifierProvider(create: (context) => getIt<PromotionsProvider>()),
    ChangeNotifierProvider(create: (context) => getIt<HomeProvider>()),
    ChangeNotifierProvider(create: (context) => getIt<SearchProvider>()),
  ];

  static Future<void> initializeAllProviders(BuildContext context) async {
    await Future.wait([]).then((value) {
      context.read<AuthProvider>().init();
      context.read<ProductsProvider>().init();
      context.read<CartProvider>().init();
      context.read<UserProvider>().init();
      context.read<OrderProvider>().init();
      context.read<PaymentProvider>().init();
      context.read<ShopProvider>().init();
      context.read<NotificationProvider>().init();
      context.read<PromotionsProvider>().init();
      context.read<HomeProvider>().init();
      context.read<SearchProvider>().init();
    });
  }
}
