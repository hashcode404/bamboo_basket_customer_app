import 'package:fpdart/fpdart.dart';

import '../../infrastructure/core/failures/app_exceptions.dart';
import 'models/promotions_model.dart';

abstract class IPromotionRepo {
  Future<Either<AppExceptions, List<PromotionsModel>>> getPromotions();
}
