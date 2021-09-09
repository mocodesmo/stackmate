// import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:sats/zold/api/exchange.dart';
// import 'package:sats/zold/model/rate.dart';
// import 'package:sats/pkg/storage.dart';
// import 'package:sats/cubit/logger.dart';

// part 'rates.freezed.dart';

// @freezed
// class RatesState with _$RatesState {
//   const factory RatesState({
//     @Default([]) List<Rate> rates,
//     @Default(false) bool loadingRates,
//     @Default('') String ratesError,
//   }) = _RatesState;
// }

// class RatesCubit extends Cubit<RatesState> {
//   RatesCubit(
//     this._storageService,
//     this._exchangeAPI,
//     this.logger,
//   ) : super(RatesState());

//   final IStorage _storageService;
//   final IExchangeAPI _exchangeAPI;
//   final LoggerCubit logger;

//   void getRates() async {
//     try {
//       emit(state.copyWith(loadingRates: true));
//       final token = await _storageService.getItem(key: CacheKeys.token);
//       final response = await _exchangeAPI.getRates(authToken: token);
//       if (response.statusCode == null || response.statusCode != 200) throw '';
//       //final data = jsonDecode(response.data);
//       List<Rate> rates = [];
//       for (var rate in response.data['message']) rates.add(Rate.fromJson(rate));
//       emit(RatesState(rates: rates));
//     } catch (e, s) {
//       logger.logException(e, 'RatesBloc._mapGetRatesToState', s);
//       emit(state.copyWith(
//         loadingRates: false,
//         ratesError: 'Error Occured. Please try again.',
//       ));
//     }
//   }
// }
