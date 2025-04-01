import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:bamboo_basket_customer_app/core/constants/app_identifiers.dart';
import 'package:bamboo_basket_customer_app/core/utils/date_utils.dart';
import 'package:bamboo_basket_customer_app/domain/checkout/models/calculated_delivery_charge_details_model.dart';

import 'package:bamboo_basket_customer_app/domain/checkout/models/checkout_data_model.dart';
import 'package:bamboo_basket_customer_app/domain/checkout/models/payment_intent_details.dart';
import 'package:bamboo_basket_customer_app/infrastructure/core/api_manager/api_manager.dart';
import 'package:bamboo_basket_customer_app/infrastructure/core/end_points/end_points.dart';

import 'package:bamboo_basket_customer_app/infrastructure/core/failures/app_exceptions.dart';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/checkout/i_checkout_repo.dart';
import '../../domain/checkout/models/calculate_take_away_details.dart';

@LazySingleton(as: ICheckoutRepo)
class CheckoutRepo implements ICheckoutRepo {
  @override
  Future<Either<AppExceptions, CalculatedDeliveryChargeDetailsModel>>
      calculateDeliveryFee({
    required String shopID,
    required String destinationPostCode,
  }) async {
    try {
      final response = await APIManager.post(
        api: Endpoints.kDeliveryCalculator,
        data: {
          "shopID": shopID,
          "postCode": destinationPostCode,
        },
        needAuth: true,
        additionalHeaders: {"x-secretkey": AppIdentifiers.kFPSecretKey},
      );
      if (response == null) return Left(InternalServerErrorException());
      return Right(CalculatedDeliveryChargeDetailsModel.fromJson(response));
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Either<AppExceptions, Map<String, dynamic>>> completeOrder({
    required CheckOutDataModel data,
  }) async {
    try {
      final response = await APIManager.post(
        api: Endpoints.kCompleteOrder,
        data: data.toJson(),
        needAuth: true,
      );
      if (response == null) return Left(InternalServerErrorException());
      return Right(jsonDecode(response));
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Either<AppExceptions, CalculateTakeAwayDetails>> calculateTakeAwayFee(
      DateTime pickupTime) async {
    try {
      final response = await APIManager.post(
        api: Endpoints.kTakeawayCalculator,
        additionalHeaders: {
          "x-secretkey": AppIdentifiers.kFPSecretKey,
        },
        data: {
          "shopID": AppIdentifiers.kShopId,
          "pickupTime": DateTimeUtils.format(pickupTime)
        },
        needAuth: true,
      );
      if (response == null) return Left(InternalServerErrorException());
      return Right(CalculateTakeAwayDetails.fromJson(response));
    } on DioException catch (e) {
      final errorResponse = e.response?.data;
      if (errorResponse is Map<String, dynamic>) {
        final message = errorResponse["message"];
        return Left(BadRequestErrorException(message: message));
      }

      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (e) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Option> cancelPaymentIntent(String paymentID) async {
    try {
      final data = {
        "shopID": AppIdentifiers.kShopId,
        "paymentID": paymentID,
      };

      final response = await APIManager.post(
        api: Endpoints.kCancelPaymentIntent,
        data: data,
        authDataKey: "user",
        needAuth: true,
      );

      if (response == null) return Option.of(InternalServerErrorException());
      return const Option.none();
    } on DioException catch (e) {
      final errorResponse = e.response?.data;
      if (errorResponse is Map<String, dynamic>) {
        final message = errorResponse["message"];
        return Option.of(BadRequestErrorException(message: message));
      }

      return Option.of(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Option.of(InternalServerErrorException());
    }
  }

  @override
  Future<Either<AppExceptions, PaymentIntentDetails>> createPaymentIntent({
    required String discountAmount,
    required String deliveryCharges,
  }) async {
    try {
      final data = {
        "devliveryCharges": deliveryCharges,
        "discountAmount": discountAmount,
        "shopID": AppIdentifiers.kShopId,
      };

      final response = await APIManager.post(
        api: Endpoints.kCreatePaymentIntent,
        data: data,
        authDataKey: "user",
        needAuth: true,
      );

      if (response == null) return Left(InternalServerErrorException());

      return Right(PaymentIntentDetails.fromJson(response));
    } on DioException catch (e) {
      final errorResponse = e.response?.data;
      if (errorResponse is Map<String, dynamic>) {
        final message = errorResponse["message"];
        return Left(BadRequestErrorException(message: message));
      }

      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }
}
