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

  Future<bool> makePayment({required BuildContext context}) async {
    FocusScope.of(context).unfocus();
    try {
      log("payment");
      paymentIntent = await createPaymentMethod(context: context);
      var gPay = const PaymentSheetGooglePay(
          merchantCountryCode: "US", testEnv: true, currencyCode: "US");
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!["client_secret"],
              style: ThemeMode.dark,
              merchantDisplayName: "Sabir",
              googlePay: gPay));
      bool status = await displayPaymentSheet(context: context);
      return status;
    } catch (error) {
      log("$error", name: "error in getting stripe data");
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
      return false;
    }
    return true;
  }

  Future<bool> displayPaymentSheet({required BuildContext context}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (error) {
      log("$error", name: "error");
      return false;
    }
    log("payment sheet");
    return true;
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
                "Bearer sk_test_51P7AaADutM4FFoVzElNAPzcd7LeAqWG1Mkit4fgFSAPY7ra1encAt4Z4U3Ig4fcV6xjjGzRPwcHc0jNRFSUYicT100jgPGf1Po",
            "Content-Type": "application/x-www-form-urlencoded"
          });
      if (context.mounted) {
        BlocProvider.of<LoadingCubit>(context).setLoading(false);
      }
      // if (response.statusCode == 200) {
      //   if (context.mounted) {
      //     BlocProvider.of<LoadingCubit>(context).setLoading(false);
      //     messageWidget(
      //         context: context,
      //         isError: false,
      //         message: "Payment Paid Successfully");
      //   }
      // }
      return json.decode(response.body);
    } catch (error) {
      if (context.mounted) {
        BlocProvider.of<LoadingCubit>(context).setLoading(false);
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
    }

    if (context.mounted) {
      BlocProvider.of<LoadingCubit>(context).setLoading(false);
    }
  }
}
