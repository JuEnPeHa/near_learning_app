import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveObject(0)
   String name;
  @HiveObject(1)
   String email;
  @HiveObject(2)
   String lastName;
  @HiveObject(3)
   int userLevel;
  @HiveObject(4)
   int userLastSyncedLevel;
  @HiveObject(5)
   String preferedLanguage;
  @HiveObject(6)
   List<String> favoriteThemes;
  @HiveObject(7)
   String lastReadPath;
  @HiveObject(8)
   String lastReadSyncedPath;
  @HiveObject(9)
  User({
    required this.name,
    required this.email,
    required this.lastName,
    required this.userLevel,
    required this.userLastSyncedLevel,
    required this.preferedLanguage,
    required this.favoriteThemes,
    required this.lastReadPath,
    required this.lastReadSyncedPath,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
        email: json['email'],
        lastName: json['lastName'],
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
        'lastName': lastName,
        'userLevel': userLevel,
        'userLastSyncedLevel': userLastSyncedLevel,
        'preferedLanguage': preferedLanguage,
        'favoriteThemes': favoriteThemes,
        'lastReadPath': lastReadPath,
        'lastReadSyncedPath': lastReadSyncedPath,
      };

  @override
  String toString() {
    return 'User{name: $name, email: $email, lastName: $lastName, userLevel: $userLevel, userLastSyncedLevel: $userLastSyncedLevel, preferedLanguage: $preferedLanguage, favoriteThemes: $favoriteThemes, lastReadPath: $lastReadPath, lastReadSyncedPath: $lastReadSyncedPath}';
  }
}