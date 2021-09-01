import 'package:flutter/material.dart';
import 'package:sats/pkg/extensions.dart';

class SettingsCell extends StatelessWidget {
  const SettingsCell({
    Key? key,
    required this.title,
    required this.description,
    required this.largeText,
    required this.onTap,
    this.alertColor = false,
    this.comingSoon = false,
    this.bottomRowText = '',
    this.bottomRowButtonText = '',
    this.largeTextAlertColor = false,
    this.bottomRowButtonPressed,
  }) : super(key: key);

  final String title;
  final String description;
  final String largeText;
  final bool alertColor;
  final bool comingSoon;
  final bool largeTextAlertColor;
  final Function onTap;

  final String bottomRowText;
  final String bottomRowButtonText;
  final Function? bottomRowButtonPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          return onTap();
        },
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: context.colours.surface),
            child: Opacity(
                opacity: comingSoon ? 0.2 : 1,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(children: [
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(title,
                                  style: context.fonts.subtitle2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 4),
                              Text(description,
                                  style: context.fonts.caption!.copyWith(
                                      color: alertColor
                                          ? context.colours.error
                                          : null))
                            ])),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(largeText,
                                  style: context.fonts.headline6!.copyWith(
                                      color: largeTextAlertColor
                                          ? context.colours.error
                                          : null),
                                  textAlign: TextAlign.end),
                              if (comingSoon) ...[
                                SizedBox(height: 8),
                                Text('COMING SOON',
                                    style: context.fonts.bodyText2!
                                        .copyWith(color: context.colours.error))
                              ]
                            ])
                      ]),
                      if (bottomRowText != '') ...[
                        SizedBox(height: 16),
                        Text(bottomRowText, style: context.fonts.caption)
                      ],
                      if (bottomRowButtonText != '' &&
                          bottomRowButtonPressed != null)
                        ElevatedButton(
                            onPressed: () {
                              bottomRowButtonPressed!();
                            },
                            child: Text(bottomRowButtonText))
                    ]))));
  }
}
