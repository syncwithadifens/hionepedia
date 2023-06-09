import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hionepedia/ui/pages/authentication/login_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageCtrl = PageController();
  bool _onLastPage = false;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _pageCtrl,
              onPageChanged: (value) {
                setState(() {
                  _onLastPage = value == 2;
                });
              },
              children: const [
                IntroPageOne(),
                IntroPageTwo(),
                IntroPageThree(),
              ],
            ),
            Container(
                alignment: const Alignment(0, 0.80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            )),
                        child: const Text('Skip')),
                    SmoothPageIndicator(controller: _pageCtrl, count: 3),
                    _onLastPage
                        ? GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                )),
                            child: const Text('Done'))
                        : GestureDetector(
                            onTap: () {
                              _pageCtrl.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            child: const Text('Next'))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class IntroPageOne extends StatelessWidget {
  const IntroPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset(
          'assets/illustration/confuse.png',
          width: 300,
        ),
      ),
    );
  }
}

class IntroPageTwo extends StatelessWidget {
  const IntroPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.asset(
            'assets/illustration/favorite.png',
            width: 300,
          )),
    );
  }
}

class IntroPageThree extends StatelessWidget {
  const IntroPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.asset(
            'assets/illustration/tryit.png',
            width: 300,
          )),
    );
  }
}
