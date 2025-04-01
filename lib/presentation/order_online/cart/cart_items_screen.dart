import 'dart:developer';

import 'package:bamboo_basket_customer_app/application/shop/shop_provider.dart';
import 'package:bamboo_basket_customer_app/core/theme/app_colors.dart';
import 'package:bamboo_basket_customer_app/core/theme/custom_text_styles.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../application/cart/cart_provider.dart';
import '../../../application/user/user_provider.dart';
import '../../../core/utils/ui_utils.dart';
import '../../widgets/qty_counter_button.dart';

class CartItemsScreen extends StatefulWidget {
  const CartItemsScreen({super.key});

  @override
  State<CartItemsScreen> createState() => _CartItemsScreenState();
}

class _CartItemsScreenState extends State<CartItemsScreen> {
  @override
  Widget build(BuildContext context) {
    final cartListener = context.watch<CartProvider>();
    final cartProvider = context.read<CartProvider>();
    final userListener = context.watch<UserProvider>();
    final userProvider = context.read<UserProvider>();
    final shopProvider = context.read<ShopProvider>();
    final shopListener = context.watch<ShopProvider>();
    return Column(
      children: [
        verticalSpaceRegular,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.swipe_outlined,
              color: Colors.grey,
            ),
            horizontalSpaceSmall,
            Text(
              'Swipe to delete',
              style: context.customTextTheme.text14W700
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
            )
          ],
        ),
        verticalSpaceRegular,
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 15)
                .copyWith(bottom: 150),
            itemCount: cartListener.cartItems.length,
            itemBuilder: (context, index) {
              final product = cartListener.cartItems.elementAt(index);
              return Dismissible(
                background: Container(
                  padding: const EdgeInsets.only(right: 10.0),
                  color: Colors.red.shade700,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'DELETE',
                      style: context.customTextTheme.text16W600
                          .copyWith(color: AppColors.kWhite),
                    ),
                  ),
                ),
                key: UniqueKey(),
                onDismissed: (direction) async {
                  await cartProvider.removeCartItem(product.cartID);
                  log('direction: $direction');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              product.variation != null
                                  ? SizedBox(
                                      width: context.screenWidth * 0.5,
                                      child: Tooltip(
                                        message:
                                            "${product.productName ?? 'N/A'} (${product.variation ?? 'N/A'})",
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${product.productName ?? 'N/A'} (${product.variation ?? 'N/A'})",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: context
                                                  .customTextTheme.text16W700
                                                  .copyWith(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(product.product_total_price ??
                                                'N/A'),
                                          ],
                                        ),
                                      ))
                                  : SizedBox(
                                      width: context.screenWidth * 0.5,
                                      child: Tooltip(
                                        message:
                                            "${product.productName ?? 'N/A'} (${product.variation ?? 'N/A'})",
                                        triggerMode: TooltipTriggerMode.tap,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.productName ?? 'N/A',
                                              style: context
                                                  .customTextTheme.text16W700
                                                  .copyWith(fontSize: 14),
                                            ),
                                            Text(product.product_total_price ??
                                                'N/A'),
                                          ],
                                        ),
                                      ),
                                    ),
                              // const Spacer(),
                            ],
                          ),
                          product.master_addon_apllied.isNotEmpty == true
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: product.master_addon_apllied
                                      .map(
                                        (addon) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // RichText(
                                            //   text: TextSpan(
                                            //     text: '|  ',
                                            //     style: const TextStyle(color: Colors.grey),
                                            //     children: [
                                            //       TextSpan(text: addon.title, style: const TextStyle(color: Colors.black)),
                                            //     ],
                                            //   ),
                                            // ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: addon.choosedOption
                                                    .map((option) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 0.0),
                                                          child: Row(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                  " + ${option.text}"),
                                                              // const Spacer(),
                                                              horizontalSpaceSmall,
                                                              Text(option
                                                                      .price ??
                                                                  'N/A'),
                                                              // horizontalSpaceTiny,
                                                              // const Icon(
                                                              //   Icons.delete_outline,
                                                              //   color: Colors.transparent,
                                                              // )
                                                            ],
                                                          ),
                                                        ))
                                                    .toList())
                                          ],
                                        ),
                                      )
                                      .toList(),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      const Spacer(),
                      QtyCounterButton2(
                          onDecrementQty: () async {
                            cartProvider.clearSelectedAddressSecondary();
                            cartProvider.clearSelectedAddress();
                            shopProvider.clearSelectedDeliverySlot();
                            cartProvider.clearDiscountValue();
                            await cartProvider.decrementCartItemQty(index);
                          },
                          previousQty: 0,
                          qty: (product.quantity ?? '0').toInt(),
                          onIncrementQty: () async {
                            cartProvider.clearSelectedAddressSecondary();
                            cartProvider.clearSelectedAddress();
                            shopProvider.clearSelectedDeliverySlot();
                            cartProvider.clearDiscountValue();

                            await cartProvider.incrementCartItemQty(index);
                          }),
                      horizontalSpaceRegular
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ),
      ],
    );
  }
}
