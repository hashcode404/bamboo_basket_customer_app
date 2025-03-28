import 'package:aj_customer/domain/cart/models/cart_details_model.dart';
import 'package:aj_customer/infrastructure/core/failures/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';

import 'models/add_product_cart_request_model.dart';

abstract class ICartRepo {
  Future<Either<AppExceptions, CartDetailsModel>> listCartItems();

  Future<Option> addCartItem(AddProductCartRequestDataModel cartItem);

  Future<Option> updateCartItem(String cartItemId, AddProductCartRequestDataModel cartItem);

  Future<Option> deleteCartItem({required String id});

  Future<Option> clearCart();
}
