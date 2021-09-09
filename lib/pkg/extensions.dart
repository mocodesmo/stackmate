import 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension contextUtils on BuildContext {
  ColorScheme get colours => Theme.of(this).colorScheme;
  TextTheme get fonts => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  AppLocalizations get word => AppLocalizations.of(this);
}

extension strings on String {
  String notLocalised() {
    //print('"' + this + '" not localised');
    return this;
  }

  String printForDebug() {
    print('STRING:: ' + this);
    return this;
  }

  String? nullIfEmpty() {
    if (this == "") return null;
    return this;
  }

  bool not(String other) {
    return this != other;
  }
}

extension bools on bool {
  bool not(bool other) {
    return this != other;
  }
}

extension nums on num {
  bool not(num other) {
    return this != other;
  }
}

class CCC {}
