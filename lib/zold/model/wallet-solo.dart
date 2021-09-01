import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'wallet-solo.g.dart';
part 'wallet-solo.freezed.dart';

@freezed
class SoloWallet with _$SoloWallet {
  const SoloWallet._();
  const factory SoloWallet({
    @JsonKey(name: 'genesis') @Default(0) int genesis,
    @JsonKey(name: 'nickname') @Default('') String nickname,
    @JsonKey(name: 'fingerprint') @Default('') String fingerprint,
    @JsonKey(name: 'path') @Default('') String path,
    @JsonKey(name: 'xpub') @Default('') String xpub,
    @JsonKey(name: 'address') @Default('') String address,
    @JsonKey(name: 'label') @Default('') String label,
    @JsonKey(name: 'index') @Default(0) int index,
    @Default(true) bool watchOnly,
    @JsonKey(name: 'balances')
    @Default(WalletBalances())
        WalletBalances balances,
  }) = _SoloWallet;

  factory SoloWallet.fromJson(Map<String, dynamic> json) =>
      _$SoloWalletFromJson(json);

  String time() {
    final t = DateTime.fromMillisecondsSinceEpoch(genesis);
    final DateFormat formatter = DateFormat('yM');
    final String formatted = formatter.format(t);

    return 'created ' + formatted;
  }
}

@freezed
class WalletBalances with _$WalletBalances {
  const WalletBalances._();
  const factory WalletBalances({
    @JsonKey(name: 'confirmed') @Default(0) int confirmed,
    @JsonKey(name: 'unconfirmed') @Default(0) int unconfirmed,
  }) = _WalletBalances;

  factory WalletBalances.fromJson(Map<String, dynamic> json) =>
      _$WalletBalancesFromJson(json);

  bool zeroBalance() => confirmed == 0 && unconfirmed == 0;
  bool hasUnconfirmed() => unconfirmed > 0;
  String confirmedToBtc() => (confirmed / 100000000).toStringAsFixed(8);
  String unconfirmedToBtc() => (unconfirmed / 100000000).toStringAsFixed(8);
}
