import 'package:flowapp/commoms/app_dimensions.dart';
import 'package:flowapp/commoms/commons.dart';
import 'package:flowapp/commoms/gaps.dart';
import 'package:flowapp/constants/colors.dart';
import 'package:flowapp/state_management_layer/manage_user_detials/user_detials.dart';
import 'package:flowapp/state_management_layer/order_sammury/cart.dart';
import 'package:flowapp/state_management_layer/order_sammury/post_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinishOrder extends ConsumerWidget {
  const FinishOrder({super.key});

  TextStyle get _textStyle {
    return const TextStyle(
      fontSize: 16,
      color: AppColors.subTextColor,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String totalConst = ref.read(cartProvider.notifier).calculatePrice;
    final String calculatedCalories =
        ref.read(cartProvider.notifier).calculatedCalories.toStringAsFixed(2);
    final String calories = ref.watch(caloriesProvider).toStringAsFixed(2);

    ref.watch(cartProvider);

    final bool isLoading = ref.watch(confrimProivder);

    return Container(
      height: context.screenHeight * .2,
      padding: padding(10.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
        color: AppColors.fillColor,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Cal",
                style: _textStyle,
              ),
              Text(
                "$calculatedCalories cal out of $calories cal",
                style: _textStyle,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Price",
                style: _textStyle,
              ),
              Text(
                "\$ $totalConst",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          gapH(0.02),
          MainButton(
            lable: "Confirm",
            hasLoading: isLoading,
            onClick: () async {
              await ref.read(confrimProivder.notifier).postConfirmation;
            },
          ),
        ],
      ),
    );
  }
}
