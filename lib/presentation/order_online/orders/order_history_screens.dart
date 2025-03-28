import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:aj_customer/application/order/order_provider.dart';
import 'package:aj_customer/core/theme/app_colors.dart';
import 'package:aj_customer/core/theme/app_theme.dart';
import 'package:aj_customer/core/theme/custom_text_styles.dart';
import 'package:aj_customer/core/utils/date_utils.dart';
import 'package:aj_customer/core/utils/ui_utils.dart';
import 'package:aj_customer/domain/user/models/order_history_raw_data_model.dart';
import 'package:aj_customer/presentation/widgets/button_progress.dart';
import 'package:aj_customer/presentation/widgets/get_provider_view.dart';

import '../../../core/routes/routes.gr.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/custom_back_button.dart';

@RoutePage()
class OrderHistoryScreen extends GetProviderView<OrderProvider> {
  const OrderHistoryScreen(this.isFromProfileScreen, {super.key});

  final bool isFromProfileScreen;

  @override
  Widget build(BuildContext context) {
    final orderProvider = notifier(context);
    final orderListener = listener(context);

    return Theme(
      data: quickSandTextTheme(context),
      child: Scaffold(
        backgroundColor: AppColors.kLightWhite,
        appBar: AppBar(
          centerTitle: true,
          leading: isFromProfileScreen
              ? const CustomBackButton()
              : const SizedBox.shrink(),
          // leading: const CustomBackButton(),
          backgroundColor: AppColors.kLightWhite,
          automaticallyImplyLeading: false,
          leadingWidth: 70,
          title: Text(
            "Orders History",
            style: context.customTextTheme.text18W600,
          ),
        ),
        body: orderListener.ordersResponse.when(
          initial: () => const Center(child: Text("Initializing...")),
          loading: () => Center(child: showButtonProgress(AppColors.kBlack2)),
          completed: (data) {
            if (data.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.noOrders.image(
                      width: context.screenWidth * 0.4,
                      height: context.screenHeight * 0.2,
                    ),
                    verticalSpaceSmall,
                    Text(
                      'No orders found..',
                      style: context.customTextTheme.text16W700.copyWith(
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => orderProvider.fetchAllOrders(),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ListView.builder(
                    itemCount: data.length,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    itemBuilder: (context, index) {
                      final order = data.elementAt(index);
                      return InkWell(
                        onTap: () {
                          if (order.orderID == null) return;
                          orderProvider.updateViewOrderId(order.orderID!);
                          context.router.push(const ViewOrderScreenRoute());
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.10),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                buildTitleCard(order, context),
                                Divider(color: Colors.grey.shade200),
                                verticalSpaceSmall,
                                buildOrderDetails(order, context),
                                verticalSpaceRegular,
                                buildOrderFooter(order, context),
                                verticalSpaceSmall,
                                Divider(color: Colors.grey.shade200),
                                buildFooterDetails(order, context),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            );
          },
          error: (message, exception) => Center(
            child: Text(message ?? ""),
          ),
        ),
      ),
    );
  }

  Widget buildFooterDetails(OrderDetailsModel order, BuildContext context) {
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

  Widget buildOrderFooter(OrderDetailsModel order, BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(FluentIcons.calendar_20_regular),
        horizontalSpaceSmall,
        Text(
          DateTimeUtils.formatDateTimeToDate(order.orderedAt),
          style: context.customTextTheme.text14W600.copyWith(
            color: AppColors.kBlack,
          ),
        ),
        const Spacer(),
        const Icon(FluentIcons.clock_20_regular),
        horizontalSpaceSmall,
        Text(
          DateTimeUtils.formatTimeMinimal(order.orderedAt),
          style: context.customTextTheme.text14W600.copyWith(
            color: AppColors.kBlack,
          ),
        ),
      ],
    );
  }

  Widget buildOrderDetails(OrderDetailsModel order, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Assets.icons.moneyBlack.image(
          height: 24,
          width: 24,
        ),
        horizontalSpaceSmall,
        Text(
          ('${order.paymentType ?? 'N/A'} Payment'),
          style: context.customTextTheme.text14W600.copyWith(
            color: AppColors.kBlack,
          ),
        ),
        const Spacer(),
        Text(
          order.formattedAmount ?? '',
          style: context.customTextTheme.text16W600.copyWith(
            color: AppColors.kBlack,
          ),
        ),
      ],
    );
  }

  Widget buildTitleCard(OrderDetailsModel order, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Assets.images.shopid.image(
              width: 20,
              height: 20,
            ),
            horizontalSpaceSmall,
            Text(
              order.customerOrderID ?? "",
              style: context.customTextTheme.text14W700,
            ),
          ],
        ),
        horizontalSpaceSmall,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            border: Border.all(color: AppColors.kGray),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            children: [
              order.isTakeaway
                  ? Assets.icons.takeAway.image(
                      height: 22,
                      width: 22,
                      color: AppColors.kBlack,
                    )
                  : Assets.icons.fastDelivery.image(
                      height: 22,
                      width: 22,
                      color: AppColors.kBlack,
                    ),
              horizontalSpaceVerySmall,
              Text(
                order.isTakeaway ? "Pickup: ${order.takeawayTime}" : "Delivery",
                style: context.customTextTheme.text14W600.copyWith(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTextIconWidget({
    required BuildContext context,
    required String text,
    required IconData icon,
    bool isExpand = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 21,
          color: AppColors.kGray3,
        ),
        horizontalSpaceSmall,
        isExpand
            ? Expanded(
                child: Text(
                  text,
                  style: context.customTextTheme.text12W400.copyWith(
                    color: AppColors.kBlack,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              )
            : Text(
                text,
                style: context.customTextTheme.text14W400
                    .copyWith(color: AppColors.kBlack),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
      ],
    );
  }
}
