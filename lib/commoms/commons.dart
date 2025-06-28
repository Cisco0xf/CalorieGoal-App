import 'package:flowapp/commoms/app_dimensions.dart';
import 'package:flowapp/commoms/gaps.dart';
import 'package:flowapp/commoms/navigator_key.dart';
import 'package:flowapp/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

BorderRadius borderRadius([double radius = 15.0]) {
  return BorderRadius.circular(radius);
}

EdgeInsetsGeometry padding(
  double padding, {
  bool isV = false,
  bool isH = false,
}) {
  if (isV) {
    return EdgeInsets.symmetric(vertical: padding);
  }
  if (isH) {
    return EdgeInsets.symmetric(horizontal: padding);
  }

  return EdgeInsets.all(padding);
}

// Button

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.lable,
    required this.onClick,
    this.width,
    this.height,
    this.isActive = true,
    this.hasLoading = false,
  });
  final void Function() onClick;
  final String lable;
  final double? width;
  final double? height;

  final bool isActive;
  final bool hasLoading;

  double get _width =>
      width == null ? context.screenWidth * .8 : width as double;
  double get _height =>
      width == null ? context.screenHeight * .07 : height as double;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: MaterialButton(
        onPressed: onClick,
        color: isActive ? AppColors.buttonsColor : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius(12.0),
        ),
        child: hasLoading
            ? const CircularProgressIndicator()
            : Text(
                lable,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.whiteColor,
                ),
              ),
      ),
    );
  }
}

// AppBar

class MainAppBAr extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(height);

  const MainAppBAr({
    super.key,
    required this.title,
    this.height = 80,
  });

  final String title;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const PopButton(),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.whiteColor,
      toolbarHeight: height,
      scrolledUnderElevation: 0.0,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          color: AppColors.mainTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PopButton extends StatelessWidget {
  const PopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            popRoute();
          },
          borderRadius: borderRadius(10.0),
          child: Padding(
            padding: padding(5.0),
            child: const Icon(
              Icons.arrow_left_outlined,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }
}

// Push navigation

void pushTo({required Widget target}) {
  final BuildContext context = navigatorKey.currentContext as BuildContext;

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return target;
      },
    ),
  );
}

// POp Screen

void popRoute({final bool clearBack = false, Widget? newRout}) {
  if (clearBack) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return newRout as Widget;
        },
      ),
      (route) => false,
    );
  } else {
    Navigator.of(context).pop();
  }
}

/// Create Toastificaton

void showToastification({
  required String msg,
  int duration = 3000,
  ToastificationType type = ToastificationType.info,
}) {
  final BuildContext context = navigatorKey.currentContext as BuildContext;

  toastification.show(
    context: context,
    description: Text(
      msg,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    applyBlurEffect: true,
    animationDuration: const Duration(milliseconds: 350),
    autoCloseDuration: Duration(milliseconds: duration),
    padding: padding(5.0),
    showProgressBar: false,
    type: type,
    closeButtonShowType: CloseButtonShowType.none,
  );
}

// Custom Clicker

class Clicker extends StatelessWidget {
  const Clicker({
    super.key,
    required this.onClick,
    this.isCircular = false,
    this.outterpadding = 0.0,
    this.inerPadding = 0.0,
    this.radius = 10.0,
    this.child,
  });

  final void Function() onClick;
  final double outterpadding;
  final double inerPadding;

  final Widget? child;

  final bool isCircular;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding(outterpadding),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onClick,
          borderRadius: isCircular ? null : borderRadius(radius),
          customBorder: isCircular ? const CircleBorder() : null,
          child: Padding(
            padding: padding(inerPadding),
            child: child,
          ),
        ),
      ),
    );
  }
}
