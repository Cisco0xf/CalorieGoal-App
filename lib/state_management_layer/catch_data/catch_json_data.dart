import 'dart:convert';
import 'dart:developer';

import 'package:flowapp/data_layer/models/product_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatchJsonData {
  Future<List<ProductModel>?> foodList({required String foodType}) async {
    try {
      final String localePath = "assets/categories/$foodType.json";

      final String loadedData = await rootBundle.loadString(localePath);

      final List<dynamic> data = json.decode(loadedData);

      final List<ProductModel> targetData = [
        for (int i = 0; i < data.length; i++) ...{
          ProductModel.fromJson(json: data[i] as Map<String, dynamic>),
        }
      ];

      debugData(
        target: targetData,
        type: foodType,
      );

      return targetData;
    } catch (error) {
      log("Error while catch json data : $error");
    }

    return null;
  }

  void debugData({required List<ProductModel> target, required String type}) {
    log("*" * 50);
    log("${"*" * 25} Json Data from $type  ${"*" * 25}");
    log("*" * 50);

    log("Number of Catched Items :${target.length}");

    for (int i = 0; i < target.length; i++) {
      log("Food Item Name : ${target[i].name}");
      log("Food Item Calories : ${target[i].calories}");
      log("*" * 50);
    }
  }
}

final jsonProvider = Provider<CatchJsonData>((ref) => CatchJsonData());
