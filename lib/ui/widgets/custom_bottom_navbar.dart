import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hionepedia/theme/styles.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({
    super.key,
    required NotchBottomBarController controller,
    required PageController pageController,
  })  : _controller = controller,
        _pageController = pageController;

  final NotchBottomBarController _controller;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return AnimatedNotchBottomBar(
      notchBottomBarController: _controller,
      color: Colors.white,
      showLabel: true,
      notchColor: primaryColor,
      removeMargins: false,
      bottomBarWidth: 500,
      durationInMilliSeconds: 300,
      bottomBarItems: const [
        BottomBarItem(
          inActiveItem: Icon(
            Icons.home_outlined,
            color: Colors.grey,
          ),
          activeItem: Icon(
            Icons.home_filled,
            color: Colors.white,
          ),
          itemLabel: 'Home',
        ),
        BottomBarItem(
          inActiveItem: Icon(
            Icons.favorite_border,
            color: Colors.grey,
          ),
          activeItem: Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          itemLabel: 'Favorite',
        ),
        BottomBarItem(
          inActiveItem: Icon(
            Icons.person_2_outlined,
            color: Colors.grey,
          ),
          activeItem: Icon(
            Icons.person,
            color: Colors.white,
          ),
          itemLabel: 'Account',
        ),
      ],
      onTap: (index) {
        _pageController.jumpToPage(index);
      },
    );
  }
}
