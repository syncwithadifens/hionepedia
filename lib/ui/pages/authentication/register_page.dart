import 'package:flutter/material.dart';
import 'package:hionepedia/providers/user_provider.dart';
import 'package:hionepedia/theme/styles.dart';
import 'package:hionepedia/ui/pages/authentication/login_page.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    void showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      ));
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Center(
                    child: Text(
                      'Register',
                      style: titleStyle.copyWith(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/avatar/default_avatar.png',
                    width: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
                  child: Text(
                    'Username',
                    style: subtitleStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    controller: userProvider.usernameCtrl,
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.account_box,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: lightGrey,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 30, 32, 10),
                  child: Text(
                    'Pin',
                    style: subtitleStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    controller: userProvider.pinCtrl,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    obscureText: userProvider.isHide,
                    maxLength: 6,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          userProvider.toggleIsHide();
                        },
                        icon: Icon(
                          Icons.visibility,
                          color: userProvider.isHide
                              ? Colors.grey
                              : Colors.deepPurple,
                        ),
                      ),
                      filled: true,
                      fillColor: lightGrey,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
                  child: Text(
                    'Umur',
                    style: subtitleStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    controller: userProvider.ageCtrl,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: lightGrey,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 30, 32, 10),
                  child: Text(
                    'Hobi',
                    style: subtitleStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextField(
                    controller: userProvider.hobbyCtrl,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.gamepad,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: lightGrey,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (userProvider.usernameCtrl.text.isNotEmpty &&
                        userProvider.pinCtrl.text.isNotEmpty &&
                        userProvider.ageCtrl.text.isNotEmpty &&
                        userProvider.hobbyCtrl.text.isNotEmpty) {
                      userProvider.register().then((value) => {
                            userProvider.status == 'isRegistered'
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ))
                                : Future.delayed(const Duration(seconds: 3),
                                    () => showError(userProvider.errorMessage))
                          });
                    } else {
                      showError('All fields is required');
                    }
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(32, 40, 32, 10),
                    decoration: BoxDecoration(
                        color: blackColor,
                        borderRadius: BorderRadius.circular(18)),
                    child: Center(
                        child: Text(
                      'Let\'s Go',
                      style: titleStyle.copyWith(
                          color: lightGrey, fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
