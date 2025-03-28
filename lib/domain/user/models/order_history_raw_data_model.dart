import 'dart:convert';

import 'package:flutter/foundation.dart';

class OrderHistoryDataModel {
  final List<OrderDetailsModel> history;

  OrderHistoryDataModel({
    this.history = const [],
  });

  OrderHistoryDataModel copyWith({
    List<OrderDetailsModel>? history,
  }) {
    return OrderHistoryDataModel(
      history: history ?? this.history,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'history': history.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderHistoryDataModel.fromMap(Map<String, dynamic> map) {
    return OrderHistoryDataModel(
      history: List<OrderDetailsModel>.from(
        (map['History'] ?? []).map<OrderDetailsModel?>(
          (x) => OrderDetailsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHistoryDataModel.fromJson(String source) =>
      OrderHistoryDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderHistoryDataModel(history: $history)';

  @override
  bool operator ==(covariant OrderHistoryDataModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.history, history);
  }

  @override
  int get hashCode => history.hashCode;
}

class OrderDetailsModel {
  final String? orderID;
  final String? customerOrderID;
  final String? phone;
  final String? amount;
  final String? formattedAmount;
  final String? discount;
  final String? couponCode;
  final String? couponType;
  final String? couponValue;
  final String? couponAmount;
  final String? deliveryType;
  final String? deliveryCharge;
  final String? takeawayTime;
  final String? formattedDeliveryCharge;
  final String? paymentGatway;
  final String? paymentStatus;
  final String? transactionID;
  final String? orderedAt;
  final String? status;
  final String? dispatchMessage;
  final String? shopID;
  final String? shopName;
  final String? shopEmail;
  final String? shopMobile;
  final String? shopAddress1;
  final String? shopAddress2;
  final List<OrderHistoryDishesDataModel>? orderDishes;
  final OrderHistoryDeliveryAddressDataModel? deliveryAddress;

  OrderDetailsModel({
    this.orderID,
    this.customerOrderID,
    this.phone,
    this.amount,
    this.formattedAmount,
    this.discount,
    this.couponCode,
    this.couponType,
    this.couponValue,
    this.couponAmount,
    this.deliveryType,
    this.deliveryCharge,
    this.takeawayTime,
    this.formattedDeliveryCharge,
    this.paymentGatway,
    this.paymentStatus,
    this.transactionID,
    this.orderedAt,
    this.status,
    this.dispatchMessage,
    this.shopID,
    this.shopName,
    this.shopEmail,
    this.shopMobile,
    this.shopAddress1,
    this.shopAddress2,
    this.orderDishes,
    this.deliveryAddress,
  });

  OrderDetailsModel copyWith({
    String? orderID,
    String? customerOrderID,
    String? phone,
    String? amount,
    String? formattedAmount,
    String? discount,
    String? couponCode,
    String? couponType,
    String? couponValue,
    String? couponAmount,
    String? deliveryType,
    String? deliveryCharge,
    String? takeawayTime,
    String? formattedDeliveryCharge,
    String? paymentGatway,
    String? paymentStatus,
    String? transactionID,
    String? orderedAt,
    String? status,
    String? dispatchMessage,
    String? shopID,
    String? shopName,
    String? shopEmail,
    String? shopMobile,
    String? shopAddress1,
    String? shopAddress2,
    List<OrderHistoryDishesDataModel>? orderDishes,
    OrderHistoryDeliveryAddressDataModel? deliveryAddress,
  }) {
    return OrderDetailsModel(
      orderID: orderID ?? this.orderID,
      customerOrderID: customerOrderID ?? this.customerOrderID,
      phone: phone ?? this.phone,
      amount: amount ?? this.amount,
      formattedAmount: formattedAmount ?? this.formattedAmount,
      discount: discount ?? this.discount,
      couponCode: couponCode ?? this.couponCode,
      couponType: couponType ?? this.couponType,
      couponValue: couponValue ?? this.couponValue,
      couponAmount: couponAmount ?? this.couponAmount,
      deliveryType: deliveryType ?? this.deliveryType,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      takeawayTime: takeawayTime ?? this.takeawayTime,
      formattedDeliveryCharge:
          formattedDeliveryCharge ?? this.formattedDeliveryCharge,
      paymentGatway: paymentGatway ?? this.paymentGatway,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      transactionID: transactionID ?? this.transactionID,
      orderedAt: orderedAt ?? this.orderedAt,
      status: status ?? this.status,
      dispatchMessage: dispatchMessage ?? this.dispatchMessage,
      shopID: shopID ?? this.shopID,
      shopName: shopName ?? this.shopName,
      shopEmail: shopEmail ?? this.shopEmail,
      shopMobile: shopMobile ?? this.shopMobile,
      shopAddress1: shopAddress1 ?? this.shopAddress1,
      shopAddress2: shopAddress2 ?? this.shopAddress2,
      orderDishes: orderDishes ?? this.orderDishes,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'customerOrderID': customerOrderID,
      'phone': phone,
      'amount': amount,
      'formattedAmount': formattedAmount,
      'discount': discount,
      'couponCode': couponCode,
      'couponType': couponType,
      'couponValue': couponValue,
      'couponAmount': couponAmount,
      'deliveryType': deliveryType,
      'deliveryCharge': deliveryCharge,
      'takeawayTime': takeawayTime,
      'formattedDeliveryCharge': formattedDeliveryCharge,
      'paymentGatway': paymentGatway,
      'paymentStatus': paymentStatus,
      'transactionID': transactionID,
      'orderedAt': orderedAt,
      'status': status,
      'dispatchMessage': dispatchMessage,
      'shopID': shopID,
      'shopName': shopName,
      'shopEmail': shopEmail,
      'shopMobile': shopMobile,
      'shopAddress1': shopAddress1,
      'shopAddress2': shopAddress2,
      'orderDishes': orderDishes?.map((x) => x.toMap()).toList(),
      'deliveryAddress': deliveryAddress?.toMap(),
    };
  }

  String? get paymentType => paymentGatway != null
      ? paymentGatway == "STRIPE"
          ? "CARD"
          : paymentGatway
      : "Unknown";

  factory OrderDetailsModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailsModel(
      orderID: map['orderID'] != null ? map['orderID'] as String : null,
      customerOrderID: map['customerOrderID'] != null
          ? map['customerOrderID'] as String
          : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
      formattedAmount: map['formattedAmount'] != null
          ? map['formattedAmount'] as String
          : null,
      discount: map['discount'] != null ? map['discount'] as String : null,
      couponCode:
          map['couponCode'] != null ? map['couponCode'] as String : null,
      couponType:
          map['couponType'] != null ? map['couponType'] as String : null,
      couponValue:
          map['couponValue'] != null ? map['couponValue'] as String : null,
      couponAmount:
          map['couponAmount'] != null ? map['couponAmount'] as String : null,
      deliveryType:
          map['deliveryType'] != null ? map['deliveryType'] as String : null,
      deliveryCharge: map['deliveryCharge'] != null
          ? map['deliveryCharge'] as String
          : null,
      takeawayTime:
          map['takeawayTime'] != null ? map['takeawayTime'] as String : null,
      formattedDeliveryCharge: map['formattedDeliveryCharge'] != null
          ? map['formattedDeliveryCharge'] as String
          : null,
      paymentGatway:
          map['paymentGatway'] != null ? map['paymentGatway'] as String : null,
      paymentStatus:
          map['paymentStatus'] != null ? map['paymentStatus'] as String : null,
      transactionID:
          map['transactionID'] != null ? map['transactionID'] as String : null,
      orderedAt: map['orderedAt'] != null ? map['orderedAt'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      dispatchMessage: map['dispatchMessage'] != null
          ? map['dispatchMessage'] as String
          : null,
      shopID: map['shopID'] != null ? map['shopID'] as String : null,
      shopName: map['shopName'] != null ? map['shopName'] as String : null,
      shopEmail: map['shopEmail'] != null ? map['shopEmail'] as String : null,
      shopMobile:
          map['shopMobile'] != null ? map['shopMobile'] as String : null,
      shopAddress1:
          map['shopAddress1'] != null ? map['shopAddress1'] as String : null,
      shopAddress2:
          map['shopAddress2'] != null ? map['shopAddress2'] as String : null,
      orderDishes: map['orderDishes'] != null
          ? List<OrderHistoryDishesDataModel>.from(
              (map['orderDishes'] as List<dynamic>)
                  .map<OrderHistoryDishesDataModel?>(
                (x) => OrderHistoryDishesDataModel.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
      deliveryAddress: map['deliveryAddress'] != null
          ? OrderHistoryDeliveryAddressDataModel.fromMap(
              map['deliveryAddress'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailsModel.fromJson(String source) =>
      OrderDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderHistorySubDataModel(orderID: $orderID, customerOrderID: $customerOrderID, phone: $phone, amount: $amount, formattedAmount: $formattedAmount, discount: $discount, couponCode: $couponCode, couponType: $couponType, couponValue: $couponValue, couponAmount: $couponAmount, deliveryType: $deliveryType, deliveryCharge: $deliveryCharge, takeawayTime: $takeawayTime, formattedDeliveryCharge: $formattedDeliveryCharge, paymentGatway: $paymentGatway, paymentStatus: $paymentStatus, transactionID: $transactionID, orderedAt: $orderedAt, status: $status, dispatchMessage: $dispatchMessage, shopID: $shopID, shopName: $shopName, shopEmail: $shopEmail, shopMobile: $shopMobile, shopAddress1: $shopAddress1, shopAddress2: $shopAddress2, orderDishes: $orderDishes, deliveryAddress: $deliveryAddress)';
  }

  @override
  bool operator ==(covariant OrderDetailsModel other) {
    if (identical(this, other)) return true;

    return other.orderID == orderID &&
        other.customerOrderID == customerOrderID &&
        other.phone == phone &&
        other.amount == amount &&
        other.formattedAmount == formattedAmount &&
        other.discount == discount &&
        other.couponCode == couponCode &&
        other.couponType == couponType &&
        other.couponValue == couponValue &&
        other.couponAmount == couponAmount &&
        other.deliveryType == deliveryType &&
        other.deliveryCharge == deliveryCharge &&
        other.takeawayTime == takeawayTime &&
        other.formattedDeliveryCharge == formattedDeliveryCharge &&
        other.paymentGatway == paymentGatway &&
        other.paymentStatus == paymentStatus &&
        other.transactionID == transactionID &&
        other.orderedAt == orderedAt &&
        other.status == status &&
        other.dispatchMessage == dispatchMessage &&
        other.shopID == shopID &&
        other.shopName == shopName &&
        other.shopEmail == shopEmail &&
        other.shopMobile == shopMobile &&
        other.shopAddress1 == shopAddress1 &&
        other.shopAddress2 == shopAddress2 &&
        listEquals(other.orderDishes, orderDishes) &&
        other.deliveryAddress == deliveryAddress;
  }

  @override
  int get hashCode {
    return orderID.hashCode ^
        customerOrderID.hashCode ^
        phone.hashCode ^
        amount.hashCode ^
        formattedAmount.hashCode ^
        discount.hashCode ^
        couponCode.hashCode ^
        couponType.hashCode ^
        couponValue.hashCode ^
        couponAmount.hashCode ^
        deliveryType.hashCode ^
        deliveryCharge.hashCode ^
        takeawayTime.hashCode ^
        formattedDeliveryCharge.hashCode ^
        paymentGatway.hashCode ^
        paymentStatus.hashCode ^
        transactionID.hashCode ^
        orderedAt.hashCode ^
        status.hashCode ^
        dispatchMessage.hashCode ^
        shopID.hashCode ^
        shopName.hashCode ^
        shopEmail.hashCode ^
        shopMobile.hashCode ^
        shopAddress1.hashCode ^
        shopAddress2.hashCode ^
        orderDishes.hashCode ^
        deliveryAddress.hashCode;
  }

  bool get isTakeaway => deliveryType == 'store_pickup' ? true : false;

  String get formattedDeliveryType {
    if (deliveryType == 'store_pickup') {
      return 'Takeaway';
    } else if (deliveryType == 'door_delivery') {
      return 'Delivery';
    }
    return 'N/A';
  }

  String get shopFullAddress => '$shopAddress1, $shopAddress2';

  String get formatDiscount => discount != null ? '-£$discount' : '-£0.00';

  String get formattedDiscount {
    if(discount != null) {
      var val = double.parse(discount!);
      var couponAmountVal = double.parse(couponAmount!);
      var result = val - couponAmountVal;
      return result.toStringAsFixed(2);
    }
    return "0.00";
    
  } 

  double get formatSubTotal {
    var subTotal = 0.0;
    var itemSubTotal = 0.0;
    var addonSubTotal = 0.0;
    if (orderDishes == null) return 0.00;
    for (var i = 0; i < orderDishes!.length; i++) {
      for (var j = 0; j < orderDishes![i].addons!.length; j++) {
        var addonPrice = double.parse(orderDishes![i].addons![j].price);
        var parsedAddonPrice = addonPrice / 100;
        addonSubTotal = addonSubTotal + parsedAddonPrice;
      }
      var val = double.parse(orderDishes![i].price!);
      var parsedVal = val / 100;
      var qty = double.parse(orderDishes![i].quantity!);
      var finalVal = parsedVal * qty;
      itemSubTotal = itemSubTotal + finalVal;
    }
    subTotal = itemSubTotal + addonSubTotal;
    return subTotal;
  }

  bool get orderPending {
    const pendingMessage = "Waiting for seller to accept the order";
    if (status?.toLowerCase() == pendingMessage.toLowerCase()) {
      return true;
    } else {
      return false;
    }
  }

  bool get orderAccepted {
    const acceptedMessage =
        "Order accepted by the seller and waiting for dispatch";
    if (status?.toLowerCase() == acceptedMessage.toLowerCase()) {
      return true;
    } else {
      return false;
    }
  }

  bool get orderDispatched {
    const dispatchMessage = "Order dispatched";

    if (status?.toLowerCase() == dispatchMessage.toLowerCase()) {
      return true;
    } else {
      return false;
    }
  }
}

class OrderHistoryDishesDataModel {
  final String? opID;
  final String? orderID;
  final String? identifierName;
  final String? name;
  final String? description;
  final String? photo;
  final String? productType;
  final String? variationName;
  final String? ingredients;
  final String? price;
  final String? quantity;
  final String? waiterID;
  final String? totalPrice;
  final String? formattedPrice;
  final String? formattedTotalPrice;
  final List<OrderHistoryAddonsDataModel>? addons;

  OrderHistoryDishesDataModel({
    this.opID,
    this.orderID,
    this.identifierName,
    this.name,
    this.description,
    this.photo,
    this.productType,
    this.variationName,
    this.ingredients,
    this.price,
    this.quantity,
    this.waiterID,
    this.totalPrice,
    this.formattedPrice,
    this.formattedTotalPrice,
    this.addons,
  });

  OrderHistoryDishesDataModel copyWith({
    String? opID,
    String? orderID,
    String? identifierName,
    String? name,
    String? description,
    String? photo,
    String? productType,
    String? variationName,
    String? ingredients,
    String? price,
    String? quantity,
    String? waiterID,
    String? totalPrice,
    String? formattedPrice,
    String? formattedTotalPrice,
    List<OrderHistoryAddonsDataModel>? addons,
  }) {
    return OrderHistoryDishesDataModel(
      opID: opID ?? this.opID,
      orderID: orderID ?? this.orderID,
      identifierName: identifierName ?? this.identifierName,
      name: name ?? this.name,
      description: description ?? this.description,
      photo: photo ?? this.photo,
      productType: productType ?? this.productType,
      variationName: variationName ?? this.variationName,
      ingredients: ingredients ?? this.ingredients,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      waiterID: waiterID ?? this.waiterID,
      totalPrice: totalPrice ?? this.totalPrice,
      formattedPrice: formattedPrice ?? this.formattedPrice,
      formattedTotalPrice: formattedTotalPrice ?? this.formattedTotalPrice,
      addons: addons ?? this.addons,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'opID': opID,
      'orderID': orderID,
      'identifierName': identifierName,
      'name': name,
      'description': description,
      'photo': photo,
      'productType': productType,
      'variationName': variationName,
      'ingredients': ingredients,
      'price': price,
      'quantity': quantity,
      'waiterID': waiterID,
      'totalPrice': totalPrice,
      'formattedPrice': formattedPrice,
      'formattedTotalPrice': formattedTotalPrice,
      'addons': addons?.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderHistoryDishesDataModel.fromMap(Map<String, dynamic> map) {
    return OrderHistoryDishesDataModel(
      opID: map['opID'] != null ? map['opID'] as String : null,
      orderID: map['orderID'] != null ? map['orderID'] as String : null,
      identifierName: map['identifierName'] != null
          ? map['identifierName'] as String
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      productType:
          map['productType'] != null ? map['productType'] as String : null,
      variationName:
          map['variationName'] != null ? map['variationName'] as String : null,
      ingredients:
          map['ingredients'] != null ? map['ingredients'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as String : null,
      waiterID: map['waiterID'] != null ? map['waiterID'] as String : null,
      totalPrice:
          map['totalPrice'] != null ? map['totalPrice'] as String : null,
      formattedPrice: map['formattedPrice'] != null
          ? map['formattedPrice'] as String
          : null,
      formattedTotalPrice: map['formattedTotalPrice'] != null
          ? map['formattedTotalPrice'] as String
          : null,
      addons: map['addons'] != null
          ? List<OrderHistoryAddonsDataModel>.from(
              (map['addons'] as List<dynamic>)
                  .map<OrderHistoryAddonsDataModel?>(
                (x) => OrderHistoryAddonsDataModel.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String get dishVariationAndModifiers {
    final hasVariation = variationName != null;
    final hasAddons = addons != null && addons!.isNotEmpty;

    if (hasVariation && hasAddons) {
      return "($variationName), ${addons!.map((e) => e.name).join(', ')}";
    } else if (hasVariation) {
      return "($variationName)";
    } else if (hasAddons) {
      return addons!.map((e) => e.name).join(', ');
    }
    return '';
  }

  String toJson() => json.encode(toMap());

  factory OrderHistoryDishesDataModel.fromJson(String source) =>
      OrderHistoryDishesDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderHistoryDishesDataModel(opID: $opID, orderID: $orderID, identifierName: $identifierName, name: $name, description: $description, photo: $photo, productType: $productType, variationName: $variationName, ingredients: $ingredients, price: $price, quantity: $quantity, waiterID: $waiterID, totalPrice: $totalPrice, formattedPrice: $formattedPrice, formattedTotalPrice: $formattedTotalPrice, addons: $addons)';
  }

  @override
  bool operator ==(covariant OrderHistoryDishesDataModel other) {
    if (identical(this, other)) return true;

    return other.opID == opID &&
        other.orderID == orderID &&
        other.identifierName == identifierName &&
        other.name == name &&
        other.description == description &&
        other.photo == photo &&
        other.productType == productType &&
        other.variationName == variationName &&
        other.ingredients == ingredients &&
        other.price == price &&
        other.quantity == quantity &&
        other.waiterID == waiterID &&
        other.totalPrice == totalPrice &&
        other.formattedPrice == formattedPrice &&
        other.formattedTotalPrice == formattedTotalPrice &&
        listEquals(other.addons, addons);
  }

  @override
  int get hashCode {
    return opID.hashCode ^
        orderID.hashCode ^
        identifierName.hashCode ^
        name.hashCode ^
        description.hashCode ^
        photo.hashCode ^
        productType.hashCode ^
        variationName.hashCode ^
        ingredients.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        waiterID.hashCode ^
        totalPrice.hashCode ^
        formattedPrice.hashCode ^
        formattedTotalPrice.hashCode ^
        addons.hashCode;
  }

  String get dishNameWithVariation =>
      variationName != null ? '$name ($variationName)' : name ?? "N/A";

  String get addonsNames {
    if (addons == null) {
      return '';
    }
    return addons!
        .map((addon) {
          return addon.name;
        })
        .toList()
        .join('\n+ ');
  }

  String get addonPrice => addons == null
      ? ''
      : addons!
          .map((aPrice) {
            final itemPrice = double.parse(aPrice.price);
            final parsedItemPrice = itemPrice / 100;
            return parsedItemPrice.toStringAsFixed(2);
          })
          .toList()
          .join('\n+ £ ');

  double get formatItemTotal {
    final itemPrice = double.parse(price!);
    final parsedItemPrice = itemPrice / 100;
    final itemQuantity = double.parse(quantity!);
    final itemTotal = parsedItemPrice * itemQuantity;
    return itemTotal;
  }
}

class OrderHistoryAddonsDataModel {
  final String opaID;
  final String opID;
  final String name;
  final String price;

  OrderHistoryAddonsDataModel({
    required this.opaID,
    required this.opID,
    required this.name,
    required this.price,
  });

  OrderHistoryAddonsDataModel copyWith({
    String? opaID,
    String? opID,
    String? name,
    String? price,
  }) {
    return OrderHistoryAddonsDataModel(
      opaID: opaID ?? this.opaID,
      opID: opID ?? this.opID,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'opaID': opaID,
      'opID': opID,
      'name': name,
      'price': price,
    };
  }

  factory OrderHistoryAddonsDataModel.fromMap(Map<String, dynamic> map) {
    return OrderHistoryAddonsDataModel(
      opaID: map['opaID'] as String,
      opID: map['opID'] as String,
      name: map['name'] as String,
      price: map['price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHistoryAddonsDataModel.fromJson(String source) =>
      OrderHistoryAddonsDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderHistoryAddonsDataModel(opaID: $opaID, opID: $opID, name: $name, price: $price)';
  }

  @override
  bool operator ==(covariant OrderHistoryAddonsDataModel other) {
    if (identical(this, other)) return true;

    return other.opaID == opaID &&
        other.opID == opID &&
        other.name == name &&
        other.price == price;
  }

  @override
  int get hashCode {
    return opaID.hashCode ^ opID.hashCode ^ name.hashCode ^ price.hashCode;
  }
}

class OrderHistoryDeliveryAddressDataModel {
  final String? oaID;
  final String? orderID;
  final String? customerName;
  final String? line1;
  final String? line2;
  final String? town;
  final String? postcode;
  final String? county;
  final String? landmark;

  OrderHistoryDeliveryAddressDataModel({
    this.oaID,
    this.orderID,
    this.customerName,
    this.line1,
    this.line2,
    this.town,
    this.postcode,
    this.county,
    this.landmark,
  });

  OrderHistoryDeliveryAddressDataModel copyWith({
    String? oaID,
    String? orderID,
    String? customerName,
    String? line1,
    String? line2,
    String? town,
    String? postcode,
    String? county,
    String? landmark,
  }) {
    return OrderHistoryDeliveryAddressDataModel(
      oaID: oaID ?? this.oaID,
      orderID: orderID ?? this.orderID,
      customerName: customerName ?? this.customerName,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      town: town ?? this.town,
      postcode: postcode ?? this.postcode,
      county: county ?? this.county,
      landmark: landmark ?? this.landmark,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'oaID': oaID,
      'orderID': orderID,
      'customerName': customerName,
      'line1': line1,
      'line2': line2,
      'town': town,
      'postcode': postcode,
      'county': county,
      'landmark': landmark,
    };
  }

  factory OrderHistoryDeliveryAddressDataModel.fromMap(
      Map<String, dynamic> map) {
    return OrderHistoryDeliveryAddressDataModel(
      oaID: map['oaID'] != null ? map['oaID'] as String : null,
      orderID: map['orderID'] != null ? map['orderID'] as String : null,
      customerName:
          map['customerName'] != null ? map['customerName'] as String : null,
      line1: map['line1'] != null ? map['line1'] as String : null,
      line2: map['line2'] != null ? map['line2'] as String : null,
      town: map['town'] != null ? map['town'] as String : null,
      postcode: map['postcode'] != null ? map['postcode'] as String : null,
      county: map['county'] != null ? map['county'] as String : null,
      landmark: map['landmark'] != null ? map['landmark'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHistoryDeliveryAddressDataModel.fromJson(String source) =>
      OrderHistoryDeliveryAddressDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderHistoryDeliveryAddressDataModel(oaID: $oaID, orderID: $orderID, customerName: $customerName, line1: $line1, line2: $line2, town: $town, postcode: $postcode, county: $county, landmark: $landmark)';
  }

  @override
  bool operator ==(covariant OrderHistoryDeliveryAddressDataModel other) {
    if (identical(this, other)) return true;

    return other.oaID == oaID &&
        other.orderID == orderID &&
        other.customerName == customerName &&
        other.line1 == line1 &&
        other.line2 == line2 &&
        other.town == town &&
        other.postcode == postcode &&
        other.county == county &&
        other.landmark == landmark;
  }

  @override
  int get hashCode {
    return oaID.hashCode ^
        orderID.hashCode ^
        customerName.hashCode ^
        line1.hashCode ^
        line2.hashCode ^
        town.hashCode ^
        postcode.hashCode ^
        county.hashCode ^
        landmark.hashCode;
  }

  String get customerFullAddress {
    if (line2 == null || line2?.isEmpty == true) {
      return '$line1, $town, $county, $postcode'.trim();
    }
    return '$line1, $line2, $town, $county, $postcode'.trim();
  }
}
