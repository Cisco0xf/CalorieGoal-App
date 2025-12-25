import 'dart:developer';

import 'package:flowapp/commoms/commons.dart';
import 'package:flowapp/presentaition_layer/screens/categories/products_screen.dart';
import 'package:flowapp/state_management_layer/manage_user_detials/user_gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaloriesCalculate extends Notifier<double> {
  @override
  double build() => 0.0;

  TextEditingController? heightController;
  TextEditingController? weightController;
  TextEditingController? ageController;

  void get initalizeControllers {
    heightController = TextEditingController();
    weightController = TextEditingController();
    ageController = TextEditingController();
  }

  void get disposeControllers {
    heightController!.dispose();
    weightController!.dispose();
    ageController!.dispose();
  }

  bool get isGoodToGo {
    final bool hasGender = ref.read(genderProvider.notifier).hasValue;
    final bool hasAge = ageController!.text.trim().isNotEmpty;
    final bool hasWeight = weightController!.text.trim().isNotEmpty;
    final bool hasHeight = heightController!.text.trim().isNotEmpty;

    log("HasAge : $hasAge || HasHeight : $hasHeight || HasWeight : $hasWeight || HasGender : $hasGender");

    bool isGood = hasGender && hasAge && hasHeight && hasWeight;

    return isGood;
  }

  int get _age {
    final String age = ageController!.text.trim();

    final int cAge = int.parse(age);

    return cAge;
  }

  int get _height {
    final String height = heightController!.text.trim();

    final int cHeight = int.parse(height);

    return cHeight;
  }

  double get _weight {
    final String weight = weightController!.text.trim();

    final double cWeight = double.parse(weight);
    return cWeight;
  }

  void get calculateUserCalories {
    if (!isGoodToGo) {
      showToastification(
        msg: "Please enter a required data",
      );
      return;
    }

    final Gender gender = ref.read(genderProvider.notifier).gender;

    /// Male, 190 cm, 90 kg, 40 year => 3,121.93 calories

    try {
      if (gender == Gender.male) {
        final double weightCalc = 13.75 * _weight;
        final double heightCalc = (5 * _height).toDouble();
        final double ageCalc = 6.75 * _age;

        state = 666.47 + weightCalc + heightCalc - ageCalc;

        log("Genger : Male | Age : $_age | Height : $_height | Weight : $_weight");
        log("Calculated Calories : $state");
      } else {
        final double weightCalc = 9.56 * _weight;
        final double heightCalc = 1.85 * _height;
        final double ageCalc = 4.67 * _age;

        state = (655.1 + weightCalc + heightCalc) - ageCalc;

        log("Genger : Female | Age : $_age | Height : $_height | Weight : $_weight");
        log("Calculated Calories : $state");
      }

      pushTo(target: const ProductsScreen());
    } catch (error) {
      log("Error while calcualtion : $error");

      showToastification(msg: "Please chack the inserted Data");
    }
  }

  double get userCalories => state;
}

final caloriesProvider = NotifierProvider<CaloriesCalculate, double>(
  CaloriesCalculate.new,
);
