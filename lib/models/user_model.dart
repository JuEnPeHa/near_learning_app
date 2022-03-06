import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserApp extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String nearAccountId;
  @HiveField(3)
  int userLevel;
  @HiveField(4)
  int userLastSyncedLevel;
  @HiveField(5)
  String preferedLanguage;
  @HiveField(6)
  List<String> favoriteThemes;
  @HiveField(7)
  String lastReadPath;
  @HiveField(8)
  String lastReadSyncedPath;
  @HiveField(9)
  UserApp({
    required this.name,
    required this.email,
    required this.nearAccountId,
    required this.userLevel,
    required this.userLastSyncedLevel,
    required this.preferedLanguage,
    required this.favoriteThemes,
    required this.lastReadPath,
    required this.lastReadSyncedPath,
  });

  factory UserApp.fromJson(Map<String, dynamic> json) => UserApp(
        name: json['name'],
        email: json['email'],
        nearAccountId: json['nearAccountId'],
        userLevel: json['userLevel'],
        userLastSyncedLevel: json['userLastSyncedLevel'],
        preferedLanguage: json['preferedLanguage'],
        favoriteThemes: (json['favoriteThemes'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        lastReadPath: json['lastReadPath'],
        lastReadSyncedPath: json['lastReadSyncedPath'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'nearAccountId': nearAccountId,
        'userLevel': userLevel,
        'userLastSyncedLevel': userLastSyncedLevel,
        'preferedLanguage': preferedLanguage,
        'favoriteThemes': favoriteThemes,
        'lastReadPath': lastReadPath,
        'lastReadSyncedPath': lastReadSyncedPath,
      };

  @override
  String toString() {
    return 'UserApp{name: $name, email: $email, nearAccountId: $nearAccountId, userLevel: $userLevel, userLastSyncedLevel: $userLastSyncedLevel, preferedLanguage: $preferedLanguage, favoriteThemes: $favoriteThemes, lastReadPath: $lastReadPath, lastReadSyncedPath: $lastReadSyncedPath}';
  }
}
