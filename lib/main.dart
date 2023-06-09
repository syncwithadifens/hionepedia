import 'package:flutter/material.dart';
import 'package:hionepedia/providers/animal_provider.dart';
import 'package:hionepedia/providers/favorite_provider.dart';
import 'package:hionepedia/ui/pages/onboarding/onboarding_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AnimalProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnboardingPage(),
      ),
    );
  }
}
