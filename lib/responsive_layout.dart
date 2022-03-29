import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/constants/breakpoints.dart';

class ResponsiveLayout extends ConsumerWidget {
  const ResponsiveLayout({
    Key? key,
    required this.mobileBody,
    this.tabletBody,
    this.desktopBody,
  }) : super(key: key);

  final Widget mobileBody;
  final Widget? tabletBody;
  final Widget? desktopBody;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, dimens) {
        if (dimens.maxWidth < kTabletBreakpoint) {
          return mobileBody;
        } else if (dimens.maxWidth < kDesktopBreakpoint) {
          return tabletBody ?? mobileBody;
        } else {
          return desktopBody ?? mobileBody;
        }
      },
    );
  }
}
