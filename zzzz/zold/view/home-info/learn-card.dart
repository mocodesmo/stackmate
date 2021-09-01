import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';

class LearnCard extends StatelessWidget {
  const LearnCard({
    Key? key,
    required this.color,
    required this.textColor,
    required this.text,
    this.header,
    this.onTap,
  }) : super(key: key);

  final Color color;
  final Color? textColor;
  final String text;
  final Function? onTap;
  final String? header;

  @override
  Widget build(BuildContext c) {
    return InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          if (onTap != null) onTap!();
        },
        child: Material(
            color: color,
            elevation: 6,
            shadowColor: color,
            borderRadius: BorderRadius.circular(16),
            child: Container(
                width: c.width * 0.3,
                height: c.width * 0.4,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Spacer(),
                          if (header != null)
                            Text(header!,
                                style: c.fonts.button!.copyWith(
                                    color: textColor!.withAlpha(150))),
                          Spacer(flex: 3),
                          Text(text,
                              style: c.fonts.subtitle2!
                                  .copyWith(color: textColor)),
                          Spacer(flex: 2)
                        ])))));
  }
}
