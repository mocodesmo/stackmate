import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

const Color _background = Color(0xFFf3f6f9);
final Color _primary = Colors.orange[400]!;
// Color(0xFFff9500).withAlpha(165);
const Color _secondary = Color(0xFF13161f);
final Color _textfieldBorder = _secondary.withAlpha(26);
const Color _white = Color(0xFFFFFFFF);
const Color fullOrange = Color(0xFFff9500);

ThemeData mainTheme() => ThemeData(
    textTheme: GoogleFonts.latoTextTheme(),
    colorScheme: ColorScheme(
      primary: _primary,
      primaryVariant: Color(0xFF0745ff),
      secondary: Color(0xFF13161f),
      secondaryVariant: Color(0xFF87888a),
      surface: _white,
      background: _background,
      error: Color(0xFFff0000),
      onPrimary: Color(0xFF13161f),
      onSecondary: _white,
      onSurface: Color(0xFF13161f),
      onBackground: Color(0xFF13161f),
      onError: _white,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Color(0xFF13161f),
    //Colors.blue[50], //_background,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(width: 1, color: _textfieldBorder)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(width: 1, color: _textfieldBorder)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(width: 1, color: Color(0xFFff9500))),
        errorStyle: TextStyle(color: Color(0xFFff9500)),
        filled: true,
        fillColor: _white,
        focusColor: _white));

BoxLooseDecoration pinInputDecoration = BoxLooseDecoration(
  obscureStyle: ObscureStyle(obscureText: '*', isTextObscure: true),
  bgColorBuilder:
      PinListenColorBuilder(Colors.pink, Colors.purple), //_white, _white),
  strokeColorBuilder:
      PinListenColorBuilder(_secondary.withAlpha(0), _textfieldBorder),
  radius: Radius.circular(2),
);

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
