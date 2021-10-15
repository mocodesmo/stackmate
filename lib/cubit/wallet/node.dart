import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/pkg/storage.dart';

part 'node.freezed.dart';

enum NodeType { electrum, bitcoincore }


@freezed
class NodeAddressState with _$NodeAddressState {
  const factory NodeAddressState({
    @Default(NodeType.electrum) NodeType nodeType,
    String? address,
    @Default('') String errNodeState,
  }) = _NodeAddressState;

  String getAddress() {
    if (nodeType == NodeType.bitcoincore) {
      if (address == null || address!.isEmpty) return '';
      return address!;
    }
    return 'default';
  }
}

class NodeAddressCubit extends Cubit<NodeAddressState> {
  NodeAddressCubit(
    this._storage,
    this._logger,
  ) : super(const NodeAddressState()) {
    init();
  }

  final IStorage _storage;
  final LoggerCubit _logger;

  void init() async {
    try {
      final address = _storage.getFirstItem<String>(StoreKeys.NodeAddress.name);

      if (address == '') {
        emit(state.copyWith(nodeType: NodeType.electrum));
        return;
      }
      emit(state.copyWith(nodeType: NodeType.bitcoincore, address: address));
    } catch (e, s) {
      emit(
        state.copyWith(
          errNodeState: e.toString(),
          nodeType: NodeType.electrum,
        ),
      );
      _logger.logException(e, 'NodeAddressCubit.init', s);
    }
  }

  void electrumSelected() {
    emit(state.copyWith(nodeType: NodeType.electrum));
  }

  void nodeSelected() {
    emit(state.copyWith(nodeType: NodeType.bitcoincore));
  }

  void addressChanged(String text) {
    emit(state.copyWith(address: text));
  }

  void saveClicked() {
    try {
      if (state.nodeType == NodeType.electrum) {
        _storage.clearAll(StoreKeys.NodeAddress.name);
        return;
      }
      if (state.address == null || state.address!.isEmpty) {
        emit(state.copyWith(errNodeState: 'Please enter a valid address'));
        return;
      }
      _storage.clearAll(StoreKeys.NodeAddress.name);
      _storage.saveItem(StoreKeys.NodeAddress.name, state.address);
    } catch (e, s) {
      emit(
        state.copyWith(
          errNodeState: e.toString(),
          // nodeType: NodeType.electrum,
        ),
      );
      _logger.logException(e, 'NodeAddressCubit.saveClicked', s);
    }
  }
}
