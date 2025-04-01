import 'package:bamboo_basket_customer_app/domain/user/models/user_login_response.dart';

abstract class IUserSharedPrefsRepo {
  Future<bool> saveUserData(UserLoginResponse userData);

  Future<bool> deleteUserData();

  Future<UserLoginResponse?> getUserData();
}
