import 'package:flowapp/commoms/app_dimensions.dart';
import 'package:flowapp/commoms/commons.dart';
import 'package:flowapp/commoms/gaps.dart';
import 'package:flowapp/constants/colors.dart';
import 'package:flowapp/data_layer/models/product_model.dart';
import 'package:flowapp/presentaition_layer/screens/order_sammury/cart_screen.dart';
import 'package:flowapp/state_management_layer/order_sammury/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodCategory extends ConsumerStatefulWidget {
  const FoodCategory({
    super.key,
    required this.foodData,
    required this.foodType,
  });

  final String foodType;
  final List<ProductModel> foodData;

  @override
  ConsumerState<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends ConsumerState<FoodCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            gapW(0.03),
            Text(
              widget.foodType,
              style: const TextStyle(
                fontSize: 20,
                color: AppColors.mainTextColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 220,
          width: context.screenWidth,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.foodData.length,
            itemBuilder: (context, index) {
              final List<ProductModel> cartList = ref.watch(cartProvider);

              final int targetIndex = cartList.indexWhere(
                (ProductModel item) {
                  return widget.foodData[index].name == item.name;
                },
              );

              final ProductModel catchedProduct = targetIndex != -1
                  ? cartList[targetIndex]
                  : widget.foodData[index];

              final int targetQnt = catchedProduct.quantity;

              return FoodItem(
                product: widget.foodData[index],
                isInCart: targetIndex != -1,
                targetQuantity: targetQnt,
              );
            },
          ),
        ),
      ],
    );
  }
}

class FoodItem extends ConsumerWidget {
  const FoodItem({
    super.key,
    required this.product,
    required this.isInCart,
    required this.targetQuantity,
  });

  final ProductModel product;
  final bool isInCart;
  final int targetQuantity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: padding(10.0),
      margin: padding(10.0),
      width: 183,
      decoration: BoxDecoration(
        borderRadius: borderRadius(12.0),
        color: AppColors.whiteColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 5.0,
            spreadRadius: 0.05,
            color: Colors.grey.shade400,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 108,
            width: 163,
            child: ClipRRect(
              borderRadius: borderRadius(10.0),
              child: Image.network(
                product.imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.mainTextColor,
                ),
              ),
              Text(
                "${product.calories} cal",
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.subTextColor,
                ),
              ),
            ],
          ),
          gapH(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("\$ 12"),
              isInCart
                  ? QuantityController(
                      onIncrease: () {
                        ref
                            .read(cartProvider.notifier)
                            .increaseFoodQnt(cartItem: product);
                      },
                      onDecrease: () {
                        ref
                            .read(cartProvider.notifier)
                            .decreaseFoodQnt(cartItem: product);
                      },
                      target: targetQuantity,
                    )
                  : MainButton(
                      lable: "Add",
                      onClick: () {
                        ref.read(cartProvider.notifier).addFoodToCart(
                              product: product,
                            );
                      },
                      height: context.screenHeight * .05,
                      width: context.screenWidth * .25,
                    )
            ],
          )
        ],
      ),
    );
  }
}
