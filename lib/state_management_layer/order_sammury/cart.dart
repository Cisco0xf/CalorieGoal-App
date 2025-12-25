import 'dart:developer';

import 'package:flowapp/commoms/commons.dart';
import 'package:flowapp/data_layer/models/product_model.dart';
import 'package:flowapp/state_management_layer/manage_user_detials/user_detials.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Cart extends StateNotifier<List<ProductModel>> {
  Cart({required this.ref}) : super(<ProductModel>[]);

  final Ref ref;

  void addFoodToCart({required ProductModel product}) {
    final bool isExistInCart = state.any((item) => product.name == item.name);

    if (isExistInCart) {
      log("Item Already Exist in cart");
      removeFoodFromCart(cartItem: product);
      return;
    }

    log("New Item added to cart : ${product.name}");

    state = <ProductModel>[...state, product];

    showToastification(msg: "Item has beed added to cart");
  }

  void removeFoodFromCart({
    required ProductModel cartItem,
  }) {
    state = <ProductModel>[
      for (int i = 0; i < state.length; i++) ...{
        if (state[i].name != cartItem.name) ...{
          state[i],
        }
      }
    ];

    showToastification(msg: "Item has been remove from cart");

    log("Item : ${cartItem.name} has been removed from cart");
  }

  void increaseFoodQnt({required ProductModel cartItem}) {
    state = <ProductModel>[
      for (int c = 0; c < state.length; c++) ...{
        if (state[c].name == cartItem.name) ...{
          cartItem.copyWith(quantity: state[c].quantity + 1)
        } else ...{
          state[c],
        }
      }
    ];
  }

  void decreaseFoodQnt({required ProductModel cartItem}) {
    state = <ProductModel>[
      for (int r = 0; r < state.length; r++) ...{
        if (state[r].name == cartItem.name && state[r].quantity > 1) ...{
          cartItem.copyWith(quantity: state[r].quantity - 1)
        } else ...{
          state[r],
        }
      }
    ];
  }

  void get clearCart {
    state = <ProductModel>[];
  }

  double get calculatedCalories {
    double calories = 0.0;

    for (int i = 0; i < state.length; i++) {
      calories += state[i].calories * state[i].quantity;
    }

    log("Selected Products Calories : $calories");

    return calories;
  }

  bool get isButtonActive {
    final double userCalories =
        ref.read(caloriesProvider.notifier).userCalories;

    final double underTenP = (10 / 100) * userCalories;

    log("10 % of user calories : $underTenP");

    final bool isActive = calculatedCalories >= (userCalories - underTenP);

    return isActive;
  }

  String get calculatePrice {
    double price = 0.0;

    for (int p = 0; p < state.length; p++) {
      price += 12 * state[p].quantity;
    }

    final String priceTxt = price.toStringAsFixed(2);

    return priceTxt;
  }

  List<ProductModel> get cartData => state;
}

final cartProvider =
    StateNotifierProvider<Cart, List<ProductModel>>((ref) => Cart(ref: ref));
