import 'dart:developer';

import 'package:bamboo_basket_customer_app/application/core/api_response.dart';
import 'package:bamboo_basket_customer_app/application/core/base_controller.dart';
import 'package:bamboo_basket_customer_app/domain/promotion/models/promotions_model.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/promotion/i_promotion_repo.dart';

@Injectable()
class PromotionsProvider extends ChangeNotifier with BaseController {
  final IPromotionRepo _promotionRepo;
  PromotionsProvider(this._promotionRepo);

  APIResponse<List<PromotionsModel>> _promotionsList = APIResponse.initial();
  APIResponse<List<PromotionsModel>> get promotionsList => _promotionsList;

  List<String> get listOfPromotionImages =>
      _promotionsList.data
          ?.map((element) => element.file != null ? element.file! : '')
          .toList() ??
      [];
  // List<String> get listOfPromotionImagesBanner =>
  //     _promotionsList.data
  //         ?.where((element) =>
  //             element.mPosition == "banner" && element.file != null)
  //         .map((element) => element.file!)
  //         .toList() ??
  //     [];

  List<String> get listOfPromotionImagesBanner =>
      _promotionsList.data
          ?.where((value) =>
              value.mPosition == "banner" &&
              value.mobile == true &&
              value.file != null)
          .map((element) => element.file!)
          .toList() ??
      [];
  List<String> get listOfPromotionImagesSlider =>
      _promotionsList.data
          ?.where((element) =>
              element.mPosition == "slider" &&
              element.mobile == true &&
              element.file != null)
          .map((element) => element.file!)
          .toList() ??
      [];
  List<String> get listOfPromotionImagesPoster =>
      _promotionsList.data
          ?.where((element) =>
              element.mPosition == "poster" && element.file != null)
          .map((element) => element.file!)
          .toList() ??
      [];

  bool _showDialogue = true;

  bool get showDialogue => _showDialogue;

  @override
  Future<void> init() {
    fetchPromotions();
    showPosterDialogue();
    notifyListeners();
    return super.init();
  }

  Future<void> fetchPromotions() async {
    _promotionsList = APIResponse.loading();
    notifyListeners();

    final result = await _promotionRepo.getPromotions();

    result.fold((error) {
      APIResponse.error(error.message);
      log(result.toString());
      notifyListeners();
    }, (data) {
      _promotionsList = APIResponse.completed(data);
      notifyListeners();
    });
  }

  void showPosterDialogue() {
    if (_showDialogue) {
      _showDialogue = false;
      notifyListeners();
    }
  }
}
