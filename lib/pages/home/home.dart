import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/constants/max_width_container.dart';
import 'package:to_do_app/pages/home/home_desktop.dart';
import 'package:to_do_app/pages/home/home_mobile.dart';
import 'package:to_do_app/pages/home/home_tablet.dart';
import 'package:to_do_app/responsive_layout.dart';

PageController pageController = PageController();
PageController signInPageController = PageController();

const List<String> listStatus = ["All", "Completed", "Active"];

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFF5F5F5),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: MaxWidthContainer(
            child: ResponsiveLayout(
              mobileBody: const HomeMobile(),
              tabletBody: const HomeTablet(),
              desktopBody: HomeDesktop(),
            ),
          ),
        ),
      ),
    );
  }
}

void navigateToPage(int index) {
  pageController.jumpToPage(index);
}

void navigateToSignInPage(int index) {
  signInPageController.jumpToPage(index);
}
