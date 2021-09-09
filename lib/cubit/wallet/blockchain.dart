import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/model/blockchain.dart';
import 'package:sats/pkg/storage.dart';
part 'blockchain.freezed.dart';

@freezed
class BlockchainState with _$BlockchainState {
  const factory BlockchainState({
    @Default(Blockchain.testNet) Blockchain blockchain,
  }) = _BlockchainState;
}

class BlockchainCubit extends Cubit<BlockchainState> {
  BlockchainCubit(
    this._storage,
    this._logger,
  ) : super(BlockchainState()) {
    this._init();
  }

  final IStorage _storage;
  final LoggerCubit _logger;

  _init() async {
    try {
      final blockchain = await _storage.getFirstItem<Blockchain>(
        StoreKeys.Blockchain.name,
      );

      emit(BlockchainState(blockchain: blockchain));
      await Future.delayed(Duration(milliseconds: 50));
    } catch (e, s) {
      _logger.logException(e, 'BlockchainCubit._init', s);
    }
  }

  changeBlockchain(Blockchain blockchain) async {
    try {
      emit(BlockchainState(blockchain: blockchain));
      _storage.saveItem<Blockchain>(
        StoreKeys.Blockchain.name,
        blockchain,
      );
      await Future.delayed(Duration(milliseconds: 50));
    } catch (e, s) {
      _logger.logException(e, 'BlockchainCubit.changeBlockchain', s);
    }
  }
}