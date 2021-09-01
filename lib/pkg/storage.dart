import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class IStorage {
  Future<void> saveOrUpdateItem({required String key, required String value});
  Future<String> getItem({required String key});
  Future<void> deleteItem({required String key});
}

class CacheKeys {
  static const token = 'token';
  static const email = 'email';
  static const hashedPin = 'hashedPin';
  static const xPriv = 'xpriv';
}

//class HiveStorage implements IStorage {
//  final String _store = 'storage';

//  @override
//  Future<void> saveOrUpdateItem(
//      {required String key, required String value}) async {
//    var _box = await Hive.openBox(_store);
//    await _box.put(key, value);
//  }

//  @override
//  Future<String> getItem({required String key}) async {
//    var _box = await Hive.openBox(_store);
//    var result = _box.get(key);

//    if ((key == CacheKeys.token ||
//            key == CacheKeys.hashedPin ||
//            key == CacheKeys.email) &&
//        (result == null || result == '')) {
//      userBloc.add(LogOut());
//      throw 'no storage result for auth for key: ' + key;
//    }

//    if (result == null) throw 'no storage result for key: ' + key;

//    return result!;
//  }

//  @override
//  Future<void> deleteItem({required String key}) async {
//    var _box = await Hive.openBox(_store);
//    await _box.delete(key);
//  }
//}

class SecureeStorage implements IStorage {
  FlutterSecureStorage? _storage; //= new FlutterSecureStorage();

  SecureeStorage() {
    _storage = new FlutterSecureStorage();
  }

  Future saveOrUpdateItem({required String key, required String value}) async {
    if (_storage == null) throw 'No Secure Storage';

    await _storage!.write(key: key, value: value);
  }

  Future<String> getItem({required String key}) async {
    try {
      if (_storage == null) throw 'No Secure Storage';
      final result = await _storage!.read(key: key);
      if (key.startsWith(CacheKeys.xPriv) && result == null) return '';
      if (result == null) throw '';
      if ((key == CacheKeys.token ||
              key == CacheKeys.hashedPin ||
              key == CacheKeys.email) &&
          result == '') {
        // userCubit.logOut();
        throw 'no storage result for auth for key: ' + key;
      }
      return result;
    } catch (e) {
      print(e.toString());
    }
    return '';
  }

  Future deleteItem({required String key}) async {
    if (_storage == null) throw 'No Secure Storage';

    await _storage!.delete(key: key);
  }
}

class DummyStorage implements IStorage {
  @override
  Future<void> deleteItem({required String key}) async {}

  @override
  Future<String> getItem({required String key}) async {
    if (key.startsWith(CacheKeys.xPriv)) throw '';
    return 'abc';
  }

  @override
  Future<void> saveOrUpdateItem(
      {required String key, required String value}) async {}
}
