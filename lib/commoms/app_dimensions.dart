import 'package:flutter/material.dart';

extension AppDimensions on BuildContext {
  double get screenHeight {
    final double height = MediaQuery.sizeOf(this).height;

    return height;
  }

  double get screenWidth {
    final double width = MediaQuery.sizeOf(this).width;

    return width;
  }
}
