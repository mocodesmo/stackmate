import 'package:freezed_annotation/freezed_annotation.dart';

part 'amount.freezed.dart';

@freezed
class BtcSendAmountState with _$BtcSendAmountState {
  const factory BtcSendAmountState({
    @Default('') String amountEntered,
    @Default('') String errAmount,
  }) = _BtcSendAmountState;
  const BtcSendAmountState._();

  bool hasError() => errAmount != '';
}

// class BtcSendAmountCubit extends Cubit<BtcSendAmountState> {
//   BtcSendAmountCubit(
//     this._walletCubit,
//     this.storage,
//     this.walletAPI,
//     this._feesCubit,
//     this.logger,
//   ) : super(BtcSendAmountState()) {
//     feeSub = _feesCubit.stream.listen((state) {
//       feeChanged(state.feeEnteredD);
//     });
//   }

//   final WalletCubit _walletCubit;
//   final BtcSendFeesCubit _feesCubit;

//   StreamSubscription? feeSub;

//   final IStorage storage;
//   final IWalletAPI walletAPI;

//   final LoggerCubit logger;

//   void feeChanged(int fees) {
//     emit(state.copyWith(finalAmountD: state.amountEnteredD + fees));
//   }

//   //void toggleMaxBalance(bool useMaxB) {
//   //  emit(state.copyWith(useMaxBalance: useMaxB));
//   //}

//   void amountEntered(String amount) async {
//     try {
//       String amt = amount;

//       if (amt.startsWith('0')) {
//         amt = amt.substring(1, amt.length);
//       }

//       var amountD = double.parse(Validation.removeCommas(amt));

//       emit(state.copyWith(amountEntered: '', amountError: ''));

//       emit(state.copyWith(
//         amountEntered: Validation.addCommas(amt),
//         amountEnteredD: amountD,
//         finalAmountD: amountD + _feesCubit.state.feeEnteredD,
//         amountEnteredSmall: (amountD / 100000000).toStringAsFixed(8),
//       ));
//     } catch (e, s) {
//       logger.logException(
//           e, 'BtcSendAmountBloc._mapAmountEnteredEventToState', s);

//       emit(state.copyWith(
//           amountEntered: '0',
//           amountEnteredD: 0,
//           finalAmountD: 0,
//           amountEnteredSmall: '0.00'));
//     }
//   }

//   void checkAmount() async {
//     try {
//       //if (state.useMaxBalance) {
//       //  emit(state.copyWith(amountError: ''));
//       //  return;
//       //}

//       if (state.amountEntered == "") {
//         emit(state.copyWith(amountError: 'Please enter valid amount'));
//         return;
//       }

//       final amt = state.amountEnteredD;

//       if (amt <= 0 ||
//           amt > _walletCubit.state.selectedWallet!.balances.confirmed)
//         emit(state.copyWith(amountError: 'Please enter valid amount'));
//       else
//         emit(state.copyWith(amountError: ''));
//     } catch (e, s) {
//       logger.logException(
//           e, 'BtcSendAmountBloc._mapCheckAmountEventToState', s);
//       emit(state.copyWith(amountError: 'Please enter valid amount'));
//     }
//   }

//   void addAmountError(String error) async {
//     emit(state.copyWith(amountError: error));
//   }

//   @override
//   Future<void> close() {
//     if (feeSub != null) feeSub!.cancel();
//     return super.close();
//   }
// }
