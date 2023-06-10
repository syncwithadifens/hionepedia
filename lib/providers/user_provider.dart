import 'package:flutter/material.dart';
import 'package:hionepedia/services/api_repository.dart';
import 'package:hive/hive.dart';

class UserProvider extends ChangeNotifier {
  dynamic userData;
  bool isLoading = false;
  String status = '';
  final usernameCtrl = TextEditingController();
  final pinCtrl = TextEditingController();
  String errorMessage = '';
  final myBox = Hive.box('userBox');

  getUserData() async {
    isLoading = true;
    notifyListeners();
    userData = await ApiRepository.getUserData(usernameCtrl.text, pinCtrl.text);
    if (userData.status == 200) {
      myBox.put('userActive', [
        userData.messages.userId,
        userData.messages.username,
        userData.messages.age,
        userData.messages.hobby,
      ]);
      status = 'isLoggedIn';
      notifyListeners();

      Future.delayed(
        const Duration(seconds: 2),
        () {
          isLoading = false;
          notifyListeners();
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          isLoading = false;
          errorMessage = userData.messages.error;
          notifyListeners();
        },
      );
    }
  }

  logout() async {
    status = '';
    myBox.delete('userActive');
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    pinCtrl.dispose();
    super.dispose();
  }
}
