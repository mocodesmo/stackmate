import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

extension ContextUtils on BuildContext {
  ColorScheme get colours => Theme.of(this).colorScheme;
  TextTheme get fonts => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  AppLocalizations get word => AppLocalizations.of(this);
}

extension Strings on String {
  String notLocalised() {
    //print('"' + this + '" not localised');
    return this;
  }

  String printForDebug() {
    print('STRING:: ' + this);
    return this;
  }

  String? nullIfEmpty() {
    if (this == '') return null;
    return this;
  }

  bool not(String other) {
    return this != other;
  }
}

extension Bools on bool {
  bool not(bool other) {
    return this != other;
  }
}

extension Nums on num {
  bool not(num other) {
    return this != other;
  }
}

extension Ints on int? {
  String toBtc() => this == null ? '0' : (this! / 100000000).toStringAsFixed(8);
}

class CCC {}
