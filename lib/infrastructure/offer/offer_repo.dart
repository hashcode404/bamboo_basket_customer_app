import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:bamboo_basket_customer_app/core/constants/app_identifiers.dart';
import 'package:bamboo_basket_customer_app/domain/offer/models/offer_details_model.dart';
import 'package:bamboo_basket_customer_app/domain/offer/models/validated_coupon_details.dart';
import 'package:bamboo_basket_customer_app/infrastructure/core/failures/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/offer/i_offer_repo.dart';
import '../core/api_manager/api_manager.dart';
import '../core/end_points/end_points.dart';

@LazySingleton(as: IOfferRepo)
class OfferRepo implements IOfferRepo {
  @override
  Future<Either<AppExceptions, List<OfferDetailsModel>>> listAllOffers() async {
    try {
      final response = await APIManager.get(
        api: Endpoints.kListActiveOffers,
        params: "/${AppIdentifiers.kShopId}",
      );

      if (response == null) return Left(InternalServerErrorException());

      final rawOfferList =
          (jsonDecode(response)?["offerCodeList"] ?? []) as List<dynamic>;

      return Right(
        rawOfferList.map((e) => OfferDetailsModel.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Either<AppExceptions, ValidatedCouponDetails>> validateCouponCode(
      String coupenId) async {
    try {
      final response = await APIManager.post(
        api: Endpoints.kValidateCouponCode,
        data: {
          "shopID": AppIdentifiers.kShopId,
          "coupenCode": coupenId,
        },
        needAuth: true,
      );

      if (response == null) return Left(InternalServerErrorException());
      return Right(
        ValidatedCouponDetails.fromJson(
          jsonDecode(response) as Map<String, dynamic>,
        ),
      );
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    }
  }
}
