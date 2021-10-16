import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/model/node.dart';
import 'package:sats/pkg/storage.dart';

part 'node.freezed.dart';

@freezed
class NodeAddressState with _$NodeAddressState {
  const factory NodeAddressState({
    @Default(NodeType.electrum) NodeType nodeType,
    @Default('') String address,
    @Default('') String port,
    @Default('') String username,
    @Default('') String password,
    @Default('') String errNodeState,
  }) = _NodeAddressState;

  String getAddress() {
    if (nodeType == NodeType.bitcoincore) {
      if (address.isEmpty) return 'default';
      return 'https://$address:$port?auth=$username:$password';
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
      final node = _storage.getFirstItem<Node>(StoreKeys.Node.name);

      if (node.nodeType == NodeType.electrum) {
        emit(state.copyWith(nodeType: NodeType.electrum));
        return;
      }

      emit(
        state.copyWith(
          nodeType: NodeType.bitcoincore,
          address: node.address,
          port: node.port,
          username: node.username,
          password: node.password,
        ),
      );
    } catch (e, s) {
      if (e.toString() == 'empty') {
        emit(state.copyWith(nodeType: NodeType.electrum));
        return;
      }
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
    emit(
      state.copyWith(
        nodeType: NodeType.electrum,
        address: '',
        port: '',
        username: '',
        password: '',
      ),
    );
  }

  void nodeSelected() {
    emit(state.copyWith(nodeType: NodeType.bitcoincore));
  }

  void addressChanged(String text) {
    emit(state.copyWith(address: text));
  }

  void usernameChanged(String text) {
    emit(state.copyWith(username: text));
  }

  void portChanged(String text) {
    emit(state.copyWith(port: text));
  }

  void passwordChanged(String text) {
    emit(state.copyWith(password: text));
  }

  void saveClicked() {
    try {
      final node = Node(
        nodeType: state.nodeType,
        address: state.address,
        port: state.port,
        username: state.username,
        password: state.password,
      );

      _storage.clearAll<Node>(StoreKeys.Node.name);
      _storage.saveItem<Node>(StoreKeys.Node.name, node);
    } catch (e, s) {
      emit(state.copyWith(errNodeState: e.toString()));
      _logger.logException(e, 'NodeAddressCubit.saveClicked', s);
    }
  }
}
