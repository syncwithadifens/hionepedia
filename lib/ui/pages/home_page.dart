import 'package:flutter/material.dart';
import 'package:hionepedia/theme/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Hionepedia',
              style: logoTeks,
            )
          ],
        ),
      ),
    );
  }
}
