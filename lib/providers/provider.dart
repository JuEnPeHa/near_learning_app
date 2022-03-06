import 'dart:async';
import 'package:flutter/material.dart';
import 'package:near_learning_app/hive_models/hive_data.dart';
import 'package:near_learning_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  String _userName = "";
  String _userEmail = "";
  String _userLastName = "";
  int _userLevel = 0;
  int _userLastSyncedLevel = 0;
  String _preferedLanguage = "";
  List<String> _favoriteThemes = [];
  String _lastReadPath = "";
  String _lastReadSyncedPath = "";

  var hiveData = HiveData();

  Future<void> _initHive() async {
    userApp = await hiveData.userApp;
    isFirstTime = await hiveData.isFirstTime;
    notifyListeners();
  }

  void saveUserApp({
      required String userName,
      required String userEmail,
      String userLastName = "",
      int userLevel = 0,
      int userLastSyncedLevel = 0,
      List<String> favoriteThemes = const [],
      String preferedLanguage = "",
      String lastReadPath = "",
      String lastReadSyncedPath = ""}) {
    _userName = userName;
    _userEmail = userEmail;
    _userLastName = userLastName;
    _userLevel = userLevel;
    _userLastSyncedLevel = userLastSyncedLevel;
    _favoriteThemes = favoriteThemes;
    _preferedLanguage = preferedLanguage;
    _lastReadPath = lastReadPath;
    _lastReadSyncedPath = lastReadSyncedPath;
    hiveData.saveUserApp(
        user: UserApp(
            email: _userEmail,
            favoriteThemes: _favoriteThemes,
            lastName: _userLastName,
            lastReadPath: _lastReadPath,
            lastReadSyncedPath: _lastReadSyncedPath,
            name: _userName,
            preferedLanguage: _preferedLanguage,
            userLastSyncedLevel: _userLastSyncedLevel,
            userLevel: _userLevel));
    notifyListeners();
  }

  // String get userName => _userName;
  // String get userEmail => _userEmail;
  // String get userLastName => _userLastName;
  // int get userLevel => _userLevel;
  // int get userLastSyncedLevel => _userLastSyncedLevel;
  // List<String> get favoriteThemes => _favoriteThemes;

  void setUserName(String userName) {
    _userName = userName;
    notifyListeners();
  }

  void setUserEmail(String userEmail) {
    _userEmail = userEmail;
    notifyListeners();
  }

  void setUserLastName(String userLastName) {
    _userLastName = userLastName;
    notifyListeners();
  }

  void setUserLevel(int userLevel) {
    _userLevel = userLevel;
    notifyListeners();
  }

  void setUserLastSyncedLevel(int userLastSyncedLevel) {
    _userLastSyncedLevel = userLastSyncedLevel;
    notifyListeners();
  }

  void setFavoriteThemes(List<String> favoriteThemes) {
    _favoriteThemes = favoriteThemes;
    notifyListeners();
  }

  void setPreferedLanguage(String preferedLanguage) {
    _preferedLanguage = preferedLanguage;
    notifyListeners();
  }

  void setLastReadPath(String lastReadPath) {
    _lastReadPath = lastReadPath;
    notifyListeners();
  }

  void setLastReadSyncedPath(String lastReadSyncedPath) {
    _lastReadSyncedPath = lastReadSyncedPath;
    notifyListeners();
  }

  void getUserData() async {
    await Future.delayed(Duration(seconds: 1));
    _userName = "John";
    _userEmail = "email";
  }
  // String _userPassword = "";
  // String _userPhone = "";
  // String _userAddress = "";
  // String _userCity = "";
  // String _userState = "";
  // String _userCountry = "";
  // String _userZip = "";
  // String _userImage = "";
  // String _userId = "";
  // String _userToken = "";
  // String _userType = "";
  // String _userStatus = "";
  // String _userCreated = "";
  // String _userUpdated = "";
  // String _userDeleted = "";
  // String _userLastLogin = "";
  // String _userLastLoginIp = "";
  // String _userLastLoginDevice = "";
  // String _userLastLoginDeviceType = "";
  // String _userLastLoginDeviceVersion = "";
  // String _userLastLoginDeviceOs = "";
  // String _userLastLoginDeviceOsVersion = "";
  // String _userLastLoginDeviceOsLanguage = "";
  // String _userLastLoginDeviceOsCountry = "";
  // String _userLastLoginDeviceOsTimezone = "";
  // String _userLastLoginDeviceOsTimezoneOffset = "";
  // String _userLastLoginDeviceOsTimezoneName = "";
  // String _userLastLoginDeviceOsTimezoneAbbr = "";
  // String _userLastLoginDeviceOsTimezoneCity = "";
  // String _userLastLoginDeviceOsTimezoneCountry = "";
  // String _userLastLoginDeviceOsTimezoneDstOffset = "";
  // String _userLastLoginDeviceOsTimezoneDst = "";
  // String _userLastLoginDeviceOsTimezoneDstStart = "";
  // String _userLastLoginDeviceOsTimezoneDstEnd = "";
  // String _userLastLoginDeviceOsTimezoneCurrent = "";
  // String _userLastLoginDeviceOsTimezoneCurrentOffset = "";
  // String _userLastLoginDeviceOsTimezoneCurrentAbbr = "";
  // String _userLastLoginDeviceOsTimezoneCurrentName = "";
  // String _userLastLoginDeviceOsTimezoneCurrentCity = ""
}
