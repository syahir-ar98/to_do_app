import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingTablet extends ConsumerWidget {
  const LandingTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('Tablet build');
    return Center(
      child: Text(
        'Tablet Layout in Development',
        style: GoogleFonts.inter(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
