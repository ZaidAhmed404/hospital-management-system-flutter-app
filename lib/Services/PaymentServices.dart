import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../Widgets/MessageWidget.dart';
import '../cubit/LoadingCubit/loading_cubit.dart';

class PaymentServices {
  Map<String, dynamic>? paymentIntent;

  makePayment({required BuildContext context}) async {
    try {
      bool status = await displayPaymentSheet(context: context);
      if (status == true) {
        paymentIntent = await createPaymentMethod(context: context);
        var gPay = const PaymentSheetGooglePay(
            merchantCountryCode: "US", testEnv: true, currencyCode: "US");
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentIntent!["client_secret"],
                style: ThemeMode.dark,
                merchantDisplayName: "Sabir",
                googlePay: gPay));
      }
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
    }
  }

  Future<bool> displayPaymentSheet({required BuildContext context}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (error) {
      return false;
    }
  }

  createPaymentMethod({required BuildContext context}) async {
    try {
      BlocProvider.of<LoadingCubit>(context).setLoading(true);
      Map<String, dynamic> body = {'amount': "1000", "currency": "USD"};
      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51OutwwP5SW1IvPMLphP61B8qn6Ms2sYT590Jtz8HjtVqqdSiOjCSEl4GNmKvH02Xx8ZZHn7FZdZfBmnCiJ2t2K8T00bgkoIWkV",
            "Content-Type": "application/x-www-form-urlencoded"
          });
      if (response.statusCode == 200) {
        if (context.mounted) {
          BlocProvider.of<LoadingCubit>(context).setLoading(false);
          messageWidget(
              context: context,
              isError: false,
              message: "Payment Paid Successfully");
        }
      }
      return json.decode(response.body);
    } catch (error) {
      if (context.mounted) {
        BlocProvider.of<LoadingCubit>(context).setLoading(false);
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
    }
  }
}
