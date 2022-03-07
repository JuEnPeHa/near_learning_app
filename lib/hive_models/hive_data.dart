import 'package:hive_flutter/hive_flutter.dart';
import 'package:near_learning_app/models/user_model.dart';

class HiveData {
  Future<int> saveUserApp({required UserApp user}) async {
    final box = Hive.box<UserApp>('user');
    if (box.isNotEmpty) {
      box.clear();
      await Future.delayed(Duration(seconds: 3));
    }
    return await box.add(user);
  }

  Future<UserApp?> getUserApp() async {
    final box = await Hive.box<UserApp>('user');
    print("BOXUSER" + box.getAt(0).toString());
    return box.getAt(0);
  }

  UserApp getUserAppSync() {
    final box = Hive.box<UserApp>('user');
    return box.getAt(0)!;
  }

  Future<UserApp?> get userApp async {
    final Box<UserApp> box = await Hive.box<UserApp>('user');
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
    final box = await Hive.box<UserApp>('user');
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

  void deleteUserApp() {
    final box = Hive.box<UserApp>('user');
    box.deleteAt(0);
  }

  void deleteAll() {
    final box = Hive.box<UserApp>('user');
    final onb = Hive.box<int>('onboarding');
    box.clear();
    onb.clear();
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
    box.add(1);
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
