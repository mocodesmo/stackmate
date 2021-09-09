import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:petitparser/petitparser.dart';
import 'package:sats/model/rate.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/pkg/validation.dart';
import 'dart:math' as math;
import 'package:sats/cubit/logger.dart';
import 'package:sats/pkg/vibrate.dart';

part 'calculator.freezed.dart';

@freezed
class CalculatorState with _$CalculatorState {
  const factory CalculatorState({
    @Default(false) bool btcSelected,
    Rate? selectedRate,
    @Default('0') String currencyAmt,
    @Default('0') String satsAmt,
    @Default(true) bool editingBtc,
    List<Rate>? rates,
    @Default(false) bool loadingRates,
    @Default('') String loadingRatesError,
  }) = _CalculatorState;
}

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit(
    this._storage,
    this._logger,
    this._vibrate,
  ) : super(CalculatorState()) {
    this.getRates();
  }

  final IStorage _storage;
  final LoggerCubit _logger;
  final IVibrate _vibrate;

  void getRates() async {
    try {
      emit(state.copyWith(loadingRates: true));
      // final token = await _storageService.getItem(key: CacheKeys.token);
      // final response = await _exchangeAPI.getRates(authToken: token);
      // if (response.statusCode == null || response.statusCode != 200) throw '';
      // List<Rate> rates = [];
      // for (var rate in response.data['rates']) rates.add(Rate.fromJson(rate));
      await Future.delayed(Duration(seconds: 1));
      emit(CalculatorState(
        rates: mockRates,
        selectedRate: mockRates[0],
        editingBtc: false,
        currencyAmt: '',
        satsAmt: '',
        loadingRates: false,
      ));
      await Future.delayed(Duration(milliseconds: 100));
      calcKeyPressed('1');
    } catch (e, s) {
      _logger.logException(e, 'CalculatorBloc._mapGetRates', s);
      emit(state.copyWith(
        loadingRates: false,
        loadingRatesError: 'Error Occured. Please try again.',
      ));
    }
  }

  void fieldSelected(bool isFiat) async {
    this.calcKeyPressed('=');
    await Future.delayed(Duration(microseconds: 10));
    emit(state.copyWith(editingBtc: !isFiat));
  }

  void currencyTypeChanged(Rate rate) async {
    if (rate.symbol == state.selectedRate!.symbol) return;

    try {
      this.calcKeyPressed('C');
      await Future.delayed(Duration(microseconds: 100));

      emit(state.copyWith(
        selectedRate: rate,
        editingBtc: false,
      ));
      await Future.delayed(Duration(microseconds: 100));
      this.calcKeyPressed('1');
    } catch (e, s) {
      _logger.logException(e, 'CalculatorBloc._mapCurrencyTypeChanged', s);
    }
  }

  void btcTypeChanged(bool isBtc) async {
    if (isBtc && state.btcSelected) return;
    if (!isBtc && !state.btcSelected) return;
    try {
      this.calcKeyPressed('C');
      await Future.delayed(Duration(microseconds: 100));

      emit(state.copyWith(
        btcSelected: isBtc,
        editingBtc: false,
      ));
      await Future.delayed(Duration(microseconds: 100));
      this.calcKeyPressed('1');
      await Future.delayed(Duration(microseconds: 100));
      emit(state.copyWith(editingBtc: true));
    } catch (e, s) {
      _logger.logException(e, 'CalculatorBloc._mapBtcTypeChanged', s);
    }
  }

  void calcKeyPressed(String key) async {
    vibrate();
    try {
      switch (key) {
        case 'C':
          emit(state.copyWith(satsAmt: '0', currencyAmt: '0'));
          return;

        case 'del':
          if (state.editingBtc) {
            final current = state.satsAmt;
            final removeLast = current.substring(0, current.length - 1);
            emit(state.copyWith(satsAmt: removeLast));
          } else {
            final current = state.currencyAmt;
            final removeLast = current.substring(0, current.length - 1);
            emit(state.copyWith(currencyAmt: removeLast));
          }

          break;

        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
        case '(':
        case ')':
        case '+':
        case '-':
        case 'x':
        case '/':
        case '.':
          String str = '';
          if (state.editingBtc) {
            if (!state.btcSelected && key == '.') return;
            str = _isZero(state.satsAmt) ? '' : state.satsAmt;
            final newExp = str + (key == 'x' ? '*' : key);
            emit(state.copyWith(
                satsAmt:
                    state.btcSelected ? newExp : Validation.addCommas(newExp)));
          } else {
            str = _isZero(state.currencyAmt) ? '' : state.currencyAmt;
            final newExp = str + (key == 'x' ? '*' : key);
            emit(state.copyWith(currencyAmt: Validation.addCommas(newExp)));
          }

          break;

        case '=':
          final parser = _expBuilder().build().end();
          String calc = '';

          if (state.editingBtc)
            calc = state.satsAmt;
          else
            calc = state.currencyAmt;

          if (calc.startsWith('.')) calc = '0' + calc;
          for (var i = 0; i < calc.length; i++)
            if (calc[i] == '.' && !Validation.isNumeric(calc[i - 1]))
              calc =
                  calc.substring(0, i) + '0' + calc.substring(i, calc.length);

          calc = parser.parse(calc).value.toString();

          if (state.editingBtc)
            emit(state.copyWith(satsAmt: calc));
          else
            emit(state.copyWith(currencyAmt: calc));

          break;
      }
    } catch (e, s) {
      _logger.logException(e, 'CalculatorBloc._mapCalcKeyPressed1', s);
      emit(state.copyWith(satsAmt: '0', currencyAmt: '0'));
    }

    await Future.delayed(Duration(microseconds: 100));
    _afterCalcChanged();
  }

  void _afterCalcChanged() {
    try {
      final parser = _expBuilder().build().end();

      String calc = '';
      if (state.editingBtc) {
        calc = Validation.removeCommas(state.satsAmt);
      } else {
        calc = Validation.removeCommas(state.currencyAmt);
      }

      if (calc.startsWith('.')) calc = '0' + calc;

      for (var i = 0; i < calc.length; i++)
        if (calc[i] == '.' && !Validation.isNumeric(calc[i - 1]))
          calc = calc.substring(0, i) + '0' + calc.substring(i, calc.length);

      calc = parser.parse(calc).value.toString();

      if (state.editingBtc) {
        final str = calc;
        final amt = double.parse(Validation.removeCommas(str));
        final finalVal = (state.btcSelected ? amt : amt / 100000000) *
            state.selectedRate!.rate;
        emit(state.copyWith(
            currencyAmt: Validation.addCommas(finalVal.toStringAsFixed(2))));
      } else {
        final str = calc;
        final amt = double.parse(Validation.removeCommas(str));
        final finalVal = amt / state.selectedRate!.rate;

        emit(state.copyWith(
            satsAmt: state.btcSelected
                ? finalVal.toStringAsFixed(8)
                : Validation.addCommas(
                    (finalVal * 100000000).toStringAsFixed(0))));
      }
    } catch (e, s) {
      _logger.logException(e, 'CalculatorBloc._mapCalcKeyPressed2', s);
      print('e2:::' + e.toString());
      if (state.editingBtc)
        emit(state.copyWith(currencyAmt: ''));
      else
        emit(state.copyWith(satsAmt: ''));
    }
  }

  bool _isZero(String val) {
    try {
      final amt = double.parse(val);
      return amt == 0 && !val.contains('.');
    } catch (e, s) {
      _logger.logException(e, 'CalculatorBloc._isZero', s);
    }
    return false;
  }

  void vibrate() {
    try {
      _vibrate.vibe();
    } catch (e, s) {
      _logger.logException(e, 'CalcKey._vibrateOnClicked', s);
    }
  }
}

ExpressionBuilder _expBuilder() {
  final builder = ExpressionBuilder();
  builder.group()
    ..primitive(digit()
        .plus()
        .seq(char('.').seq(digit().plus()).optional())
        .flatten()
        .trim()
        .map((a) => num.tryParse(a)))
    ..wrapper(
        char('(').trim(), char(')').trim(), (String l, num a, String r) => a);

  builder.group()..prefix(char('-').trim(), (String op, num a) => -a);

  builder.group()
    ..right(char('^').trim(), (num a, String op, num b) => math.pow(a, b));

  builder.group()
    ..left(char('*').trim(), (num a, String op, num b) => a * b)
    ..left(char('/').trim(), (num a, String op, num b) => a / b);
  builder.group()
    ..left(char('+').trim(), (num a, String op, num b) => a + b)
    ..left(char('-').trim(), (num a, String op, num b) => a - b);

  return builder;
}
