import 'package:flutter/material.dart';
import 'package:sats/cubit/new-wallet/common/xpub-import.dart';
import 'package:sats/pkg/extensions.dart';

class XpubFieldsImport extends StatefulWidget {
  const XpubFieldsImport({
    Key? key,
  }) : super(key: key);

  @override
  _XpubImportFieldsState createState() => _XpubImportFieldsState();
}

class _XpubImportFieldsState extends State<XpubFieldsImport> {
  late TextEditingController _xpubController;
  late TextEditingController _fingerPrintController;
  late TextEditingController _pathController;

  @override
  void initState() {
    _xpubController = TextEditingController();
    _fingerPrintController = TextEditingController();
    _pathController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<XpubImportCubit, XpubImportState>(
      builder: (context, state) {
        if (_xpubController.text != state.xpub)
          _xpubController.text = state.xpub;

        if (_fingerPrintController.text != state.fingerPrint)
          _fingerPrintController.text = state.fingerPrint;

        if (_pathController.text != state.path)
          _pathController.text = state.path;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              'Enter your XPub',
              style: c.fonts.headline4!.copyWith(
                color: Colors.white,
                // fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Public Key'.notLocalised(),
                    style: c.fonts.overline!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text('SCAN'),
                  ),
                  onPressed: () {
                    c.read<XpubImportCubit>().toggleCamera();
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: TextField(
                controller: _xpubController,
                maxLines: 4,
                style: c.fonts.bodyText1!.copyWith(
                  color: c.colours.onBackground,
                ),
                onChanged: (text) {
                  c.read<XpubImportCubit>().xpubChanged(text);
                },
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    c.read<XpubImportCubit>().xpubPasteClicked();
                  },
                  child: Text(
                    'PASTE'.notLocalised(),
                    style: c.fonts.button!.copyWith(color: c.colours.primary),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            if (state.showOtherDetails()) ...[
              Text(
                'Fingerprint'.toUpperCase().notLocalised(),
                style: c.fonts.overline!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  controller: _fingerPrintController,
                  style: c.fonts.bodyText1!.copyWith(
                    color: c.colours.onBackground,
                  ),
                  onChanged: (text) {
                    c.read<XpubImportCubit>().fingerPrintChanged(text);
                  },
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      c.read<XpubImportCubit>().fingerPrintPastedClicked();
                    },
                    child: Text(
                      'PASTE'.notLocalised(),
                      style: c.fonts.button!.copyWith(color: c.colours.primary),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Path'.toUpperCase().notLocalised(),
                style: c.fonts.overline!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  controller: _pathController,
                  style: c.fonts.bodyText1!.copyWith(
                    color: c.colours.onBackground,
                  ),
                  onChanged: (text) {
                    c.read<XpubImportCubit>().pathChanged(text);
                  },
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      c.read<XpubImportCubit>().pathPasteClicked();
                    },
                    child: Text(
                      'PASTE'.notLocalised(),
                      style: c.fonts.button!.copyWith(color: c.colours.primary),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
            if (state.errXpub != '')
              Text(
                state.errXpub,
                style: c.fonts.caption!.copyWith(color: c.colours.error),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () {
                  c.read<XpubImportCubit>().checkDetails();
                },
                child: const Text('CONFIRM'),
              ),
            )
          ],
        );
      },
    );
  }
}
