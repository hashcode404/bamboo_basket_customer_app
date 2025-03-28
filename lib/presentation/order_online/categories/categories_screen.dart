import 'dart:developer';

import 'package:aj_customer/application/core/api_response.dart';
import 'package:aj_customer/application/products/products_provider.dart';
import 'package:aj_customer/core/theme/app_colors.dart';
import 'package:aj_customer/core/theme/custom_text_styles.dart';
import 'package:aj_customer/core/utils/ui_utils.dart';
import 'package:aj_customer/gen/assets.gen.dart';
import 'package:aj_customer/presentation/widgets/product_details_tile.dart';
import 'package:aj_customer/presentation/widgets/shimmer_product_details_tile.dart';
import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../../application/cart/cart_provider.dart';
import '../../../domain/store/models/product_details_model.dart';
import '../../widgets/manage_dish_sheets.dart';
import '../../widgets/qty_counter_button.dart';

@RoutePage()
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productListner = context.watch<ProductsProvider>();
    final productProvider = context.read<ProductsProvider>();
    final cartProvider = context.read<CartProvider>();
    final products = productProvider.productsList;
    return Scaffold(
      backgroundColor: AppColors.kLightWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kLightWhite,
        title: Text(
          "Categories",
          style: context.customTextTheme.text18W600,
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: productListner.categories.length,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TabBar(
                  onTap: (index) async {
                    final category = productListner.categories.elementAt(index);
                    final cID = category.cID;
                    if (cID == productProvider.selectedCategory?.cID) return;

                    productProvider.onChangeSelectedCategory(category);
                    if (cID != null) {
                      log("started");
                      await productProvider.getAllProducts(cID);
                      log("completed");
                    }
                  },
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  tabs: productListner.categories
                      .mapIndexed((index, e) => SizedBox(
                            width: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                      color: AppColors.kPrimaryColor
                                          .withOpacity(0.1),
                                      border: productListner.selectedCategory ==
                                              e
                                          ? Border.all(
                                              color: AppColors.kPrimaryColor,
                                              width: 1.5)
                                          : null,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: e.image != null
                                      ? Center(
                                          child: CachedNetworkImage(
                                          imageUrl: e.image ?? '',
                                          height: 50,
                                        ))
                                      : SizedBox(
                                          height: 70,
                                          width: 70,
                                          child: Center(
                                            child: Image(
                                              image: AssetImage(
                                                  Assets.images.noimage.path),
                                              height: 50,
                                            ),
                                          ),
                                        ),
                                ),
                                Text(
                                  e.name ?? '',
                                  // maxLines: 1,
                                  textAlign: TextAlign.center,

                                  overflow: TextOverflow.ellipsis,
                                  style: context.customTextTheme.text12W500,
                                ),
                                verticalSpaceSmall,
                              ],
                            ),
                          ))
                      .toList()),
              verticalSpaceSmall,
              Expanded(
                child: productListner.productsListAPIResponse.status ==
                        APIResponseStatus.loading
                    ? const ShimmerProductDetailsTile()
                    : AlignedGridView.count(
                        crossAxisCount: 2,
                        itemCount: productListner.productsList.length,
                        cacheExtent: 250,
                        itemBuilder: (context, index) {
                          final product =
                              productListner.productsList.elementAt(index);
                          final isExist =
                              cartProvider.isProductExist(product.pID);
                          final productQtyUpdated =
                              cartProvider.getProductQuantity(product.pID);
                          final cartIndex =
                              cartProvider.getProductCartIndex(product.pID);
                          return ProductDetailsTile(
                            product,
                            secondaryWidget: QtyCounterButton2(
                                qty: productQtyUpdated,
                                onDecrementQty: () {
                                  cartProvider.decrementCartItemQty(cartIndex);
                                  cartProvider.clearSelectedAddressSecondary();
                                  cartProvider.clearSelectedAddress();
                                },
                                onIncrementQty: () {
                                  cartProvider.incrementCartItemQty(cartIndex);
                                  cartProvider.clearSelectedAddressSecondary();
                                  cartProvider.clearSelectedAddress();
                                }),
                            useSecondaryWidget: isExist,
                            onPressed: () {
                              showItemDetailsBottomSheet(context, product);
                            },
                            onPressAddBtn: () {
                              if (product.pID == null) return;
                              if (product.variations.isNotEmpty) {
                                cartProvider.onChangeVariation(
                                  product.variations.first,
                                );
                              }
                              cartProvider.updateSelectedItemId(product.pID!);
                              // cartProvider.addItemToCart().then((added) {
                              //   if (added) {
                              //     cartProvider.resetValues();
                              //   }
                              // });
                              showAddItemBottomSheet(context, product);
                            },
                          );
                        },
                      ),
              ),
              verticalSpaceRegular,
              verticalSpaceRegular,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.kPrimaryColor, width: 1.5)),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          prefixIcon: const Icon(FluentIcons.search_12_regular,
              color: AppColors.kGray2),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 20,
                width: 1,
                color: AppColors.kGray2,
              ),
              horizontalSpaceSmall,
              const Icon(Icons.tune_rounded, color: AppColors.kPrimaryColor),
            ],
          ),
          border: InputBorder.none,
          hintText: 'Search...',
          hintStyle: context.customTextTheme.text14W500
              .copyWith(color: AppColors.kGray2),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  void showItemDetailsBottomSheet(
      BuildContext context, ProductDataModel product) {
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
          return DishDetailBottomSheet(
            product: product,
            onRequestOrderDish: () {
              if (product.pID == null) return;

              if (product.variations.isNotEmpty) {
                context.read<CartProvider>().onChangeVariation(
                      product.variations.first,
                    );
              }

              context.read<CartProvider>().updateSelectedItemId(product.pID!);

              showAddItemBottomSheet(context, product);
            },
          );
        });
  }

  void showAddItemBottomSheet(BuildContext context, ProductDataModel product) {
    final sheetFuture = showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (context) {
          return AddDishBottomSheet(
            product: product,
          );
        });

    sheetFuture.whenComplete(() {
      context.read<CartProvider>().resetValues();
    });
  }
}
