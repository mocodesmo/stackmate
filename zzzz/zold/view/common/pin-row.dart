import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';

class PinRow extends StatelessWidget {
  const PinRow({Key? key, required this.count}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      if (count == 0) ...[
        _Pin(isOn: false),
        _Pin(isOn: false),
        _Pin(isOn: false),
        _Pin(isOn: false),
      ] else if (count == 1) ...[
        _Pin(isOn: true),
        _Pin(isOn: false),
        _Pin(isOn: false),
        _Pin(isOn: false),
      ] else if (count == 2) ...[
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: false),
        _Pin(isOn: false),
      ] else if (count == 3) ...[
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: false),
      ] else if (count == 4) ...[
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: true),
      ]
    ]);
  }
}

class PinRowSix extends StatelessWidget {
  const PinRowSix({Key? key, required this.count}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      if (count == 0) ...[
        _Pin(isOn: false),
        _Pin(isOn: false),
        _Pin(isOn: false),
        _Pin(isOn: false),
        _Pin(isOn: false),
        _Pin(isOn: false),
      ] else if (count == 1) ...[
        _Pin(isOn: true),
        _Pin(isOn: false),
        _Pin(isOn: false),
        _Pin(isOn: false),
        _Pin(isOn: false),
        _Pin(isOn: false),
      ] else if (count == 2) ...[
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: false),
        _Pin(isOn: false),
        _Pin(isOn: false),
        _Pin(isOn: false),
      ] else if (count == 3) ...[
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: false),
        _Pin(isOn: false),
        _Pin(isOn: false),
      ] else if (count == 4) ...[
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: false),
        _Pin(isOn: false),
      ] else if (count == 5) ...[
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: false),
      ] else if (count == 6) ...[
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: true),
        _Pin(isOn: true),
      ]
    ]);
  }
}

class _Pin extends StatelessWidget {
  const _Pin({Key? key, required this.isOn}) : super(key: key);

  final bool isOn;

  @override
  Widget build(BuildContext c) {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        child: Container(
            key: isOn ? ValueKey(1) : ValueKey(2),
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: c.colours.surface),
            child: !isOn
                ? Container()
                : Center(
                    child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: c.colours.secondary)),
                  )));
  }
}
