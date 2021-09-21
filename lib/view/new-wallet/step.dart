import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';

class StepCell extends StatelessWidget {
  const StepCell({
    Key? key,
    required this.isOn,
    required this.isSelected,
    required this.text,
  }) : super(key: key);

  final bool isOn;
  final bool isSelected;
  final String text;

  @override
  Widget build(BuildContext c) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: c.width * 0.2,
          decoration: BoxDecoration(
            color: isOn ? c.colours.secondary : Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            text,
            style: c.fonts.caption!.copyWith(
              color:
                  isSelected ? c.colours.secondary : c.colours.secondaryVariant,
            ),
          ),
        )
      ],
    );
  }
}
