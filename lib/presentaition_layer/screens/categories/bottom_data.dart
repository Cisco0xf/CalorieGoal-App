import 'dart:developer';

import 'package:flowapp/commoms/app_dimensions.dart';
import 'package:flowapp/commoms/commons.dart';
import 'package:flowapp/commoms/gaps.dart';
import 'package:flowapp/constants/colors.dart';
import 'package:flowapp/presentaition_layer/screens/order_sammury/cart_screen.dart';
import 'package:flowapp/state_management_layer/manage_user_detials/user_detials.dart';
import 'package:flowapp/state_management_layer/order_sammury/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceOrder extends ConsumerWidget {
  const PlaceOrder({super.key});

  TextStyle get _textStyle {
    return const TextStyle(
      fontSize: 16,
      color: AppColors.subTextColor,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double userCalories = ref.watch(caloriesProvider);

    final String calculatedCalories =
        ref.read(cartProvider.notifier).calculatedCalories.toStringAsFixed(2);

    final bool isButtonActive = ref.read(cartProvider.notifier).isButtonActive;

    //    final String calories = userCalories.toStringAsFixed(2);

    final String totalPrice = ref.read(cartProvider.notifier).calculatePrice;

    ref.watch(cartProvider);
    return Container(
      height: context.screenHeight * .2,
      padding: padding(15.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
        color: AppColors.fillColor,
      ),
      child: Column(
        children: <Widget>[
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: userCalories),
            duration: const Duration(milliseconds: 600),
            builder: (context, calories, _) {
              final String txtCalories = calories.toStringAsFixed(2);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Cal",
                    style: _textStyle,
                  ),
                  Text(
                    "$calculatedCalories cal out of $txtCalories cal",
                    style: _textStyle,
                  ),
                ],
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Price",
                style: _textStyle,
              ),
              Text(
                "\$ $totalPrice",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          gapH(0.02),
          Opacity(
            opacity: isButtonActive ? 1.0 : 0.7,
            child: MainButton(
              lable: "Place Order",
              isActive: isButtonActive,
              onClick: () {
                if (!isButtonActive) {
                  log("Button is not Active");
                  return;
                }
                pushTo(target: const CartScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
