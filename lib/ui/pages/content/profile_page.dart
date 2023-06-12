import 'package:flutter/material.dart';
import 'package:hionepedia/extensions/custom_extension.dart';
import 'package:hionepedia/providers/user_provider.dart';
import 'package:hionepedia/ui/pages/authentication/login_page.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final myBox = Hive.box('userBox');
    final userActive = myBox.get('userActive');
    final userProvider = Provider.of<UserProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/avatar/default_avatar.png',
          width: 200,
        ),
        Text(
          userActive[1].toString().toTitleCase(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "${userActive[2]} Tahun",
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Text(
          userActive[3].toString().toTitleCase(),
          style: const TextStyle(fontSize: 18),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ElevatedButton.icon(
            onPressed: () {
              userProvider.logout().then((value) => {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ))
                  });
            },
            icon: const Icon(Icons.logout),
            label: const Text('Keluar'),
          ),
        )
      ],
    );
  }
}
