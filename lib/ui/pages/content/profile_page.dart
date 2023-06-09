import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/avatar/default_avatar.png',
          width: 200,
        ),
        const Text(
          'Afiv Dicky Efendy',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            '22 Tahun',
            style: TextStyle(fontSize: 18),
          ),
        ),
        const Text(
          'Membaca Manhwa',
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }
}
