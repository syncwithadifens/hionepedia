import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hionepedia/providers/animal_provider.dart';
import 'package:hionepedia/providers/favorite_provider.dart';
import 'package:hionepedia/providers/user_provider.dart';
import 'package:hionepedia/theme/styles.dart';
import 'package:hionepedia/ui/pages/content/mypage.dart';
import 'package:hionepedia/ui/pages/onboarding/onboarding_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  runApp(const MainApp());
  await Future.delayed(
    const Duration(seconds: 2),
    () {
      FlutterNativeSplash.remove();
    },
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final myBox = Hive.box('userBox');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AnimalProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Hionepedia Apps',
        theme: ThemeData(primaryColor: primaryColor),
        debugShowCheckedModeBanner: false,
        home: myBox.keys.contains('userActive')
            ? const MyPage()
            : const OnboardingPage(),
      ),
    );
  }
}
