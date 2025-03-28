import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:aj_customer/application/core/base_controller.dart';
import 'package:aj_customer/core/constants/app_identifiers.dart';
import 'package:aj_customer/core/utils/alert_dialogs.dart';
import 'package:aj_customer/domain/checkout/i_checkout_repo.dart';
import 'package:aj_customer/domain/checkout/models/payment_intent_details.dart';
import 'package:aj_customer/infrastructure/core/failures/app_exceptions.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class PaymentProvider extends ChangeNotifier with BaseController {
  final ICheckoutRepo checkoutRepo;

  PaymentProvider({required this.checkoutRepo});

  var _creatingPaymentIntent = false;

  bool get creatingPaymentIntent => _creatingPaymentIntent;

  PaymentIntentDetails? _paymentIntentDetails;

  PaymentIntentDetails? get paymentIntentDetails => _paymentIntentDetails;

  String? get _clientSecret => paymentIntentDetails?.paymentIntent?.client_secret;

  String? get transactionId => paymentIntentDetails?.paymentIntent?.id;

  Future<void> createPaymentIntent(
    double discountAmount,
    double deliveryCharges, {
    required void Function(String transactionId) onPaymentSuccess,
  }) async {
    try {
      _creatingPaymentIntent = true;
      notifyListeners();

      final response = await checkoutRepo.createPaymentIntent(
        discountAmount: (discountAmount * 100).toStringAsFixed(0),
        deliveryCharges: (deliveryCharges * 100).toStringAsFixed(0),
      );

      response.fold((exception) {
        AlertDialogs.showError(exception.message);
      }, (result) {
        _paymentIntentDetails = result;
        notifyListeners();
        _doPaymentWithStripe(
          onPaymentSuccess: onPaymentSuccess,
        );
      });
    } finally {
      _creatingPaymentIntent = false;
      notifyListeners();
    }
  }

  Future<void> _doPaymentWithStripe({
    required void Function(String transactionId) onPaymentSuccess,
  }) async {
    if (_clientSecret != null && transactionId != null) {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: _clientSecret!,
          merchantDisplayName: AppIdentifiers.kApplicationName,
        ),
      );
      await Stripe.instance
          .presentPaymentSheet()
          .then((_) => onPaymentSuccess(transactionId!))
          .catchError((exception) async {
        if (exception is StripeException) {
          if (exception.error.code == FailureCode.Canceled ||
              exception.error.code == FailureCode.Failed ||
              exception.error.code == FailureCode.Timeout ||
              exception.error.code == FailureCode.Unknown) {
            final response = await checkoutRepo.cancelPaymentIntent(
              transactionId!,
            );

            response.fold(() {
              if (exception.error.code == FailureCode.Failed) {
                AlertDialogs.showError("Stripe Payment Failed!");
              }

              if (exception.error.code == FailureCode.Timeout) {
                AlertDialogs.showError("Internet Connection is seems to be slow.");
              }
            }, (exception) {
              log((exception as AppExceptions).message, name: "STRIPE-ERROR");
            });
          }
        }
      });
    }
  }
}
