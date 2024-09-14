import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoappp/model/my_user.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;
  SharedPreferences? sharedPreferences;

  UserProvider() {
    loadUserData();
  }

  Future<void> loadUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? savedEmail = sharedPreferences?.getString("userEmail");
    if (savedEmail != null) {
      currentUser = MyUser(id: "placeholderId", name: "placeholderName", email: savedEmail);
      notifyListeners();
    }
  }

  Future<void> updateUser(MyUser newUser) async {
    currentUser = newUser;
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences?.setString("userEmail", newUser.email);
    notifyListeners();
  }

  Future<void> clearUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences?.remove("userEmail");
    currentUser = null;
    notifyListeners();
  }

  String? getUserEmail() {
    return currentUser?.email;
  }
}
