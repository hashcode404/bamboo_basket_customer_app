import 'package:bamboo_basket_customer_app/application/home/home_provider.dart';
import 'package:bamboo_basket_customer_app/core/theme/app_colors.dart';
import 'package:bamboo_basket_customer_app/core/theme/custom_text_styles.dart';
import 'package:bamboo_basket_customer_app/core/utils/ui_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/routes.gr.dart';
import '../../../gen/assets.gen.dart';

@RoutePage()
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              child: Image(image: AssetImage(Assets.images.success01.path)),
            ),
          ),
          verticalSpaceRegular,
          Text(
            'Order Created Successfully',
            style: context.customTextTheme.text20W600,
          ),
          verticalSpaceSmall,
          Text(
            'Your order has been created successfully.\n We will notify you once its out for delivery.',
            style: context.customTextTheme.text14W500
                .copyWith(color: AppColors.kGray3),
            textAlign: TextAlign.center,
          ),
          verticalSpaceRegular,
          verticalSpaceRegular,
          verticalSpaceRegular,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      side: const WidgetStatePropertyAll(
                        BorderSide(color: AppColors.kPrimaryColor),
                      ),
                      foregroundColor: const WidgetStatePropertyAll(
                        AppColors.kPrimaryColor,
                      ),
                      padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      ),
                    ),
                    onPressed: () {
                      context.router.replaceAll([
                        const OrderOnlineScreenRoute(),
                      ]);
                      context.read<HomeProvider>().onChangeCurrentPage(3);
                    },
                    child: Text(
                      'View Orders',
                      style: context.customTextTheme.text14W700,
                    ),
                  ),
                ),
                verticalSpaceRegular,
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0))),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const OrderOnlineScreen()));
                      context.router.replaceAll([
                        const OrderOnlineScreenRoute(),
                      ]);
                      context.read<HomeProvider>().onChangeCurrentPage(0);
                    },
                    child: Text(
                      'Continue Shopping',
                      style: context.customTextTheme.text14W700,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
