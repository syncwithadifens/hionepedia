import 'package:flutter/material.dart';
import 'package:hionepedia/services/api_repository.dart';
import 'package:hive/hive.dart';

class UserProvider extends ChangeNotifier {
  dynamic userData;
  String status = '';
  String errorMessage = '';
  bool isLoading = false;
  bool isHide = true;
  final usernameCtrl = TextEditingController();
  final pinCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final hobbyCtrl = TextEditingController();
  final myBox = Hive.box('userBox');

  toggleIsHide() {
    isHide = !isHide;
    notifyListeners();
  }

  login() async {
    isLoading = true;
    notifyListeners();
    userData = await ApiRepository.login(usernameCtrl.text, pinCtrl.text);
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

  register() async {
    isLoading = true;
    notifyListeners();
    final response = await ApiRepository.register(
        usernameCtrl.text, pinCtrl.text, ageCtrl.text, hobbyCtrl.text);
    if (response == 'Account created successfully') {
      status = 'isRegistered';
      notifyListeners();
      Future.delayed(
        const Duration(seconds: 2),
        () {
          isLoading = false;
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
    ageCtrl.dispose();
    hobbyCtrl.dispose();
    super.dispose();
  }
}
