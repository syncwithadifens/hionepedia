import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hionepedia/providers/animal_provider.dart';
import 'package:hionepedia/providers/favorite_provider.dart';
import 'package:hionepedia/ui/pages/favorite_page.dart';
import 'package:hionepedia/ui/pages/home_page.dart';
import 'package:hionepedia/ui/pages/login_page.dart';
import 'package:hionepedia/ui/pages/profile_page.dart';
import 'package:hionepedia/ui/widgets/custom_bottom_navbar.dart';
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
        home: LoginPage(),
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    const HomePage(),
    const FavoritePage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
                bottomBarPages.length, (index) => bottomBarPages[index]),
          ),
          extendBody: true,
          bottomNavigationBar: CustomBottomNavbar(
              controller: _controller, pageController: _pageController)),
    );
  }
}
