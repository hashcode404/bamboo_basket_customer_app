import 'dart:developer';

import 'package:aj_customer/application/core/api_response.dart';
import 'package:aj_customer/application/search/search_provider.dart';

import 'package:aj_customer/presentation/widgets/qty_counter_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aj_customer/application/cart/cart_provider.dart';
import 'package:aj_customer/application/products/products_provider.dart';
import 'package:aj_customer/core/theme/app_colors.dart';
import 'package:aj_customer/core/theme/custom_text_styles.dart';
import 'package:aj_customer/core/utils/ui_utils.dart';
import 'package:aj_customer/presentation/widgets/manage_dish_sheets.dart';
import 'package:aj_customer/presentation/widgets/shimmer_product_details_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../../../application/home/home_provider.dart';
import '../../../application/promotion/promotions_provider.dart';

import '../../../application/shop/shop_provider.dart';
import '../../../domain/store/models/product_details_model.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/product_details_tile.dart';

@RoutePage()
class OrderOnlineHomeScreen extends StatefulWidget {
  const OrderOnlineHomeScreen({super.key});

  @override
  State<OrderOnlineHomeScreen> createState() => _OrderOnlineHomeScreenState();
}

class _OrderOnlineHomeScreenState extends State<OrderOnlineHomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  // final isNewView = true;
  final List<String> imageUrlsForBanner = [
    Assets.images.ajBanner01.path,
    Assets.images.ajBanner02.path,
    Assets.images.ajBanner03.path,
  ];

  final List<String> imageUrlsForSliders = [
    Assets.images.sliderOne.path,
    Assets.images.sliderTwo.path,
    Assets.images.sliderOne.path,
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final productProvider = context.read<ProductsProvider>();
        final categories = productProvider.categories;
        if (productProvider.productsList.isNotEmpty) {
          _setupTabController(categories);
        } else {
          productProvider.getAllCategories().then((_) {
            _setupTabController(productProvider.categories);
          });
        }
      }
    });
    super.initState();
  }

  void _setupTabController(List categories) {
    final totalCategories = categories.length;
    setState(() {
      _tabController = TabController(length: totalCategories, vsync: this);
    });
    _tabController?.addListener(() {
      final categoryId = categories.elementAt(_tabController!.index).cID;
      if (categoryId != null) {
        context.read<ProductsProvider>().getAllProducts(categoryId);
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductsProvider>();
    final productListener = context.watch<ProductsProvider>();
    final cartProvider = context.read<CartProvider>();
    final cartListener = context.watch<CartProvider>();
    final promotionListner = context.watch<PromotionsProvider>();

    final shopProvider = context.read<ShopProvider>();
    final shopListener = context.watch<ShopProvider>();

    return PopScope(
      onPopInvokedWithResult: (_, __) {
        Future.delayed(const Duration(milliseconds: 100), () {
          productProvider.resetValues();
        });
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.kWhite,
            // appBar: AppBar(
            //   title: Assets.images.ajLogo.image(height: 50),
            //   backgroundColor: AppColors.kLightWhite,
            // ),
            body: buildContent(
              promotionListner,
              productListener,
              productProvider,
              cartProvider,
            )),
      ),
    );
  }

  Widget buildContent(
    PromotionsProvider promotionListener,
    ProductsProvider productListener,
    ProductsProvider productProvider,
    CartProvider cartProvider,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpaceSmall,
          buildAppbar(),
          verticalSpaceMedium,
          buildImageForBanners(),
          verticalSpaceSmall,
          buildCategories(productListener, productProvider),
          verticalSpaceSmall,
          buildRecommendedProducts(
              productListener, cartProvider, productProvider),
          verticalSpaceMedium,
          buildImageForSliders(),
          verticalSpaceSmall,
          buildFeaturedProducts(productListener, cartProvider, productProvider),
          verticalSpaceRegular,
          buildDealsWidget(productListener, cartProvider, productProvider),
          verticalSpaceXLarge,
        ],
      ),
    );
  }

  Row buildAppbar() {
    return Row(
      children: [
        Image(
          image: AssetImage(Assets.images.ajLogo.path),
          height: MediaQuery.of(context).size.height * 0.06,
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            showSearch(context: context, delegate: ProductSearchDelegate());
          },
          child: Assets.icons.searchNormal.svg(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
        ),
        // IconButton(
        //     onPressed: () {
        //       showSearch(context: context, delegate: ProductSearchDelegate());
        //     },
        //     icon: const Icon(Icons.search)),
        horizontalSpaceRegular,
        horizontalSpaceSmall,
        // Flexible(
        //   flex: 2,
        //   child: Container(
        //     margin: const EdgeInsets.only(right: 10),
        //     decoration: BoxDecoration(
        //         color: AppColors.kWhite,
        //         borderRadius: BorderRadius.circular(30),
        //         border: Border.all(color: AppColors.kPrimaryColor, width: 1.5)),
        //     child: TextField(
        //       textAlignVertical: TextAlignVertical.center,
        //       decoration: InputDecoration(
        //         prefixIcon: const Icon(FluentIcons.search_12_regular,
        //             color: AppColors.kGray2),
        //         suffixIcon: Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Container(
        //               height: 20,
        //               width: 1,
        //               color: AppColors.kGray2,
        //             ),
        //             horizontalSpaceSmall,
        //             const Icon(Icons.tune_rounded,
        //                 color: AppColors.kPrimaryColor),
        //           ],
        //         ),
        //         border: InputBorder.none,
        //         hintText: 'Search...',
        //         hintStyle: context.customTextTheme.text14W500
        //             .copyWith(color: AppColors.kGray2),
        //         enabledBorder: InputBorder.none,
        //         focusedBorder: InputBorder.none,
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }

//For banners
  Widget buildImageForBanners() {
    return CarouselSlider(
      options: CarouselOptions(
        disableCenter: true,
        height: MediaQuery.of(context).size.height * 0.15,
        viewportFraction: 0.8,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlay: true,
        pauseAutoPlayOnTouch: true,
        enlargeCenterPage: true,
      ),
      items: imageUrlsForBanner.map((imageUrl) {
        return Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(imageUrl, fit: BoxFit.cover),
          ),
        );
      }).toList(),
    );
  }

  //for sliders
  Widget buildImageForSliders() {
    return CarouselSlider(
      options: CarouselOptions(
        disableCenter: true,
        height: MediaQuery.of(context).size.height * 0.13,
        viewportFraction: 0.7,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlay: false,
        pauseAutoPlayOnTouch: true,
        enlargeCenterPage: true,
      ),
      items: imageUrlsForSliders.map((imageUrl) {
        return Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(imageUrl, fit: BoxFit.cover),
          ),
        );
      }).toList(),
    );
  }

  Widget buildDealsWidget(ProductsProvider productListener,
      CartProvider cartProvider, ProductsProvider productProvider) {
    final listOfItems = ['Hot Deals', 'Best Seller', 'Top Rated'];
    final products = productProvider.productsList;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Deals 🔥",
                style: context.customTextTheme.text16W600,
              ),
              horizontalSpaceSmall,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    listOfItems[0],
                    style: context.customTextTheme.text14W400
                        .copyWith(color: AppColors.kWhite),
                  ),
                ),
              ),
              horizontalSpaceSmall,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                decoration: BoxDecoration(
                  // color: AppColors.kGray3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    listOfItems[1],
                    style: context.customTextTheme.text14W400
                        .copyWith(color: AppColors.kBlack),
                  ),
                ),
              ),
              horizontalSpaceSmall,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                decoration: BoxDecoration(
                  // color: AppColors.kGray3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    listOfItems[2],
                    style: context.customTextTheme.text14W400
                        .copyWith(color: AppColors.kBlack),
                  ),
                ),
              ),
            ],
          ),
          verticalSpaceRegular,
          productListener.productsListAPIResponse.status ==
                  APIResponseStatus.initial
              ? const SizedBox.shrink()
              : productListener.productsListAPIResponse.status ==
                      APIResponseStatus.loading
                  ? const CupertinoActivityIndicator()
                  : Column(
                      children: [
                        products.isEmpty
                            ? const Center(child: Text("No products found"))
                            : AlignedGridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 8.0,
                                itemCount: 4,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final product = productListener
                                      .productsListRandom
                                      .getRange(8, 12)
                                      .elementAt(index);
                                  final isExist =
                                      cartProvider.isProductExist(product.pID);
                                  final productQtyUpdated = cartProvider
                                      .getProductQuantity(product.pID);
                                  final cartIndex = cartProvider
                                      .getProductCartIndex(product.pID);

                                  return ProductDetailsTile(
                                    product,
                                    secondaryWidget: QtyCounterButton2(
                                        qty: productQtyUpdated,
                                        onDecrementQty: () {
                                          cartProvider
                                              .decrementCartItemQty(cartIndex);
                                          cartProvider
                                              .clearSelectedAddressSecondary();
                                          cartProvider.clearSelectedAddress();
                                        },
                                        onIncrementQty: () {
                                          cartProvider
                                              .incrementCartItemQty(cartIndex);
                                          cartProvider
                                              .clearSelectedAddressSecondary();
                                          cartProvider.clearSelectedAddress();
                                        }),
                                    useSecondaryWidget: isExist,
                                    onPressed: () {
                                      showItemDetailsBottomSheet(product);
                                    },
                                    onPressAddBtn: () {
                                      if (product.pID == null) return;
                                      if (product.variations.isNotEmpty) {
                                        cartProvider.onChangeVariation(
                                          product.variations.first,
                                        );
                                      }
                                      cartProvider
                                          .updateSelectedItemId(product.pID!);
                                      // cartProvider.addItemToCart().then((added) {
                                      //   if (added) {
                                      //     cartProvider.resetValues();
                                      //   }
                                      // });
                                      showAddItemBottomSheet(product);
                                    },
                                  );
                                },
                              ),
                      ],
                    )
        ],
      ),
    );
  }

  Widget buildFeaturedProducts(ProductsProvider productListener,
      CartProvider cartProvider, ProductsProvider productProvider) {
    final products = productProvider.productsList;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Our Featured Products",
                style: context.customTextTheme.text16W600,
              ),
              Text(
                "SEE ALL",
                style: context.customTextTheme.text16W600
                    .copyWith(fontSize: 1, color: AppColors.kPrimaryColor),
              ),
            ],
          ),
          verticalSpaceSmall,
          productListener.productsListAPIResponse.status ==
                  APIResponseStatus.initial
              ? const SizedBox.shrink()
              : productListener.productsListAPIResponse.status ==
                      APIResponseStatus.loading
                  ? const CupertinoActivityIndicator()
                  : Column(
                      children: [
                        products.isEmpty
                            ? const Center(child: Text("No products found"))
                            : AlignedGridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 8.0,
                                itemCount: 4,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final product = productListener
                                      .productsListRandom
                                      .getRange(4, 8)
                                      .elementAt(index);
                                  final isExist =
                                      cartProvider.isProductExist(product.pID);
                                  final productQtyUpdated = cartProvider
                                      .getProductQuantity(product.pID);
                                  final cartIndex = cartProvider
                                      .getProductCartIndex(product.pID);

                                  return ProductDetailsTile(
                                    product,
                                    secondaryWidget: QtyCounterButton2(
                                        qty: productQtyUpdated,
                                        onDecrementQty: () {
                                          cartProvider
                                              .decrementCartItemQty(cartIndex);
                                          cartProvider
                                              .clearSelectedAddressSecondary();
                                          cartProvider.clearSelectedAddress();
                                        },
                                        onIncrementQty: () {
                                          cartProvider
                                              .incrementCartItemQty(cartIndex);
                                          cartProvider
                                              .clearSelectedAddressSecondary();
                                          cartProvider.clearSelectedAddress();
                                        }),
                                    useSecondaryWidget: isExist,
                                    onPressed: () {
                                      showItemDetailsBottomSheet(product);
                                    },
                                    onPressAddBtn: () {
                                      if (product.pID == null) return;
                                      if (product.variations.isNotEmpty) {
                                        cartProvider.onChangeVariation(
                                          product.variations.first,
                                        );
                                      }
                                      cartProvider
                                          .updateSelectedItemId(product.pID!);
                                      // cartProvider.addItemToCart().then((added) {
                                      //   if (added) {
                                      //     cartProvider.resetValues();
                                      //   }
                                      // });
                                      showAddItemBottomSheet(product);
                                    },
                                  );
                                },
                              ),
                      ],
                    ),
        ],
      ),
    );
  }

  Widget buildRecommendedProducts(ProductsProvider productListner,
      CartProvider cartProvider, ProductsProvider productProvider) {
    final cartListener = context.watch<CartProvider>();
    final products = productProvider.productsList;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended For You",
            style: context.customTextTheme.text16W600,
          ),
          verticalSpaceSmall,
          productListner.productsListAPIResponse.status ==
                  APIResponseStatus.initial
              ? const SizedBox.shrink()
              : productListner.productsListAPIResponse.status ==
                      APIResponseStatus.loading
                  ? const ShimmerProductDetailsTile()
                  : Column(
                      children: [
                        products.isEmpty
                            ? const Center(child: Text("No products found"))
                            : AlignedGridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 8.0,
                                itemCount: 4,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final product = productListner
                                      .productsListRandom
                                      .getRange(0, 4)
                                      .elementAt(index);
                                  final isExist =
                                      cartProvider.isProductExist(product.pID);
                                  final productQtyUpdated = cartProvider
                                      .getProductQuantity(product.pID);
                                  final cartIndex = cartProvider
                                      .getProductCartIndex(product.pID);

                                  return ProductDetailsTile(
                                    product,
                                    secondaryWidget: QtyCounterButton2(
                                        qty: productQtyUpdated,
                                        onDecrementQty: () {
                                          cartProvider
                                              .decrementCartItemQty(cartIndex);
                                          cartProvider
                                              .clearSelectedAddressSecondary();
                                          cartProvider.clearSelectedAddress();
                                        },
                                        onIncrementQty: () {
                                          cartProvider
                                              .incrementCartItemQty(cartIndex);
                                          cartProvider
                                              .clearSelectedAddressSecondary();
                                          cartProvider.clearSelectedAddress();
                                        }),
                                    useSecondaryWidget: isExist,
                                    onPressed: () {
                                      showItemDetailsBottomSheet(product);
                                    },
                                    onPressAddBtn: () {
                                      if (product.pID == null) return;
                                      if (product.variations.isNotEmpty) {
                                        cartProvider.onChangeVariation(
                                          product.variations.first,
                                        );
                                      }
                                      cartProvider
                                          .updateSelectedItemId(product.pID!);
                                      // cartProvider.addItemToCart().then((added) {
                                      //   if (added) {
                                      //     cartProvider.resetValues();
                                      //   }
                                      // });
                                      showAddItemBottomSheet(product);
                                    },
                                  );
                                },
                              ),
                      ],
                    )
        ],
      ),
    );
  }

  Widget buildCategories(
    ProductsProvider productListner,
    ProductsProvider productProvider,
  ) {
    return productListner.categoriesListAPIResponse.status ==
            APIResponseStatus.loading
        ? const BuildProductsCategoryShimmer()
        : Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: context.customTextTheme.text16W600,
                      ),
                      InkWell(
                        onTap: () async {
                          context.read<HomeProvider>().onChangeCurrentPage(1);
                          final initialcategoryID =
                              productListner.categories.first.cID;
                          if (initialcategoryID != null) {
                            await productProvider
                                .getAllProducts(initialcategoryID);
                          }
                        },
                        child: Text(
                          "See All",
                          style: context.customTextTheme.text16W600.copyWith(
                              fontSize: 14, color: AppColors.kPrimaryColor),
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceRegular,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: productListner.categories
                          .mapIndexed((index, e) => InkWell(
                                onTap: () async {
                                  final cID = e.cID;

                                  if (cID != null) {
                                    productProvider.onChangeSelectedCategory(e);
                                    context
                                        .read<HomeProvider>()
                                        .onChangeCurrentPage(1);
                                    await productProvider.getAllProducts(cID);
                                  }
                                },
                                child: Container(
                                  width: 100,
                                  // height: 100,
                                  margin: const EdgeInsets.only(right: 10.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              //  productListner.selectedCategory == e
                                              //     ? AppColors.kprimary
                                              //     :
                                              AppColors.kLightWhite2,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        e.image != null
                                            ? CachedNetworkImage(
                                                imageUrl: e.image ?? '',
                                                height: 30,
                                              )
                                            : Image(
                                                image: AssetImage(
                                                    Assets.images.noimage.path),
                                                height: 30,
                                              ),
                                        verticalSpaceTiny,
                                        Text(
                                          e.name ?? '',
                                          style: context
                                              .customTextTheme.text12W500
                                              .copyWith(
                                                  color: AppColors.kBlack),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  )
                ],
              ),
            );
          });
  }

  Widget buildSliderPromotions(PromotionsProvider promotionListener) {
    return Visibility(
      visible: promotionListener.listOfPromotionImagesSlider.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CarouselSlider(
          options: CarouselOptions(
              height: 120.0,
              viewportFraction: 1,
              autoPlay: true,
              enlargeCenterPage: true),
          items: promotionListener.listOfPromotionImagesSlider.map((imageUrl) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.fitWidth,
                          )
                        : const Placeholder(
                            strokeWidth: 1.0,
                            fallbackHeight: 100.0,
                            fallbackWidth: double.infinity,
                          )));
          }).toList(),
        ),
      ),
    );
  }

  void showItemDetailsBottomSheet(ProductDataModel product) {
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

              showAddItemBottomSheet(product);
            },
          );
        });
  }

  void showAddItemBottomSheet(ProductDataModel product) {
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

  // Widget _buildVegAndNonVegBtn() {
  //   return Builder(builder: (context) {
  //     final productProvider = context.read<ProductsProvider>();
  //     final productListener = context.watch<ProductsProvider>();
  //     return Row(
  //       children: [
  //         OutlinedButton.icon(
  //           onPressed: () {
  //             productProvider.onChangeFoodType(FoodType.veg);
  //           },
  //           label: const Text("Veg"),
  //           style: OutlinedButton.styleFrom(
  //             foregroundColor:
  //                 productListener.selectedFoodType != FoodType.veg ? AppColors.kGray5 : AppColors.kTealGreen,
  //             side: BorderSide(
  //                 color: productListener.selectedFoodType != FoodType.veg ? AppColors.kGray5 : AppColors.kTealGreen),
  //           ),
  //           icon: Assets.icons.veg.svg(
  //             color: productListener.selectedFoodType != FoodType.veg ? AppColors.kGray5 : null,
  //           ),
  //         ),
  //         horizontalSpaceSmall,
  //         OutlinedButton.icon(
  //           onPressed: () {
  //             productProvider.onChangeFoodType(FoodType.nonVeg);
  //           },
  //           label: const Text("Non Veg"),
  //           style: OutlinedButton.styleFrom(
  //             foregroundColor:
  //                 productListener.selectedFoodType != FoodType.nonVeg ? AppColors.kGray5 : AppColors.kDarkRed,
  //             side: BorderSide(
  //                 color: productListener.selectedFoodType != FoodType.nonVeg ? AppColors.kGray5 : AppColors.kDarkRed),
  //           ),
  //           icon: Assets.icons.nonVeg.svg(
  //             color: productListener.selectedFoodType != FoodType.nonVeg ? AppColors.kGray5 : null,
  //           ),
  //         )
  //       ],
  //     );
  //   });
  // }
}

class ProductSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    final searchProvider = context.read<SearchProvider>();

    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          searchProvider.clearSearchData();
        },
      )
    ];
  }

  @override
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              const BorderSide(color: AppColors.kPrimaryColor, width: 1),
        ),
      );

  @override
  TextStyle get searchFieldStyle => const TextStyle(
      color: AppColors.kPrimaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 12);

  @override
  Widget? buildLeading(BuildContext context) {
    // return IconButton(
    //   icon: const Icon(Icons.arrow_back_ios_rounded),
    //   onPressed: () {
    //     close(context, null);
    //   },
    // );
    return _buildCustomBackButton(context);
  }

  InkWell _buildCustomBackButton(BuildContext context) {
    return InkWell(
      onTap: () {
        close(context, null);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.kGray3)),
        padding: const EdgeInsets.all(4),
        child: const Icon(
          Icons.arrow_back_ios_rounded,
          color: AppColors.kBlack,
          size: 20,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _SearchResults(query: query); // Pass query to _SearchResults
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // return _SearchResults(query: query); // Use same widget for suggestions
    return const SizedBox();
  }
}

class _SearchResults extends StatefulWidget {
  final String query;
  const _SearchResults({super.key, required this.query});

  @override
  State<_SearchResults> createState() => __SearchResultsState();
}

