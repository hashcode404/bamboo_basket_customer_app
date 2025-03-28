import 'dart:developer';

import 'package:aj_customer/core/utils/alert_dialogs.dart';
import 'package:aj_customer/domain/store/models/store_delivery_slot_model.dart';
import 'package:flutter/material.dart';
import 'package:aj_customer/application/core/api_response.dart';
import 'package:aj_customer/application/core/base_controller.dart';
import 'package:aj_customer/domain/store/i_store_repo.dart';
import 'package:aj_customer/domain/store/models/store_timing_data_model.dart';

import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@LazySingleton()
class ShopProvider extends ChangeNotifier with BaseController {
  final IStoreRepo _storeRepo;

  ShopProvider(this._storeRepo);

  APIResponse<StoreTimingDataModel> _shopTiming = APIResponse.initial();

  APIResponse<StoreTimingDataModel> get shopTiming => _shopTiming;

  APIResponse<StoreDeliverySlotModel> _deliverySlots = APIResponse.initial();

  APIResponse<StoreDeliverySlotModel> get deliverySlots => _deliverySlots;

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  String get formattedSelectedDate => selectedDate != null
      ? DateFormat('yyyy MMM dd').format(selectedDate!)
      : "";

  String get formattedSelectedDateForPayload => selectedDate != null
      ? DateFormat('yyyy-MM-dd').format(selectedDate!)
      : "";

  StoreDeliverySlotDataModelResponse? _selectedDeliverySlot;
  StoreDeliverySlotDataModelResponse? get selectedDeliverySlot =>
      _selectedDeliverySlot;

  bool isLoading = false;
  String? errorMessage;

  List<StoreDeliverySlotDataModelResponse>? get slotForSelectedDate {
    final slots = _deliverySlots.data?.deliverySlots;
    if (slots == null) return null;
    switch (_selectedDate?.weekday) {
      case 1:
        return slots.monday;
      case 2:
        return slots.tuesday;
      case 3:
        return slots.wednesday;
      case 4:
        return slots.thursday;
      case 5:
        return slots.friday;
      case 6:
        return slots.saturday;
      case 7:
        return slots.sunday;
      default:
        return null;
    }
  }

  bool get isSlotsEmpty =>
      slotForSelectedDate?.isEmpty == true || slotForSelectedDate == null
          ? true
          : false;

  @override
  Future<void> init() {
    fetchShopTimingDetails();
    return super.init();
  }

  Future<void> fetchShopTimingDetails() async {
    _shopTiming = APIResponse.loading();
    notifyListeners();

    final result = await _storeRepo.getShopTimingDetails();

    log(result.toString(), name: "ShopTiming");

    result.fold(
      (error) {
        _shopTiming = APIResponse.error(error.message);
        notifyListeners();
      },
      (data) {
        _shopTiming = APIResponse.completed(data);
        notifyListeners();
      },
    );
  }

  Future<void> fetchShopDeliverySlots() async {
    _deliverySlots = APIResponse.loading();
    notifyListeners();

    final result = await _storeRepo.getStoreDeliverySlots();

    result.fold(
      (error) {
        _deliverySlots = APIResponse.error(error.message);
        notifyListeners();
      },
      (data) {
        _deliverySlots = APIResponse.completed(data);
        notifyListeners();
      },
    );
  }

  //clear the slots
  void clearSelectedDeliverySlot() {
    _selectedDate = null;
    _selectedDeliverySlot = null;
    notifyListeners();
  }

 

  void onChangeSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void onChangeOnSelectedDeliverySlot(
      StoreDeliverySlotDataModelResponse? slot) {
    _selectedDeliverySlot = slot;
    notifyListeners();
  }

  bool validateInputData() {
    if (selectedDate == null) {
      AlertDialogs.showInfo("Please Select A Delivery Date & Time");
      return false;
    }
    if (selectedDeliverySlot == null) {
      AlertDialogs.showInfo("Please Select A Delivery Date & Time");
      return false;
    }
    return true;
  }
}
