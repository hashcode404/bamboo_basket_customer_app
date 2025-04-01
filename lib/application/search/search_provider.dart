import 'dart:developer';

import 'package:bamboo_basket_customer_app/application/core/base_controller.dart';
import 'package:bamboo_basket_customer_app/domain/store/models/product_details_model.dart';
// import 'package:bamboo_basket_customer_app/domain/search/model/search_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../domain/search/i_search_repo.dart';

@LazySingleton()
class SearchProvider extends ChangeNotifier with BaseController {
  final ISearchRepo searchRepo;
  SearchProvider({required this.searchRepo});

  final _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  bool _isSearchLoading = false;

  bool get isSearchLoading => _isSearchLoading;

  List<ProductDataModel>? _searchResponse;

  List<ProductDataModel>? get searchResponse => _searchResponse;

  // List<ProductDataModel> get searchProductsList => _searchResponse ?? [];

  String previousSearchKey = '';

  Future<void> getAllSearchProducts(String searchKey) async {
    if (searchKey == previousSearchKey) return;
    try {
      _isSearchLoading = true;
      notifyListeners();
      final response =
          await searchRepo.getAllSearchProducts(searchKey: searchKey);

      response.fold((error) {
        return error;
      }, (result) async {
        _searchResponse = result;
      });
    } finally {
      _isSearchLoading = false;
      notifyListeners();
    }
  }

  void clearSearchData() {
    _searchResponse = null;
    previousSearchKey = '';
    notifyListeners();
  }
}
