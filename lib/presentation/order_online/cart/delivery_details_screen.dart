import 'package:bamboo_basket_customer_app/application/shop/shop_provider.dart';
import 'package:bamboo_basket_customer_app/core/routes/routes.gr.dart';
import 'package:bamboo_basket_customer_app/core/theme/custom_text_styles.dart';
import 'package:bamboo_basket_customer_app/core/utils/alert_dialogs.dart';
import 'package:bamboo_basket_customer_app/domain/user/models/user_address_list_data_model.dart';
import 'package:bamboo_basket_customer_app/presentation/widgets/custom_close_icon.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:dartx/dartx.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../../application/cart/cart_provider.dart';
import '../../../application/user/user_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/ui_utils.dart';
import '../../../core/utils/utils.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/bottom_sheet_drag_handler.dart';
import '../../widgets/button_progress.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  const DeliveryDetailsScreen({super.key});

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final cartListener = context.watch<CartProvider>();
    final cartProvider = context.read<CartProvider>();
    final shopListener = context.watch<ShopProvider>();
    final shopProvider = context.read<ShopProvider>();
    final userListener = context.watch<UserProvider>();
    final userProvider = context.read<UserProvider>();
    const outlinedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    );
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 15.0).copyWith(bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpaceSmall,
            Visibility(
              visible: false,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Type",
                      style: context.customTextTheme.text16W600,
                    ),
                    verticalSpaceSmall,
                    ListTileTheme(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              visualDensity: VisualDensity.compact,
                              selected: cartListener.selectedOrderType ==
                                  OrderType.delivery,
                              selectedTileColor:
                                  cartListener.selectedOrderType ==
                                          OrderType.delivery
                                      ? AppColors.kLightWhite2
                                      : AppColors.kWhite,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: cartListener.selectedOrderType ==
                                          OrderType.delivery
                                      ? AppColors.kBlack2
                                      : AppColors.kGray2,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              leading:
                                  Assets.icons.fastDelivery.image(height: 34.0),
                              title: Text(
                                "Home Delivery",
                                style:
                                    context.customTextTheme.text14W600.copyWith(
                                  color: cartListener.selectedOrderType ==
                                          OrderType.delivery
                                      ? AppColors.kBlack
                                      : AppColors.kGray,
                                ),
                              ),
                              onTap: () {
                                cartProvider.onChangeOrderType(
                                  OrderType.delivery,
                                );
                              },
                            ),
                          ),
                          horizontalSpaceRegular,
                          Expanded(
                            child: ListTile(
                              visualDensity: VisualDensity.compact,
                              selected: cartListener.selectedOrderType ==
                                  OrderType.takeaway,
                              selectedTileColor:
                                  cartListener.selectedOrderType ==
                                          OrderType.takeaway
                                      ? AppColors.kLightWhite2
                                      : AppColors.kWhite,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: cartListener.selectedOrderType ==
                                          OrderType.takeaway
                                      ? AppColors.kBlack2
                                      : AppColors.kGray2,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              leading:
                                  Assets.icons.takeAway.image(height: 34.0),
                              title: Text(
                                "Take Away",
                                style:
                                    context.customTextTheme.text14W600.copyWith(
                                  color: cartListener.selectedOrderType ==
                                          OrderType.takeaway
                                      ? AppColors.kBlack
                                      : AppColors.kGray,
                                ),
                              ),
                              onTap: () {
                                cartProvider.onChangeOrderType(
                                  OrderType.takeaway,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Divider(),
            if (cartListener.selectedAddressSecondary == null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (cartListener.selectedOrderType ==
                          OrderType.takeaway) ...[
                        _buildTakeAwayTimeWidget(),
                        const Divider(
                          height: 30.0,
                          color: AppColors.kLightGray2,
                        ),
                      ],
                      InkWell(
                        onTap: () {
                          userProvider.initAllTextEditingController();
                          showAddressListSheet(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(FluentIcons.location_24_regular),
                            const SizedBox(width: 8.0),
                            // Add space between icon and text
                            Flexible(
                              child: Text(
                                "Select Address For ${cartListener.selectedOrderType == OrderType.takeaway ? "Billing" : "Delivery"}",
                                style: context.customTextTheme.text16W600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 0.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (cartListener.selectedOrderType ==
                          OrderType.takeaway) ...[
                        _buildTakeAwayTimeWidget(),
                        const Divider(
                          height: 30.0,
                          color: AppColors.kLightGray2,
                        ),
                      ],
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Icon(FluentIcons.location_24_regular),
                          horizontalSpaceSmall,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Address",
                                  style: GoogleFonts.quicksand(
                                    textStyle: context
                                        .customTextTheme.text16W600
                                        .copyWith(
                                      color: AppColors.kBlack2,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Text(
                                  cartListener
                                      .selectedAddressSecondary!.userFulladdress
                                      .trimLeft()
                                      .capitalize(),
                                  style: GoogleFonts.quicksand(
                                    textStyle: context
                                        .customTextTheme.text16W500
                                        .copyWith(
                                      color: AppColors.kBlack2,
                                    ),
                                  ),
                                ),
                                Text(
                                  userListener.userData?.user.userMobile ?? "",
                                  style: GoogleFonts.quicksand(
                                    textStyle:
                                        context.customTextTheme.text16W500,
                                  ),
                                ),
                                Text(
                                  userListener.userData?.user.userEmail ?? "",
                                  style: GoogleFonts.quicksand(
                                    textStyle:
                                        context.customTextTheme.text16W500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          horizontalSpaceSmall,
                          InkWell(
                            onTap: () {
                              userListener.initAllTextEditingController();
                              showAddressListSheet(context);
                            },
                            child: Text(
                              "CHANGE",
                              style: context.customTextTheme.text14W600,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            verticalSpaceSmall,
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     vertical: 16.0,
            //     horizontal: 0.0,
            //   ),
            //   child: shopListener.selectedDate == null &&
            //           shopListener.selectedDeliverySlot == null
            //       ? InkWell(
            //           onTap: () async {
            //             shopProvider.onChangeOnSelectedDeliverySlot(null);

            //             shopProvider.fetchShopDeliverySlots();

            //             final selectedDate = await showDatePicker(
            //               context: context,
            //               initialDate: DateTime.now(),
            //               firstDate: DateTime.now(),
            //               lastDate: DateTime(2100),
            //               builder: (context, child) {
            //                 return Theme(
            //                   data: Theme.of(context).copyWith(
            //                     colorScheme: const ColorScheme.light(
            //                       primary: AppColors.kPrimaryColor,
            //                     ),
            //                   ),
            //                   child: child!,
            //                 );
            //               },
            //             );
            //             if (selectedDate != null) {
            //               shopProvider.onChangeSelectedDate(selectedDate);
            //               await showSlotChooseSheet(context, shopProvider);
            //             }
            //           },
            //           child: Row(
            //             mainAxisSize: MainAxisSize.min,
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: [
            //               const Icon(FluentIcons.calendar_clock_24_regular),
            //               const SizedBox(width: 8.0),
            //               // Add space between icon and text
            //               Flexible(
            //                 child: Text(
            //                   "Select Delivery Date & Time",
            //                   style: context.customTextTheme.text16W600,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         )
            //       : Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Row(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 const Icon(FluentIcons.calendar_clock_24_regular),
            //                 horizontalSpaceSmall,
            //                 // Text(
            //                 //     '${DateFormat.jm(shopListener.selectedDate)}'),

            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       'Delivery Date & Time',
            //                       style: context.customTextTheme.text16W700,
            //                     ),
            //                     Text(
            //                       shopListener.formattedSelectedDate,
            //                       style: context.customTextTheme.text16W500,
            //                     ),
            //                     verticalSpaceTiny,
            //                     shopListener.selectedDeliverySlot != null
            //                         ? Text(
            //                             "${shopListener.selectedDeliverySlot?.openingTime} - ${shopListener.selectedDeliverySlot?.closingTime}",
            //                             style:
            //                                 context.customTextTheme.text14W600,
            //                           )
            //                         : Text(
            //                             'Not Selected',
            //                             style: context
            //                                 .customTextTheme.text14W400
            //                                 .copyWith(
            //                                     color: Colors.red.shade700),
            //                           ),
            //                   ],
            //                 )
            //               ],
            //             ),
            //             InkWell(
            //                 onTap: () async {
            //                   shopProvider.onChangeOnSelectedDeliverySlot(null);
            //                   shopProvider.fetchShopDeliverySlots();

            //                   final selectedDate = await showDatePicker(
            //                     context: context,
            //                     initialDate: DateTime.now(),
            //                     firstDate: DateTime.now(),
            //                     lastDate: DateTime(2100),
            //                     builder: (context, child) {
            //                       return Theme(
            //                         data: Theme.of(context).copyWith(
            //                           colorScheme: const ColorScheme.light(
            //                             primary: AppColors.kPrimaryColor,
            //                           ),
            //                         ),
            //                         child: child!,
            //                       );
            //                     },
            //                   );
            //                   if (selectedDate != null) {
            //                     shopProvider.onChangeSelectedDate(selectedDate);
            //                     await showSlotChooseSheet(
            //                         context, shopProvider);
            //                   }
            //                 },
            //                 child: Text('CHANGE',
            //                     style: context.customTextTheme.text14W600)),
            //           ],
            //         ),
            // ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0.0,
                  vertical: 5.0,
                ),
                child: Row(
                  children: [
                    const Icon(
                      FluentIcons.notepad_24_regular,
                      color: AppColors.kBlack2,
                    ),
                    horizontalSpaceSmall,
                    Expanded(
                      child: FormBuilderTextField(
                        name: 'notes',
                        key: cartListener.notesFieldKey,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: outlinedBorder,
                          border: outlinedBorder,
                          focusedBorder: outlinedBorder,
                          disabledBorder: outlinedBorder,
                          errorBorder: outlinedBorder,
                          focusedErrorBorder: outlinedBorder,
                          hintText: "Notes for the restaurant...",
                          hintStyle: context.customTextTheme.text16W400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text("Payment Method", style: context.customTextTheme.text16W600),
            Row(
              children: <Widget>[
                _PaymentOptionCard(
                  title: "Cash On\nDelivery",
                  icon: Assets.icons.money.image(
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  selected:
                      cartListener.selectedPaymentMethod == PaymentMethod.cash,
                  onTap: () =>
                      cartListener.onChangePaymentMethod(PaymentMethod.cash),
                ),
                horizontalSpaceRegular,
                _PaymentOptionCard(
                  title: "Card\nPayment",
                  rightPos: -12,
                  bottomPos: -16,
                  icon: Assets.icons.creditCard.image(
                    height: 34,
                    fit: BoxFit.contain,
                  ),
                  selected:
                      cartListener.selectedPaymentMethod == PaymentMethod.card,
                  onTap: () =>
                      cartListener.onChangePaymentMethod(PaymentMethod.card),
                ),
              ],
            ),
            Container(
              // height: context.heightPx * 0.3,
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: const BoxDecoration(
                color: AppColors.kWhite,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                    value:
                        "£${cartListener.calculatedDeliveryFee.toStringAsFixed(2)}",
                  ),
                  verticalSpaceTiny,
                  _SummaryRow(
                    label: "Discount",
                    value:
                        "-£${cartListener.calculatedDiscount.toStringAsFixed(2)}",
                  ),
                  verticalSpaceTiny,
                  // _SummaryRow(
                  //   label: "Coupon Discount",
                  //   value: "-£${cartListener.offerDiscount.toStringAsFixed(2)}",
                  // ),
                  // const Divider(height: 20.0),
                  // _SummaryRow(
                  //   label: "To Pay",
                  //   value: Utils.format(cartListener.totalAmount),
                  //   style: context.customTextTheme.text18W600,
                  // ),
                  // verticalSpaceRegular,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showSlotChooseSheet(
      BuildContext context, ShopProvider shopProvider) async {
    return await showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) {
        final shopListener = context.watch<ShopProvider>();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Slots for ${shopListener.formattedSelectedDate}",
                  style: context.customTextTheme.text18W600
                      .copyWith(color: AppColors.kBlack),
                ),
                shopListener.isSlotsEmpty
                    ? Column(
                        children: [
                          verticalSpaceRegular,
                          const Icon(
                            FluentIcons.clock_dismiss_24_regular,
                            size: 75,
                            color: Colors.grey,
                          ),
                          verticalSpaceRegular,
                          Text(
                            "No Slots available for the slected date",
                            style: context.customTextTheme.text16W500
                                .copyWith(color: AppColors.kBlack),
                          ),
                          verticalSpaceRegular,
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Wrap(
                          children: shopListener.slotForSelectedDate
                                  ?.map((slot) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: ChoiceChip(
                                            selectedColor:
                                                AppColors.kPrimaryColor,
                                            color: const WidgetStatePropertyAll(
                                                Colors.white),
                                            onSelected: (value) {
                                              if (value) {
                                                shopProvider
                                                    .onChangeOnSelectedDeliverySlot(
                                                        slot);
                                              } else {
                                                shopProvider
                                                    .onChangeOnSelectedDeliverySlot(
                                                        null);
                                              }
                                            },
                                            label: Text(
                                                "${slot.openingTime} - ${slot.closingTime}"),
                                            selected: shopListener
                                                    .selectedDeliverySlot ==
                                                slot),
                                      ))
                                  .toList() ??
                              [],
                        ),
                      ),
                verticalSpaceSmall,
                InkWell(
                  onTap: () {
                    if (shopListener.selectedDeliverySlot == null &&
                        !shopListener.isSlotsEmpty) {
                      AlertDialogs.showWarning("Choose a delivery slot");
                      return;
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    width: context.screenWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColors.kPrimaryColor),
                    child: Center(
                        child: Text(
                      shopListener.slotForSelectedDate?.isEmpty == true
                          ? "CHOOSE ANOTHER DATE"
                          : "CONFIRM",
                      style: context.customTextTheme.text14W600
                          .copyWith(color: AppColors.kWhite),
                    )),
                  ),
                ),
                verticalSpaceRegular,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTakeAwayTimeWidget() {
    return Builder(builder: (context) {
      final cartListener = context.watch<CartProvider>();

      final cartProvider = context.read<CartProvider>();
      return InkWell(
        onTap: () async {
          final TimeOfDay? pickUpTime = await showTimePicker(
            context: context,
            initialTime: cartListener.selectedPickUpTime != null
                ? TimeOfDay(
                    hour: cartListener.selectedPickUpTime!.hour,
                    minute: cartListener.selectedPickUpTime!.minute)
                : DateTimeUtils.addMinutesToTime(TimeOfDay.now(), 15),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  dialogBackgroundColor: AppColors.kWhite,
                  textTheme: poppinsTextTheme(context).textTheme,
                  timePickerTheme: TimePickerThemeData(
                      backgroundColor: AppColors.kLightWhite2,
                      dialBackgroundColor: AppColors.kLightGray2,
                      dayPeriodColor: WidgetStateColor.resolveWith(
                        (states) {
                          if (states.contains(WidgetState.selected)) {
                            return AppColors.kBlack2;
                          }
                          return AppColors.kLightWhite2;
                        },
                      ),
                      hourMinuteColor: WidgetStateColor.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return AppColors.kBlack2;
                        }
                        return AppColors.kLightWhite2;
                      }),
                      hourMinuteTextColor: WidgetStateColor.resolveWith(
                        (states) {
                          if (states.contains(WidgetState.selected)) {
                            return AppColors.kWhite;
                          }
                          return AppColors.kGray;
                        },
                      ),
                      dayPeriodTextColor: WidgetStateColor.resolveWith(
                        (states) {
                          if (states.contains(WidgetState.selected)) {
                            return AppColors.kWhite;
                          }
                          return AppColors.kGray;
                        },
                      )),
                ),
                child: child!,
              );
            },
          );

          if (pickUpTime == null) return;
          cartProvider.onChangePickUpTime(
            DateTimeUtils.combineDateTime(DateTime.now(), pickUpTime),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(FluentIcons.clock_24_regular),
            horizontalSpaceSmall,
            Expanded(
              child: Text(
                cartListener.selectedPickUpTime == null
                    ? "Select Pick Time"
                    : "Pickup on ${DateTimeUtils.formatDateTimeToTime(
                        cartListener.selectedPickUpTime!,
                      )}",
                style: context.customTextTheme.text16W600,
              ),
            ),
            Visibility(
              visible: cartListener.selectedPickUpTime != null,
              child: Text(
                "CHANGE",
                style: context.customTextTheme.text14W600,
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<void> showAddressListSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      enableDrag: true,
      builder: (context) {
        final userProvider = context.read<UserProvider>();
        final userListener = context.watch<UserProvider>();
        final cartListener = context.watch<CartProvider>();

        final addressList = userListener.searchAddressTxtController.text.isEmpty
            ? userListener.userAddressList
            : userListener.searchAddressListItem;

        return Theme(
          data: quickSandTextTheme(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const RoundedCloseIcon(),
              verticalSpaceRegular,
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: context.heightPx * 0.8,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.kOffWhite4,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    verticalSpaceSmall,
                    const BottomSheetDragHandler(),
                    verticalSpaceRegular,
                    Text(
                      'Delivery Address',
                      style: context.customTextTheme.text18W600,
                    ),
                    verticalSpaceRegular,
                    // Search TextField
                    TextFormField(
                      controller: userListener.searchAddressTxtController,
                      onChanged: (value) =>
                          userListener.searchAddressByPostCode(value),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Assets.icons.searchNormal.svg(
                            height: 16,
                            width: 16,
                            fit: BoxFit.contain,
                          ),
                        ),
                        isDense: true,
                        fillColor: AppColors.kLightBlue2,
                        filled: true,
                        hintText: 'Look for a Postcode...',
                        hintStyle: context.customTextTheme.text16W500.copyWith(
                          color: AppColors.kGray3,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(14.0),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    // Display Address List
                    Expanded(
                      child: addressList.isNotEmpty
                          ? ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: addressList.length,
                              itemBuilder: (context, index) {
                                final address = addressList[index];

                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.kWhite,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: const <BoxShadow>[
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.1),
                                        spreadRadius: 0,
                                        blurRadius: 8,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: ListTileTheme(
                                          horizontalTitleGap: 8.0,
                                          child: RadioListTile(
                                            value: address,
                                            groupValue:
                                                cartListener.selectedAddress,
                                            onChanged: (UserAddressDataModel?
                                                newAddress) {
                                              if (newAddress == null) return;
                                              context
                                                  .read<CartProvider>()
                                                  .onChangeAddress(newAddress);
                                            },
                                            title: Text(
                                              address.addressTitle ?? "",
                                              style: context
                                                  .customTextTheme.text18W600,
                                            ),
                                            subtitle: Text(
                                              Utils.removeExtraSpaces(address
                                                  .userFulladdress
                                                  .capitalize()),
                                              style: context
                                                  .customTextTheme.text16W400
                                                  .copyWith(
                                                      color: AppColors.kGray),
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context
                                              .read<UserProvider>()
                                              .initAllTextEditingController();
                                          context
                                              .read<UserProvider>()
                                              .loadDataForAddressUpdate(
                                                  address);

                                          context.router.push(
                                            AddNewAddressScreenRoute(
                                              address: address,
                                            ),
                                          );
                                        },
                                        icon: Assets.icons.editIcon.svg(),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            barrierDismissible:
                                                false, // Prevents dismissing while loading
                                            builder: (BuildContext context) {
                                              return Consumer<UserProvider>(
                                                builder: (context, userListener,
                                                    child) {
                                                  bool isLoading = userListener
                                                      .isDeletingUserAddress;

                                                  return Stack(
                                                    children: [
                                                      AlertDialog(
                                                        title: isLoading
                                                            ? null
                                                            : Center(
                                                                child: Text(
                                                                  'Address',
                                                                  style: context
                                                                      .customTextTheme
                                                                      .text18W600
                                                                      .copyWith(
                                                                    color: AppColors
                                                                        .kBlack,
                                                                  ),
                                                                ),
                                                              ),
                                                        content: userListener
                                                                .isDeletingUserAddress
                                                            ? null
                                                            : Text(
                                                                'Are you sure you want to delete this address?',
                                                                style: context
                                                                    .customTextTheme
                                                                    .text16W400
                                                                    .copyWith(
                                                                  color: AppColors
                                                                      .kBlack,
                                                                ),
                                                              ),
                                                        actions: isLoading
                                                            ? null
                                                            : <Widget>[
                                                                Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      OutlinedButton(
                                                                        onPressed: isLoading
                                                                            ? null
                                                                            : () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                        child: const Text(
                                                                            'Cancel'),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              10),
                                                                      ElevatedButton(
                                                                        style:
                                                                            const ButtonStyle(
                                                                          backgroundColor:
                                                                              WidgetStatePropertyAll(
                                                                            AppColors.kPrimaryColor,
                                                                          ),
                                                                        ),
                                                                        onPressed: isLoading
                                                                            ? null
                                                                            : () async {
                                                                                final currentContext = context; // Store context

                                                                                await userListener.deleteUserAddress(address.uaID.toString());
                                                                                // cartListener.selectedAddressSecondary = null;

                                                                                cartListener.clearSelectedAddressSecondary();

                                                                                if (currentContext.mounted) {
                                                                                  Navigator.of(currentContext).pop();

                                                                                  currentContext.read<UserProvider>().getAddressList();
                                                                                }
                                                                              },
                                                                        child:
                                                                            const Text(
                                                                          'Delete',
                                                                          style:
                                                                              TextStyle(color: AppColors.kWhite),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                      ),
                                                      if (isLoading)
                                                        Container(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          child: const Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: AppColors
                                                                  .kPrimaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          color: AppColors.kGray,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return verticalSpaceRegular;
                              },
                            )
                          : Center(
                              child: Text(
                                userListener
                                        .searchAddressTxtController.text.isEmpty
                                    ? 'No address found'
                                    : 'The address is not found',
                                style: context.customTextTheme.text14W400,
                              ),
                            ),
                    ),
                    const Divider(height: 30.0, color: AppColors.kLightGray2),
                    Row(
                      children: [
                        Expanded(
                            child: OutlinedButton.icon(
                          onPressed: () {
                            context
                                .read<UserProvider>()
                                .initAllTextEditingController();
                            context.router
                                .push(AddNewAddressScreenRoute(address: null));
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          label: Text(
                            '+ Add Address',
                            style: context.customTextTheme.text14W600,
                          ),
                        )),
                        horizontalSpaceSmall,
                        Visibility(
                          visible: userListener.userAddressList.isNotEmpty,
                          child: Expanded(
                            child: FilledButton(
                              onPressed: cartListener
                                      .deliveryOrTakeAwayChargeCalculating
                                  ? null
                                  : () {
                                      context
                                          .read<CartProvider>()
                                          .validateAddress()
                                          .then((validated) {
                                        if (validated) {
                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);
                                        }
                                      });
                                    },
                              child: cartListener
                                      .deliveryOrTakeAwayChargeCalculating
                                  ? showButtonProgress()
                                  : Text('Apply',
                                      style:
                                          context.customTextTheme.text14W600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PaymentOptionCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;
  final bool selected;
  final double? rightPos;
  final double? bottomPos;

  const _PaymentOptionCard({
    required this.title,
    required this.icon,
    this.selected = false,
    this.rightPos,
    this.bottomPos,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 10.0,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned.fill(
                  top: 0,
                  child: Card(
                    color: selected
                        ? AppColors.kPrimaryColor.withOpacity(1)
                        : AppColors.kWhite,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: selected
                            ? AppColors.kPrimaryColor
                            : AppColors.kLightGray,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        top: 8.0,
                      ),
                      child: Text(
                        title,
                        style: GoogleFonts.quicksand(
                          textStyle:
                              context.customTextTheme.text16W600.copyWith(
                            fontWeight: FontWeight.w700,
                            color: selected ? AppColors.kWhite : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: rightPos ?? -18,
                  bottom: bottomPos ?? -18,
                  child: icon,
                ),
              ],
            ),
          ),
        ),
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
