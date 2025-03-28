import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../core/constants/app_identifiers.dart';
import '../../domain/promotion/i_promotion_repo.dart';
import '../../domain/promotion/models/promotions_model.dart';
import '../core/api_manager/api_manager.dart';
import '../core/end_points/end_points.dart';
import '../core/failures/app_exceptions.dart';

@LazySingleton(as: IPromotionRepo)
class PromotionsRepo implements IPromotionRepo {
  @override
  Future<Either<AppExceptions, List<PromotionsModel>>> getPromotions() async {
    try {
      final response = await APIManager.get(
          api: Endpoints.kPromotion,
          baseUrl: Endpoints.kPromotionsBaseUrl,
          params: AppIdentifiers.kShopId);
      if (response == null) return Left(InternalServerErrorException());
      final json = jsonDecode(response);
      final jsonData = (jsonDecode(response) ?? []) as List<dynamic>;
      log(jsonData.toString());

      final l = jsonData
          .map(
            (e) => PromotionsModel(
              offerId: e['offerId'],
              rId: e['rId'],
              title: e['title'],
              description: e['description'],
              offerCode: e['offerCode'],
              web: e['web'],
              mobile: e['mobile'],
              wPosition: e['wPosition'],
              mPosition: e['mPosition'],
              paymentType: e['paymentType'],
              price: e['price'],
              discount_price: e['discount_price'],
              startDate: e['startDate'],
              endDate: e['endDate'],
              usage_count: e['usage_count'],
              locations: e['locations'],
              doorDelivery: e['doorDelivery'],
              takeAway: e['takeAway'],
              active: e['active'],
              file: e['file'],
            ),
          )
          .toList();

      return right(l);
      // return Right(jsonData.map((e) {
      //   return PromotionsModel.fromJson(e);
      // }).toList());
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  // Future<Either<AppExceptions, PromotionsModel>> getPromotions() async {
  //   try {
  //     final response = await APIManager.get(
  //         api: Endpoints.kPromotion,
  //         baseUrl: Endpoints.kPromotionsBaseUrl,
  //         params: AppIdentifiers.kShopId);
  //     log(response.toString());
  //     if (response == null) return Left(InternalServerErrorException());
  //     return Right(
  //       PromotionsModel.fromJson(response as Map<String, dynamic>),
  //     );
  //   } on DioException catch (e) {
  //     return Left(e.error is AppExceptions
  //         ? e.error as AppExceptions
  //         : InternalServerErrorException());
  //   } catch (_) {
  //     return Left(InternalServerErrorException());
  //   }
  // }
}
