import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appMode = ThemeMode.light;
  SharedPreferences? sharedPreferences;
  AppCofigProvider(){
    getConfigData();
  }

  Future <void> getConfigData()async{
    sharedPreferences=await SharedPreferences.getInstance();
    appLanguage=sharedPreferences!.getString("appLanguage")??"en";
    appMode=sharedPreferences!.getString("appMode")=="dark"?ThemeMode.dark:ThemeMode.light;
    notifyListeners();
  }
  Future<void> changeLanguage(String newLanguage)async {
    if (appLanguage == newLanguage) {
      return;
    }
    sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences!.setString("appLanguage", newLanguage);
    appLanguage = newLanguage;
    notifyListeners();
  }

  Future<void>changeTheme(ThemeMode newMode)async{
    if (appMode == newMode) {
      return;
    }
    sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences!.setString("appTheme", newMode==ThemeMode.dark?"dark":"light");
    appMode = newMode;
    notifyListeners();
  }

  bool isDarkMode() {
    return appMode == ThemeMode.dark;
  }
}

