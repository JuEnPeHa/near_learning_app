import 'package:hive_flutter/hive_flutter.dart';
import 'package:near_learning_app/models/user_model.dart';

class HiveData {
  Future<int> saveUserApp({required UserApp user}) async {
    final box = await Hive.openBox<UserApp>('user');

    return box.add(user);
  }

  Future<UserApp?> getUserApp() async {
    final box = await Hive.openBox<UserApp>('user');
    print(box.get('user'));
    return box.get('user');
  }

  Future<UserApp?> get userApp async {
    final Box<UserApp> box = await Hive.openBox<UserApp>('user');
    print(box.get('user'));

    return box.get('user');
  }

  copyWith({
    String? name,
    String? email,
    String? nearAccountId,
    int? userLevel,
    int? userLastSyncedLevel,
    String? preferedLanguage,
    String? id,
    List<String>? favoriteThemes,
    String? lastReadPath,
    String? lastReadSyncedPath,
  }) async {
    final box = await Hive.openBox<UserApp>('user');
    final user = box.get('user');
    if (user != null) {
      if (name != null) {
        user.name = name;
      } else {
        user.name = user.name;
      }
      if (email != null) {
        user.email = email;
      } else {
        user.email = user.email;
      }
      if (nearAccountId != null) {
        user.nearAccountId = nearAccountId;
      } else {
        user.nearAccountId = user.nearAccountId;
      }
      if (userLevel != null) {
        user.userLevel = userLevel;
      } else {
        user.userLevel = user.userLevel;
      }
      if (userLastSyncedLevel != null) {
        user.userLastSyncedLevel = userLastSyncedLevel;
      } else {
        user.userLastSyncedLevel = user.userLastSyncedLevel;
      }
      if (preferedLanguage != null) {
        user.preferedLanguage = preferedLanguage;
      } else {
        user.preferedLanguage = user.preferedLanguage;
      }
      if (favoriteThemes != null) {
        user.favoriteThemes = favoriteThemes;
      } else {
        user.favoriteThemes = user.favoriteThemes;
      }
      if (lastReadPath != null) {
        user.lastReadPath = lastReadPath;
      } else {
        user.lastReadPath = user.lastReadPath;
      }
      if (lastReadSyncedPath != null) {
        user.lastReadSyncedPath = lastReadSyncedPath;
      } else {
        user.lastReadSyncedPath = user.lastReadSyncedPath;
      }
      box.delete('user');
      box.put('user', user);
    }
  }

  Future<void> deleteUserApp() async {
    final box = await Hive.openBox<UserApp>('user');
    box.deleteAt(0);
  }

  Future<void> deleteAll() async {
    final box = await Hive.openBox<UserApp>('user');
    box.clear();
  }

  Future<bool> isFirstTime2() async {
    final box = await Hive.openBox<int>('onboarding');
    if (box.values.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> setFirstTime() async {
    final box = await Hive.openBox<int>('onboarding');
    box.putAt(0, 1);
  }

  Future<bool> get isFirstTime async {
    final box = await Hive.openBox<int>('onboarding');
    if (box.values.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
