import 'package:bamboo_basket_customer_app/application/shop/shop_provider.dart';
import 'package:bamboo_basket_customer_app/core/theme/custom_text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartx/dartx.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../../application/cart/cart_provider.dart';
import '../../../application/user/user_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/ui_utils.dart';

class CheckoutDetailsScreen extends StatelessWidget {
  const CheckoutDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartListener = context.watch<CartProvider>();
    final userListener = context.watch<UserProvider>();
    final shopListener = context.watch<ShopProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceRegular,
          ListTile(
            leading: const Icon(FluentIcons.cart_24_regular),
            trailing: const Icon(FluentIcons.chevron_right_24_regular),
            title: const Text("Items"),
            // subtitle: const Text("**** **** **** 4242"),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(15.0)),
            onTap: () {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                builder: (context) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: cartListener.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartListener.cartItems.elementAt(index);
                      return Column(
                        children: [
                          Row(
                            children: [
                              product.variation != null
                                  ? Text(
                                      "${product.productName ?? 'N/A'} (${product.variation ?? 'N/A'})",
                                      style: context.customTextTheme.text16W700
                                          .copyWith(fontSize: 14),
                                    )
                                  : Text(
                                      product.productName ?? 'N/A',
                                      style: context.customTextTheme.text16W700
                                          .copyWith(fontSize: 14),
                                    ),
                              // const Spacer(),
                              horizontalSpaceSmall,

                              Text(product.product_total_price ?? 'N/A'),
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
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  );
                },
              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const _CartItemsSummary(),
              //     fullscreenDialog: true,
              //   ),
              // );
            },
          ),
          verticalSpaceRegular,
          Visibility(
            visible: false,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order Type",
                          style: context.customTextTheme.text14W600),
                      verticalSpaceTiny,
                      ListTile(
                        leading: const Icon(FluentIcons.card_ui_24_regular),
                        title: Text(
                            cartListener.selectedOrderType == OrderType.delivery
                                ? OrderType.delivery.label
                                : OrderType.takeaway.label),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ],
                  ),
                ),
                horizontalSpaceRegular,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Payment Method",
                          style: context.customTextTheme.text14W600),
                      verticalSpaceTiny,
                      ListTile(
                        leading: const Icon(FluentIcons.card_ui_24_regular),
                        title: Text(cartListener.selectedPaymentMethod ==
                                PaymentMethod.cash
                            ? PaymentMethod.cash.label
                            : PaymentMethod.card.label),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Text("Delivery Date & Time",
          //     style: context.customTextTheme.text16W600),
          // verticalSpaceTiny,
          // Text(
          //   shopListener.formattedSelectedDate,
          //   style: context.customTextTheme.text16W500,
          // ),
          // verticalSpaceTiny,
          // shopListener.selectedDeliverySlot != null
          //     ? Text(
          //         "${shopListener.selectedDeliverySlot?.openingTime} - ${shopListener.selectedDeliverySlot?.closingTime}",
          //         style: context.customTextTheme.text14W600,
          //       )
          //     : Text(
          //         'Empty',
          //         style: context.customTextTheme.text14W400,
          //       ),
          // verticalSpaceRegular,
          Text(
              cartListener.selectedOrderType == OrderType.delivery
                  ? "Delivery Address"
                  : "Billing Address",
              style: context.customTextTheme.text16W600),
          verticalSpaceTiny,
          Text(
            cartListener.selectedAddress?.userFulladdress
                    .trimLeft()
                    .capitalize() ??
                '',
            style: GoogleFonts.quicksand(
              textStyle: context.customTextTheme.text16W500.copyWith(
                color: AppColors.kBlack2,
              ),
            ),
          ),
          Text(
            userListener.userData?.user.userMobile ?? "",
            style: GoogleFonts.quicksand(
              textStyle: context.customTextTheme.text16W500,
            ),
          ),
          Text(
            userListener.userData?.user.userEmail ?? "",
            style: GoogleFonts.quicksand(
              textStyle: context.customTextTheme.text16W500,
            ),
          ),
          verticalSpaceRegular,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Payment Method : ",
                  style: GoogleFonts.quicksand(
                    textStyle: context.customTextTheme.text16W600
                        .copyWith(color: AppColors.kBlack2),
                  ),
                ),
                TextSpan(
                  text:
                      " ${cartListener.selectedPaymentMethod == PaymentMethod.cash ? PaymentMethod.cash.label : PaymentMethod.card.label}",
                  style: GoogleFonts.quicksand(
                    textStyle: context.customTextTheme.text16W500.copyWith(
                      color: AppColors.kBlack2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          verticalSpaceRegular,
          Text(
            "Bill Details",
            style: context.customTextTheme.text16W500,
          ),
          verticalSpaceSmall,
          _SummaryRow(
            label: "Sub Total",
            value: cartListener.cartTotalPriceDisplay ?? "£0.00",
            style: context.customTextTheme.text16W600,
          ),
          verticalSpaceTiny,
          _SummaryRow(
            label: cartListener.selectedOrderType == OrderType.takeaway
                ? "Takeaway Charge"
                : "Delivery Charge",
            value: "£${cartListener.calculatedDeliveryFee.toStringAsFixed(2)}",
          ),
          verticalSpaceTiny,
          _SummaryRow(
            label: "Discount",
            value: "-£${cartListener.calculatedDiscount.toStringAsFixed(2)}",
          ),
          verticalSpaceTiny,
          // _SummaryRow(
          //   label: "Coupon Discount",
          //   value: "-£${cartListener.offerDiscount.toStringAsFixed(2)}",
          // ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? style;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: style ?? context.customTextTheme.text14W500,
        ),
        Text(
          value,
          style: style ?? context.customTextTheme.text14W500,
        ),
      ],
    );
  }
}

class _CartItemsSummary extends StatelessWidget {
  const _CartItemsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final cartListener = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Summary"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: cartListener.cartItems.length,
        itemBuilder: (context, index) {
          final product = cartListener.cartItems.elementAt(index);
          return Column(
            children: [
              Row(
                children: [
                  product.variation != null
                      ? Text(
                          "${product.productName ?? 'N/A'} (${product.variation ?? 'N/A'})",
                          style: context.customTextTheme.text16W700
                              .copyWith(fontSize: 14),
                        )
                      : Text(
                          product.productName ?? 'N/A',
                          style: context.customTextTheme.text16W700
                              .copyWith(fontSize: 14),
                        ),
                  // const Spacer(),
                  horizontalSpaceSmall,

                  Text(product.product_total_price ?? 'N/A'),
                ],
              ),
              product.master_addon_apllied.isNotEmpty == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: product.master_addon_apllied
                          .map(
                            (addon) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: addon.choosedOption
                                        .map((option) => Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0),
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(" + ${option.text}"),
                                                  // const Spacer(),
                                                  horizontalSpaceSmall,
                                                  Text(option.price ?? 'N/A'),
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
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
