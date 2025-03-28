// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:aj_customer/application/auth/auth_provider.dart' as _i271;
import 'package:aj_customer/application/cart/cart_provider.dart' as _i965;
import 'package:aj_customer/application/home/home_provider.dart' as _i489;
import 'package:aj_customer/application/notification/notification_provider.dart'
    as _i814;
import 'package:aj_customer/application/order/order_provider.dart' as _i862;
import 'package:aj_customer/application/payment/payment_provider.dart' as _i372;
import 'package:aj_customer/application/products/products_provider.dart'
    as _i279;
import 'package:aj_customer/application/promotion/promotions_provider.dart'
    as _i42;
import 'package:aj_customer/application/search/search_provider.dart' as _i1052;
import 'package:aj_customer/application/shop/shop_provider.dart' as _i18;
import 'package:aj_customer/application/table/table_provider.dart' as _i756;
import 'package:aj_customer/application/user/user_provider.dart' as _i1051;
import 'package:aj_customer/domain/cart/i_cart_repo.dart' as _i108;
import 'package:aj_customer/domain/checkout/i_checkout_repo.dart' as _i387;
import 'package:aj_customer/domain/offer/i_offer_repo.dart' as _i492;
import 'package:aj_customer/domain/promotion/i_promotion_repo.dart' as _i542;
import 'package:aj_customer/domain/search/i_search_repo.dart' as _i145;
import 'package:aj_customer/domain/store/i_store_repo.dart' as _i748;
import 'package:aj_customer/domain/table/i_table_repo.dart' as _i509;
import 'package:aj_customer/domain/user/i_user_repo.dart' as _i463;
import 'package:aj_customer/domain/user/i_user_shared_prefs.dart' as _i194;
import 'package:aj_customer/infrastructure/cart/cart_repo.dart' as _i591;
import 'package:aj_customer/infrastructure/checkout/checkout_repo.dart'
    as _i504;
import 'package:aj_customer/infrastructure/offer/offer_repo.dart' as _i326;
import 'package:aj_customer/infrastructure/promotions/promotions_repo.dart'
    as _i553;
import 'package:aj_customer/infrastructure/search/search_repo.dart' as _i350;
import 'package:aj_customer/infrastructure/store/store_repo.dart' as _i460;
import 'package:aj_customer/infrastructure/table/table_repo.dart' as _i841;
import 'package:aj_customer/infrastructure/user/user_repo.dart' as _i1056;
import 'package:aj_customer/infrastructure/user/user_shared_prefs_repo.dart'
    as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i489.HomeProvider>(() => _i489.HomeProvider());
    gh.lazySingleton<_i814.NotificationProvider>(
        () => _i814.NotificationProvider());
    gh.lazySingleton<_i748.IStoreRepo>(() => _i460.StoreRepo());
    gh.lazySingleton<_i542.IPromotionRepo>(() => _i553.PromotionsRepo());
    gh.lazySingleton<_i194.IUserSharedPrefsRepo>(
        () => _i895.UserSharedPrefsRepo());
    gh.lazySingleton<_i463.IUserRepo>(() => _i1056.UserRepo());
    gh.lazySingleton<_i492.IOfferRepo>(() => _i326.OfferRepo());
    gh.lazySingleton<_i271.AuthProvider>(() => _i271.AuthProvider(
          userRepository: gh<_i463.IUserRepo>(),
          sharedPrefsRepository: gh<_i194.IUserSharedPrefsRepo>(),
        ));
    gh.lazySingleton<_i509.ITableRepo>(() => _i841.TableRepo());
    gh.factory<_i42.PromotionsProvider>(
        () => _i42.PromotionsProvider(gh<_i542.IPromotionRepo>()));
    gh.lazySingleton<_i145.ISearchRepo>(() => _i350.SearchRepo());
    gh.lazySingleton<_i387.ICheckoutRepo>(() => _i504.CheckoutRepo());
    gh.lazySingleton<_i108.ICartRepo>(() => _i591.CartRepo());
    gh.lazySingleton<_i372.PaymentProvider>(
        () => _i372.PaymentProvider(checkoutRepo: gh<_i387.ICheckoutRepo>()));
    gh.lazySingleton<_i18.ShopProvider>(
        () => _i18.ShopProvider(gh<_i748.IStoreRepo>()));
    gh.lazySingleton<_i965.CartProvider>(() => _i965.CartProvider(
          cartRepo: gh<_i108.ICartRepo>(),
          checkRepo: gh<_i387.ICheckoutRepo>(),
          offerRepo: gh<_i492.IOfferRepo>(),
        ));
    gh.lazySingleton<_i1052.SearchProvider>(
        () => _i1052.SearchProvider(searchRepo: gh<_i145.ISearchRepo>()));
    gh.lazySingleton<_i279.ProductsProvider>(
        () => _i279.ProductsProvider(storeRepo: gh<_i748.IStoreRepo>()));
    gh.lazySingleton<_i1051.UserProvider>(() => _i1051.UserProvider(
          userRepo: gh<_i463.IUserRepo>(),
          sharedPrefsRepository: gh<_i194.IUserSharedPrefsRepo>(),
        ));
    gh.lazySingleton<_i862.OrderProvider>(
        () => _i862.OrderProvider(userRepo: gh<_i463.IUserRepo>()));
    gh.lazySingleton<_i756.TableProvider>(() => _i756.TableProvider(
          tableRepo: gh<_i509.ITableRepo>(),
          userSharedPrefsRepo: gh<_i194.IUserSharedPrefsRepo>(),
        ));
    return this;
  }
}
