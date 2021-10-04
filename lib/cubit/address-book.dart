import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sats/cubit/logger.dart';
import 'package:sats/model/address-book.dart';
import 'package:sats/pkg/storage.dart';
import 'package:sats/pkg/vibrate.dart';

part 'address-book.freezed.dart';

@freezed
class AddressBookState with _$AddressBookState {
  const factory AddressBookState({
    @Default([]) List<AddressBookUser> users,
    //
    @Default(false) bool editUserDetails,
    @Default(false) bool editKeyDetails,
    //
    @Default('') String editUserName,
    @Default('') String errEditUserName,
    //
    @Default('') String editKeyName,
    @Default('') String errKeyName,
    //
    @Default('') String editPublicKey,
    @Default('') String errEditPublicKey,
    //
    //
    AddressBookUser? selectedUser,
    AddressBookKey? selectedKey,
  }) = _AddressBookState;
}

class AddressBookCubit extends Cubit<AddressBookState> {
  AddressBookCubit(
    this._storage,
    this._logger,
    this._vibrate,
  ) : super(const AddressBookState());

  final IStorage _storage;
  final LoggerCubit _logger;
  final IVibrate _vibrate;

  void loadAddressUsers() {
    try {
      final users =
          _storage.getAll<AddressBookUser>(StoreKeys.AddressBookUser.name);
      emit(state.copyWith(users: users));
    } catch (e, s) {
      _logger.logException(e, 'AddressBookCubit.loadAddresses', s);
      emit(state.copyWith());
    }
  }

  void userSelected(AddressBookUser user) {
    emit(state.copyWith(selectedUser: user));
  }

  void clearSelectedUser() {
    emit(state.copyWith(selectedUser: null));
  }

  void editUserSelected() {
    if (state.selectedUser == null)
      emit(state.copyWith(editUserDetails: true));
    else
      emit(
        state.copyWith(
          editUserDetails: true,
          editUserName: state.selectedUser!.name,
        ),
      );
  }

  void cancelUserEdit() {
    emit(
      state.copyWith(
        editUserDetails: false,
        editUserName: '',
        errEditUserName: '',
      ),
    );
  }

  void userNameChanged(String text) {
    emit(
      state.copyWith(
        editUserName: text,
        errEditUserName: '',
      ),
    );
  }

  void keySelected(AddressBookKey key) {
    emit(state.copyWith(selectedKey: key));
  }

  void clearSelectedKey() {
    emit(state.copyWith(selectedKey: null));
  }

  void editKeySelected() {
    if (state.selectedKey == null)
      emit(state.copyWith(editKeyDetails: true));
    else
      emit(
        state.copyWith(
          editKeyDetails: true,
          editKeyName: state.selectedKey!.name,
          editPublicKey: state.selectedKey!.publicKey,
        ),
      );
  }

  void cancelKeyEdit() {
    emit(
      state.copyWith(
        editKeyDetails: false,
        editKeyName: '',
        editPublicKey: '',
        errEditPublicKey: '',
        errKeyName: '',
      ),
    );
  }

  void keyNameChanged(String text) {
    emit(
      state.copyWith(
        editKeyName: text,
        errKeyName: '',
      ),
    );
  }

  void publicKeyChanged(String text) {
    emit(
      state.copyWith(
        editPublicKey: text,
        errEditPublicKey: '',
      ),
    );
  }

  void saveUserClicked() {
    try {
      final newUser = AddressBookUser(
        name: state.editUserName,
        keys: state.selectedUser!.keys,
      );

      final idx = state.users.indexOf(state.selectedUser!);

      _storage.deleteItemAt(StoreKeys.AddressBookUser.name, idx);
      _storage.saveItemAt(StoreKeys.AddressBookUser.name, idx, newUser);

      cancelUserEdit();
      loadAddressUsers();
    } catch (e, s) {
      _logger.logException(e, 'AddressBookCubit.saveUserClicked', s);
      emit(state.copyWith(errEditUserName: e.toString()));
    }
  }

  void deleteUserClicked() {
    try {
      final idx = state.users.indexOf(state.selectedUser!);
      _storage.deleteItemAt(StoreKeys.AddressBookUser.name, idx);

      cancelUserEdit();
      loadAddressUsers();
    } catch (e, s) {
      _logger.logException(e, 'AddressBookCubit.deleteUserClicked', s);
      emit(state.copyWith());
    }
  }

  void saveKeyClicked() {
    try {
      final newKey = AddressBookKey(
        name: state.editKeyName,
        publicKey: state.editPublicKey,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      final keys = state.selectedUser!.keys!.toList();
      keys.add(newKey);

      final newUser = AddressBookUser(
        name: state.selectedUser!.name,
        keys: keys,
      );

      final idx = state.users.indexOf(state.selectedUser!);

      _storage.deleteItemAt(StoreKeys.AddressBookUser.name, idx);
      _storage.saveItemAt(StoreKeys.AddressBookUser.name, idx, newUser);

      cancelUserEdit();
      loadAddressUsers();
    } catch (e, s) {
      _logger.logException(e, 'AddressBookCubit.saveKeyClicked', s);
      emit(state.copyWith());
    }
  }

  void deleteKeyClicked() {
    try {
      final keys = state.selectedUser!.keys!.toList();
      keys.remove(state.selectedKey);

      final newUser = AddressBookUser(
        name: state.selectedUser!.name,
        keys: keys,
      );

      final idx = state.users.indexOf(state.selectedUser!);

      _storage.deleteItemAt(StoreKeys.AddressBookUser.name, idx);
      _storage.saveItemAt(StoreKeys.AddressBookUser.name, idx, newUser);

      cancelUserEdit();
      loadAddressUsers();
    } catch (e, s) {
      _logger.logException(e, 'AddressBookCubit.deleteKeyClicked', s);
      emit(state.copyWith());
    }
  }
}
