import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/zold/api/wallet-solo.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/zold/cubit/wallet.dart';
import 'package:sats/zold/model/wallet-solo.dart';
import 'package:sats/pkg/storage.dart';

part 'address-generate.freezed.dart';

@freezed
class AddressGenerateState with _$AddressGenerateState {
  const factory AddressGenerateState({
    @Default(false) bool expandAddressSection,
    @Default('') String addressLabel,
    @Default(false) bool savingAddress,
    @Default('') String errAddressGenerate,
    @Default(false) bool addressSaved,
  }) = _AddressGenerate;
}

class AddressGenerateCubit extends Cubit<AddressGenerateState> {
  AddressGenerateCubit(
    this._storage,
    //this._networkAPI,
    this._soloWalletAPI,
    this.walletCubit,
    this.logger,
  ) : super(AddressGenerateState());

  //final INetworkAPI _networkAPI;
  final IStorage _storage;
  final LoggerCubit logger;
  final WalletCubit walletCubit;
  final ISoloWalletAPI _soloWalletAPI;

  expandedAddressSection() {
    emit(state.copyWith(expandAddressSection: true));
  }

  closeAddressSection() {
    emit(AddressGenerateState());
  }

  addressLabelChanged(String text) {
    emit(state.copyWith(addressLabel: text, errAddressGenerate: ''));
  }

  generateClicked() async {
    try {
      if (state.addressLabel.length == 0 ||
          state.addressLabel.contains(' ') ||
          state.addressLabel.length > 10) {
        emit(state.copyWith(errAddressGenerate: 'Invalid Label.'));
        return;
      }

      emit(state.copyWith(
        errAddressGenerate: '',
        savingAddress: true,
      ));

      final authToken = await _storage.getItem(key: CacheKeys.token);

      final response = await _soloWalletAPI.getAddress(
        authToken: authToken,
        nickname: state.addressLabel,
        format: '',
      );

      if (response.statusCode != 200) throw '';

      final data = response.data['message'];

      final wallet = walletCubit.state.selectedWallet!;
      walletCubit.updateSelectedWallet(SoloWallet(
        genesis: wallet.genesis,
        nickname: wallet.nickname,
        fingerprint: wallet.fingerprint,
        path: wallet.path,
        xpub: wallet.xpub,
        address: data,
        label: state.addressLabel,
        balances: wallet.balances,
      ));

      emit(state.copyWith(
        savingAddress: false,
        addressSaved: true,
      ));

      walletCubit.getWallets();

      //await Future.delayed(Duration(seconds: 2));

      emit(AddressGenerateState());
    } catch (e, s) {
      logger.logException(e, 'AddressGenerateCubit.generateClicked', s);

      emit(state.copyWith(
        savingAddress: false,
        errAddressGenerate: 'Error Occured.',
      ));
    }
  }
}
