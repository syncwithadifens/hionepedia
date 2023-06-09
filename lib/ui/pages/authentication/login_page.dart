import 'package:flutter/material.dart';
import 'package:hionepedia/theme/styles.dart';
import 'package:hionepedia/ui/pages/authentication/register_page.dart';
import 'package:hionepedia/ui/pages/content/mypage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(
                    left: 12, right: 12, top: 12, bottom: 30),
                height: 430,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffF6C3BF)),
                child:
                    Center(child: Image.asset('assets/illustration/vr.png'))),
            const Center(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(32, 30, 32, 10),
              child: Text(
                'Username',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
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
            const Padding(
              padding: EdgeInsets.fromLTRB(32, 30, 32, 10),
              child: Text(
                'Pin',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.visibility,
                      color: Colors.deepPurple,
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
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyPage(),
                  )),
              child: Container(
                height: 60,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(32, 40, 32, 10),
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(18)),
                child: const Center(
                    child: Text(
                  'Go',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Belum punya akun? ',
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    )),
                    child: const Text(
                      'buat sekarang juga',
                      style: TextStyle(fontSize: 14, color: Colors.deepPurple),
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
