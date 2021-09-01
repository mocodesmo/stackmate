import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isRed = false,
  }) : super(key: key);

  final String text;
  final Function? onPressed;
  final bool isRed;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: TextButton(
              style: ButtonStyle(alignment: Alignment.centerLeft),
              onPressed: () {
                if (onPressed != null) onPressed!();
              },
              child: Text(text,
                  style: context.fonts.subtitle2!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isRed ? context.colours.error : null)),
            )));
  }
}
