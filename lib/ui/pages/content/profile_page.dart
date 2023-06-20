import 'package:flutter/material.dart';
import 'package:hionepedia/extensions/custom_extension.dart';
import 'package:hionepedia/providers/user_provider.dart';
import 'package:hionepedia/theme/styles.dart';
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
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Image.asset(
            'assets/avatar/default_avatar.png',
            width: 170,
          ),
        ),
        Text(
          userActive[1].toString().toTitleCase(),
          style: titleStyle.copyWith(fontWeight: FontWeight.w700),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "${userActive[2]} Tahun",
            style: subtitleStyle,
          ),
        ),
        Text(
          userActive[3].toString().toTitleCase(),
          style: textStyle,
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
