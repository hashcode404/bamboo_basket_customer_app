import 'package:bamboo_basket_customer_app/domain/store/models/product_details_pagination.dart';
import 'package:bamboo_basket_customer_app/domain/store/models/store_settings_data_model.dart';
import 'package:bamboo_basket_customer_app/domain/store/models/store_timing_data_model.dart';
import 'package:bamboo_basket_customer_app/infrastructure/core/failures/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';

import 'models/product_category_model.dart';
import 'models/product_details_model.dart';
import 'models/store_delivery_slot_model.dart';

abstract class IStoreRepo {
  Future<Either<AppExceptions, ProductDetailsModel>> getProducts({
    required String categoryID,
  });

  Future<Either<AppExceptions, ProductCategoryModel>> getCategories();

  Future<Either<AppExceptions, StoreTimingDataModel>> getShopTimingDetails();

  Future<Either<AppExceptions, StoreSettingsDataModel>> getStoreSettings();

  Future<Either<AppExceptions, StoreDeliverySlotModel>> getStoreDeliverySlots();

  Future<Either<AppExceptions, ProductDetailsPagination>>
      getProductsByPagination({
    required String categoryID,
    required String numberOfProducts,
  });
}
