import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/services/providers.dart';

class NavigationRailButton extends ConsumerWidget {
  const NavigationRailButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.logic,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Function() logic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _state = ref.watch(stateMenuProvider(text));
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: 48.0,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              child: Row(
                children: [
                  Container(
                    width: 5.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: _state ? const Color(0xFF00BFA5) : Colors.transparent,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Icon(icon, size: 24.0, color: _state ? const Color(0xFF00BFA5) : const Color(0xFF808080)),
                  const SizedBox(width: 16.0),
                  Text(
                    text,
                    style: GoogleFonts.inter(
                      color: _state ? const Color(0xFF00BFA5) : const Color(0xFF808080),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(_state ? const Color(0xFFE0F2F1) : const Color(0xFFFFFFFF)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.only(left: 0.0, top: 14.0, bottom: 14.0),
                ),
                overlayColor: MaterialStateProperty.all(const Color(0xFFA7FFEB).withOpacity(0.3)),
              ),
              onPressed: logic,
            ),
          ),
        ),
        const SizedBox(height: 10.0)
      ],
    );
  }
}
