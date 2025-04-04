import 'package:flutter/material.dart';
import 'package:bamboo_basket_customer_app/application/products/products_provider.dart';
import 'package:bamboo_basket_customer_app/domain/store/models/product_details_model.dart';
import 'package:bamboo_basket_customer_app/presentation/widgets/manage_dish_sheets.dart';
import 'package:bamboo_basket_customer_app/presentation/widgets/product_details_tile.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:bamboo_basket_customer_app/application/cart/cart_provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, productProvider, child) {
        final results = productProvider.productsList
            .where((item) =>
                item.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();

        if (results.isEmpty) {
          return const Center(
            child: Text('No items match your search.'),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final item = results[index];
            return ListTile(
              title: Text(item.name!),
              subtitle: Text('£${item.price.toString()}'),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, productProvider, child) {
        final datas = productProvider.productsList
            .where((item) =>
                item.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();

        return ListView.builder(
          itemCount: datas.length,
          itemBuilder: (context, index) {
            final item = datas[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ProductDetailsTile(
                item,
                secondaryWidget: const SizedBox.shrink(),
                onPressed: () {
                  showItemDetailsBottomSheet(item, context);
                },
                onPressAddBtn: () {
                  showAddItemBottomSheet(item, context);
                },
              ),
            );
          },
        );
      },
    );
  }

  void showItemDetailsBottomSheet(
      ProductDataModel product, BuildContext context) {
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

              showAddItemBottomSheet(product, context);
            },
          );
        });
  }

  void showAddItemBottomSheet(ProductDataModel product, BuildContext context) {
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
