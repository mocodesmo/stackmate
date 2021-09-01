import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';

class Back extends StatelessWidget {
  const Back({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(c);
        },
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(width: 0),
          Icon(
            Icons.arrow_back_ios_outlined,
            size: 16,
            color: c.colours.primary,
            // Colors.white,
          ),
          SizedBox(width: 4),
          Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text('Back',
                  style: c.fonts.button!.copyWith(
                    color: c.colours.primary,
                  )))
        ]));
  }
}
