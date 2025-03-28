import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:dartx/dartx.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:aj_customer/core/theme/app_colors.dart';
import 'package:aj_customer/core/theme/custom_text_styles.dart';
import 'package:aj_customer/core/utils/ui_utils.dart';
import 'package:aj_customer/core/utils/utils.dart';
import 'package:aj_customer/presentation/widgets/button_progress.dart';
import 'package:aj_customer/presentation/widgets/custom_close_icon.dart';
import 'package:aj_customer/presentation/widgets/qty_counter_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../application/cart/cart_provider.dart';
import '../../domain/store/models/product_details_model.dart';
import '../../gen/assets.gen.dart';
import 'get_provider_view.dart';

class DishDetailBottomSheet extends StatelessWidget {
  final ProductDataModel product;
  final VoidCallback onRequestOrderDish;

  const DishDetailBottomSheet({
    super.key,
    required this.product,
    required this.onRequestOrderDish,
  });

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const RoundedCloseIcon(),
        verticalSpaceRegular,
        Theme(
          data: Theme.of(context).copyWith(
            textTheme: GoogleFonts.quicksandTextTheme(baseTextTheme).apply(
              displayColor: AppColors.kBlack2,
              bodyColor: AppColors.kBlack2,
            ),
          ),
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            decoration: const BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceTiny,
                _ProductImageWidget(product: product),
                verticalSpaceRegular,
                _ProductNameWidget(product: product),
                // _RatingAndTimeWidget(product: product),
                verticalSpaceSmall,
                _DescriptionWidget(product: product),
                verticalSpaceRegular,
                _OrderSectionWidget(
                  product: product,
                  onRequestOrderDish: onRequestOrderDish,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AddDishBottomSheet extends GetProviderView<CartProvider> {
  final ProductDataModel product;

  const AddDishBottomSheet({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = notifier(context);
    final cartListener = listener(context);

    final baseTextTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const RoundedCloseIcon(),
        verticalSpaceRegular,
        Theme(
          data: Theme.of(context).copyWith(
            textTheme: GoogleFonts.quicksandTextTheme(baseTextTheme).apply(
              displayColor: AppColors.kBlack2,
              bodyColor: AppColors.kBlack2,
            ),
          ),
          child: ListTileTheme(
            contentPadding: EdgeInsets.zero,
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              decoration: const BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              constraints: BoxConstraints(
                maxHeight: context.heightPx * 0.8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  verticalSpaceTiny,
                  Row(
                    children: [
                      Expanded(child: _ProductImageWidget(product: product)),
                      horizontalSpaceSmall,
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _ProductNameWidget(product: product),
                            // _RatingAndTimeWidget(product: product),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ProductPriceWidget(product: product),
                      QtyCounterButton2(
                        qty: cartListener.selectedItemQty,
                        onIncrementQty: cartListener.incrementQty,
                        onDecrementQty: cartListener.decrementQty,
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  _DescriptionWidget(product: product),
                  verticalSpaceSmall,
                  Flexible(
                    flex: 2,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        _FoodVariationSection(product),
                        verticalSpaceRegular,
                        _FoodAddonsSection(product),
                      ],
                    ),
                  ),
                  verticalSpaceSmall,
                  Center(child: AddToCartButton(product)),
                  verticalSpaceTiny,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CloseIconWidget extends StatelessWidget {
  const _CloseIconWidget();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerRight,
      child: RoundedCloseIcon(),
    );
  }
}

class _ProductImageWidget extends StatelessWidget {
  final ProductDataModel product;
  final bool small;

  const _ProductImageWidget({
    required this.product,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: product.photo != null
            ? CachedNetworkImage(
                imageUrl: product.photo!,
                fit: BoxFit.cover,
                width: small ? 150 : double.infinity,
              )
            : const Text("No Image"),
      ),
    );
  }
}

class _ProductNameWidget extends StatelessWidget {
  final ProductDataModel product;

  const _ProductNameWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    return Text(
      (product.name ?? "").capitalize(),
      style: context.customTextTheme.text20W600.copyWith(
        color: AppColors.kBlack,
      ),
    );
  }
}

// class _RatingAndTimeWidget extends StatelessWidget {
//   final ProductDataModel product;

//   const _RatingAndTimeWidget({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         const Icon(
//           Icons.star,
//           color: AppColors.kSunRiseOrange,
//           size: 16,
//         ),
//         horizontalSpaceTiny,
//         Text(
//           '4.5',
//           style: context.customTextTheme.text14W700
//               .copyWith(color: AppColors.kGray),
//         ),
//         horizontalSpaceSmall,
//         const Icon(
//           Icons.history,
//           size: 16,
//         ),
//         horizontalSpaceTiny,
//         Text(
//           '26 mins',
//           style: context.customTextTheme.text14W700
//               .copyWith(color: AppColors.kGray),
//         ),
//         horizontalSpaceSmall,
//         product.type == "veg"
//             ? Assets.icons.veg.svg()
//             : Assets.icons.nonVeg.svg(),
//       ],
//     );
//   }
// }

class _DescriptionWidget extends StatelessWidget {
  final ProductDataModel product;

  const _DescriptionWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    return product.description != null && product.description!.isNotEmpty
        ? Align(
            alignment: Alignment.centerLeft,
            child: Text(
              Utils.removeExtraSpaces(
                Utils.removeHtmlTags(product.description ?? ''),
              ),
              style: context.customTextTheme.text16W400.copyWith(
                color: AppColors.kGray5,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              maxLines: 4,
            ),
          )
        : const SizedBox.shrink();
  }
}

class _OrderSectionWidget extends StatelessWidget {
  final ProductDataModel product;
  final VoidCallback onRequestOrderDish;

  const _OrderSectionWidget({
    required this.product,
    required this.onRequestOrderDish,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ProductPriceWidget(product: product),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            onRequestOrderDish();
          },
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: context.screenWidth * 0.5,
            child: Center(
              child: Text(
                'ORDER NOW',
                style: context.customTextTheme.text16W600
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductPriceWidget extends StatelessWidget {
  const _ProductPriceWidget({
    required this.product,
  });

  final ProductDataModel product;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: product.price?.contains("£") == true ? "£" : "",
            style: context.customTextTheme.text24W600
                .copyWith(color: AppColors.kGray5),
          ),
          TextSpan(
            text: product.price?.replaceAll("£", "") ?? "",
            style: context.customTextTheme.text24W600.copyWith(
              color: AppColors.kBlack,
            ),
          ),
        ],
      ),
    );
  }
}

// ADD DISH WIDGETS
class _FoodVariationSection extends GetProviderView<CartProvider> {
  const _FoodVariationSection(this.item);

  final ProductDataModel item;

  @override
  Widget build(BuildContext context) {
    final cartProvider = notifier(context);
    final cartListener = listener(context);

    if (!item.hasMultipleVariation) {
      return const SizedBox.shrink();
    }

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Choose One Variation",
              style: context.customTextTheme.text16W600,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: AppColors.kGray3.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Text(
                  "REQUIRED",
                  style: context.customTextTheme.text12W600.copyWith(
                    color: AppColors.kBlack2,
                  ),
                ),
              ),
            )
          ],
        ),
        ...item.variations.mapIndexed((index, variation) {
          return RadioListTile(
            value: cartListener.selectedItemVariation == variation,
            groupValue: true,
            title: Text(
              (variation.name ?? "").capitalize(),
              style: context.customTextTheme.text14W600.copyWith(
                color: AppColors.kDimGray,
              ),
            ),
            subtitle: Text(
              variation.displayPrice ?? "",
              style: context.customTextTheme.text14W500.copyWith(
                color: AppColors.kGray7,
              ),
            ),
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (_) => cartProvider.onChangeVariation(variation),
            visualDensity: VisualDensity.compact,
          );
        }),
      ],
    );
  }
}

