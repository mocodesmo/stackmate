import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';

class SeedWord extends StatelessWidget {
  const SeedWord({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Function? onTap;

  @override
  Widget build(BuildContext c) {
    return Expanded(
      child: GestureDetector(
          onTap: () {
            if (onTap == null) return;
            onTap!();
          },
          child: Container(
              //width: c.width * 0.25,
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  color: c.colours.secondary,
                  borderRadius: BorderRadius.circular(4)),
              child: Text(text,
                  textAlign: TextAlign.left,
                  style: c.fonts.subtitle2!.copyWith(
                    color: onTap == null ? Colors.white : c.colours.primary,
                  )))),
    );
  }
}
