// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bamboo_basket_customer_app/application/auth/auth_provider.dart'
    as _i508;
import 'package:bamboo_basket_customer_app/application/cart/cart_provider.dart'
    as _i46;
import 'package:bamboo_basket_customer_app/application/home/home_provider.dart'
    as _i97;
import 'package:bamboo_basket_customer_app/application/notification/notification_provider.dart'
    as _i458;
import 'package:bamboo_basket_customer_app/application/order/order_provider.dart'
    as _i921;
import 'package:bamboo_basket_customer_app/application/payment/payment_provider.dart'
    as _i1004;
import 'package:bamboo_basket_customer_app/application/products/products_provider.dart'
    as _i942;
import 'package:bamboo_basket_customer_app/application/promotion/promotions_provider.dart'
    as _i656;
import 'package:bamboo_basket_customer_app/application/search/search_provider.dart'
    as _i158;
import 'package:bamboo_basket_customer_app/application/shop/shop_provider.dart'
    as _i766;
import 'package:bamboo_basket_customer_app/application/table/table_provider.dart'
    as _i842;
import 'package:bamboo_basket_customer_app/application/user/user_provider.dart'
    as _i448;
import 'package:bamboo_basket_customer_app/domain/cart/i_cart_repo.dart' as _i7;
import 'package:bamboo_basket_customer_app/domain/checkout/i_checkout_repo.dart'
    as _i234;
import 'package:bamboo_basket_customer_app/domain/offer/i_offer_repo.dart'
    as _i165;
import 'package:bamboo_basket_customer_app/domain/promotion/i_promotion_repo.dart'
    as _i235;
import 'package:bamboo_basket_customer_app/domain/search/i_search_repo.dart'
    as _i570;
import 'package:bamboo_basket_customer_app/domain/store/i_store_repo.dart'
    as _i989;
import 'package:bamboo_basket_customer_app/domain/table/i_table_repo.dart'
    as _i1006;
import 'package:bamboo_basket_customer_app/domain/user/i_user_repo.dart'
    as _i92;
import 'package:bamboo_basket_customer_app/domain/user/i_user_shared_prefs.dart'
    as _i309;
import 'package:bamboo_basket_customer_app/infrastructure/cart/cart_repo.dart'
    as _i544;
import 'package:bamboo_basket_customer_app/infrastructure/checkout/checkout_repo.dart'
    as _i881;
import 'package:bamboo_basket_customer_app/infrastructure/offer/offer_repo.dart'
    as _i714;
import 'package:bamboo_basket_customer_app/infrastructure/promotions/promotions_repo.dart'
    as _i391;
import 'package:bamboo_basket_customer_app/infrastructure/search/search_repo.dart'
    as _i904;
import 'package:bamboo_basket_customer_app/infrastructure/store/store_repo.dart'
    as _i366;
import 'package:bamboo_basket_customer_app/infrastructure/table/table_repo.dart'
    as _i931;
import 'package:bamboo_basket_customer_app/infrastructure/user/user_repo.dart'
    as _i679;
import 'package:bamboo_basket_customer_app/infrastructure/user/user_shared_prefs_repo.dart'
    as _i393;
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
    gh.lazySingleton<_i97.HomeProvider>(() => _i97.HomeProvider());
    gh.lazySingleton<_i458.NotificationProvider>(
        () => _i458.NotificationProvider());
    gh.lazySingleton<_i570.ISearchRepo>(() => _i904.SearchRepo());
    gh.lazySingleton<_i989.IStoreRepo>(() => _i366.StoreRepo());
    gh.lazySingleton<_i234.ICheckoutRepo>(() => _i881.CheckoutRepo());
    gh.lazySingleton<_i1006.ITableRepo>(() => _i931.TableRepo());
    gh.lazySingleton<_i165.IOfferRepo>(() => _i714.OfferRepo());
    gh.lazySingleton<_i235.IPromotionRepo>(() => _i391.PromotionsRepo());
    gh.lazySingleton<_i7.ICartRepo>(() => _i544.CartRepo());
    gh.lazySingleton<_i942.ProductsProvider>(
        () => _i942.ProductsProvider(storeRepo: gh<_i989.IStoreRepo>()));
    gh.factory<_i656.PromotionsProvider>(
        () => _i656.PromotionsProvider(gh<_i235.IPromotionRepo>()));
    gh.lazySingleton<_i309.IUserSharedPrefsRepo>(
        () => _i393.UserSharedPrefsRepo());
    gh.lazySingleton<_i842.TableProvider>(() => _i842.TableProvider(
          tableRepo: gh<_i1006.ITableRepo>(),
          userSharedPrefsRepo: gh<_i309.IUserSharedPrefsRepo>(),
        ));
    gh.lazySingleton<_i46.CartProvider>(() => _i46.CartProvider(
          cartRepo: gh<_i7.ICartRepo>(),
          checkRepo: gh<_i234.ICheckoutRepo>(),
          offerRepo: gh<_i165.IOfferRepo>(),
        ));
    gh.lazySingleton<_i92.IUserRepo>(() => _i679.UserRepo());
    gh.lazySingleton<_i508.AuthProvider>(() => _i508.AuthProvider(
          userRepository: gh<_i92.IUserRepo>(),
          sharedPrefsRepository: gh<_i309.IUserSharedPrefsRepo>(),
        ));
    gh.lazySingleton<_i158.SearchProvider>(
        () => _i158.SearchProvider(searchRepo: gh<_i570.ISearchRepo>()));
    gh.lazySingleton<_i921.OrderProvider>(
        () => _i921.OrderProvider(userRepo: gh<_i92.IUserRepo>()));
    gh.lazySingleton<_i766.ShopProvider>(
        () => _i766.ShopProvider(gh<_i989.IStoreRepo>()));
    gh.lazySingleton<_i1004.PaymentProvider>(
        () => _i1004.PaymentProvider(checkoutRepo: gh<_i234.ICheckoutRepo>()));
    gh.lazySingleton<_i448.UserProvider>(() => _i448.UserProvider(
          userRepo: gh<_i92.IUserRepo>(),
          sharedPrefsRepository: gh<_i309.IUserSharedPrefsRepo>(),
        ));
    return this;
  }
}
