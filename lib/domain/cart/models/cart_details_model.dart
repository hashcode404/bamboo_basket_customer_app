// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'add_product_cart_request_model.dart';

class CartDetailsModel {
  final String? restaurantID;
  final String? restaurantName;
  final List<CartItemDataModel> cartItems;
  final CartItemTotalSummary? cartTotal;
  final CartItemPaymentDetails? paymentOptions;

  CartDetailsModel({
    this.restaurantID,
    this.restaurantName,
    this.cartItems = const [],
    this.cartTotal,
    this.paymentOptions,
  });

  CartDetailsModel copyWith({
    String? restaurantID,
    String? restaurantName,
    List<CartItemDataModel>? cartItems,
    CartItemTotalSummary? cartTotal,
    CartItemPaymentDetails? paymentOptions,
  }) {
    return CartDetailsModel(
      restaurantID: restaurantID ?? this.restaurantID,
      restaurantName: restaurantName ?? this.restaurantName,
      cartItems: cartItems ?? this.cartItems,
      cartTotal: cartTotal ?? this.cartTotal,
      paymentOptions: paymentOptions ?? this.paymentOptions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'restaurantID': restaurantID,
      'restaurantName': restaurantName,
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
      'cartTotal': cartTotal?.toMap(),
      'paymentOptions': paymentOptions?.toMap(),
    };
  }

