import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:bamboo_basket_customer_app/application/order/order_provider.dart';
import 'package:bamboo_basket_customer_app/application/user/user_provider.dart';
import 'package:bamboo_basket_customer_app/core/theme/app_theme.dart';
import 'package:bamboo_basket_customer_app/core/theme/custom_text_styles.dart';
import 'package:bamboo_basket_customer_app/domain/user/models/user_login_response.dart';
import 'package:bamboo_basket_customer_app/presentation/widgets/custom_painer_shape.dart';
import 'package:bamboo_basket_customer_app/presentation/widgets/get_provider_view.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/ui_utils.dart';
import '../../../domain/user/models/order_history_raw_data_model.dart';
import '../../../gen/assets.gen.dart';

@RoutePage()
class ViewOrderScreen extends GetProviderView<OrderProvider> {
  const ViewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = notifier(context);
    final orderListener = listener(context);
    final orderDetails = orderListener.viewOrderDetails;
    final customerDetails = listener2<UserProvider>(context).userData;

    return Theme(
      data: quickSandTextTheme(context),
      child: Scaffold(
        backgroundColor: AppColors.kLightWhite2,
        appBar: AppBar(
          title: Text(
            "Order Details",
            style: context.customTextTheme.text20W600,
          ),
          centerTitle: true,
          backgroundColor: AppColors.kLightWhite2,
        ),
        body: orderDetails == null || customerDetails == null
            ? const Center(
                child: Text(
                  "Failed to retrieve order details. Please go back and select it again.",
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: builderOrderStatusDetails(
                        orderDetails,
                        context,
                      ),
                    ),
                    verticalSpaceRegular,
                    buildOrderSummaryContainer(context, orderDetails),
                    verticalSpaceSmall,
                    _buildOrderAddressDetails(orderDetails, customerDetails),
                    verticalSpaceLarge,
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildOrderAddressDetails(
    OrderDetailsModel orderDetails,
    UserLoginResponse customerDetails,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: AppColors.kWhite,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            spreadRadius: 0,
            blurRadius: 8.0,
            offset: Offset(0, 3),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 22.0,
        vertical: 20.0,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Assets.icons.deliveryAddress.svg(),
                horizontalSpaceSmall,
                Text(
                  orderDetails.isTakeaway ? "Bill address" : "Delivery address",
                  style: context.customTextTheme.text16W600.copyWith(
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            verticalSpaceSmall,
            SizedBox(
              width: constraints.maxWidth * 0.8,
              child: Text(
                orderDetails.deliveryAddress?.customerFullAddress ?? "",
                style: context.customTextTheme.text16W500,
              ),
            ),
            Text(
              orderDetails.phone ?? "",
              style: context.customTextTheme.text16W500,
            ),
            Text(
              customerDetails.user.userEmail ?? "",
              style: context.customTextTheme.text16W500,
            ),
          ],
        );
      }),
    );
  }

  Widget buildOrderSummaryContainer(
    BuildContext context,
    OrderDetailsModel orderDetails,
  ) {
    return ClipPath(
      clipper: RPSCustomClipper(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        decoration: const BoxDecoration(
          color: AppColors.kWhite,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              spreadRadius: 0,
              blurRadius: 10.0,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Order Summary',
              style: context.customTextTheme.text16W700.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
            verticalSpaceTiny,
            ...orderDetails.orderDishes?.map((dish) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  maxLines: 2,
                                  dish.name ?? "",
                                  style: context.customTextTheme.text16W700,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  "£${dish.formatItemTotal.toStringAsFixed(2)}",
                                  style: context.customTextTheme.text16W700
                                      .copyWith(
                                    color: AppColors.kDimGray,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: SizedBox(
                                  width: constraints.maxWidth * 0.7,
                                  child: Text(
                                    dish.dishVariationAndModifiers,
                                    style: context.customTextTheme.text14W500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  );
                }).toList() ??
                [],
            verticalSpaceRegular,
            Assets.icons.zigzag.svg(),
            verticalSpaceLarge,
            _SummaryRow(
              label: "Order Type",
              value: orderDetails.formattedDeliveryType,
              style: context.customTextTheme.text14W600,
            ),
            if (orderDetails.isTakeaway) ...[
              verticalSpaceTiny,
              _SummaryRow(
                label: "Pickup Time",
                value: orderDetails.takeawayTime ?? "",
                style: context.customTextTheme.text14W600,
              ),
            ],
            verticalSpaceTiny,
            _SummaryRow(
              label: "Payment",
              value: orderDetails.paymentGatway ?? "",
              style: context.customTextTheme.text14W600,
            ),
            verticalSpaceRegular,
            Text(
              "Bill Details",
              style: context.customTextTheme.text16W600.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
            verticalSpaceSmall,
            _SummaryRow(
              label: "Sub Total",
              value: "£${orderDetails.formatSubTotal.toStringAsFixed(2)}",
              style: context.customTextTheme.text16W600,
            ),
            verticalSpaceTiny,
            _SummaryRow(
              label: "Delivery Charge",
              value: orderDetails.formattedDeliveryCharge ?? "0.00",
            ),
            verticalSpaceTiny,
            _SummaryRow(
              label: "Discount",
              value: "£ ${orderDetails.formattedDiscount}",
            ),
            verticalSpaceTiny,
            const Divider(height: 20.0),
            _SummaryRow(
              label: "Total",
              value: orderDetails.formattedAmount ?? "£0.00",
              style: context.customTextTheme.text18W600,
            ),
          ],
        ),
      ),
    );
  }

  Widget builderOrderStatusDetails(
      OrderDetailsModel order, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildStatusWidget(
          "Pending",
          completed: order.orderPending ||
              order.orderAccepted ||
              order.orderDispatched,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Divider(
              color: order.orderAccepted || order.orderDispatched
                  ? AppColors.kPrimaryColor
                  : Colors.grey.shade300,
              thickness: 1,
            ),
          ),
        ),
        buildStatusWidget(
          "Accepted",
          completed: order.orderAccepted || order.orderDispatched,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Divider(
              color: order.orderDispatched
                  ? AppColors.kPrimaryColor
                  : Colors.grey.shade300,
              thickness: 1,
            ),
          ),
        ),
        buildStatusWidget("Dispatched", completed: order.orderDispatched),
      ],
    );
  }

  Widget buildStatusWidget(
    String data, {
    bool completed = false,
  }) {
    return Builder(builder: (context) {
      return Column(
        children: <Widget>[
          Icon(
            Icons.adjust_rounded,
            color: completed ? AppColors.kPrimaryColor : AppColors.kGray7,
            size: 22,
          ),
          verticalSpaceTiny,
          Text(
            data,
            style: context.customTextTheme.text12W400.copyWith(
              color: completed ? AppColors.kPrimaryColor : AppColors.kGray7,
            ),
          )
        ],
      );
    });
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
