import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hionepedia/theme/styles.dart';
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
                alignment: const Alignment(0, 0.85),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            )),
                        child: Text(
                          'Lewati',
                          style: textStyle.copyWith(color: Colors.grey),
                        )),
                    SmoothPageIndicator(controller: _pageCtrl, count: 3),
                    _onLastPage
                        ? GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                )),
                            child: Text(
                              'Selesai',
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.w600),
                            ))
                        : GestureDetector(
                            onTap: () {
                              _pageCtrl.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            child: Text(
                              'Lanjut',
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.w600),
                            ))
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
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 50),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/illustration/confuse.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              'Cara baru belajar',
              style: titleStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            'Aplikasi pembelajaran yang akan mengubah cara Anda belajar. Kenali beragam hewan langkai di ujung jari Anda.',
            style: textStyle.copyWith(fontSize: 14),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}

class IntroPageTwo extends StatelessWidget {
  const IntroPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 100),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/illustration/favorite.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              'Fitur Favorite',
              style: titleStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            'Buat koleksi hewan pribadi dengan fitur Favorite. Tandai hewan yang disuka dan lihat kembali saat Anda membutuhkannya.',
            style: textStyle.copyWith(fontSize: 14),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}

class IntroPageThree extends StatelessWidget {
  const IntroPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 100),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/illustration/tryit.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              'Mulai belajar',
              style: titleStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            'Ayo mulai petualangan belajar! Temukan fitur-fitur canggih aplikasi  dan nikmati pengalaman belajar yang tak terlupakan.',
            style: textStyle.copyWith(fontSize: 14),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
