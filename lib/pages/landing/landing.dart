import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/pages/landing/landing_desktop.dart';
import 'package:to_do_app/constants/max_width_container.dart';
import 'package:to_do_app/pages/landing/landing_mobile.dart';
import 'package:to_do_app/responsive_layout.dart';
import 'package:to_do_app/pages/landing/landing_tablet.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  Widget build(BuildContext context) {
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
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: MaxWidthContainer(
            child: ResponsiveLayout(
              mobileBody: LandingMobile(),
              tabletBody: LandingTablet(),
              desktopBody: LandingDesktop(),
            ),
          ),
        ),
      ),
    );
  }
}
