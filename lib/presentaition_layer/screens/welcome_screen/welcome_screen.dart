import 'package:flowapp/commoms/commons.dart';
import 'package:flowapp/commoms/gaps.dart';
import 'package:flowapp/constants/colors.dart';
import 'package:flowapp/constants/paths.dart';
import 'package:flowapp/constants/texts.dart';
import 'package:flowapp/presentaition_layer/screens/user_detials/user_detials_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              Paths.welcomeImg,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            child: Column(
              children: <Widget>[
                gapH(0.08),
                const Text(
                  appTitle,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
                const Expanded(child: SizedBox()),
                const Text(
                  welcomText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.whiteColor,
                  ),
                ),
                gapH(0.02),
                MainButton(
                  lable: "Order Food",
                  onClick: () {
                    pushTo(target: const UserDetialsScreen());
                  },
                ),
                gapH(0.03),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
