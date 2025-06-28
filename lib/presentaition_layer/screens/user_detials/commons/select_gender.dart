import 'package:flowapp/commoms/app_dimensions.dart';
import 'package:flowapp/commoms/commons.dart';
import 'package:flowapp/commoms/gaps.dart';
import 'package:flowapp/commoms/navigator_key.dart';
import 'package:flowapp/constants/colors.dart';
import 'package:flowapp/constants/texts.dart';
import 'package:flowapp/state_management_layer/manage_user_detials/user_gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectGender extends ConsumerWidget {
  const SelectGender({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Gender? currentGender = ref.watch(genderProvider);

    return Column(
      children: [
        gapH(0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            gapW(0.05),
            const Text(
              "Gender",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.subTextColor,
              ),
            ),
          ],
        ),
        gapH(),
        SizedBox(
          width: context.screenWidth * .9,
          child: ButtonTheme(
            alignedDropdown: true,
            padding: padding(0.0),
            child: DropdownButtonFormField<Gender?>(
              value: currentGender,
              padding: padding(0.0),
              decoration: InputDecoration(
                fillColor: AppColors.whiteColor,
                filled: true,
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
                    width: 1.0,
                  ),
                ),
              ),
              hint: const Text(gender),
              borderRadius: borderRadius(12.0),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              items: <DropdownMenuItem<Gender?>>[
                for (int i = 0; i < Gender.values.length; i++) ...{
                  DropdownMenuItem<Gender?>(
                    value: Gender.values[i],
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: borderRadius(10.0),
                        color: currentGender == Gender.values[i]
                            ? Colors.red.withOpacity(0.1)
                            : null,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            Gender.values[i] == Gender.male ? "Male" : "Female",
                          ),
                        ],
                      ),
                    ),
                  ),
                }
              ],
              onChanged: (Gender? target) {
                ref.read(genderProvider.notifier).catchSelectedGender(
                      gender: target!,
                    );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CustomGenderSelector extends ConsumerStatefulWidget {
  const CustomGenderSelector({super.key});

  @override
  ConsumerState<CustomGenderSelector> createState() =>
      _CustomGenderSelectorState();
}

class _CustomGenderSelectorState extends ConsumerState<CustomGenderSelector> {
  Gender? get currentGender => ref.watch(genderProvider);

  String get currentLable {
    switch (currentGender) {
      case null:
        {
          return gender;
        }
      case Gender.male:
        {
          return "Male";
        }

      case Gender.female:
        {
          return "Female";
        }

      default:
        {
          return "Can not catch";
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        gapH(0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            gapW(0.05),
            const Text(
              "Gender",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.subTextColor,
              ),
            ),
          ],
        ),
        gapH(),
        Container(
          margin: padding(10.0),
          width: context.screenWidth * .9,
          decoration: BoxDecoration(
            borderRadius: borderRadius(12.0),
            color: AppColors.whiteColor,
            border: Border.all(
              color: AppColors.borderColor,
              width: 1.2,
            ),
          ),
          child: Clicker(
            radius: 12.0,
            inerPadding: 5.0,
            outterpadding: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  currentLable,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: currentGender == null ? null : FontWeight.bold,
                    color:
                        currentGender == null ? AppColors.hintTextColor : null,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
            onClick: () async {
              await _showGenderMenue(
                targetContext: context,
                currentGender: currentGender,
                ref: ref,
              );
            },
          ),
        ),
      ],
    );
  }
}

Future<void> _showGenderMenue({
  required BuildContext targetContext,
  required Gender? currentGender,
  required WidgetRef ref,
}) async {
  final BuildContext context = navigatorKey.currentContext as BuildContext;

  final RenderBox renderBox = targetContext.findRenderObject() as RenderBox;

  final Offset position = renderBox.localToGlobal(Offset.zero);

  await showMenu(
    context: context,
    constraints: BoxConstraints(
      minWidth: targetContext.screenWidth * .9,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius(12.0),
    ),
    color: AppColors.whiteColor,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy + 110,
      0.0,
      0.0,
    ),
    popUpAnimationStyle: AnimationStyle(),
    items: <PopupMenuEntry>[
      for (int i = 0; i < Gender.values.length; i++) ...{
        PopupMenuItem(
          child: SizedBox(
            width: context.screenWidth * .9,
            child: MenueItem(
              isSelected:
                  Gender.values[i] == currentGender && currentGender != null,
              genderType: Gender.values[i] == Gender.male ? "Male" : "Female",
              onSelect: () {
                ref.read(genderProvider.notifier).catchSelectedGender(
                      gender: Gender.values[i],
                    );
                popRoute();
              },
            ),
          ),
        ),
      }
    ],
  );
}

class MenueItem extends StatelessWidget {
  const MenueItem({
    super.key,
    required this.isSelected,
    required this.genderType,
    required this.onSelect,
  });

  final bool isSelected;
  final String genderType;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding(8.0),
      decoration: BoxDecoration(
        borderRadius: borderRadius(10.0),
        color: isSelected ? Colors.red.withOpacity(0.3) : null,
      ),
      child: Clicker(
        onClick: onSelect,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              genderType,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            ),
            if (isSelected) ...{
              const Icon(Icons.done),
            } else ...{
              const SizedBox(),
            }
          ],
        ),
      ),
    );
  }
}
