import 'package:flowapp/commoms/app_dimensions.dart';
import 'package:flutter/material.dart';
/* 
final BuildContext context = navigatorKey.currentContext as BuildContext;

// Height Gap Healper

SizedBox Gap(hRatio: [double gap = 0.01]) {
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
 */

class Gap extends StatelessWidget {
  const Gap({
    super.key,
    this.hRatio,
    this.height,
    this.wRatio,
    this.width,
  });

  final double? width;
  final double? height;
  final double? hRatio;
  final double? wRatio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hRatio != null ? context.screenHeight * hRatio! : height,
      width: wRatio != null ? context.screenWidth * wRatio! : width,
    );
  }
}