  factory CartDetailsModel.fromMap(Map<String, dynamic> map) {
    return CartDetailsModel(
      restaurantID:
          map['restaurantID'] != null ? map['restaurantID'] as String : null,
      restaurantName: map['restaurantName'] != null
          ? map['restaurantName'] as String
          : null,
      cartItems: List<CartItemDataModel>.from(
        (map['cartItems'] ?? []).map<CartItemDataModel?>(
          (x) => CartItemDataModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      cartTotal: map['cartTotal'] != null
          ? CartItemTotalSummary.fromMap(
              map['cartTotal'] as Map<String, dynamic>)
          : null,
      paymentOptions: map['paymentOptions'] != null
          ? CartItemPaymentDetails.fromMap(
              map['paymentOptions'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartDetailsModel.fromJson(String source) =>
      CartDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartSummarySubDataModel(restaurantID: $restaurantID, restaurantName: $restaurantName, cartItems: $cartItems, cartTotal: $cartTotal, paymentOptions: $paymentOptions)';
  }

  @override
  bool operator ==(covariant CartDetailsModel other) {
    if (identical(this, other)) return true;

    return other.restaurantID == restaurantID &&
        other.restaurantName == restaurantName &&
        listEquals(other.cartItems, cartItems) &&
        other.cartTotal == cartTotal &&
        other.paymentOptions == paymentOptions;
  }

  @override
  int get hashCode {
    return restaurantID.hashCode ^
        restaurantName.hashCode ^
        cartItems.hashCode ^
        cartTotal.hashCode ^
        paymentOptions.hashCode;
  }
}

class CartItemDataModel {
  final String? pID;
  final String? productName;
  final String? quantity;
  final String? cartID;
  final String? product_price;
  final String? product_total_price;
  final int? total;
  final String? display_total;
  final String? variation;
  final List<AppliedAddonsDetails> addon_apllied;
  final List<AppliedAddonsDetails> master_addon_apllied;
  final CartCOptionsDataModel? cOption;

  CartItemDataModel({
    this.pID,
    this.productName,
    this.quantity,
    this.cartID,
    this.product_price,
    this.product_total_price,
    this.total,
    this.display_total,
    this.variation,
    this.addon_apllied = const [],
    this.master_addon_apllied = const [],
    this.cOption,
  });

  CartItemDataModel copyWith({
    String? pID,
    String? productName,
    String? quantity,
    String? cartID,
    String? product_price,
    String? product_total_price,
    int? total,
    String? display_total,
    String? variation,
    List<AppliedAddonsDetails>? addon_apllied,
    List<AppliedAddonsDetails>? master_addon_apllied,
    CartCOptionsDataModel? cOption,
  }) {
    return CartItemDataModel(
      pID: pID ?? this.pID,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      cartID: cartID ?? this.cartID,
      product_price: product_price ?? this.product_price,
      product_total_price: product_total_price ?? this.product_total_price,
      total: total ?? this.total,
      display_total: display_total ?? this.display_total,
      variation: variation ?? this.variation,
      addon_apllied: addon_apllied ?? this.addon_apllied,
      master_addon_apllied: master_addon_apllied ?? this.master_addon_apllied,
      cOption: cOption ?? this.cOption,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pID': pID,
      'productName': productName,
      'quantity': quantity,
      'cartID': cartID,
      'product_price': product_price,
      'product_total_price': product_total_price,
      'total': total,
      'display_total': display_total,
      'variation': variation,
      'addon_apllied': addon_apllied.map((x) => x.toMap()).toList(),
      'master_addon_apllied':
          master_addon_apllied.map((x) => x.toMap()).toList(),
      'cOption': cOption?.toMap(),
    };
  }

  factory CartItemDataModel.fromMap(Map<String, dynamic> map) {
    return CartItemDataModel(
      pID: map['pID'] != null ? map['pID'] as String : null,
      productName:
          map['productName'] != null ? map['productName'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as String : null,
      cartID: map['cartID'] != null ? map['cartID'] as String : null,
      product_price:
          map['product_price'] != null ? map['product_price'] as String : null,
      product_total_price: map['product_total_price'] != null
          ? map['product_total_price'] as String
          : null,
      total: map['total'] != null ? map['total'] as int : null,
      display_total:
          map['display_total'] != null ? map['display_total'] as String : null,
      variation: map['variation'] != null ? map['variation'] as String : null,
      addon_apllied: List<AppliedAddonsDetails>.from(
        (map['addon_apllied'] ?? []).map<AppliedAddonsDetails>(
          (x) => AppliedAddonsDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      master_addon_apllied: List<AppliedAddonsDetails>.from(
        (map['master_addon_apllied'] ?? []).map<AppliedAddonsDetails>(
          (x) => AppliedAddonsDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      cOption: map['cOption'] != null
          ? CartCOptionsDataModel.fromMap(
              map['cOption'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemDataModel.fromJson(String source) =>
      CartItemDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  double get getModifiersTotal {
    final total = addon_apllied.isNotEmpty
        ? addon_apllied
            .expand((e) => e.choosedOption.map(
                (e) => double.parse((e.price ?? "0.00").replaceAll("£", ""))))
            .reduce((a, b) => a + b)
        : 0.0;

    final totalMasterAddons = master_addon_apllied.isNotEmpty
        ? master_addon_apllied
            .expand((e) => e.choosedOption.map(
                (e) => double.parse((e.price ?? "0.00").replaceAll("£", ""))))
            .reduce((a, b) => a + b)
        : 0.0;

    return total + totalMasterAddons;
  }

  @override
  String toString() {
    return 'CartItemDataModel(pID: $pID, productName: $productName, quantity: $quantity, cartID: $cartID, product_price: $product_price, product_total_price: $product_total_price, total: $total, display_total: $display_total, variation: $variation, addon_apllied: $addon_apllied, master_addon_apllied: $master_addon_apllied, cOption: $cOption)';
  }

  @override
  bool operator ==(covariant CartItemDataModel other) {
    if (identical(this, other)) return true;

    return other.pID == pID &&
        other.productName == productName &&
        other.quantity == quantity &&
        other.cartID == cartID &&
        other.product_price == product_price &&
        other.product_total_price == product_total_price &&
        other.total == total &&
        other.display_total == display_total &&
        other.variation == variation &&
        listEquals(other.addon_apllied, addon_apllied) &&
        listEquals(other.master_addon_apllied, master_addon_apllied) &&
        other.cOption == cOption;
  }

  @override
  int get hashCode {
    return pID.hashCode ^
        productName.hashCode ^
        quantity.hashCode ^
        cartID.hashCode ^
        product_price.hashCode ^
        product_total_price.hashCode ^
        total.hashCode ^
        display_total.hashCode ^
        variation.hashCode ^
        addon_apllied.hashCode ^
        master_addon_apllied.hashCode ^
        cOption.hashCode;
  }
}

class AppliedAddonsDetails {
  final String? title;
  final List<ChoosedModifierOption> choosedOption;

  AppliedAddonsDetails({
    this.title,
    this.choosedOption = const [],
  });

  AppliedAddonsDetails copyWith({
    String? title,
    List<ChoosedModifierOption>? choosedOption,
  }) {
    return AppliedAddonsDetails(
      title: title ?? this.title,
      choosedOption: choosedOption ?? this.choosedOption,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'choosedOption': choosedOption.map((x) => x.toMap()).toList(),
    };
  }

  factory AppliedAddonsDetails.fromMap(Map<String, dynamic> map) {
    return AppliedAddonsDetails(
      title: map['title'] != null ? map['title'] as String : null,
      choosedOption: List<ChoosedModifierOption>.from(
        (map['choosedOption'] ?? []).map<ChoosedModifierOption?>(
          (x) => ChoosedModifierOption.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppliedAddonsDetails.fromJson(String source) =>
      AppliedAddonsDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AppliedAddonsDetails(title: $title, choosedOption: $choosedOption)';

  @override
  bool operator ==(covariant AppliedAddonsDetails other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        listEquals(other.choosedOption, choosedOption);
  }

  @override
  int get hashCode => title.hashCode ^ choosedOption.hashCode;
}

class ChoosedModifierOption {
  final String? text;
  final String? price;

  ChoosedModifierOption({
    this.text,
    this.price,
  });

  ChoosedModifierOption copyWith({
    String? text,
    String? price,
  }) {
    return ChoosedModifierOption(
      text: text ?? this.text,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'price': price,
    };
  }

  factory ChoosedModifierOption.fromMap(Map<String, dynamic> map) {
    return ChoosedModifierOption(
      text: map['text'] != null ? map['text'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChoosedModifierOption.fromJson(String source) =>
      ChoosedModifierOption.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChoosedModifierOption(text: $text, price: $price)';

  @override
  bool operator ==(covariant ChoosedModifierOption other) {
    if (identical(this, other)) return true;

    return other.text == text && other.price == price;
  }

  @override
  int get hashCode => text.hashCode ^ price.hashCode;
}

class CartItemTotalSummary {
  final int? cartTotalPrice;
  final String? cartTotalPriceDisplay;

  CartItemTotalSummary({
    this.cartTotalPrice,
    this.cartTotalPriceDisplay,
  });

  CartItemTotalSummary copyWith({
    int? cartTotalPrice,
    String? cartTotalPriceDisplay,
  }) {
    return CartItemTotalSummary(
      cartTotalPrice: cartTotalPrice ?? this.cartTotalPrice,
      cartTotalPriceDisplay:
          cartTotalPriceDisplay ?? this.cartTotalPriceDisplay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartTotalPrice': cartTotalPrice,
      'cartTotalPriceDisplay': cartTotalPriceDisplay,
    };
  }

  factory CartItemTotalSummary.fromMap(Map<String, dynamic> map) {
    return CartItemTotalSummary(
      cartTotalPrice:
          map['cartTotalPrice'] != null ? map['cartTotalPrice'] as int : null,
      cartTotalPriceDisplay: map['cartTotalPriceDisplay'] != null
          ? map['cartTotalPriceDisplay'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemTotalSummary.fromJson(String source) =>
      CartItemTotalSummary.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CartItemTotalSummary(cartTotalPrice: $cartTotalPrice, cartTotalPriceDisplay: $cartTotalPriceDisplay)';

  @override
  bool operator ==(covariant CartItemTotalSummary other) {
    if (identical(this, other)) return true;

    return other.cartTotalPrice == cartTotalPrice &&
        other.cartTotalPriceDisplay == cartTotalPriceDisplay;
  }

  @override
  int get hashCode => cartTotalPrice.hashCode ^ cartTotalPriceDisplay.hashCode;
}

class CartItemPaymentDetails {
  final String? cod;
  final String? stripe;
  final String? shopStatus;

  CartItemPaymentDetails({
    this.cod,
    this.stripe,
    this.shopStatus,
  });

  CartItemPaymentDetails copyWith({
    String? cod,
    String? stripe,
    String? shopStatus,
  }) {
    return CartItemPaymentDetails(
      cod: cod ?? this.cod,
      stripe: stripe ?? this.stripe,
      shopStatus: shopStatus ?? this.shopStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cod': cod,
      'stripe': stripe,
      'shopStatus': shopStatus,
    };
  }

  factory CartItemPaymentDetails.fromMap(Map<String, dynamic> map) {
    return CartItemPaymentDetails(
      cod: map['cod'] != null ? map['cod'] as String : null,
      stripe: map['stripe'] != null ? map['stripe'] as String : null,
      shopStatus:
          map['shopStatus'] != null ? map['shopStatus'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemPaymentDetails.fromJson(String source) =>
      CartItemPaymentDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CartItemPaymentDetails(cod: $cod, stripe: $stripe, shopStatus: $shopStatus)';

  @override
  bool operator ==(covariant CartItemPaymentDetails other) {
    if (identical(this, other)) return true;

    return other.cod == cod &&
        other.stripe == stripe &&
        other.shopStatus == shopStatus;
  }

  @override
  int get hashCode => cod.hashCode ^ stripe.hashCode ^ shopStatus.hashCode;
}
