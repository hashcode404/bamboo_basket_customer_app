import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:bamboo_basket_customer_app/domain/cart/i_cart_repo.dart';
import 'package:bamboo_basket_customer_app/domain/cart/models/cart_details_model.dart';
import 'package:bamboo_basket_customer_app/infrastructure/core/api_manager/api_manager.dart';
import 'package:bamboo_basket_customer_app/infrastructure/core/end_points/end_points.dart';
import 'package:bamboo_basket_customer_app/infrastructure/core/failures/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/cart/models/add_product_cart_request_model.dart';

@LazySingleton(as: ICartRepo)
class CartRepo implements ICartRepo {
  @override
  Future<Option> addCartItem(AddProductCartRequestDataModel cartItem) async {
    try {
      final response = await APIManager.post(
        api: Endpoints.kAddToCartNew,
        data: cartItem.toJson(),
        needAuth: true,
      );
      if (response == null) {
        return Option<AppExceptions>.of(InternalServerErrorException());
      }
      return const Option.none();
    } on DioException catch (e) {
      return Option.of(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Option.of(InternalServerErrorException());
    }
  }

  @override
  Future<Option> clearCart() async {
    try {
      final response = await APIManager.delete(
        api: Endpoints.kClearCart,
        needAuthentication: true,
      );
      if (response == null) {
        return Option<AppExceptions>.of(InternalServerErrorException());
      }
      return const Option.none();
    } on DioException catch (e) {
      return Option.of(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Option.of(InternalServerErrorException());
    }
  }

  @override
  Future<Option> deleteCartItem({required String id}) async {
    try {
      final response = await APIManager.delete(
        api: "${Endpoints.kDeleteCartItem}/$id",
        needAuthentication: true,
      );
      if (response == null) {
        return Option<AppExceptions>.of(InternalServerErrorException());
      }
      return const Option.none();
    } on DioException catch (e) {
      return Option.of(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Option.of(InternalServerErrorException());
    }
  }

  @override
  Future<Either<AppExceptions, CartDetailsModel>> listCartItems() async {
    try {
      final response = await APIManager.get(
        api: Endpoints.kListCartItems,
        needAuth: true,
      );
      if (response == null) {
        return Left(InternalServerErrorException());
      }
      return Right(CartDetailsModel.fromMap(jsonDecode(response)["cart"]));
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Option> updateCartItem(
    String cartItemId,
    AddProductCartRequestDataModel cartItem,
  ) async {
    try {
      log(cartItem.toJson(), name: "Payload");
      final response = await APIManager.put(
        api: "${Endpoints.kNewUpdateCartItem}/$cartItemId",
        data: cartItem.toJson(),
        needAuthentication: true,
      );
      if (response == null) {
        return Option<AppExceptions>.of(InternalServerErrorException());
      }
      return const Option.none();
    } on DioException catch (e) {
      return Option.of(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Option.of(InternalServerErrorException());
    }
  }
}
