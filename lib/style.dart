import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData mainTheme() => ThemeData(
      textTheme: GoogleFonts.latoTextTheme(),
      colorScheme: ColorScheme(
        primary: Colors.orange[400]!,
        primaryVariant: Color(0xFF0745ff),
        secondary: Color(0xFF13161f),
        secondaryVariant: Color(0xFF87888a),
        surface: Colors.blue.withOpacity(0.1),
        background: Color(0xFF13161f),
        error: Color(0xFFff0000),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white.withOpacity(0.8),
        onBackground: Colors.white.withOpacity(0.8),
        onError: Colors.white,
        brightness: Brightness.light,
      ),
    );

ThemeData derivedTheme(ThemeData theme) {
  return theme.copyWith(
    scaffoldBackgroundColor: Color(0xFF13161f),
    //Colors.blue[50], //_background,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: theme.colorScheme.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          width: 1,
          color: theme.colorScheme.secondary.withAlpha(26),
        ),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
              width: 1, color: theme.colorScheme.secondary.withAlpha(26))),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(width: 1, color: Color(0xFFff9500))),
      errorStyle: TextStyle(color: Color(0xFFff9500)),
      filled: true,
      fillColor: theme.colorScheme.onBackground,
      focusColor: theme.colorScheme.onBackground ,
    ),
  );
}

// BoxLooseDecoration pinInputDecoration = BoxLooseDecoration(
//   obscureStyle: ObscureStyle(obscureText: '*', isTextObscure: true),
//   bgColorBuilder:
//       PinListenColorBuilder(Colors.pink, Colors.purple), //_white, _white),
//   strokeColorBuilder:
//       PinListenColorBuilder(_secondary.withAlpha(0), _textfieldBorder),
//   radius: Radius.circular(2),
// );

Widget buttonToLoaderTransition({
  required Widget child,
  required Animation<double> animation,
}) =>
    FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: child,
        ));
