import 'package:bloc/bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/cubit/chain-select.dart';
import 'package:sats/cubit/wallets.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/model/wallet.dart';
import 'package:sats/pkg/bitcoin.dart';
import 'package:sats/pkg/clipboard.dart';
import 'package:sats/pkg/storage.dart';

part 'xpub-import.freezed.dart';

@freezed
class XpubImportState with _$XpubImportState {
  const factory XpubImportState({
    @Default('') String xpub,
    @Default('') String fingerPrint,
    @Default('') String path,
    @Default('') String errXpub,
    @Default(false) bool cameraOpened,
    @Default('') String label,
    @Default(false) bool savingWallet,
    @Default('') String errSavingWallet,
    @Default(false) bool newWalletSaved,
  }) = _SeedImportXpubState;
  const XpubImportState._();
}
