import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:bamboo_basket_customer_app/core/constants/app_identifiers.dart';
import 'package:bamboo_basket_customer_app/domain/table/i_table_repo.dart';
import 'package:bamboo_basket_customer_app/domain/table/models/reserve_dining_table.dart';
import 'package:bamboo_basket_customer_app/domain/table/models/table_reservation_details.dart';
import 'package:bamboo_basket_customer_app/infrastructure/core/failures/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../core/api_manager/api_manager.dart';
import '../core/end_points/end_points.dart';

@LazySingleton(as: ITableRepo)
class TableRepo implements ITableRepo {
  @override
  Future<Either<AppExceptions, List<TableReservationDetails>>>
      reservationHistory() async {
    try {
      final response = await APIManager.get(
        api: Endpoints.kDiningTableReservationHistory,
        needAuth: true,
        params: "${AppIdentifiers.kShopId}/all",
      );
      if (response == null) return Left(InternalServerErrorException());
      final rawData = jsonDecode(response);
      final data = rawData["enquiryList"] as List;
      return right(
          data.map((e) => TableReservationDetails.fromJson(e)).toList());
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Option> reserveDiningTable(ReserveDiningTable payload) async {
    try {
      final response = await APIManager.post(
        api: Endpoints.kDiningTableReservationNew,
        data: payload.toJson(),
        additionalHeaders: {
          "x-secretkey": AppIdentifiers.kReservationSecretKey,
        },
      );
      if (response == null) return Option.of(InternalServerErrorException());
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
