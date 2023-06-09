import 'package:flutter/material.dart';
import 'package:hionepedia/theme/styles.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Center(
              child: Image.asset(
                'assets/avatar/default_avatar.png',
                width: 200,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(32, 10, 32, 10),
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
            const Padding(
              padding: EdgeInsets.fromLTRB(32, 10, 32, 10),
              child: Text(
                'Umur',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
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
            const Padding(
              padding: EdgeInsets.fromLTRB(32, 10, 32, 10),
              child: Text(
                'Hobi',
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
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: 60,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(32, 40, 32, 10),
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(18)),
                child: const Center(
                    child: Text(
                  'Let\'s Go',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
