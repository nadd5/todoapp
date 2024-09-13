import 'package:flutter/material.dart';
import 'package:todoappp/model/my_user.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;
  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
