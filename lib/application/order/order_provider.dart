import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:aj_customer/application/core/base_controller.dart';
import 'package:aj_customer/domain/user/i_user_repo.dart';
import 'package:injectable/injectable.dart';

import '../../domain/user/models/order_history_raw_data_model.dart';
import '../core/api_response.dart';

@LazySingleton()
class OrderProvider extends ChangeNotifier with BaseController {
  final IUserRepo userRepo;

  APIResponse<List<OrderDetailsModel>> _ordersResponse = APIResponse<List<OrderDetailsModel>>.initial();

  APIResponse<List<OrderDetailsModel>> get ordersResponse => _ordersResponse;

  bool get isEmpty => _ordersResponse.data?.isEmpty ?? true;

  String? _viewOrderId;

  String? get viewOrderId => _viewOrderId;

  OrderDetailsModel? get viewOrderDetails {
    return _ordersResponse.data?.firstOrNullWhere((order) {
      return order.orderID == viewOrderId;
    });
  }

  OrderProvider({required this.userRepo});

  @override
  Future<void> init() {
    fetchAllOrders();
    return super.init();
  }

  Future<void> fetchAllOrders() async {
    _ordersResponse = APIResponse.loading();
    notifyListeners();
    final response = await userRepo.getOrderHistory();
    response.fold((exception) {
      _ordersResponse = throwAppException(exception);
      notifyListeners();
    }, (result) {
      _ordersResponse = APIResponse.completed(result.history);
      notifyListeners();
    });
  }

  void updateViewOrderId(String orderID) async {
    _viewOrderId = orderID;
    notifyListeners();
  }
}
