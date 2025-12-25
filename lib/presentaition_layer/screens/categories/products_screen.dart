import 'dart:async';

import 'package:flowapp/commoms/commons.dart';
import 'package:flowapp/commoms/gaps.dart';
import 'package:flowapp/data_layer/product_model.dart';
import 'package:flowapp/presentaition_layer/screens/categories/bottom_data.dart';
import 'package:flowapp/presentaition_layer/screens/categories/food_item_screen.dart';
import 'package:flowapp/state_management_layer/catch_data/catch_json_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  late CatchJsonData foodData;

  late Future<List<List<ProductModel>?>> allData;

  @override
  void initState() {
    foodData = ref.read(jsonProvider);

    allData = Future.wait(
      [
        foodData.foodList(foodType: "vegetables"),
        foodData.foodList(foodType: "meat"),
        foodData.foodList(foodType: "carbs"),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBAr(title: "Create your order"),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: allData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: Text("Error"),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }

            return Column(
              children: <Widget>[
                FoodCategory(
                  foodData: snapshot.data![0]!,
                  foodType: "Vegetables",
                ),
                FoodCategory(
                  foodData: snapshot.data![1]!,
                  foodType: "Meat",
                ),
                FoodCategory(
                  foodData: snapshot.data![2]!,
                  foodType: "Carbs",
                ),
                const Gap(hRatio: 0.03),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const PlaceOrder(),
    );
  }
}
