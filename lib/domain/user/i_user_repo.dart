import 'package:aj_customer/domain/user/models/user_login_request.dart';
import 'package:aj_customer/domain/user/models/user_login_response.dart';
import 'package:aj_customer/domain/user/models/user_register_response.dart';
import 'package:aj_customer/infrastructure/core/failures/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';

import 'models/add_new_adress_request_model.dart';
import 'models/order_history_raw_data_model.dart';
import 'models/user_address_list_data_model.dart';
import 'models/user_register_request.dart';

abstract class IUserRepo {
  Future<Either<AppExceptions, UserLoginResponse>> loginUser(UserLoginRequest payload);

  Future<Either<AppExceptions, UserLoginResponse>> loginUserSecret(String userId);

  Future<Either<AppExceptions, UserRegisterResponse>> registerUser(UserRegisterRequest payload);

  Future<Option> requestPasswordResetOTP(String userEmail);

  Future<Option> validateAndResetPassword({
    required String userEmail,
    required String otp,
    required String password,
  });

  Future<Option> sendVerifyOTPForUserRegistration({
    required String userEmail,
    required String otp,
    required String customerName,
  });

  Future<Either<AppExceptions, UserAddressListDataModel>> getUserAddressList();

  Future<Either<AppExceptions, String>> addNewAddress({required AddNewUserAddressRequestModel data});

  Future<Either<AppExceptions, String>> updateAddress({
    required AddNewUserAddressRequestModel data,
    required String addressID,
  });

  Future<Option> deleteUserAddress({required String addressID});

  Future<Either<AppExceptions, String>> setDefaultUserAddress({required String addressID});

  Future<Either<AppExceptions, OrderHistoryDataModel>> getOrderHistory();
}
