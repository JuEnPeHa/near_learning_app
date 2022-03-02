// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAppAdapter extends TypeAdapter<UserApp> {
  @override
  final int typeId = 0;

  @override
  UserApp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserApp(
      name: fields[0] as String,
      email: fields[1] as String,
      lastName: fields[2] as String,
      userLevel: fields[3] as int,
      userLastSyncedLevel: fields[4] as int,
      preferedLanguage: fields[5] as String,
      favoriteThemes: (fields[6] as List).cast<String>(),
      lastReadPath: fields[7] as String,
      lastReadSyncedPath: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserApp obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.userLevel)
      ..writeByte(4)
      ..write(obj.userLastSyncedLevel)
      ..writeByte(5)
      ..write(obj.preferedLanguage)
      ..writeByte(6)
      ..write(obj.favoriteThemes)
      ..writeByte(7)
      ..write(obj.lastReadPath)
      ..writeByte(8)
      ..write(obj.lastReadSyncedPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAppAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
