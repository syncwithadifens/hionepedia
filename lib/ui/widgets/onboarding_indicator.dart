import 'package:flutter/material.dart';
import 'package:hionepedia/theme/styles.dart';
import 'package:hionepedia/ui/pages/authentication/login_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    super.key,
    required PageController pageCtrl,
    required bool onLastPage,
  })  : _pageCtrl = pageCtrl,
        _onLastPage = onLastPage;

  final PageController _pageCtrl;
  final bool _onLastPage;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      style: textStyle.copyWith(fontWeight: FontWeight.w600),
                    ))
                : GestureDetector(
                    onTap: () {
                      _pageCtrl.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    child: Text(
                      'Lanjut',
                      style: textStyle.copyWith(fontWeight: FontWeight.w600),
                    ))
          ],
        ));
  }
}
