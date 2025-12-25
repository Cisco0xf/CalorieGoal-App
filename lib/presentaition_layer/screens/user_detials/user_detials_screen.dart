import 'package:flowapp/commoms/commons.dart';
import 'package:flowapp/commoms/gaps.dart';
import 'package:flowapp/constants/texts.dart';
import 'package:flowapp/presentaition_layer/screens/user_detials/commons/detials_field.dart';
import 'package:flowapp/presentaition_layer/screens/user_detials/commons/select_gender.dart';
import 'package:flowapp/state_management_layer/manage_user_detials/user_detials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetialsScreen extends ConsumerStatefulWidget {
  const UserDetialsScreen({super.key});

  @override
  ConsumerState<UserDetialsScreen> createState() => _UserDetialsScreenState();
}

class _UserDetialsScreenState extends ConsumerState<UserDetialsScreen> {
  late CaloriesCalculate caloriesCalc;
  @override
  void initState() {
    caloriesCalc = ref.read(caloriesProvider.notifier);
    caloriesCalc.initalizeControllers;
    super.initState();
  }

  @override
  void dispose() {
    caloriesCalc.disposeControllers;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBAr(title: detials),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /* const SelectGender(),
            Gap(hRatio: 0.05), */
            const CustomGenderSelector(),
            const Gap(hRatio: 0.03),
            DetialsField(
              controller: caloriesCalc.weightController!,
              hintText: weight,
              sufLable: "KG",
              title: "Weight",
            ),
            const Gap(hRatio: 0.03),
            DetialsField(
              controller: caloriesCalc.heightController!,
              hintText: height,
              sufLable: "CM",
              title: "Height",
            ),
           const  Gap(hRatio: 0.03),
            DetialsField(
              controller: caloriesCalc.ageController!,
              hintText: age,
              sufLable: "",
              title: "Age",
              type: TextInputType.number,
            ),
            const Gap(hRatio: 0.15),
            MainButton(
              lable: "Next",
              onClick: () {
                caloriesCalc.calculateUserCalories;
              },
            ),
            const Gap(hRatio: 0.03),
          ],
        ),
      ),
    );
  }
}
