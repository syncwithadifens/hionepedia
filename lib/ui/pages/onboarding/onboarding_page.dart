import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hionepedia/theme/styles.dart';
import 'package:hionepedia/ui/widgets/onboarding_indicator.dart';

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
        resizeToAvoidBottomInset: false,
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
            OnboardingIndicator(pageCtrl: _pageCtrl, onLastPage: _onLastPage),
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
              height: MediaQuery.of(context).size.height * 0.5,
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
            'Aplikasi pembelajaran yang akan mengubah cara kamu belajar. Kenali beragam hewan langka di ujung jari jarimu.',
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
              height: MediaQuery.of(context).size.height * 0.4,
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
              height: MediaQuery.of(context).size.height * 0.4,
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
