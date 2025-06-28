import 'package:flowapp/commoms/app_dimensions.dart';
import 'package:flowapp/commoms/navigator_key.dart';
import 'package:flutter/material.dart';

final BuildContext context = navigatorKey.currentContext as BuildContext;

// Height Gap Healper

SizedBox gapH([double gap = 0.01]) {
  return SizedBox(
    height: context.screenHeight * gap,
  );
}

// Width Gap Healper

SizedBox gapW([double gap = 0.03]) {
  return SizedBox(
    width: context.screenWidth * gap,
  );
}
