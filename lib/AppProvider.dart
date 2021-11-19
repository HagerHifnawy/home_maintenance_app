
import 'package:flutter/material.dart';
import 'package:home_maintenance/auth/signup/model/UserModel.dart';

class AppProvider extends ChangeNotifier{
  userModel? currentUser;
  void updateUser(userModel?userModel){
    currentUser = userModel;
    notifyListeners();
  }
}