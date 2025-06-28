import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserGender extends Notifier<Gender?> {
  @override
  Gender? build() => null;

  void catchSelectedGender({required Gender gender}) {
    state = gender;

    log("Selected GEnder :$gender");
  }

  bool get isMeal => state == Gender.male;

  String get currentGender {
    if (isMeal) {
      return "Meal";
    }

    return "Female";
  }

  bool get hasValue => state != null;

  Gender get gender => state as Gender;
}

enum Gender {
  male,
  female,
}

final genderProvider = NotifierProvider<UserGender, Gender?>(
  UserGender.new,
);
