import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sats/cubit/new-wallet/xpub-import.dart';
import 'package:sats/pkg/extensions.dart';
import 'package:sats/view/common/header-text.dart';

class XpubImport extends StatefulWidget {
  const XpubImport({Key? key}) : super(key: key);

  @override
  _XpubImportState createState() => _XpubImportState();
}

class _XpubImportState extends State<XpubImport> {
  TextEditingController? _xpubController;
  TextEditingController? _fingerPrintController;
  TextEditingController? _pathController;

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
      if (_xpubController!.text != state.xpub)
        _xpubController!.text = state.xpub;

      if (_fingerPrintController!.text != state.fingerPrint)
        _fingerPrintController!.text = state.fingerPrint;

      if (_pathController!.text != state.path)
        _pathController!.text = state.path;

      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(height: 24),
        HeaderTextDark(text: 'Enter your XPub'),
        SizedBox(height: 24),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(children: [
              Expanded(
                  child: Text('ADDRESS'.notLocalised(),
                      style: c.fonts.overline!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ))),
              TextButton(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text('OPEN SCANNER'),
                  ),
                  onPressed: () {
                    c.read<XpubImportCubit>().toggleCamera();
                  })
            ])),
        Padding(
            padding: EdgeInsets.all(0),
            child: TextField(
              controller: _xpubController,
              maxLines: 4,
              onChanged: (text) {
                c.read<XpubImportCubit>().xpubChanged(text);
              },
              //decoration: InputDecoration(
              //    //labelText: 'XPub',
              //    //errorText: state.walletLabelError.nullIfEmpty(),
              //    ),
            )),
        SizedBox(height: 8),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () {
                      c.read<XpubImportCubit>().xpubPasteClicked();
                    },
                    child: Text('PASTE FROM CLIPBOARD'.notLocalised(),
                        style: c.fonts.button!
                            .copyWith(color: c.colours.primary))))),
        SizedBox(height: 40),
        if (state.showOtherDetails()) ...[
          Text('Fingerprint'.notLocalised(),
              style: c.fonts.overline!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          SizedBox(height: 4),
          Padding(
              padding: EdgeInsets.all(0),
              child: TextField(
                controller: _fingerPrintController,
                onChanged: (text) {
                  c.read<XpubImportCubit>().fingerPrintChanged(text);
                },
                //decoration: InputDecoration(
                //    //labelText: 'XPub',
                //    //errorText: state.walletLabelError.nullIfEmpty(),
                //    ),
              )),
          SizedBox(height: 8),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        c.read<XpubImportCubit>().fingerPrintPastedClicked();
                      },
                      child: Text('PASTE FROM CLIPBOARD'.notLocalised(),
                          style: c.fonts.button!
                              .copyWith(color: c.colours.primary))))),
          SizedBox(height: 40),
          Text('Path'.notLocalised(),
              style: c.fonts.overline!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          SizedBox(height: 4),
          Padding(
              padding: EdgeInsets.all(0),
              child: TextField(
                controller: _pathController,
                onChanged: (text) {
                  c.read<XpubImportCubit>().pathChanged(text);
                },
                //decoration: InputDecoration(
                //    //labelText: 'XPub',
                //    //errorText: state.walletLabelError.nullIfEmpty(),
                //    ),
              )),
          SizedBox(height: 8),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        c.read<XpubImportCubit>().pathPasteClicked();
                      },
                      child: Text('PASTE FROM CLIPBOARD'.notLocalised(),
                          style: c.fonts.button!
                              .copyWith(color: c.colours.primary))))),
          SizedBox(height: 40),
        ],
        if (state.errXpub != '')
          Text(state.errXpub,
              style: c.fonts.caption!.copyWith(color: c.colours.error)),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
                onPressed: () {
                  c.read<XpubImportCubit>().nextClicked();
                },
                child: Text('CONFIRM')))
      ]);
    });
  }
}
