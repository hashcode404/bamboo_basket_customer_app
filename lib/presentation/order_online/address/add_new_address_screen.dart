import 'dart:developer';

import 'package:bamboo_basket_customer_app/presentation/widgets/custom_back_button.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:bamboo_basket_customer_app/application/user/user_provider.dart';
import 'package:bamboo_basket_customer_app/core/theme/app_colors.dart';
import 'package:bamboo_basket_customer_app/core/theme/custom_text_styles.dart';
import 'package:bamboo_basket_customer_app/domain/user/models/user_address_list_data_model.dart';
import 'package:bamboo_basket_customer_app/presentation/widgets/button_progress.dart';
import 'package:bamboo_basket_customer_app/presentation/widgets/get_provider_view.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/ui_utils.dart';
import '../../../core/utils/utils.dart';

@RoutePage()
class AddNewAddressScreen extends GetProviderView<UserProvider> {
  final UserAddressDataModel? address;
  final bool isFromProfieView;
  const AddNewAddressScreen(this.address,
      {super.key, this.isFromProfieView = false});

  @override
  Widget build(BuildContext context) {
    final userProvider = notifier(context);
    final userListener = listener(context);

    return Form(
      key: userProvider.newAddressFormKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            address != null ? "Edit Address" : "Add Address",
            style: context.customTextTheme.text24W600,
          ),
          leading: InkWell(
            onTap: () {
              userListener.searchAddressTxtController.clear();
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.kGray2),
                  color: AppColors.kWhite,
                  shape: BoxShape.circle),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
              ),
            ),
          ),
          leadingWidth: 60,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0).copyWith(bottom: 110),
            child: SingleChildScrollView(
              child: _buildAddressForm(context, userProvider, address),
            ),
          ),
        ),
        bottomSheet: MediaQuery.of(context).viewInsets.bottom == 0.0
            ? buildConfirmButton(context, userProvider)
            : null,
      ),
    );
  }

  Widget _buildAddressForm(BuildContext context, UserProvider userProvider,
      UserAddressDataModel? address) {
    // if (address != null) {
    //   userProvider.addressTitleTxtController.text = address.addressTitle ?? '';
    //   userProvider.firstNameTxtController.text = address.firstName ?? '';
    //   userProvider.lastNameTxtController.text = address.lastName ?? '';
    //   userProvider.line1TxtController.text = address.line1 ?? '';
    //   userProvider.line2TxtController.text = address.line2 ?? '';
    //   userProvider.townTxtController.text = address.town ?? '';
    //   userProvider.postCodeTxtController.text = address.postcode ?? '';
    //   userProvider.countyTxtController.text = address.county ?? '';
    //   userProvider.landMarkTxtController.text = address.landmark ?? '';
    // }
    return Column(
      children: [
        verticalSpaceSmall,
        buildTextField(
          context: context,
          title: 'Address Title *',
          hintText: 'Address title',
          controller: userProvider.addressTitleTxtController,
          validator: (value) => Utils.commonValidator(value, '*required'),
        ),
        verticalSpaceSmall,
        buildTextField(
          context: context,
          title: 'First Name *',
          hintText: 'First name',
          controller: userProvider.firstNameTxtController,
          validator: (value) => Utils.commonValidator(value, '*required'),
        ),
        verticalSpaceSmall,
        buildTextField(
          context: context,
          title: 'Last Name',
          optional: 'Optional',
          hintText: 'Last name',
          controller: userProvider.lastNameTxtController,
        ),
        verticalSpaceSmall,
        buildTextField(
          context: context,
          title: 'Line 1 *',
          hintText: 'Line 1',
          controller: userProvider.line1TxtController,
          validator: (value) => Utils.commonValidator(value, '*required'),
        ),
        verticalSpaceSmall,
        buildTextField(
          context: context,
          title: 'Line 2',
          optional: 'Optional',
          hintText: 'Line 2',
          controller: userProvider.line2TxtController,
        ),
        verticalSpaceSmall,
        buildTextField(
          context: context,
          title: 'Town *',
          hintText: 'Town',
          controller: userProvider.townTxtController,
          validator: (value) => Utils.commonValidator(value, '*required'),
        ),
        verticalSpaceSmall,
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: buildTextField(
                  context: context,
                  title: 'Postcode *',
                  hintText: 'Postcode',
                  controller: userProvider.postCodeTxtController,
                  validator: (value) =>
                      Utils.commonValidator(value, '*required'),
                ),
              ),
            ),
            verticalSpaceMedium,
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: buildTextField(
                  context: context,
                  title: 'County',
                  optional: 'Optional',
                  hintText: 'County',
                  controller: userProvider.countyTxtController,
                  // validator: (value) =>
                  //     Utils.commonValidator(value, '*required'),
                ),
              ),
            ),
          ],
        ),
        verticalSpaceSmall,
        buildTextField(
          context: context,
          title: 'Landmark',
          optional: 'Optional',
          hintText: 'Landmark',
          controller: userProvider.landMarkTxtController,
          // validator: (value) =>
          //     Utils.commonValidator(value, '*required'),
        ),
        verticalSpaceRegular,
      ],
    );
  }

  Widget buildConfirmButton(
    BuildContext context,
    UserProvider userProvider,
  ) {
    final userLitsner = context.watch<UserProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: SizedBox(
        width: context.screenWidth,
        height: 50,
        child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.kPrimaryColor)),
          onPressed: () async {
            if (userProvider.newAddressFormKey.currentState?.validate() ??
                false) {
              await userLitsner
                  .addOrUpdateUserAddress(address?.uaID)
                  .then((done) {
                if (done) {
                  userProvider.getAddressList();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);

                  userProvider.clearAddressForm();
                }
              });
            }
          },
          child: userLitsner.isAddingOrUpdatingUserAddress
              ? showButtonProgress()
              : Text(
                  address != null ? 'Update' : 'Confirm',
                  style: context.customTextTheme.text20W400.copyWith(
                    fontSize: 20,
                    color: AppColors.kWhite,
                  ),
                ),
        ),
      ),
    );
  }

  // Widget buildConfirmButton(
  //   BuildContext context,
  //   UserProvider userProvider,
  // ) {
  //   final userLitsner = context.watch<UserProvider>();
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
  //     child: SizedBox(
  //       width: context.screenWidth,
  //       height: 50,
  //       child: ElevatedButton(
  //         style: const ButtonStyle(
  //             backgroundColor: WidgetStatePropertyAll(AppColors.kPrimaryColor)),
  //         onPressed: () async {
  //           if (userProvider.newAddressFormKey.currentState?.validate() ??
  //               false) {
  //             await userLitsner
  //                 .addOrUpdateUserAddress(address?.uaID)
  //                 .then((done) {
  //               if (done) {
  //                 // userProvider.getAddressList();
  //                 // ignore: use_build_context_synchronously
  //                 Navigator.pop(context);
  //                 if (!isFromProfieView) {
  //                   Navigator.pop(context);
  //                 }

  //                 userProvider.clearAddressForm();
  //               }
  //             });
  //           }
  //         },
  //         child: userLitsner.isAddingOrUpdatingUserAddress
  //             ? showButtonProgress()
  //             : Text(
  //                 address != null ? 'Update' : 'Confirm',
  //                 style: context.customTextTheme.text20W400.copyWith(
  //                   fontSize: 20,
  //                   color: AppColors.kWhite,
  //                 ),
  //               ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildTextField({
    required String hintText,
    required String title,
    String? optional,
    String? Function(String?)? validator,
    TextEditingController? controller,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Text(
                title,
                style: context.customTextTheme.text16W700,
              ),
              horizontalSpaceSmall,
              Text(
                optional ?? '',
                style: context.customTextTheme.text12W400
                    .copyWith(color: AppColors.kGray),
              ),
            ],
          ),
        ),
        verticalSpaceSmall,
        Container(
          decoration: BoxDecoration(
              color: AppColors.kOffWhite,
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: controller,
            onChanged: (value) {},
            decoration: InputDecoration(
              label: Text(hintText),
              labelStyle: context.customTextTheme.text14W500
                  .copyWith(color: AppColors.kGray),
              hintText: hintText,
              hintStyle: context.customTextTheme.text14W700
                  .copyWith(color: AppColors.kGray),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
