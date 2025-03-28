// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:aj_customer/domain/user/models/user_address_list_data_model.dart'
    as _i25;
import 'package:aj_customer/presentation/auth/forgot_otp.dart' as _i6;
import 'package:aj_customer/presentation/auth/forgot_screen.dart' as _i7;
import 'package:aj_customer/presentation/auth/login_screen.dart' as _i9;
import 'package:aj_customer/presentation/auth/otp_screen.dart' as _i13;
import 'package:aj_customer/presentation/auth/register_screen.dart' as _i15;
import 'package:aj_customer/presentation/home/home_screen.dart' as _i8;
import 'package:aj_customer/presentation/order_online/address/add_new_address_screen.dart'
    as _i1;
import 'package:aj_customer/presentation/order_online/address/user_address_screen.dart'
    as _i21;
import 'package:aj_customer/presentation/order_online/cart/cart_screen.dart'
    as _i2;
import 'package:aj_customer/presentation/order_online/cart/success_screen.dart'
    as _i18;
import 'package:aj_customer/presentation/order_online/categories/categories_screen.dart'
    as _i3;
import 'package:aj_customer/presentation/order_online/checkout/checkout_screen.dart'
    as _i4;
import 'package:aj_customer/presentation/order_online/coupen/coupen_screen.dart'
    as _i5;
import 'package:aj_customer/presentation/order_online/home/order_online_home_screen.dart'
    as _i11;
import 'package:aj_customer/presentation/order_online/order_online_screen.dart'
    as _i12;
import 'package:aj_customer/presentation/order_online/orders/order_history_screens.dart'
    as _i10;
import 'package:aj_customer/presentation/order_online/orders/view_order_screen.dart'
    as _i22;
import 'package:aj_customer/presentation/order_online/profile/profile_screen.dart'
    as _i14;
import 'package:aj_customer/presentation/reservation/table_reservation_history.dart'
    as _i19;
import 'package:aj_customer/presentation/reservation/table_reservation_screen.dart'
    as _i20;
import 'package:aj_customer/presentation/splash/splash_screen.dart' as _i16;
import 'package:aj_customer/presentation/store/store_screen.dart' as _i17;
import 'package:aj_customer/presentation/welcome/welcome_screen.dart' as _i23;
import 'package:auto_route/auto_route.dart' as _i24;
import 'package:flutter/cupertino.dart' as _i27;
import 'package:flutter/material.dart' as _i26;

/// generated route for
/// [_i1.AddNewAddressScreen]
class AddNewAddressScreenRoute
    extends _i24.PageRouteInfo<AddNewAddressScreenRouteArgs> {
  AddNewAddressScreenRoute({
    required _i25.UserAddressDataModel? address,
    _i26.Key? key,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          AddNewAddressScreenRoute.name,
          args: AddNewAddressScreenRouteArgs(
            address: address,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNewAddressScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddNewAddressScreenRouteArgs>();
      return _i1.AddNewAddressScreen(
        args.address,
        key: args.key,
      );
    },
  );
}

class AddNewAddressScreenRouteArgs {
  const AddNewAddressScreenRouteArgs({
    required this.address,
    this.key,
  });

  final _i25.UserAddressDataModel? address;

  final _i26.Key? key;

  @override
  String toString() {
    return 'AddNewAddressScreenRouteArgs{address: $address, key: $key}';
  }
}

/// generated route for
/// [_i2.CartScreen]
class CartScreenRoute extends _i24.PageRouteInfo<void> {
  const CartScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          CartScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i2.CartScreen();
    },
  );
}

/// generated route for
/// [_i3.CategoriesScreen]
class CategoriesScreenRoute extends _i24.PageRouteInfo<void> {
  const CategoriesScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          CategoriesScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i3.CategoriesScreen();
    },
  );
}

/// generated route for
/// [_i4.CheckoutScreen]
class CheckoutScreenRoute extends _i24.PageRouteInfo<void> {
  const CheckoutScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          CheckoutScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i4.CheckoutScreen();
    },
  );
}

/// generated route for
/// [_i5.CoupenScreen]
class CoupenScreenRoute extends _i24.PageRouteInfo<void> {
  const CoupenScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          CoupenScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'CoupenScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i5.CoupenScreen();
    },
  );
}

/// generated route for
/// [_i6.ForgotOtpScreen]
class ForgotOtpScreenRoute extends _i24.PageRouteInfo<void> {
  const ForgotOtpScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ForgotOtpScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotOtpScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i6.ForgotOtpScreen();
    },
  );
}

/// generated route for
/// [_i7.ForgotPasswordScreen]
class ForgotPasswordScreenRoute extends _i24.PageRouteInfo<void> {
  const ForgotPasswordScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ForgotPasswordScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i7.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i8.HomeScreen]
class HomeScreenRoute extends _i24.PageRouteInfo<HomeScreenRouteArgs> {
  HomeScreenRoute({
    _i26.Key? key,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          HomeScreenRoute.name,
          args: HomeScreenRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeScreenRouteArgs>(
          orElse: () => const HomeScreenRouteArgs());
      return _i8.HomeScreen(key: args.key);
    },
  );
}

class HomeScreenRouteArgs {
  const HomeScreenRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'HomeScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.LoginScreen]
class LoginScreenRoute extends _i24.PageRouteInfo<LoginScreenRouteArgs> {
  LoginScreenRoute({
    bool isFromProfile = false,
    _i27.Key? key,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          LoginScreenRoute.name,
          args: LoginScreenRouteArgs(
            isFromProfile: isFromProfile,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginScreenRouteArgs>(
          orElse: () => const LoginScreenRouteArgs());
      return _i9.LoginScreen(
        isFromProfile: args.isFromProfile,
        key: args.key,
      );
    },
  );
}

class LoginScreenRouteArgs {
  const LoginScreenRouteArgs({
    this.isFromProfile = false,
    this.key,
  });

