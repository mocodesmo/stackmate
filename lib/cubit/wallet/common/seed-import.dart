import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';

part 'seed-import.freezed.dart';

enum SeedImportStep {
  passphrase,
  import,
}

@freezed
class SeedImportState with _$SeedImportState {
  const factory SeedImportState({
    @Default(SeedImportStep.passphrase) SeedImportStep currentStep,
    @Default('') String seed,
    @Default('') String seedError,
    @Default('') String passPhrase,
    @Default(0) int accountNumber,
    @Default('') String errPassPhrase,
    @Default(false) bool seedReady,
  }) = _SeedImportState;
  const SeedImportState._();

  bool showSeedCompleteButton() => seed.split(' ').length == 12;
}

class SeedImportCubit extends Cubit<SeedImportState> {
  SeedImportCubit(this.logger) : super(const SeedImportState());

  final LoggerCubit logger;

  void backOnPassphaseClicked() {
    emit(
      state.copyWith(
        currentStep: SeedImportStep.passphrase,
        passPhrase: '',
        errPassPhrase: '',
      ),
    );
  }

  void passPhraseChanged(String text) {
    emit(state.copyWith(passPhrase: text));
  }

  void accountNumberChanged(String number) {
    try {
      final val = int.parse(number);
      emit(state.copyWith(accountNumber: val));
    } catch (e) {
      print(e.toString());
    }
  }

  void checkPassPhrase() {
    if (state.passPhrase.length > 8 || state.passPhrase.contains(' ')) {
      emit(state.copyWith(errPassPhrase: 'Invalid Passphrase'));
      return;
    }

    emit(
      state.copyWith(
        currentStep: SeedImportStep.import,
        errPassPhrase: '',
      ),
    );
  }

  void backOnSeedClicked() {
    emit(
      state.copyWith(
        currentStep: SeedImportStep.passphrase,
        seed: '',
        seedError: '',
      ),
    );
  }

  void seedTextChanged(String seed) {
    emit(
      state.copyWith(
        seed: seed,
        seedError: '',
      ),
    );
  }

  void checkSeed() {
    try {
      final seed = state.seed;

      if (seed.split(' ').length != 12) {
        emit(state.copyWith(seedError: 'Invalid Seed.'));
        return;
      }

      emit(state.copyWith(seedReady: true));

      // emit(state.copyWith(currentStep: SeedImportWalletSteps.label));
    } catch (e) {
      print(e.toString());
    }
  }
}
