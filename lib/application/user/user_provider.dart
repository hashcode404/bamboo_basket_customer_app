import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:bamboo_basket_customer_app/application/core/base_controller.dart';
import 'package:bamboo_basket_customer_app/core/utils/alert_dialogs.dart';
import 'package:bamboo_basket_customer_app/domain/user/i_user_repo.dart';
import 'package:bamboo_basket_customer_app/domain/user/models/add_new_adress_request_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/user/i_user_shared_prefs.dart';
import '../../domain/user/models/user_address_list_data_model.dart';
import '../../domain/user/models/user_login_response.dart';
import '../../infrastructure/core/failures/app_exceptions.dart';

@LazySingleton()
class UserProvider extends ChangeNotifier with BaseController {
  final IUserRepo userRepo;
  final IUserSharedPrefsRepo sharedPrefsRepository;

  UserProvider({
    required this.userRepo,
    required this.sharedPrefsRepository,
  });

  UserLoginResponse? _userData;

  UserLoginResponse? get userData => _userData;

  String get userFullName {
    final firstName = userData?.user.userFirstName;
    final lastName = userData?.user.userLastName;
    return "${(firstName != null && firstName.isNotEmpty) ? firstName : "Aj"} ${(lastName != null && lastName.isNotEmpty) ? lastName : "User"}";
  }

  GlobalKey<FormState> newAddressFormKey = GlobalKey<FormState>();

  UserAddressListDataModel? _userAddressList;

  List<UserAddressDataModel> get userAddressList =>
      _userAddressList?.data?.list ?? [];

  String? _updateRequiredAddressId;

  String? get updateRequiredAddressId => _updateRequiredAddressId;

  bool _isAddingOrUpdatingUserAddress = false;

  bool get isAddingOrUpdatingUserAddress => _isAddingOrUpdatingUserAddress;

  bool _isUserAddressListLoading = false;

  bool get isUserAddressListLoading => _isUserAddressListLoading;

  bool _isDeletingUserAddress = false;

  bool get isDeletingUserAddress => _isDeletingUserAddress;

  UserAddressDataModel? _selectedAddress;

  UserAddressDataModel? get selectedAddress => _selectedAddress;

  UserAddressListDataModel? _searchAddressListItem;

  List<UserAddressDataModel> get searchAddressListItem =>
      _searchAddressListItem?.data?.list ?? [];

  late TextEditingController addressTitleTxtController;
  late TextEditingController firstNameTxtController;
  late TextEditingController lastNameTxtController;
  late TextEditingController line1TxtController;
  late TextEditingController line2TxtController;
  late TextEditingController townTxtController;
  late TextEditingController postCodeTxtController;
  late TextEditingController countyTxtController;
  late TextEditingController landMarkTxtController;
  late TextEditingController searchAddressTxtController;

  @override
  Future<void> init() {
    getUserData();
    getAddressList();
    return super.init();
  }

  Future<void> getUserData() async {
    _userData = await sharedPrefsRepository.getUserData();
    notifyListeners();
  }

  void initAllTextEditingController() {
    addressTitleTxtController = TextEditingController();
    firstNameTxtController = TextEditingController();
    lastNameTxtController = TextEditingController();
    line1TxtController = TextEditingController();
    line2TxtController = TextEditingController();
    townTxtController = TextEditingController();
    postCodeTxtController = TextEditingController();
    countyTxtController = TextEditingController();
    landMarkTxtController = TextEditingController();
    searchAddressTxtController = TextEditingController();
  }

  void loadDataForAddressUpdate(UserAddressDataModel? address) {
    if (address != null) {
      addressTitleTxtController.text = address.addressTitle ?? '';
      firstNameTxtController.text = address.firstName ?? '';
      lastNameTxtController.text = address.lastName ?? '';
      line1TxtController.text = address.line1 ?? '';
      line2TxtController.text = address.line2 ?? '';
      townTxtController.text = address.town ?? '';
      postCodeTxtController.text = address.postcode ?? '';
      countyTxtController.text = address.county ?? '';
      landMarkTxtController.text = address.landmark ?? '';
      searchAddressTxtController.text = address.postcode ?? '';
    }
  }

  void clearAddressForm({bool delay = true}) async {
    if (delay) {
      await Future.delayed(const Duration(milliseconds: 600));
    }
    addressTitleTxtController.clear();
    firstNameTxtController.clear();
    lastNameTxtController.clear();
    line1TxtController.clear();
    line2TxtController.clear();
    townTxtController.clear();
    postCodeTxtController.clear();
    countyTxtController.clear();
    landMarkTxtController.clear();
    searchAddressTxtController.clear();
  }

  Future<void> getAddressList() async {
    try {
      _isUserAddressListLoading = true;
      notifyListeners();
      final response = await userRepo.getUserAddressList();
      response.fold((error) {
        AlertDialogs.showError(error.message);
      }, (result) {
        _userAddressList = result;
      });
    } finally {
      _isUserAddressListLoading = false;
      notifyListeners();
    }
  }

  //search
  Future<void> searchAddressByPostCode(String query) async {
    if (query.isEmpty) {
      _searchAddressListItem = null;
      notifyListeners();
      return;
    }

    if (_userAddressList?.data?.list != null) {
      final filteredList = _userAddressList!.data!.list!
          .where((address) =>
              address.postcode!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      _searchAddressListItem = UserAddressListDataModel(
        data: UserAddressListSubDataModel(
          list: filteredList,
        ),
      );
    } else {
      _searchAddressListItem = null;
    }

    notifyListeners();
  }

  Future<bool> addOrUpdateUserAddress(String? updateRequiredAddressId) async {
    try {
      _isAddingOrUpdatingUserAddress = true;
      notifyListeners();
      final data = AddNewUserAddressRequestModel(
        addressTitle: addressTitleTxtController.text,
        firstName: firstNameTxtController.text,
        lastName: lastNameTxtController.text,
        line1: line1TxtController.text,
        line2: line2TxtController.text,
        town: townTxtController.text,
        county: countyTxtController.text,
        postcode: postCodeTxtController.text,
        landmark: landMarkTxtController.text,
      );

      Either<AppExceptions, String> response;

      if (updateRequiredAddressId != null) {
        response = await userRepo.updateAddress(
            data: data, addressID: updateRequiredAddressId);
      } else {
        response = await userRepo.addNewAddress(data: data);
      }

      return response.fold((error) {
        AlertDialogs.showError(error.message);
        return false;
      }, (message) {
        AlertDialogs.showSuccess(message);
        return true;
      });
    } finally {
      _isAddingOrUpdatingUserAddress = false;
      notifyListeners();
      await getAddressList();
    }
  }

  Future<bool> deleteUserAddress(String addressID) async {
    try {
      _isAddingOrUpdatingUserAddress = true;
      _isDeletingUserAddress = true;

      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 300));
      final response = await userRepo.deleteUserAddress(addressID: addressID);
      notifyListeners();
      return response.fold(() {
        return true;
      }, (error) {
        AlertDialogs.showError(error.message);
        return false;
      });
      // await Future.delayed(Duration(seconds: 5));
      // return true;
    } finally {
      _isAddingOrUpdatingUserAddress = false;
      _isDeletingUserAddress = false;
      notifyListeners();
    }
  }

  // void dispose() {
  //   disposeAllTextEditingControllers();
  //   super.dispose();
  // }
}
