import 'package:bamboo_basket_customer_app/application/core/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class HomeProvider extends ChangeNotifier with BaseController {
  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  ValueNotifier<int> get currentPage => _currentPage;

  void onChangeCurrentPage(int index) {
    _currentPage.value = index;
    notifyListeners();
  }
}
