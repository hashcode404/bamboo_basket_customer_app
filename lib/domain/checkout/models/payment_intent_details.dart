
import 'dart:convert';

import 'package:flutter/foundation.dart';

class PaymentIntentDetails {
  final String? message;
  final String? shopID;
  final int? amount;
  final int? deliveryCharge;
  final int? total;
  final PaymentData? paymentIntent;
  PaymentIntentDetails({
    this.message,
    this.shopID,
    this.amount,
    this.deliveryCharge,
    this.total,
    this.paymentIntent,
  });

  PaymentIntentDetails copyWith({
    String? message,
    String? shopID,
    int? amount,
    int? deliveryCharge,
    int? total,
    PaymentData? paymentIntent,
  }) {
    return PaymentIntentDetails(
      message: message ?? this.message,
      shopID: shopID ?? this.shopID,
      amount: amount ?? this.amount,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      total: total ?? this.total,
      paymentIntent: paymentIntent ?? this.paymentIntent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'shopID': shopID,
      'amount': amount,
      'deliveryCharge': deliveryCharge,
      'total': total,
      'paymentIntent': paymentIntent?.toMap(),
    };
  }

  factory PaymentIntentDetails.fromMap(Map<String, dynamic> map) {
    return PaymentIntentDetails(
      message: map['message'] != null ? map['message'] as String : null,
      shopID: map['shopID'] != null ? map['shopID'] as String : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
      deliveryCharge:
      map['deliveryCharge'] != null ? map['deliveryCharge'] as int : null,
      total: map['total'] != null ? map['total'] as int : null,
      paymentIntent: map['paymentIntent'] != null
          ? PaymentData.fromMap(
          map['paymentIntent'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentDetails.fromJson(String source) =>
      PaymentIntentDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentIntentSubDataModel(message: $message, shopID: $shopID, amount: $amount, deliveryCharge: $deliveryCharge, total: $total, paymentIntent: $paymentIntent)';
  }

  @override
  bool operator ==(covariant PaymentIntentDetails other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.shopID == shopID &&
        other.amount == amount &&
        other.deliveryCharge == deliveryCharge &&
        other.total == total &&
        other.paymentIntent == paymentIntent;
  }

  @override
  int get hashCode {
    return message.hashCode ^
    shopID.hashCode ^
    amount.hashCode ^
    deliveryCharge.hashCode ^
    total.hashCode ^
    paymentIntent.hashCode;
  }
}

class PaymentData {
  final String? id;
  final String? object;
  final int? amount;
  final int? amount_capturable;
  final PaymentIntentAmountDetailsDataModel? amount_details;
  final int? amount_received;
  final String? application;
  final int? application_fee_amount;
  final String? automatic_payment_methods;
  final String? canceled_at;
  final String? cancellation_reason;
  final String? capture_method;
  final PaymentIntentChargesDataModel? charges;
  final String? client_secret;
  final String? confirmation_method;
  final int? created;
  final String? currency;
  final String? customer;
  final String? description;
  final String? invoice;
  final String? last_payment_error;
  final String? latest_charge;
  final bool livemode;
  final List<dynamic>? metadata;
  final String? next_action;
  final String? on_behalf_of;
  final String? payment_method;
  final String? payment_method_configuration_details;
  final PaymentIntentPaymentMethodOptionsDataModel? payment_method_options;
  final List<String>? payment_method_types;
  final String? processing;
  final String? receipt_email;
  final String? review;
  final String? setup_future_usage;
  final String? shipping;
  final String? source;
  final String? statement_descriptor;
  final String? statement_descriptor_suffix;
  final String? status;
  final PaymentIntentTransferDataModel? transfer_data;
  final String? transfer_group;
  PaymentData({
    this.id,
    this.object,
    this.amount,
    this.amount_capturable,
    this.amount_details,
    this.amount_received,
    this.application,
    this.application_fee_amount,
    this.automatic_payment_methods,
    this.canceled_at,
    this.cancellation_reason,
    this.capture_method,
    this.charges,
    this.client_secret,
    this.confirmation_method,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.invoice,
    this.last_payment_error,
    this.latest_charge,
    required this.livemode,
    this.metadata,
    this.next_action,
    this.on_behalf_of,
    this.payment_method,
    this.payment_method_configuration_details,
    this.payment_method_options,
    this.payment_method_types,
    this.processing,
    this.receipt_email,
    this.review,
    this.setup_future_usage,
    this.shipping,
    this.source,
    this.statement_descriptor,
    this.statement_descriptor_suffix,
    this.status,
    this.transfer_data,
    this.transfer_group,
  });

  PaymentData copyWith({
    String? id,
    String? object,
    int? amount,
    int? amount_capturable,
    PaymentIntentAmountDetailsDataModel? amount_details,
    int? amount_received,
    String? application,
    int? application_fee_amount,
    String? automatic_payment_methods,
    String? canceled_at,
    String? cancellation_reason,
    String? capture_method,
    PaymentIntentChargesDataModel? charges,
    String? client_secret,
    String? confirmation_method,
    int? created,
    String? currency,
    String? customer,
    String? description,
    String? invoice,
    String? last_payment_error,
    String? latest_charge,
    bool? livemode,
    List<dynamic>? metadata,
    String? next_action,
    String? on_behalf_of,
    String? payment_method,
    String? payment_method_configuration_details,
    PaymentIntentPaymentMethodOptionsDataModel? payment_method_options,
    List<String>? payment_method_types,
    String? processing,
    String? receipt_email,
    String? review,
    String? setup_future_usage,
    String? shipping,
    String? source,
    String? statement_descriptor,
    String? statement_descriptor_suffix,
    String? status,
    PaymentIntentTransferDataModel? transfer_data,
    String? transfer_group,
  }) {
    return PaymentData(
      id: id ?? this.id,
      object: object ?? this.object,
      amount: amount ?? this.amount,
      amount_capturable: amount_capturable ?? this.amount_capturable,
      amount_details: amount_details ?? this.amount_details,
      amount_received: amount_received ?? this.amount_received,
      application: application ?? this.application,
      application_fee_amount:
      application_fee_amount ?? this.application_fee_amount,
      automatic_payment_methods:
      automatic_payment_methods ?? this.automatic_payment_methods,
      canceled_at: canceled_at ?? this.canceled_at,
      cancellation_reason: cancellation_reason ?? this.cancellation_reason,
      capture_method: capture_method ?? this.capture_method,
      charges: charges ?? this.charges,
      client_secret: client_secret ?? this.client_secret,
      confirmation_method: confirmation_method ?? this.confirmation_method,
      created: created ?? this.created,
      currency: currency ?? this.currency,
      customer: customer ?? this.customer,
      description: description ?? this.description,
      invoice: invoice ?? this.invoice,
      last_payment_error: last_payment_error ?? this.last_payment_error,
      latest_charge: latest_charge ?? this.latest_charge,
      livemode: livemode ?? this.livemode,
      metadata: metadata ?? this.metadata,
      next_action: next_action ?? this.next_action,
      on_behalf_of: on_behalf_of ?? this.on_behalf_of,
      payment_method: payment_method ?? this.payment_method,
      payment_method_configuration_details:
      payment_method_configuration_details ??
          this.payment_method_configuration_details,
      payment_method_options:
      payment_method_options ?? this.payment_method_options,
      payment_method_types: payment_method_types ?? this.payment_method_types,
      processing: processing ?? this.processing,
      receipt_email: receipt_email ?? this.receipt_email,
      review: review ?? this.review,
      setup_future_usage: setup_future_usage ?? this.setup_future_usage,
      shipping: shipping ?? this.shipping,
      source: source ?? this.source,
      statement_descriptor: statement_descriptor ?? this.statement_descriptor,
      statement_descriptor_suffix:
      statement_descriptor_suffix ?? this.statement_descriptor_suffix,
      status: status ?? this.status,
      transfer_data: transfer_data ?? this.transfer_data,
      transfer_group: transfer_group ?? this.transfer_group,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'amount': amount,
      'amount_capturable': amount_capturable,
      'amount_details': amount_details?.toMap(),
      'amount_received': amount_received,
      'application': application,
      'application_fee_amount': application_fee_amount,
      'automatic_payment_methods': automatic_payment_methods,
      'canceled_at': canceled_at,
      'cancellation_reason': cancellation_reason,
      'capture_method': capture_method,
      'charges': charges?.toMap(),
      'client_secret': client_secret,
      'confirmation_method': confirmation_method,
      'created': created,
      'currency': currency,
      'customer': customer,
      'description': description,
      'invoice': invoice,
      'last_payment_error': last_payment_error,
      'latest_charge': latest_charge,
      'livemode': livemode,
      'metadata': metadata,
      'next_action': next_action,
      'on_behalf_of': on_behalf_of,
      'payment_method': payment_method,
      'payment_method_configuration_details':
      payment_method_configuration_details,
      'payment_method_options': payment_method_options?.toMap(),
      'payment_method_types': payment_method_types,
      'processing': processing,
      'receipt_email': receipt_email,
      'review': review,
      'setup_future_usage': setup_future_usage,
      'shipping': shipping,
      'source': source,
      'statement_descriptor': statement_descriptor,
      'statement_descriptor_suffix': statement_descriptor_suffix,
      'status': status,
      'transfer_data': transfer_data?.toMap(),
      'transfer_group': transfer_group,
    };
  }

  factory PaymentData.fromMap(Map<String, dynamic> map) {
    return PaymentData(
      id: map['id'] != null ? map['id'] as String : null,
      object: map['object'] != null ? map['object'] as String : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
      amount_capturable: map['amount_capturable'] != null
          ? map['amount_capturable'] as int
          : null,
      amount_details: map['amount_details'] != null
          ? PaymentIntentAmountDetailsDataModel.fromMap(
          map['amount_details'] as Map<String, dynamic>)
          : null,
      amount_received:
      map['amount_received'] != null ? map['amount_received'] as int : null,
      application:
      map['application'] != null ? map['application'] as String : null,
      application_fee_amount: map['application_fee_amount'] != null
          ? map['application_fee_amount'] as int
          : null,
      automatic_payment_methods: map['automatic_payment_methods'] != null
          ? map['automatic_payment_methods'] as String
          : null,
      canceled_at:
      map['canceled_at'] != null ? map['canceled_at'] as String : null,
      cancellation_reason: map['cancellation_reason'] != null
          ? map['cancellation_reason'] as String
          : null,
      capture_method: map['capture_method'] != null
          ? map['capture_method'] as String
          : null,
      charges: map['charges'] != null
          ? PaymentIntentChargesDataModel.fromMap(
          map['charges'] as Map<String, dynamic>)
          : null,
      client_secret:
      map['client_secret'] != null ? map['client_secret'] as String : null,
      confirmation_method: map['confirmation_method'] != null
          ? map['confirmation_method'] as String
          : null,
      created: map['created'] != null ? map['created'] as int : null,
      currency: map['currency'] != null ? map['currency'] as String : null,
      customer: map['customer'] != null ? map['customer'] as String : null,
      description:
      map['description'] != null ? map['description'] as String : null,
      invoice: map['invoice'] != null ? map['invoice'] as String : null,
      last_payment_error: map['last_payment_error'] != null
          ? map['last_payment_error'] as String
          : null,
      latest_charge:
      map['latest_charge'] != null ? map['latest_charge'] as String : null,
      livemode: map['livemode'] as bool,
      metadata: map['metadata'] != null
          ? List<dynamic>.from((map['metadata'] as List<dynamic>))
          : null,
      next_action:
      map['next_action'] != null ? map['next_action'] as String : null,
      on_behalf_of:
      map['on_behalf_of'] != null ? map['on_behalf_of'] as String : null,
      payment_method: map['payment_method'] != null
          ? map['payment_method'] as String
          : null,
      payment_method_configuration_details:
      map['payment_method_configuration_details'] != null
          ? map['payment_method_configuration_details'] as String
          : null,
      payment_method_options: map['payment_method_options'] != null
          ? PaymentIntentPaymentMethodOptionsDataModel.fromMap(
          map['payment_method_options'] as Map<String, dynamic>)
          : null,
      payment_method_types: map['payment_method_types'] != null
          ? List<String>.from((map['payment_method_types'] as List<dynamic>))
          : null,
      processing:
      map['processing'] != null ? map['processing'] as String : null,
      receipt_email:
      map['receipt_email'] != null ? map['receipt_email'] as String : null,
      review: map['review'] != null ? map['review'] as String : null,
      setup_future_usage: map['setup_future_usage'] != null
          ? map['setup_future_usage'] as String
          : null,
      shipping: map['shipping'] != null ? map['shipping'] as String : null,
      source: map['source'] != null ? map['source'] as String : null,
      statement_descriptor: map['statement_descriptor'] != null
          ? map['statement_descriptor'] as String
          : null,
      statement_descriptor_suffix: map['statement_descriptor_suffix'] != null
          ? map['statement_descriptor_suffix'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      transfer_data: map['transfer_data'] != null
          ? PaymentIntentTransferDataModel.fromMap(
          map['transfer_data'] as Map<String, dynamic>)
          : null,
      transfer_group: map['transfer_group'] != null
          ? map['transfer_group'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentData.fromJson(String source) =>
      PaymentData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentIntentDataModel(id: $id, object: $object, amount: $amount, amount_capturable: $amount_capturable, amount_details: $amount_details, amount_received: $amount_received, application: $application, application_fee_amount: $application_fee_amount, automatic_payment_methods: $automatic_payment_methods, canceled_at: $canceled_at, cancellation_reason: $cancellation_reason, capture_method: $capture_method, charges: $charges, client_secret: $client_secret, confirmation_method: $confirmation_method, created: $created, currency: $currency, customer: $customer, description: $description, invoice: $invoice, last_payment_error: $last_payment_error, latest_charge: $latest_charge, livemode: $livemode, metadata: $metadata, next_action: $next_action, on_behalf_of: $on_behalf_of, payment_method: $payment_method, payment_method_configuration_details: $payment_method_configuration_details, payment_method_options: $payment_method_options, payment_method_types: $payment_method_types, processing: $processing, receipt_email: $receipt_email, review: $review, setup_future_usage: $setup_future_usage, shipping: $shipping, source: $source, statement_descriptor: $statement_descriptor, statement_descriptor_suffix: $statement_descriptor_suffix, status: $status, transfer_data: $transfer_data, transfer_group: $transfer_group)';
  }

  @override
  bool operator ==(covariant PaymentData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.object == object &&
        other.amount == amount &&
        other.amount_capturable == amount_capturable &&
        other.amount_details == amount_details &&
        other.amount_received == amount_received &&
        other.application == application &&
        other.application_fee_amount == application_fee_amount &&
        other.automatic_payment_methods == automatic_payment_methods &&
        other.canceled_at == canceled_at &&
        other.cancellation_reason == cancellation_reason &&
        other.capture_method == capture_method &&
        other.charges == charges &&
        other.client_secret == client_secret &&
        other.confirmation_method == confirmation_method &&
        other.created == created &&
        other.currency == currency &&
        other.customer == customer &&
        other.description == description &&
        other.invoice == invoice &&
        other.last_payment_error == last_payment_error &&
        other.latest_charge == latest_charge &&
        other.livemode == livemode &&
        listEquals(other.metadata, metadata) &&
        other.next_action == next_action &&
        other.on_behalf_of == on_behalf_of &&
        other.payment_method == payment_method &&
        other.payment_method_configuration_details ==
            payment_method_configuration_details &&
        other.payment_method_options == payment_method_options &&
        listEquals(other.payment_method_types, payment_method_types) &&
        other.processing == processing &&
        other.receipt_email == receipt_email &&
        other.review == review &&
        other.setup_future_usage == setup_future_usage &&
        other.shipping == shipping &&
        other.source == source &&
        other.statement_descriptor == statement_descriptor &&
        other.statement_descriptor_suffix == statement_descriptor_suffix &&
        other.status == status &&
        other.transfer_data == transfer_data &&
        other.transfer_group == transfer_group;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    object.hashCode ^
    amount.hashCode ^
    amount_capturable.hashCode ^
    amount_details.hashCode ^
    amount_received.hashCode ^
    application.hashCode ^
    application_fee_amount.hashCode ^
    automatic_payment_methods.hashCode ^
    canceled_at.hashCode ^
    cancellation_reason.hashCode ^
    capture_method.hashCode ^
    charges.hashCode ^
    client_secret.hashCode ^
    confirmation_method.hashCode ^
    created.hashCode ^
    currency.hashCode ^
    customer.hashCode ^
    description.hashCode ^
    invoice.hashCode ^
    last_payment_error.hashCode ^
    latest_charge.hashCode ^
    livemode.hashCode ^
    metadata.hashCode ^
    next_action.hashCode ^
    on_behalf_of.hashCode ^
    payment_method.hashCode ^
    payment_method_configuration_details.hashCode ^
    payment_method_options.hashCode ^
    payment_method_types.hashCode ^
    processing.hashCode ^
    receipt_email.hashCode ^
    review.hashCode ^
    setup_future_usage.hashCode ^
    shipping.hashCode ^
    source.hashCode ^
    statement_descriptor.hashCode ^
    statement_descriptor_suffix.hashCode ^
    status.hashCode ^
    transfer_data.hashCode ^
    transfer_group.hashCode;
  }
}

class PaymentIntentAmountDetailsDataModel {
  final List<dynamic>? tip;
  PaymentIntentAmountDetailsDataModel({
    this.tip,
  });

  PaymentIntentAmountDetailsDataModel copyWith({
    List<dynamic>? tip,
  }) {
    return PaymentIntentAmountDetailsDataModel(
      tip: tip ?? this.tip,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tip': tip,
    };
  }

  factory PaymentIntentAmountDetailsDataModel.fromMap(
      Map<String, dynamic> map) {
    return PaymentIntentAmountDetailsDataModel(
      tip: map['tip'] != null
          ? List<dynamic>.from((map['tip'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentAmountDetailsDataModel.fromJson(String source) =>
      PaymentIntentAmountDetailsDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PaymentIntentAmountDetailsDataModel(tip: $tip)';

  @override
  bool operator ==(covariant PaymentIntentAmountDetailsDataModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.tip, tip);
  }

  @override
  int get hashCode => tip.hashCode;
}

class PaymentIntentChargesDataModel {
  final String? object;
  final List<dynamic>? data;
  final bool? has_more;
  final int? total_count;
  final String? url;
  PaymentIntentChargesDataModel({
    this.object,
    this.data,
    this.has_more,
    this.total_count,
    this.url,
  });

  PaymentIntentChargesDataModel copyWith({
    String? object,
    List<dynamic>? data,
    bool? has_more,
    int? total_count,
    String? url,
  }) {
    return PaymentIntentChargesDataModel(
      object: object ?? this.object,
      data: data ?? this.data,
      has_more: has_more ?? this.has_more,
      total_count: total_count ?? this.total_count,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'object': object,
      'data': data,
      'has_more': has_more,
      'total_count': total_count,
      'url': url,
    };
  }

  factory PaymentIntentChargesDataModel.fromMap(Map<String, dynamic> map) {
    return PaymentIntentChargesDataModel(
      object: map['object'] != null ? map['object'] as String : null,
      data: map['data'] != null
          ? List<dynamic>.from((map['data'] as List<dynamic>))
          : null,
      has_more: map['has_more'] != null ? map['has_more'] as bool : null,
      total_count:
      map['total_count'] != null ? map['total_count'] as int : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentChargesDataModel.fromJson(String source) =>
      PaymentIntentChargesDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentIntentChargesDataModel(object: $object, data: $data, has_more: $has_more, total_count: $total_count, url: $url)';
  }

  @override
  bool operator ==(covariant PaymentIntentChargesDataModel other) {
    if (identical(this, other)) return true;

    return other.object == object &&
        listEquals(other.data, data) &&
        other.has_more == has_more &&
        other.total_count == total_count &&
        other.url == url;
  }

  @override
  int get hashCode {
    return object.hashCode ^
    data.hashCode ^
    has_more.hashCode ^
    total_count.hashCode ^
    url.hashCode;
  }
}

class PaymentIntentPaymentMethodOptionsDataModel {
  final PaymentIntentCardDataModel? card;
  PaymentIntentPaymentMethodOptionsDataModel({
    this.card,
  });

  PaymentIntentPaymentMethodOptionsDataModel copyWith({
    PaymentIntentCardDataModel? card,
  }) {
    return PaymentIntentPaymentMethodOptionsDataModel(
      card: card ?? this.card,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'card': card?.toMap(),
    };
  }

  factory PaymentIntentPaymentMethodOptionsDataModel.fromMap(
      Map<String, dynamic> map) {
    return PaymentIntentPaymentMethodOptionsDataModel(
      card: map['card'] != null
          ? PaymentIntentCardDataModel.fromMap(
          map['card'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentPaymentMethodOptionsDataModel.fromJson(String source) =>
      PaymentIntentPaymentMethodOptionsDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PaymentIntentPaymentMethodOptionsDataModel(card: $card)';

  @override
  bool operator ==(covariant PaymentIntentPaymentMethodOptionsDataModel other) {
    if (identical(this, other)) return true;

    return other.card == card;
  }

  @override
  int get hashCode => card.hashCode;
}

class PaymentIntentCardDataModel {
  final String? installments;
  final String? mandate_options;
  final String? network;
  final String? request_three_d_secure;
  PaymentIntentCardDataModel({
    this.installments,
    this.mandate_options,
    this.network,
    this.request_three_d_secure,
  });

  PaymentIntentCardDataModel copyWith({
    String? installments,
    String? mandate_options,
    String? network,
    String? request_three_d_secure,
  }) {
    return PaymentIntentCardDataModel(
      installments: installments ?? this.installments,
      mandate_options: mandate_options ?? this.mandate_options,
      network: network ?? this.network,
      request_three_d_secure:
      request_three_d_secure ?? this.request_three_d_secure,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'installments': installments,
      'mandate_options': mandate_options,
      'network': network,
      'request_three_d_secure': request_three_d_secure,
    };
  }

  factory PaymentIntentCardDataModel.fromMap(Map<String, dynamic> map) {
    return PaymentIntentCardDataModel(
      installments:
      map['installments'] != null ? map['installments'] as String : null,
      mandate_options: map['mandate_options'] != null
          ? map['mandate_options'] as String
          : null,
      network: map['network'] != null ? map['network'] as String : null,
      request_three_d_secure: map['request_three_d_secure'] != null
          ? map['request_three_d_secure'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentCardDataModel.fromJson(String source) =>
      PaymentIntentCardDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentIntentCardDataModel(installments: $installments, mandate_options: $mandate_options, network: $network, request_three_d_secure: $request_three_d_secure)';
  }

  @override
  bool operator ==(covariant PaymentIntentCardDataModel other) {
    if (identical(this, other)) return true;

    return other.installments == installments &&
        other.mandate_options == mandate_options &&
        other.network == network &&
        other.request_three_d_secure == request_three_d_secure;
  }

  @override
  int get hashCode {
    return installments.hashCode ^
    mandate_options.hashCode ^
    network.hashCode ^
    request_three_d_secure.hashCode;
  }
}

class PaymentIntentTransferDataModel {
  final String? destination;
  PaymentIntentTransferDataModel({
    this.destination,
  });

  PaymentIntentTransferDataModel copyWith({
    String? destination,
  }) {
    return PaymentIntentTransferDataModel(
      destination: destination ?? this.destination,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'destination': destination,
    };
  }

  factory PaymentIntentTransferDataModel.fromMap(Map<String, dynamic> map) {
    return PaymentIntentTransferDataModel(
      destination:
      map['destination'] != null ? map['destination'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentTransferDataModel.fromJson(String source) =>
      PaymentIntentTransferDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PaymentIntentTransferDataModel(destination: $destination)';

  @override
  bool operator ==(covariant PaymentIntentTransferDataModel other) {
    if (identical(this, other)) return true;

    return other.destination == destination;
  }

  @override
  int get hashCode => destination.hashCode;
}
