import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.text,
    required this.onTapped,
  }) : super(key: key);

  final String text;
  final Function onTapped;

  @override
  Widget build(BuildContext c) {
    return Center(
        child: Container(
      width: c.width - 32,
      height: 44,
      child: ElevatedButton(
        onPressed: () {
          return onTapped();
        },
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
        child: Center(
            child: Text(text,
                style: c.fonts.button!.copyWith(
                  //fontWeight: FontWeight.w700,
                  color: c.colours.secondary,
                ))),
      ),
    ));
  }
}
