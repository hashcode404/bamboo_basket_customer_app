import 'package:bamboo_basket_customer_app/application/user/user_provider.dart';
import 'package:bamboo_basket_customer_app/core/theme/app_colors.dart';
import 'package:bamboo_basket_customer_app/core/theme/custom_text_styles.dart';
import 'package:bamboo_basket_customer_app/core/utils/ui_utils.dart';
import 'package:bamboo_basket_customer_app/presentation/order_online/address/add_new_address_screen.dart';
import 'package:bamboo_basket_customer_app/presentation/widgets/custom_back_button.dart';
import 'package:bamboo_basket_customer_app/presentation/widgets/get_provider_view.dart';
import 'package:auto_route/annotations.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class UserAddressScreen extends GetProviderView<UserProvider> {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userListener = listener(context);
    final userNotifier = notifier(context);
    return Theme(
        data: Theme.of(context).copyWith(
          textTheme: GoogleFonts.quicksandTextTheme(),
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: const CustomBackButton(),
            leadingWidth: 70,
            title: Text(
              "Address",
              style: context.customTextTheme.text20W600,
            ),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.kPrimaryColor,
            onPressed: () {
              userNotifier.initAllTextEditingController();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddNewAddressScreen(null),
                      fullscreenDialog: true));
            },
            child: const Icon(
              FluentIcons.add_24_regular,
              color: Colors.white,
            ),
          ),
          body: userListener.isAddingOrUpdatingUserAddress
              ? const Center(child: CupertinoActivityIndicator())
              : userListener.userAddressList.isEmpty
                  ? const Center(
                      child: Text("No Address Found"),
                    )
                  : Column(
                      children: [
                        Visibility(
                          visible: userListener.isUserAddressListLoading,
                          child: LinearProgressIndicator(
                            color: AppColors.kPrimaryColor,
                            minHeight: 2.0,
                            backgroundColor: AppColors.kBlack2.withOpacity(0.1),
                          ),
                        ),
                        verticalSpaceRegular,
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () => userNotifier.getAddressList(),
                            child: ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15)
                                      .copyWith(bottom: 100),
                              separatorBuilder: (context, index) =>
                                  verticalSpaceRegular,
                              itemCount: userListener.userAddressList.length,
                              itemBuilder: (context, index) {
                                final address = userListener.userAddressList
                                    .elementAt(index);

                                return ListTile(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color:
                                              AppColors.kGray.withOpacity(0.3)),
                                      borderRadius: BorderRadius.circular(10)),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        address.addressTitle ?? '',
                                        style: context
                                            .customTextTheme.text18W600
                                            .copyWith(
                                                color: AppColors.kDarkGray),
                                      ),
                                      Text(
                                        address.userFullname,
                                        style: context
                                            .customTextTheme.text16W600
                                            .copyWith(color: AppColors.kGray),
                                      ),
                                      Text(
                                        address.userFulladdress,
                                        style: context
                                            .customTextTheme.text14W700
                                            .copyWith(color: AppColors.kGray),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            userNotifier
                                                .initAllTextEditingController();
                                            userNotifier
                                                .loadDataForAddressUpdate(
                                                    address);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddNewAddressScreen(
                                                          address,
                                                          isFromProfieView:
                                                              true,
                                                        ),
                                                    fullscreenDialog: true));
                                          },
                                          icon: const Icon(
                                            FluentIcons.edit_24_regular,
                                            size: 20,
                                          )),
                                      IconButton(
                                          onPressed: () async {
                                            if (address.uaID != null) {
                                              await userNotifier
                                                  .deleteUserAddress(
                                                      address.uaID!);
                                              await userNotifier
                                                  .getAddressList();
                                            }
                                          },
                                          icon: const Icon(
                                            FluentIcons.delete_24_regular,
                                            size: 20,
                                          )),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
        ));
  }
}
