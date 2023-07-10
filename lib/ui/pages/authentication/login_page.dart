import 'package:flutter/material.dart';
import 'package:hionepedia/providers/user_provider.dart';
import 'package:hionepedia/theme/styles.dart';
import 'package:hionepedia/ui/pages/authentication/register_page.dart';
import 'package:hionepedia/ui/pages/content/mypage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                      image: AssetImage('assets/illustration/vr.png'))),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'Login',
                  style: titleStyle.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 5, 32, 10),
              child: Text(
                'Username',
                style: subtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: userProvider.usernameCtrl,
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
              padding: const EdgeInsets.fromLTRB(32, 20, 32, 10),
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
                textInputAction: TextInputAction.done,
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
                      color:
                          userProvider.isHide ? Colors.grey : Colors.deepPurple,
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
            GestureDetector(
                onTap: () {
                  if (userProvider.usernameCtrl.text.isNotEmpty &&
                      userProvider.pinCtrl.text.isNotEmpty) {
                    userProvider.login().then((value) => {
                          userProvider.status == 'isLoggedIn'
                              ? Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MyPage(),
                                  ))
                              : Future.delayed(const Duration(seconds: 3),
                                  () => showError(userProvider.errorMessage))
                        });
                  } else {
                    showError('Username / Pin is required');
                  }
                },
                child: userProvider.isLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        height: 60,
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(32, 10, 32, 10),
                        decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadius.circular(18)),
                        child: Center(
                            child: Text(
                          'Go',
                          style: titleStyle.copyWith(
                              color: lightGrey, fontWeight: FontWeight.w600),
                        )),
                      )),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: textStyle.copyWith(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    )),
                    child: Text(
                      'buat sekarang juga',
                      style: textStyle.copyWith(
                          fontSize: 14, color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
