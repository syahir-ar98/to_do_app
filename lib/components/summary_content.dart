import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/pages/home/home.dart';
import 'package:to_do_app/services/providers.dart';

class SummaryContent extends ConsumerWidget {
  const SummaryContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(listStatus.length, (index) {
          final _count = ref.watch(todoListByStatusProvider(listStatus[index]));
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70.0,
                height: 70.0,
                alignment: Alignment.center,
                child: _count.when(
                  data: (data) {
                    return Text(
                      data.docs.length.toString(),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF18312C),
                        fontSize: 48.0,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                  error: (e, st) => Text("Error: $e"),
                  loading: () => const CircularProgressIndicator(),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                listStatus[index] == "All" ? "Total" : listStatus[index],
                style: GoogleFonts.inter(
                  color: const Color(0xFF808080),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
