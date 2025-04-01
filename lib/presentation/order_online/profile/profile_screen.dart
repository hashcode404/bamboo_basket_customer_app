import 'dart:developer';

import 'package:bamboo_basket_customer_app/application/order/order_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
// Import flutter_svg to handle SVG
import 'package:bamboo_basket_customer_app/application/user/user_provider.dart';
import 'package:bamboo_basket_customer_app/core/routes/routes.gr.dart';
import 'package:bamboo_basket_customer_app/core/theme/app_colors.dart';
import 'package:bamboo_basket_customer_app/core/theme/custom_text_styles.dart';
import 'package:bamboo_basket_customer_app/core/utils/ui_utils.dart';
import 'package:bamboo_basket_customer_app/gen/assets.gen.dart';
import 'package:bamboo_basket_customer_app/presentation/widgets/bottom_sheet_drag_handler.dart';
import 'package:bamboo_basket_customer_app/presentation/widgets/get_provider_view.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../../application/auth/auth_provider.dart';
import '../../../core/utils/date_utils.dart';
import '../../../domain/user/models/order_history_raw_data_model.dart';
import '../../widgets/button_progress.dart';

@RoutePage()
class ProfileScreen extends GetProviderView<UserProvider> {
  const ProfileScreen(this.isFromHome, this.onTap, {super.key});
  final bool isFromHome;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final userProvider = notifier(context);
    final userListner = listener(context);
    final orderProvider = notifier2<OrderProvider>(context);
    final orderListener = listener2<OrderProvider>(context);
    final String userId = userListner.userData?.user.userID ?? '';

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.kWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBioWidget(userListner, context),
                verticalSpaceRegular,
                orderListener.ordersResponse.when(
                  initial: () => const Center(child: Text("Initializing...")),
                  loading: () =>
                      Center(child: showButtonProgress(AppColors.kBlack2)),
                  completed: (data) {
                    if (data.isEmpty) {
                      return _buildNoOrderWidget(context);
                    }

                    return buidOrdderHistoryWidget(data);
                  },
                  error: (message, exception) => Center(
                    child: Text(message ?? ""),
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  'Address',
                  style: context.customTextTheme.text16W600,
                ),
                verticalSpaceSmall,
                _buildUpdateAddress(context),
                verticalSpaceRegular,
                Text(
                  'Settings',
                  style: context.customTextTheme.text16W600,
                ),
                verticalSpaceSmall,
                _buildSettingOptions(context),
                verticalSpaceMedium,
                Text(
                  'Shop Info',
                  style: context.customTextTheme.text16W600,
                ),
                verticalSpaceSmall,
                buildShopInfo(context),
                verticalSpaceLarge,
                verticalSpaceLarge,
                verticalSpaceLarge,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buidOrdderHistoryWidget(List<OrderDetailsModel> data) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
          itemCount: 1,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemBuilder: (context, index) {
            final order = data.elementAt(index);
            return InkWell(
              // onTap: () {
              //   if (order.orderID == null) return;
              //   orderProvider.updateViewOrderId(order.orderID!);
              //   context.router.push(const ViewOrderScreenRoute());
              // },
              child: Container(
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
                      buildHeader(context),
                      verticalSpaceSmall,
                      buildTitleCard(order, context),
                      Divider(color: Colors.grey.shade200),
                      verticalSpaceSmall,
                      buildOrderDetails(order, context),
                      verticalSpaceSmall,
                      Divider(color: Colors.grey.shade200),
                      buildFooterDetails(order, context),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildNoOrderWidget(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'My Orders',
          style: context.customTextTheme.text16W600,
        ),
        TextButton(
            onPressed: () {
              context.router
                  .push(OrderHistoryScreenRoute(isFromProfileScreen: true));
            },
            child: Text(
              'See All',
              style: context.customTextTheme.text14W500
                  .copyWith(color: AppColors.kPrimaryColor),
            ))
      ],
    );
  }

  Widget _buildUpdateAddress(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return Container(
      // margin: EdgeInsets.symmetric(horizontal: isFromHome ? 20.0 : 0.00),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.kGray2.withOpacity(0.5),
              blurRadius: 6.0,
              offset: const Offset(0, 3),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () async {
              context.router.push(const UserAddressScreenRoute());
              await context.read<UserProvider>().getAddressList();
            },
            leading: const Icon(
              FluentIcons.location_24_regular,
              color: AppColors.kGray,
            ),
            title: Text(
              'Update Address',
              style: context.customTextTheme.text14W600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShopInfo(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return Container(
      // margin: EdgeInsets.symmetric(horizontal: isFromHome ? 20.0 : 0.00),
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(10.0),
        // border: Border.all(color: AppColors.kPrimaryColor)
        boxShadow: [
          BoxShadow(
            color: AppColors.kGray2.withOpacity(0.5),
            blurRadius: 6.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () async {},
            leading: const Icon(
              Icons.phone,
              color: AppColors.kSecondaryColor,
            ),
            title: Text(
              '+44 7715819009',
              style: context.customTextTheme.text14W500
                  .copyWith(color: AppColors.kBlack3),
            ),
          ),
          ListTile(
            onTap: () async {},
            leading: const Icon(
              Icons.mail,
              color: AppColors.kSecondaryColor,
            ),
            title: Text(
              'info@bamboobasket.shop',
              style: context.customTextTheme.text14W500
                  .copyWith(color: AppColors.kBlack3),
            ),
          ),
          ListTile(
            onTap: () async {},
            leading: const Icon(
              Icons.location_on_rounded,
              color: AppColors.kSecondaryColor,
            ),
            title: Text(
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              '13a colbea 1 george williams way Essex United Kingdom CO1 2JS',
              style: context.customTextTheme.text14W500
                  .copyWith(color: AppColors.kBlack3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingOptions(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return Container(
      // margin: EdgeInsets.symmetric(horizontal: isFromHome ? 20.0 : 0.00),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.kGray2.withOpacity(0.5),
              blurRadius: 6.0,
              offset: const Offset(0, 3),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () async {
              authProvider.onChangeSelectedAuthView(AuthView.forgotPassword);
              context.router.push(LoginScreenRoute(isFromProfile: true));
            },
            leading: const Icon(
              FluentIcons.lock_closed_12_regular,
              color: AppColors.kSecondaryColor,
            ),
            title: Text(
              'Change Password',
              style: context.customTextTheme.text14W600,
            ),
          ),
          // ListTile(
          //   onTap: () {},
          //   leading: const Icon(
          //     FluentIcons.alert_24_regular,
          //     color: AppColors.kGray,
          //   ),
          //   title: Text(
          //     'Notifications',
          //     style: context.customTextTheme.text14W600,
          //   ),
          // ),
          ListTile(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  builder: (context) {
                    return Container(
                        height: context.heightPx * 0.4,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: const BoxDecoration(
                          color: AppColors.kWhite,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BottomSheetDragHandler(),
                            verticalSpaceMedium,
                            Container(
                              width: context.screenWidth * 0.2,
                              height: context.screenWidth * 0.2,
                              decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Icon(
                                Icons.logout_rounded,
                                color: AppColors.kPrimaryColor,
                                size: 50,
                              ),
                            ),
                            verticalSpaceMedium,
                            Text(
                              'Confirm Logout',
                              style:
                                  context.customTextTheme.text14W600.copyWith(
                                color: AppColors.kBlack,
                              ),
                            ),
                            verticalSpaceSmall,
                            Text(
                              'Are you sure you want to logout?',
                              style: context.customTextTheme.text14W700,
                            ),
                            verticalSpaceMedium,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: AppColors.kWhite,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Not Now',
                                      style: context.customTextTheme.text14W600
                                          .copyWith(
                                              color: AppColors.kPrimaryColor),
                                    ),
                                  ),
                                ),
                                horizontalSpaceSmall,
                                Flexible(
                                  child: FilledButton(
                                    onPressed: () async {
                                      await authProvider.logoutUser();
                                      context.router
                                          .replace(LoginScreenRoute());
                                    },
                                    style: FilledButton.styleFrom(
                                        backgroundColor:
                                            AppColors.kPrimaryColor),
                                    child: Text(
                                      'Logout',
                                      style: context.customTextTheme.text14W600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            verticalSpaceSmall,
                          ],
                        ));
                  });
            },
            leading: const Icon(
              Icons.logout,
              color: AppColors.kSecondaryColor,
            ),
            title: Text(
              'Logout',
              style: context.customTextTheme.text14W600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertBox() {
    return AlertDialog(
      title: const Text('Logout this app'),
      actions: <Widget>[
        OutlinedButton(onPressed: () {}, child: const Text('Cancel')),
        ElevatedButton(
          style: const ButtonStyle(
            elevation: WidgetStatePropertyAll(0),
          ),
          onPressed: () {},
          child: const Text('Logout'),
        ),
      ],
    );
  }

  Widget _buildMyOrderButtons(BuildContext context, VoidCallback onTap) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return AppColors.kBlack3;
                  }
                  return AppColors.kWhite;
                },
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return AppColors.kWhite;
                  }
                  return AppColors.kBlack3;
                },
              ),
              side: WidgetStateProperty.all(
                const BorderSide(color: AppColors.kGray),
              ),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              elevation: WidgetStateProperty.all(0),
            ),
            onPressed: onTap,
            // onPressed: () {
            // context.router.push(const OrderOnlineScreenRoute());

            // },
            child: Text(
              'Order History',
              style: context.customTextTheme.text14W700,
            ),
          ),
        ),
        horizontalSpaceMedium,
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return AppColors.kWhite;
                  }
                  return AppColors.kPrimaryColor;
                },
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return AppColors.kBlack3;
                  }
                  return AppColors.kWhite;
                },
              ),
              side: WidgetStateProperty.all(
                const BorderSide(color: AppColors.kPrimaryColor),
              ),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              elevation: WidgetStateProperty.all(0),
            ),
            onPressed: () {
              context.router.push(const OrderOnlineScreenRoute());
            },
            child: Text(
              'Order Online',
              style: context.customTextTheme.text14W700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfigShopDetails(BuildContext context) {
    log(isFromHome.toString());
    return Row(
      children: [
        SizedBox(
            width: context.screenWidth * 0.2,
            height: context.screenWidth * 0.2,
            child: Image.asset('assets/images/Profile_circle.png')),
        horizontalSpaceSmall,
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Welcome to Best Options',
                  style: context.customTextTheme.text16W400
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      ", your premier grocery store. We bring you quality and convenience with care!",
                  style: context.customTextTheme.text14W400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBioWidget(UserProvider userListener, BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpaceLarge,
          // Image(
          //     height: 100,
          //     image: AssetImage(
          //       Assets.images.profilePhoto.path,
          //     )),

          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.kPrimaryColor),
            child: Icon(
              FluentIcons.person_48_regular,
              size: MediaQuery.of(context).size.height * 0.08,
              color: AppColors.kWhite,
            ),
          ),
          verticalSpaceSmall,
          Text(
            ' ${userListener.userFullName}',
            style: context.customTextTheme.text20W600
                .copyWith(color: AppColors.kBlack),
          ),
          verticalSpaceSmall,
          Text(
            (userListener.userData?.user.userEmail?.isNotEmpty ?? false)
                ? userListener.userData!.user.userEmail!
                : 'No email found',
            style: context.customTextTheme.text16W400,
          ),
          verticalSpaceTiny,
          // Text(
          //   (userListener.userData?.user.userMobile?.isNotEmpty ?? false)
          //       ? userListener.userData!.user.userMobile!
          //       : 'No phone number',
          //   style: context.customTextTheme.text14W400,
          // ),
        ],
      ),
    );
  }

  // Widget _buildCustomPadding(Widget child) {
  //   return child;
  // }

  Widget _buildCustomBackButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.kGray2),
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
        ),
      ),
    );
  }

  Row _buildAppBar(String userId, BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      isFromHome ? _buildCustomBackButton(context) : const SizedBox(),
      isFromHome ? horizontalSpaceMedium : const SizedBox(),
      // Container(
      //   // margin: const EdgeInsets.only(),
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.withOpacity(0.1),
      //         blurRadius: 4.0,
      //         offset: const Offset(0, 2),
      //       ),
      //     ],
      //   ),
      //   child: CircleAvatar(
      //     radius: 20,
      //     backgroundColor: Colors.white,
      //     //
      //     backgroundImage: AssetImage(Assets.images.profilePhoto.path),
      //   ),
      // ),
      // horizontalSpaceSmall,
      // Container(
      //   padding: const EdgeInsets.symmetric(
      //     horizontal: 20,
      //     vertical: 8,
      //   ),
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(20),
      //       color: AppColors.kBlack3,
      //       border: Border.all(color: AppColors.kGray2)),
      //   child: Text(
      //     'Profile Info',
      //     style: context.customTextTheme.text14W700.copyWith(color: AppColors.kWhite),
      //   ),
      // ),
    ]);
  }

  String _getAvatarForUser(String userId) {
    // Logic to determine avatar based on user ID
    // For simplicity, we return the same svgString for now
    // You can replace this with actual logic to fetch or generate avatars
    return RandomAvatarString(
      userId,
      trBackground: true,
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
                  color: AppColors.kBlack,
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
