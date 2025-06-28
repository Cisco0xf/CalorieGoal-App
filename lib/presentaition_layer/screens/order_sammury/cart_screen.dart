import 'package:flowapp/commoms/app_dimensions.dart';
import 'package:flowapp/commoms/commons.dart';
import 'package:flowapp/commoms/gaps.dart';
import 'package:flowapp/constants/colors.dart';
import 'package:flowapp/data_layer/models/product_model.dart';
import 'package:flowapp/presentaition_layer/screens/order_sammury/finish_order.dart';
import 'package:flowapp/state_management_layer/order_sammury/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ProductModel> cartItems = ref.watch(cartProvider);
    return Scaffold(
      appBar: const MainAppBAr(title: "Order Sammury"),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return CartItemWidget(
            cartItem: cartItems[index],
          );
        },
      ),
      bottomNavigationBar: const FinishOrder(),
    );
  }
}

class CartItemWidget extends ConsumerWidget {
  const CartItemWidget({
    super.key,
    required this.cartItem,
  });

  final ProductModel cartItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: padding(10.0),
      margin: padding(10.0),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: borderRadius(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            height: 62,
            width: 76,
            child: Image.network(cartItem.imagePath),
          ),
          SizedBox(
            width: 221,
            height: context.screenHeight * .1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      cartItem.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainTextColor,
                      ),
                    ),
                    const Text(
                      "\$ 12",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${cartItem.calories} cal",
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.subTextColor,
                      ),
                    ),
                    QuantityController(
                      onIncrease: () {
                        ref
                            .read(cartProvider.notifier)
                            .increaseFoodQnt(cartItem: cartItem);
                      },
                      onDecrease: () {
                        ref
                            .read(cartProvider.notifier)
                            .decreaseFoodQnt(cartItem: cartItem);
                      },
                      target: cartItem.quantity,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuantityController extends StatelessWidget {
  const QuantityController({
    super.key,
    required this.onDecrease,
    required this.onIncrease,
    required this.target,
  });

  final void Function() onIncrease;
  final void Function() onDecrease;

  final int target;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: AppColors.buttonsColor,
          child: Clicker(
            onClick: onDecrease,
            isCircular: true,
            child: const Icon(Icons.remove),
          ),
        ),
        gapW(0.02),
        Text(
          "$target",
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        gapW(0.02),
        CircleAvatar(
          backgroundColor: AppColors.buttonsColor,
          child: Clicker(
            onClick: onIncrease,
            isCircular: true,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
