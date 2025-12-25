import 'package:flowapp/commoms/app_dimensions.dart';
import 'package:flowapp/commoms/commons.dart';
import 'package:flowapp/commoms/gaps.dart';
import 'package:flowapp/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetialsField extends StatelessWidget {
  const DetialsField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.sufLable,
    required this.title,
    this.type = TextInputType.number,
  });
  final TextEditingController controller;
  final String hintText;
  final TextInputType type;
  final String sufLable;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(width: 15.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.subTextColor,
              ),
            )
          ],
        ),
        const Gap(hRatio: 0.01),
        Padding(
          padding: padding(15.0, isH: true),
          child: SizedBox(
            height: context.screenHeight * .07,
            child: TextFormField(
              keyboardType: type,
              controller: controller,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(10),
              ],
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadius(12.0),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadius(12.0),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                    width: 2.0,
                  ),
                ),
                filled: true,
                fillColor: AppColors.whiteColor,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.hintTextColor,
                ),
                suffixIcon: Container(
                  alignment: Alignment.center,
                  width: context.screenWidth * .1,
                  child: Text(
                    sufLable,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