class _FoodAddonsSection extends GetProviderView<CartProvider> {
  const _FoodAddonsSection(this.item);

  final ProductDataModel item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cartProvider = notifier(context);
    final cartListener = listener(context);

    return Column(
      children: [
        Column(
          children: item.masterAddons.map((modifier) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Choose ${modifier.name}",
                  style: context.customTextTheme.text16W600,
                ),
                (modifier.minimumRequired?.isEmpty == true ||
                            modifier.minimumRequired == "0") &&
                        (modifier.maximumRequired?.isEmpty == true ||
                            modifier.maximumRequired == "0")
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${modifier.minimumRequired == "0" ? '' : 'Min ${modifier.minimumRequired}'}${modifier.minimumRequired != "0" && modifier.maximumRequired != "0" ? ', ' : ''}${modifier.maximumRequired == "0" ? '' : 'Max ${modifier.maximumRequired}'}",
                            style: textTheme.labelSmall!.copyWith(
                              color: AppColors.kBlack2,
                            ),
                          ),
                          Visibility(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 3.0,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.kGray3.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Center(
                                child: Text(
                                  "REQUIRED",
                                  style: context.customTextTheme.text12W600
                                      .copyWith(
                                    color: AppColors.kBlack2,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                verticalSpaceSmall,
                ...modifier.options.map((option) {
                  return CheckboxListTile(
                    value: cartProvider.checkMasterOptionsIsSelected(
                        modifier, option),
                    title: Text(
                      (option.text ?? "").capitalize(),
                      style: context.customTextTheme.text14W600.copyWith(
                        color: AppColors.kDimGray,
                      ),
                    ),
                    subtitle: Text(
                      '£${option.price}',
                      style: context.customTextTheme.text14W500.copyWith(
                        color: AppColors.kGray7,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (_) =>
                        cartProvider.onSelectMasterAddon(modifier, option),
                  );
                }),
              ],
            );
          }).toList(),
        ),
        Column(
          children: item.addons.map((modifier) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Choose ${modifier.name}",
                  style: context.customTextTheme.text16W600,
                ),
                ...modifier.options.map((option) {
                  return CheckboxListTile(
                    value:
                        cartProvider.checkOptionsIsSelected(modifier, option),
                    title: Text(
                      (option.text ?? "").capitalize(),
                      style: context.customTextTheme.text14W600.copyWith(
                        color: AppColors.kDimGray,
                      ),
                    ),
                    subtitle: Text(
                      '£${option.price}',
                      style: context.customTextTheme.text14W500.copyWith(
                        color: AppColors.kGray7,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (_) =>
                        cartProvider.onSelectAddon(modifier, option),
                  );
                }),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

class AddToCartButton extends GetProviderView<CartProvider> {
  const AddToCartButton(this.product, {super.key});

  final ProductDataModel product;

  @override
  Widget build(BuildContext context) {
    final cartProvider = notifier(context);
    final cartListener = listener(context);
    return FilledButton(
        onPressed: () {
          final validationResult =
              cartProvider.validateRequiredModifiers(product);
          if (validationResult) {
            cartProvider.addItemToCart().then((added) {
              if (added) {
                Navigator.pop(context);
                cartProvider.resetValues();
              }
            });
          }
        },
        child: !cartListener.addItemLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: AppColors.kWhite,
                    size: 20,
                  ),
                  horizontalSpaceMedium,
                  Text('Add To Cart'),
                ],
              )
            : showButtonProgress());
    // return SwipeButton(
    //   thumb: const Icon(
    //     FluentIcons.cart_24_filled,
    //     color: AppColors.kBlack3,
    //   ),
    //   activeTrackColor: AppColors.kBlack3,
    //   inactiveThumbColor: AppColors.kWhite,
    //   thumbPadding: const EdgeInsets.all(2),
    //   activeThumbColor: AppColors.kWhite,
    //   width: cartListener.addItemLoading
    //       ? context.widthPx * 0.6
    //       : context.widthPx * 0.7,
    //   inactiveTrackColor: AppColors.kGray6,
    //   enabled: !cartListener.addItemLoading,
    //   onSwipe: () {
    //     final validationResult =
    //         cartProvider.validateRequiredModifiers(product);
    //     if (validationResult) {
    //       cartProvider.addItemToCart().then((added) {
    //         if (added) {
    //           Navigator.pop(context);
    //           cartProvider.resetValues();
    //         }
    //       });
    //     }
    //   },
    //   child: cartListener.addItemLoading
    //       ? showButtonProgress()
    //       : Padding(
    //           padding: EdgeInsets.only(
    //             left: context.widthPx * 0.15,
    //             right: context.widthPx * 0.05,
    //           ),
    //           child: Row(
    //             mainAxisSize: MainAxisSize.min,
    //             children: <Widget>[
    //               Text(
    //                 "£${cartListener.selectedItemPrice}",
    //                 style: context.customTextTheme.text20W600
    //                     .copyWith(color: AppColors.kWhite),
    //               ),
    //               const Spacer(),
    //               Text(
    //                 "Add To Cart",
    //                 style: context.customTextTheme.text18W600.copyWith(
    //                   color: AppColors.kWhite,
    //                 ),
    //               ),
    //               horizontalSpaceTiny,
    //               const Icon(
    //                 Icons.arrow_forward_ios,
    //                 color: AppColors.kWhite,
    //                 size: 20.0,
    //               )
    //             ],
    //           ),
    //         ),
    // );
  }
}