  final bool isFromProfile;

  final _i27.Key? key;

  @override
  String toString() {
    return 'LoginScreenRouteArgs{isFromProfile: $isFromProfile, key: $key}';
  }
}

/// generated route for
/// [_i10.OrderHistoryScreen]
class OrderHistoryScreenRoute
    extends _i24.PageRouteInfo<OrderHistoryScreenRouteArgs> {
  OrderHistoryScreenRoute({
    required bool isFromProfileScreen,
    _i26.Key? key,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          OrderHistoryScreenRoute.name,
          args: OrderHistoryScreenRouteArgs(
            isFromProfileScreen: isFromProfileScreen,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderHistoryScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderHistoryScreenRouteArgs>();
      return _i10.OrderHistoryScreen(
        args.isFromProfileScreen,
        key: args.key,
      );
    },
  );
}

class OrderHistoryScreenRouteArgs {
  const OrderHistoryScreenRouteArgs({
    required this.isFromProfileScreen,
    this.key,
  });

  final bool isFromProfileScreen;

  final _i26.Key? key;

  @override
  String toString() {
    return 'OrderHistoryScreenRouteArgs{isFromProfileScreen: $isFromProfileScreen, key: $key}';
  }
}

/// generated route for
/// [_i11.OrderOnlineHomeScreen]
class OrderOnlineHomeScreenRoute extends _i24.PageRouteInfo<void> {
  const OrderOnlineHomeScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          OrderOnlineHomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderOnlineHomeScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i11.OrderOnlineHomeScreen();
    },
  );
}

/// generated route for
/// [_i12.OrderOnlineScreen]
class OrderOnlineScreenRoute extends _i24.PageRouteInfo<void> {
  const OrderOnlineScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          OrderOnlineScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderOnlineScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i12.OrderOnlineScreen();
    },
  );
}

/// generated route for
/// [_i13.OtpScreen]
class OtpScreenRoute extends _i24.PageRouteInfo<void> {
  const OtpScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          OtpScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OtpScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i13.OtpScreen();
    },
  );
}

/// generated route for
/// [_i14.ProfileScreen]
class ProfileScreenRoute extends _i24.PageRouteInfo<ProfileScreenRouteArgs> {
  ProfileScreenRoute({
    required bool isFromHome,
    required _i26.VoidCallback onTap,
    _i26.Key? key,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          ProfileScreenRoute.name,
          args: ProfileScreenRouteArgs(
            isFromHome: isFromHome,
            onTap: onTap,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileScreenRouteArgs>();
      return _i14.ProfileScreen(
        args.isFromHome,
        args.onTap,
        key: args.key,
      );
    },
  );
}

class ProfileScreenRouteArgs {
  const ProfileScreenRouteArgs({
    required this.isFromHome,
    required this.onTap,
    this.key,
  });

  final bool isFromHome;

  final _i26.VoidCallback onTap;

  final _i26.Key? key;

  @override
  String toString() {
    return 'ProfileScreenRouteArgs{isFromHome: $isFromHome, onTap: $onTap, key: $key}';
  }
}

/// generated route for
/// [_i15.RegisterScreen]
class RegisterScreenRoute extends _i24.PageRouteInfo<void> {
  const RegisterScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          RegisterScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i15.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i16.SplashScreen]
class SplashScreenRoute extends _i24.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          SplashScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i16.SplashScreen();
    },
  );
}

/// generated route for
/// [_i17.StoreScreen]
class StoreScreenRoute extends _i24.PageRouteInfo<void> {
  const StoreScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          StoreScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoreScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i17.StoreScreen();
    },
  );
}

/// generated route for
/// [_i18.SuccessScreen]
class SuccessScreenRoute extends _i24.PageRouteInfo<void> {
  const SuccessScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          SuccessScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SuccessScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i18.SuccessScreen();
    },
  );
}

/// generated route for
/// [_i19.TableReservationHistoryScreen]
class TableReservationHistoryScreenRoute extends _i24.PageRouteInfo<void> {
  const TableReservationHistoryScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          TableReservationHistoryScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'TableReservationHistoryScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i19.TableReservationHistoryScreen();
    },
  );
}

/// generated route for
/// [_i20.TableReservationScreen]
class TableReservationScreenRoute extends _i24.PageRouteInfo<void> {
  const TableReservationScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          TableReservationScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'TableReservationScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i20.TableReservationScreen();
    },
  );
}

/// generated route for
/// [_i21.UserAddressScreen]
class UserAddressScreenRoute extends _i24.PageRouteInfo<void> {
  const UserAddressScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          UserAddressScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserAddressScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i21.UserAddressScreen();
    },
  );
}

/// generated route for
/// [_i22.ViewOrderScreen]
class ViewOrderScreenRoute extends _i24.PageRouteInfo<void> {
  const ViewOrderScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ViewOrderScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ViewOrderScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i22.ViewOrderScreen();
    },
  );
}

/// generated route for
/// [_i23.WelcomeScreen]
class WelcomeScreenRoute extends _i24.PageRouteInfo<void> {
  const WelcomeScreenRoute({List<_i24.PageRouteInfo>? children})
      : super(
          WelcomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeScreenRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i23.WelcomeScreen();
    },
  );
}
