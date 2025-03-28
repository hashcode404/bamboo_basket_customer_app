import 'dart:developer';

import 'package:aj_customer/application/home/home_provider.dart';
import 'package:aj_customer/core/utils/ui_utils.dart';
import 'package:aj_customer/presentation/order_online/categories/categories_screen.dart';
import 'package:auto_route/annotations.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:aj_customer/application/order/order_provider.dart';
import 'package:aj_customer/core/theme/custom_text_styles.dart';
import 'package:aj_customer/presentation/order_online/cart/cart_screen.dart';
import 'package:aj_customer/presentation/order_online/home/order_online_home_screen.dart';
import 'package:aj_customer/presentation/order_online/orders/order_history_screens.dart';
import 'package:aj_customer/presentation/order_online/profile/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../application/cart/cart_provider.dart';
import '../../core/theme/app_colors.dart';

@RoutePage()
class OrderOnlineScreen extends StatefulWidget {
  const OrderOnlineScreen({super.key});

  @override
  State<OrderOnlineScreen> createState() => _OrderOnlineScreenState();
}

class _OrderOnlineScreenState extends State<OrderOnlineScreen> {
  final ValueNotifier<int> currentPageNotifier = ValueNotifier(0);

  final pages = <Widget>[
    const OrderOnlineHomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const OrderHistoryScreen(false),
    ProfileScreen(
      false,
      () {
        // log('fgfg');
      },
    ),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().fetchAllOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeListener = context.watch<HomeProvider>();
    final homeNotifier = context.read<HomeProvider>();
    final cartListener = context.watch<CartProvider>();

    return ValueListenableBuilder(
      valueListenable: homeListener.currentPage,
      builder: (context, currentPage, _) {
        final titleTextStyle = GoogleFonts.quicksand(
          textStyle: context.customTextTheme.text16W600.copyWith(
            fontWeight: FontWeight.w700,
          ),
        );
        return Scaffold(
          body: pages[currentPage],
          floatingActionButton: FloatingActionButton(
            elevation: currentPage == 2 ? null : 0.0,
            backgroundColor: AppColors.kPrimaryColor,
            onPressed: () async {
              homeNotifier.onChangeCurrentPage(2);

              await context.read<CartProvider>().listCartItems();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Badge.count(
                textColor: AppColors.kPrimaryColor,
                backgroundColor: Colors.white,
                count: cartListener.totalCartItems,
                child: const Icon(
                  FluentIcons.cart_24_regular,
                  color: Colors.white,
                )),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            notchMargin: 8.0,
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => homeNotifier.onChangeCurrentPage(0),
                  icon: Icon(
                    currentPage == 0
                        ? FluentIcons.home_24_filled
                        : FluentIcons.home_24_regular,
                    color: currentPage == 0 ? AppColors.kPrimaryColor : null,
                  ),
                ),
                IconButton(
                  onPressed: () => homeNotifier.onChangeCurrentPage(1),
                  icon: Icon(
                    currentPage == 1
                        ? FluentIcons.food_grains_24_filled
                        : FluentIcons.food_grains_24_regular,
                    color: currentPage == 1 ? AppColors.kPrimaryColor : null,
                  ),
                ),
                horizontalSpaceSmall,
                IconButton(
                  onPressed: () async {
                    homeNotifier.onChangeCurrentPage(3);
                    // await context.read<OrderProvider>().fetchAllOrders();
                  },
                  icon: Icon(
                    currentPage == 3
                        ? FluentIcons.history_24_filled
                        : FluentIcons.history_24_regular,
                    color: currentPage == 3 ? AppColors.kPrimaryColor : null,
                  ),
                ),
                IconButton(
                  onPressed: () => homeNotifier.onChangeCurrentPage(4),
                  icon: Icon(
                    currentPage == 4
                        ? FluentIcons.person_24_filled
                        : FluentIcons.person_24_regular,
                    color: currentPage == 4 ? AppColors.kPrimaryColor : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
