import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddCartProductDetails {
  final List<AddCartItemModel> cartItems;
  final AddProductTotalSummary? cartTotal;
  final String? shopId;
  final AddCartPaymentDetails? paymentOptions;
  AddCartProductDetails({
    required this.cartItems,
    this.cartTotal,
    this.shopId,
    this.paymentOptions,
  });

  AddCartProductDetails copyWith({
    List<AddCartItemModel>? cartItems,
    AddProductTotalSummary? cartTotal,
    String? shopId,
    AddCartPaymentDetails? paymentOptions,
  }) {
    return AddCartProductDetails(
      cartItems: cartItems ?? this.cartItems,
      cartTotal: cartTotal ?? this.cartTotal,
      shopId: shopId ?? this.shopId,
      paymentOptions: paymentOptions ?? this.paymentOptions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
      'cartTotal': cartTotal?.toMap(),
      'shopId': shopId,
      'paymentOptions': paymentOptions?.toMap(),
    };
  }

  factory AddCartProductDetails.fromMap(Map<String, dynamic> map) {
    return AddCartProductDetails(
      cartItems: List<AddCartItemModel>.from(
        (map['cartItems'] as List<dynamic>).map<AddCartItemModel>(
          (x) => AddCartItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      cartTotal: map['cartTotal'] != null
          ? AddProductTotalSummary.fromMap(
              map['cartTotal'] as Map<String, dynamic>)
          : null,
      shopId: map['shopId'] != null ? map['shopId'] as String : null,
      paymentOptions: map['paymentOptions'] != null
          ? AddCartPaymentDetails.fromMap(
              map['paymentOptions'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddCartProductDetails.fromJson(String source) =>
      AddCartProductDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartProductDetails(cartItems: $cartItems, cartTotal: $cartTotal, shopId: $shopId, paymentOptions: $paymentOptions)';
  }

  @override
  bool operator ==(covariant AddCartProductDetails other) {
    if (identical(this, other)) return true;

    return listEquals(other.cartItems, cartItems) &&
        other.cartTotal == cartTotal &&
        other.shopId == shopId &&
        other.paymentOptions == paymentOptions;
  }

  @override
  int get hashCode {
    return cartItems.hashCode ^
        cartTotal.hashCode ^
        shopId.hashCode ^
        paymentOptions.hashCode;
  }
}

class AddCartItemModel {
  final String? productName;
  final String? quantity;
  final String? cartID;
  final String? product_price;
  final String? product_total_price;
  final int? total;
  final String? display_total;
  final List<AddProductAppliedAddonsModel>? addon_apllied;
  final List<AddProductAppliedAddonsModel>? master_addon_apllied;
  final String? variation;
  AddCartItemModel({
    this.productName,
    this.quantity,
    this.cartID,
    this.product_price,
    this.product_total_price,
    this.total,
    this.display_total,
    this.addon_apllied,
    this.master_addon_apllied,
    this.variation,
  });

  AddCartItemModel copyWith({
    String? productName,
    String? quantity,
    String? cartID,
    String? product_price,
    String? product_total_price,
    int? total,
    String? display_total,
    List<AddProductAppliedAddonsModel>? addon_apllied,
    List<AddProductAppliedAddonsModel>? master_addon_apllied,
    String? variation,
  }) {
    return AddCartItemModel(
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      cartID: cartID ?? this.cartID,
      product_price: product_price ?? this.product_price,
      product_total_price: product_total_price ?? this.product_total_price,
      total: total ?? this.total,
      display_total: display_total ?? this.display_total,
      addon_apllied: addon_apllied ?? this.addon_apllied,
      master_addon_apllied: master_addon_apllied ?? this.master_addon_apllied,
      variation: variation ?? this.variation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'quantity': quantity,
      'cartID': cartID,
      'product_price': product_price,
      'product_total_price': product_total_price,
      'total': total,
      'display_total': display_total,
      'addon_apllied': addon_apllied?.map((x) => x.toMap()).toList(),
      'master_addon_apllied':
          master_addon_apllied?.map((x) => x.toMap()).toList(),
      'variation': variation,
    };
  }

  factory AddCartItemModel.fromMap(Map<String, dynamic> map) {
    return AddCartItemModel(
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
      addon_apllied: map['addon_apllied'] != null
          ? List<AddProductAppliedAddonsModel>.from(
              (map['addon_apllied'] as List<dynamic>)
                  .map<AddProductAppliedAddonsModel?>(
                (x) => AddProductAppliedAddonsModel.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
      master_addon_apllied: map['master_addon_apllied'] != null
          ? List<AddProductAppliedAddonsModel>.from(
              (map['master_addon_apllied'] as List<dynamic>)
                  .map<AddProductAppliedAddonsModel?>(
                (x) => AddProductAppliedAddonsModel.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
      variation: map['variation'] != null ? map['variation'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddCartItemModel.fromJson(String source) =>
      AddCartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItemModel(productName: $productName, quantity: $quantity, cartID: $cartID, product_price: $product_price, product_total_price: $product_total_price, total: $total, display_total: $display_total, addon_apllied: $addon_apllied, master_addon_apllied: $master_addon_apllied, variation: $variation)';
  }

  @override
  bool operator ==(covariant AddCartItemModel other) {
    if (identical(this, other)) return true;

    return other.productName == productName &&
        other.quantity == quantity &&
        other.cartID == cartID &&
        other.product_price == product_price &&
        other.product_total_price == product_total_price &&
        other.total == total &&
        other.display_total == display_total &&
        listEquals(other.addon_apllied, addon_apllied) &&
        listEquals(other.master_addon_apllied, master_addon_apllied) &&
        other.variation == variation;
  }

  @override
  int get hashCode {
    return productName.hashCode ^
        quantity.hashCode ^
        cartID.hashCode ^
        product_price.hashCode ^
        product_total_price.hashCode ^
        total.hashCode ^
        display_total.hashCode ^
        addon_apllied.hashCode ^
        master_addon_apllied.hashCode ^
        variation.hashCode;
  }
}

class AddProductAppliedAddonsModel {
  final String? title;
  final List<AddProductAppliedAddonOption> choosedOption;
  AddProductAppliedAddonsModel({
    this.title,
    required this.choosedOption,
  });

  AddProductAppliedAddonsModel copyWith({
    String? title,
    List<AddProductAppliedAddonOption>? choosedOption,
  }) {
    return AddProductAppliedAddonsModel(
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

  factory AddProductAppliedAddonsModel.fromMap(Map<String, dynamic> map) {
    return AddProductAppliedAddonsModel(
      title: map['title'] != null ? map['title'] as String : null,
      choosedOption: List<AddProductAppliedAddonOption>.from(
        (map['choosedOption'] as List<dynamic>)
            .map<AddProductAppliedAddonOption>(
          (x) =>
              AddProductAppliedAddonOption.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddProductAppliedAddonsModel.fromJson(String source) =>
      AddProductAppliedAddonsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AppliedAddonsModel(title: $title, choosedOption: $choosedOption)';

  @override
  bool operator ==(covariant AddProductAppliedAddonsModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        listEquals(other.choosedOption, choosedOption);
  }

  @override
  int get hashCode => title.hashCode ^ choosedOption.hashCode;
}

class AddProductAppliedAddonOption {
  final String? text;
  final String? price;
  AddProductAppliedAddonOption({
    this.text,
    this.price,
  });

  AddProductAppliedAddonOption copyWith({
    String? text,
    String? price,
  }) {
    return AddProductAppliedAddonOption(
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

  factory AddProductAppliedAddonOption.fromMap(Map<String, dynamic> map) {
    return AddProductAppliedAddonOption(
      text: map['text'] != null ? map['text'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddProductAppliedAddonOption.fromJson(String source) =>
      AddProductAppliedAddonOption.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AppliedAddonOption(text: $text, price: $price)';

  @override
  bool operator ==(covariant AddProductAppliedAddonOption other) {
    if (identical(this, other)) return true;

    return other.text == text && other.price == price;
  }

  @override
  int get hashCode => text.hashCode ^ price.hashCode;
}

class AddProductTotalSummary {
  final int? cartTotalPrice;
  final String? cartTotalPriceDisplay;
  AddProductTotalSummary({
    this.cartTotalPrice,
    this.cartTotalPriceDisplay,
  });

  AddProductTotalSummary copyWith({
    int? cartTotalPrice,
    String? cartTotalPriceDisplay,
  }) {
    return AddProductTotalSummary(
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

  factory AddProductTotalSummary.fromMap(Map<String, dynamic> map) {
    return AddProductTotalSummary(
      cartTotalPrice:
          map['cartTotalPrice'] != null ? map['cartTotalPrice'] as int : null,
      cartTotalPriceDisplay: map['cartTotalPriceDisplay'] != null
          ? map['cartTotalPriceDisplay'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddProductTotalSummary.fromJson(String source) =>
      AddProductTotalSummary.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CartProductTotalSummary(cartTotalPrice: $cartTotalPrice, cartTotalPriceDisplay: $cartTotalPriceDisplay)';

  @override
  bool operator ==(covariant AddProductTotalSummary other) {
    if (identical(this, other)) return true;

    return other.cartTotalPrice == cartTotalPrice &&
        other.cartTotalPriceDisplay == cartTotalPriceDisplay;
  }

  @override
  int get hashCode => cartTotalPrice.hashCode ^ cartTotalPriceDisplay.hashCode;
}

class AddCartPaymentDetails {
  final String? cod;
  final String? stripe;
  final String? shopStatus;
  AddCartPaymentDetails({
    this.cod,
    this.stripe,
    this.shopStatus,
  });

  AddCartPaymentDetails copyWith({
    String? cod,
    String? stripe,
    String? shopStatus,
  }) {
    return AddCartPaymentDetails(
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

  factory AddCartPaymentDetails.fromMap(Map<String, dynamic> map) {
    return AddCartPaymentDetails(
      cod: map['cod'] != null ? map['cod'] as String : null,
      stripe: map['stripe'] != null ? map['stripe'] as String : null,
      shopStatus:
          map['shopStatus'] != null ? map['shopStatus'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddCartPaymentDetails.fromJson(String source) =>
      AddCartPaymentDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CartPaymentDetails(cod: $cod, stripe: $stripe, shopStatus: $shopStatus)';

  @override
  bool operator ==(covariant AddCartPaymentDetails other) {
    if (identical(this, other)) return true;

    return other.cod == cod &&
        other.stripe == stripe &&
        other.shopStatus == shopStatus;
  }

  @override
  int get hashCode => cod.hashCode ^ stripe.hashCode ^ shopStatus.hashCode;
}