class __SearchResultsState extends State<_SearchResults> {
  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Fetch API on initState
  }

  void _fetchProducts() {
    if (widget.query.isNotEmpty) {
      Future.microtask(() {
        Provider.of<SearchProvider>(context, listen: false)
            .getAllSearchProducts(widget.query);
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final cartProvider = context.read<CartProvider>();

    return Consumer<SearchProvider>(
      builder: (context, value, child) {
        if (value.searchResponse == null ||
            value.searchResponse?.isEmpty == true) {
          return const Center(child: Text("No products found"));
        }
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: AlignedGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: value.searchResponse?.length ?? 0,
              itemBuilder: (context, index) {
                final product = value.searchResponse?.elementAt(index);
                final isExist = cartProvider.isProductExist(product!.pID);
                final productQtyUpdated =
                    cartProvider.getProductQuantity(product.pID);
                final cartIndex = cartProvider.getProductCartIndex(product.pID);
                return ProductDetailsTile(product,
                    onPressed: () {
                      showItemDetailsBottomSheet(product);
                    },
                    useSecondaryWidget: isExist,
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
                      showAddItemBottomSheet(product);
                    },
                    secondaryWidget: QtyCounterButton2(
                      qty: productQtyUpdated,
                      onIncrementQty: () {
                        cartProvider.incrementCartItemQty(cartIndex);
                      },
                      onDecrementQty: () {
                        cartProvider.decrementCartItemQty(cartIndex);
                      },
                    ));
              }),
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant _SearchResults oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != oldWidget.query) {
      _fetchProducts(); // Re-fetch if query changes
    }
  }

  void showItemDetailsBottomSheet(ProductDataModel product) {
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

              showAddItemBottomSheet(product);
            },
          );
        });
  }

  void showAddItemBottomSheet(ProductDataModel product) {
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
