import 'dart:developer' as dev;
import 'dart:isolate';
import 'dart:math';

import 'package:bamboo_basket_customer_app/infrastructure/store/store_repo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bamboo_basket_customer_app/application/core/api_response.dart';
import 'package:bamboo_basket_customer_app/application/core/base_controller.dart';
import 'package:bamboo_basket_customer_app/domain/store/i_store_repo.dart';
import 'package:bamboo_basket_customer_app/domain/store/models/product_category_model.dart';
import 'package:injectable/injectable.dart';

import '../../domain/store/models/product_details_model.dart';

// enum FoodType { nonVeg, veg }

@LazySingleton()
class ProductsProvider extends ChangeNotifier with BaseController {
  final IStoreRepo storeRepo;

  ProductsProvider({required this.storeRepo});
  Random random = Random();

  var _productsListAPIResponse = APIResponse<List<ProductDataModel>>.initial();

  APIResponse<List<ProductDataModel>> get productsListAPIResponse =>
      _productsListAPIResponse;

  List<ProductDataModel> get productsList =>
      _productsListAPIResponse.data ?? [];

  List<ProductDataModel> _productsCollection = [];

  List<ProductDataModel> productsListRandom = [];

  var _categoriesListAPIResponse = APIResponse<List<CategoryData>>.initial();

  APIResponse<List<CategoryData>> get categoriesListAPIResponse =>
      _categoriesListAPIResponse;

  bool get categoryLoadingAndProductEmpty =>
      categoriesListAPIResponse == APIResponse<List<CategoryData>>.loading() &&
      _productsListAPIResponse.data == null;

  List<CategoryData> get categories => _categoriesListAPIResponse.data ?? [];

  CategoryData? _selectedCategory;

  CategoryData? get selectedCategory => _selectedCategory;

  // FoodType _selectedFoodType = FoodType.nonVeg;

  // FoodType get selectedFoodType => _selectedFoodType;

  // void onChangeFoodType(FoodType type) {
  //   _selectedFoodType = type;
  //   notifyListeners();
  // }

  Map<String, List<ProductDataModel>> _cachedProducts = {}; // Cache storage

  @override
  Future<void> init() async {
    await getAllProductsByPagination();
    return super.init();
  }

  Future<void> getAllProductsByPagination() async {
    _productsListAPIResponse = APIResponse.loading();
    notifyListeners();
    final response = await storeRepo.getProductsByPagination(
        categoryID: '0', numberOfProducts: '12');
    response.fold((error) {
      _productsListAPIResponse = APIResponse.error(
        error.message,
        exception: error,
      );
      notifyListeners();
    }, (result) async {
      dev.log(result.dataList.length.toString(),
          name: "productsListLength-paginations");
      // List<ProductDataModel> products = await Future.wait(
      //   result.dataList.map(
      //     (product) async => product.copyWith(
      //       scheme: await getSchemeFromImage(product.photo),
      //     ),
      //   ),
      // );
      _productsListAPIResponse = APIResponse.completed(result.dataList);
      productsListRandom = result.dataList;

      // var shuffledList = List<ProductDataModel>.from(_productsListAPIResponse.data!);
      // shuffledList.shuffle(random);
      // productsListRandom = shuffledList;
      notifyListeners();
    });
  }

  // Future<void> getAllProducts(String categoryID) async {
  //   _productsListAPIResponse = APIResponse.loading();
  //   notifyListeners();
  //   final response = await storeRepo.getProducts(categoryID: categoryID);
  //   response.fold((error) {
  //     _productsListAPIResponse = APIResponse.error(
  //       error.message,
  //       exception: error,
  //     );
  //     notifyListeners();
  //   }, (result) {
  //     dev.log(result.items.length.toString(), name: "productsListLength");
  //     // print('Response data: ${result.items}');
  //     // List<ProductDataModel> products = await Future.wait(
  //     //   result.items.map(
  //     //     (product) async => product.copyWith(
  //     //       scheme: await getSchemeFromImage(product.photo),
  //     //     ),
  //     //   ),
  //     // );
  //     _productsListAPIResponse = APIResponse.completed(result.items);
  //     _productsCollection = result.items;
  //     notifyListeners();
  //   });
  // }

  Future<void> getAllProducts(String categoryID) async {

    if (_cachedProducts.containsKey(categoryID)) {
      _productsCollection = _cachedProducts[categoryID]!;
      _productsListAPIResponse = APIResponse.completed(_productsCollection);
      notifyListeners();
      return;
    }

  
    _productsListAPIResponse = APIResponse.loading();
    notifyListeners();

    final response = await storeRepo.getProducts(categoryID: categoryID);
    response.fold((error) {
      _productsListAPIResponse =
          APIResponse.error(error.message, exception: error);
      notifyListeners();
    }, (result) {
      _cachedProducts[categoryID] = result.items; 
      _productsCollection = result.items;
      _productsListAPIResponse = APIResponse.completed(result.items);
      notifyListeners();
    });
  }

  Future<ColorScheme?> getSchemeFromImage(String? image) async {
    try {
      if (image == null) return null;
      return await ColorScheme.fromImageProvider(
        provider: CachedNetworkImageProvider(image),
      );
    } catch (e) {
      return null;
    }
  }

  // Future<void> getAllCategories() async {
  //   _categoriesListAPIResponse = APIResponse.loading();
  //   notifyListeners();
  //   final response = await storeRepo.getCategories();
  //   response.fold((error) {
  //     _categoriesListAPIResponse = APIResponse.error(
  //       error.message,
  //       exception: error,
  //     );
  //     notifyListeners();
  //   }, (result) async {
  //     _categoriesListAPIResponse = APIResponse.completed(result.items);
  //     notifyListeners();

  //     if (result.items == null) return;
  //     if (result.items?.first.cID != null) {
  //       await getAllProducts(result.items!.first.cID!);
  //       notifyListeners();
  //     }
  //   });
  // }

  Future<void> getAllCategories() async {
    _categoriesListAPIResponse = APIResponse.loading();
    notifyListeners();

    final response = await storeRepo.getCategories();
    response.fold((error) {
      _categoriesListAPIResponse = APIResponse.error(
        error.message,
        exception: error,
      );
      notifyListeners();
    }, (result) async {
      final filteredCategories = result.items
          ?.where((category) => category.productsCount?.online != 0)
          .toList();

      final filteredCategoriesChildren = result.items
          ?.expand((category) => category.childrens ?? [])
          .where((child) => child.productsCount?.online != 0)
          .toList();

      if (filteredCategories == null && filteredCategoriesChildren == null) {
        return;
      }

      final mergedCategories = <CategoryData>[
        ...filteredCategories ?? [],
        ...filteredCategoriesChildren ?? []
      ];

      _categoriesListAPIResponse = APIResponse.completed(mergedCategories);
      notifyListeners();

      if (mergedCategories.isNotEmpty && mergedCategories.first.cID != null) {
        await getAllProducts(mergedCategories.first.cID!);
        notifyListeners();
      }
    });
  }

  void onChangeSelectedCategory(CategoryData? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void resetValues() {
    _productsListAPIResponse = APIResponse.initial();
    _categoriesListAPIResponse = APIResponse.initial();
    _productsCollection.clear();
    // _selectedFoodType = FoodType.nonVeg;
  }
}
