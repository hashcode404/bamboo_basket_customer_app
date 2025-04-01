import 'package:bamboo_basket_customer_app/core/constants/app_identifiers.dart';
import 'package:bamboo_basket_customer_app/domain/user/i_user_shared_prefs.dart';
import 'package:bamboo_basket_customer_app/domain/user/models/user_login_response.dart';
import 'package:bamboo_basket_customer_app/domain/user/models/user_register_response.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IUserSharedPrefsRepo)
class UserSharedPrefsRepo implements IUserSharedPrefsRepo {
  static const String kUserPrefsKey =
      "${AppIdentifiers.kBuildIdentifier}/user_data";

  @override
  Future<UserLoginResponse?> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(kUserPrefsKey);
    if (data == null) return null;
    return UserLoginResponse.fromJson(data);
  }

  @override
  Future<bool> saveUserData(UserLoginResponse userData) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(kUserPrefsKey, userData.toJson());
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .remove(kUserPrefsKey)
        .then((_) => true)
        .catchError((_) => false);
  }
}
