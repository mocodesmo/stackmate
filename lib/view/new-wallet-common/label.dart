//import 'package:flutter/material.dart';
//import 'package:sats/cubit/new-wallet/seed-generate.dart';
//import 'package:sats/cubit/new-wallet/seed-import.dart';
//import 'package:sats/pkg/extensions.dart';
//import 'package:sats/zold/view/common/header-text.dart';

//class SeedLabel extends StatelessWidget {
//  const SeedLabel({Key? key, required this.isImport}) : super(key: key);

//  final bool isImport;

//  @override
//  Widget build(BuildContext c) {
//    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//      HeaderTextDark(text: 'Label your\nwallet'),
//      SizedBox(height: 16),
//      SizedBox(height: 40),
//      Padding(
//        padding: EdgeInsets.all(0),
//        child: isImport ? ImportLabelField() : GenerateLabelField(),
//      ),
//      SizedBox(height: 40),
//      Padding(
//          padding: const EdgeInsets.all(16.0),
//          child: ElevatedButton(
//              onPressed: () {
//                if (isImport)
//                  c.read<SeedImportCubit>().nextClicked();
//                else
//                  c.read<SeedGenerateCubit>().nextClicked();
//              },
//              child: Text('Confirm')))
//    ]);
//  }
//}

//class ImportLabelField extends StatelessWidget {
//  const ImportLabelField({Key? key}) : super(key: key);

//  @override
//  Widget build(BuildContext c) {
//    return BlocBuilder<SeedImportCubit, SeedImportState>(
//        buildWhen: (previous, current) =>
//            previous.walletLabelError != current.walletLabelError,
//        builder: (context, state) {
//          return TextField(
//              onChanged: (text) {
//                c.read<SeedImportCubit>().labelChanged(text);
//              },
//              decoration: InputDecoration(
//                  labelText: 'Wallet Name',
//                  errorText: state.walletLabelError.nullIfEmpty()));
//        });
//  }
//}

//class GenerateLabelField extends StatelessWidget {
//  const GenerateLabelField({Key? key}) : super(key: key);

//  @override
//  Widget build(BuildContext c) {
//    return BlocBuilder<SeedGenerateCubit, SeedGenerateState>(
//        buildWhen: (previous, current) =>
//            previous.walletLabelError != current.walletLabelError,
//        builder: (context, state) {
//          return TextField(
//              onChanged: (text) {
//                c.read<SeedGenerateCubit>().labelChanged(text);
//              },
//              decoration: InputDecoration(
//                  labelText: 'Wallet Name',
//                  errorText: state.walletLabelError.nullIfEmpty()));
//        });
//  }
//}
