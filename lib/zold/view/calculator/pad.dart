import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/pkg/validation.dart';
import 'package:sats/cubit/rates/calculator.dart';

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  //static Widget _w = SizedBox(width: 4);
  static Widget _h = SizedBox(height: 4);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _h,
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        //_w,
        CalcKey(text: 'C'),
        //_w,
        CalcKey(text: 'del'),
        //_w,
        CalcKey(text: '1'),
        //_w,
        CalcKey(text: '2'),
        //_w,
        CalcKey(text: '3'),
        //_w,
      ]),
      _h,
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        //_w,
        CalcKey(text: '('),
        //_w,
        CalcKey(text: ')'),
        //_w,
        CalcKey(text: '4'),
        //_w,
        CalcKey(text: '5'),
        //_w,
        CalcKey(text: '6'),
        //_w,
      ]),
      _h,
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        //_w,
        CalcKey(text: '+'),
        //_w,
        CalcKey(text: '-'),
        //_w,
        CalcKey(text: '7'),
        //_w,
        CalcKey(text: '8'),
        //_w,
        CalcKey(text: '9'),
        //_w,
      ]),
      _h,
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        //_w,
        CalcKey(text: 'x'),
        //_w,
        CalcKey(text: '/'),
        //_w,
        CalcKey(text: '.'),
        //_w,
        CalcKey(text: '='),
        //_w,
        CalcKey(text: '0'),
        //_w,
      ]),
      SizedBox(height: 200)
    ]);
  }
}

class CalcKey extends StatefulWidget {
  const CalcKey({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  _CalcKeyState createState() => _CalcKeyState();
}

class _CalcKeyState extends State<CalcKey> {
  double _elevation = 2.0;

  @override
  Widget build(BuildContext c) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _elevation = 0;
        });
      },
      onTapUp: (details) {
        setState(() {
          _elevation = 2;
        });
      },
      onTapCancel: () {
        setState(() {
          _elevation = 0;
        });
      },
      onTap: () {
        c.read<CalculatorCubit>().calcKeyPressed(widget.text);
      },
      child: Container(
        width: (c.width / 5) - 5,
        height: (c.width / 5) - 5,
        child: Material(
          elevation: _elevation,
          color: Validation.isNumeric(widget.text)
              ? c.colours.surface
              : c.colours.primary,
          child: Center(child: Text(widget.text, style: c.fonts.headline6)),
        ),
      ),
    );
  }
}
