import 'dart:convert';
import 'dart:developer';

import 'package:bamboo_basket_customer_app/domain/user/models/user_register_response.dart';
import 'package:dio/dio.dart';
import 'package:bamboo_basket_customer_app/domain/user/models/add_new_adress_request_model.dart';
import 'package:bamboo_basket_customer_app/domain/user/models/order_history_raw_data_model.dart';
import 'package:bamboo_basket_customer_app/domain/user/models/user_address_list_data_model.dart';
import 'package:bamboo_basket_customer_app/domain/user/models/user_login_request.dart';
import 'package:bamboo_basket_customer_app/domain/user/models/user_login_response.dart';
import 'package:bamboo_basket_customer_app/domain/user/models/user_register_request.dart';
import 'package:bamboo_basket_customer_app/infrastructure/core/api_manager/api_manager.dart';
import 'package:bamboo_basket_customer_app/infrastructure/core/end_points/end_points.dart';
import 'package:bamboo_basket_customer_app/infrastructure/core/failures/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../core/constants/app_identifiers.dart';
import '../../domain/user/i_user_repo.dart';

@LazySingleton(as: IUserRepo)
class UserRepo implements IUserRepo {
  @override
  Future<Either<AppExceptions, String>> addNewAddress(
      {required AddNewUserAddressRequestModel data}) async {
    try {
      final response = await APIManager.post(
        api: Endpoints.kAddNewAddress,
        needAuth: true,
        data: data.toJson(),
      );
      if (response == null) return Left(InternalServerErrorException());
      final decodedData = jsonDecode(response);
      return Right(decodedData["message"]);
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Option> deleteUserAddress({required String addressID}) async {
    try {
      final response = await APIManager.delete(
        api: "${Endpoints.kDeleteAddress}/$addressID",
        needAuthentication: true,
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

  @override
  Future<Either<AppExceptions, UserAddressListDataModel>>
      getUserAddressList() async {
    try {
      final response = await APIManager.get(
        api: Endpoints.kUserAddressList,
        needAuth: true,
        dataKeyChecking: false,
      );
      if (response == null) return Left(InternalServerErrorException());
      return Right(UserAddressListDataModel.fromJson(response));
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Either<AppExceptions, OrderHistoryDataModel>> getOrderHistory() async {
    try {
      final response = await APIManager.get(
        api: Endpoints.kOrderHistory,
        needAuth: true,
        params: AppIdentifiers.kShopId,
        dataKeyChecking: true,
      );
      if (response == null) return Left(InternalServerErrorException());
      return Right(OrderHistoryDataModel.fromJson(response));
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Either<AppExceptions, UserLoginResponse>> loginUser(
      UserLoginRequest payload) async {
    try {
      final response = await APIManager.post(
        api: Endpoints.kUserLogin,
        data: payload.toJson(),
      );
      if (response == null) return Left(InternalServerErrorException());
      return Right(UserLoginResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Either<AppExceptions, UserLoginResponse>> loginUserSecret(
      String userId) async {
    try {
      final response = await APIManager.post(
        api: Endpoints.kUserLogin,
        data: json.encode({
          "user": userId,
          "FPsecretkey": AppIdentifiers.kSecretKey,
        }),
      );
      if (response == null) return Left(InternalServerErrorException());
      return Right(UserLoginResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Either<AppExceptions, UserRegisterResponse>> registerUser(
      UserRegisterRequest payload) async {
    try {
      final response = await APIManager.post(
        api: Endpoints.kUserRegistration,
        dataKeyChecking: true,
        data: payload.toJson(),
      );
      if (response == null) return Left(InternalServerErrorException());
      log(response);
      return Right(UserRegisterResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Option> requestPasswordResetOTP(String userEmail) async {
    try {
      final data = {
        "shopID": AppIdentifiers.kShopId,
        "useremailid": userEmail,
        "FPsecretkey": AppIdentifiers.kFPSecretKey,
      };
      final response = await APIManager.post(
        api: Endpoints.kPasswordResetOtp,
        data: data,
        dataKeyChecking: false,
      );
      if (response == null) {
        return Option<AppExceptions>.of(InternalServerErrorException());
      }
      return const Option.none();
    } on DioException catch (e) {
      return Option<AppExceptions>.of(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Option<AppExceptions>.of(InternalServerErrorException());
    }
  }

  @override
  Future<Either<AppExceptions, String>> setDefaultUserAddress(
      {required String addressID}) async {
    try {
      final response = await APIManager.put(
        api: "${Endpoints.kSetDefaultAddress}/$addressID",
        needAuthentication: true,
        dataKeyChecking: false,
      );
      if (response == null) return Left(InternalServerErrorException());
      final decodedData = jsonDecode(response);
      return Right(decodedData["message"]);
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Either<AppExceptions, String>> updateAddress(
      {required AddNewUserAddressRequestModel data,
      required String addressID}) async {
    try {
      final response = await APIManager.put(
        api: "${Endpoints.kUpdateAddress}/$addressID",
        needAuthentication: true,
        data: data.toJson(),
      );
      if (response == null) return Left(InternalServerErrorException());
      final decodedData = jsonDecode(response);
      return Right(decodedData["message"]);
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  @override
  Future<Option> validateAndResetPassword(
      {required String userEmail,
      required String otp,
      required String password}) async {
    try {
      final data = {
        "shopID": AppIdentifiers.kShopId,
        "useremailid": userEmail,
        "otp": otp,
        "password": password,
        "FPsecretkey": AppIdentifiers.kFPSecretKey,
      };
      final response = await APIManager.post(
          api: Endpoints.kResetPassword, data: data, dataKeyChecking: false);
      if (response == null) {
        return Option<AppExceptions>.of(InternalServerErrorException());
      }
      return const Option.none();
    } on DioException catch (e) {
      return Option<AppExceptions>.of(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Option<AppExceptions>.of(InternalServerErrorException());
    }
  }

  @override
  Future<Option> sendVerifyOTPForUserRegistration(
      {required String userEmail,
      required String otp,
      required String customerName}) async {
    try {
      final data = {
        "shopName": AppIdentifiers.kShopName,
        "FPsecretkey": AppIdentifiers.kFPSecretKey,
        "customerName": customerName,
        "subject": "Verify your account",
        "useremailid": userEmail,
        "otp": otp
      };
      final response = await APIManager.post(
          api: Endpoints.kVerificationOtpMail, data: data);
      if (response == null) {
        return Option<AppExceptions>.of(InternalServerErrorException());
      }
      return const Option.none();
    } on DioException catch (e) {
      return Option<AppExceptions>.of(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Option<AppExceptions>.of(InternalServerErrorException());
    }
  }
}
