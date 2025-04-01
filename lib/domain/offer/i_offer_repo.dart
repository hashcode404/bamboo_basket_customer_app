import 'package:bamboo_basket_customer_app/domain/offer/models/offer_details_model.dart';
import 'package:bamboo_basket_customer_app/domain/offer/models/validated_coupon_details.dart';
import 'package:bamboo_basket_customer_app/infrastructure/core/failures/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';

abstract class IOfferRepo {
  Future<Either<AppExceptions, List<OfferDetailsModel>>> listAllOffers();
  Future<Either<AppExceptions, ValidatedCouponDetails>> validateCouponCode(
      String coupenId);
}
