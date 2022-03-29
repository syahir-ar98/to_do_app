import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/components/sign_in.dart';
import 'package:to_do_app/components/sign_up.dart';
import 'package:to_do_app/pages/home/home.dart';

///Task 1: Landing Page

class LandingDesktop extends ConsumerWidget {
  const LandingDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('Landing - Desktop build');
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          // Sign In
          Expanded(
              child: PageView(
            controller: signInPageController,
            children: const [
              SignIn(),
              SignUp(),
            ],
          )),
          // Hero Content
          Expanded(
            child: Container(
              color: const Color(0xFFF5F5F5),
              child: Row(
                children: [
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 124.0,
                                height: 124.0,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF80CBC4), borderRadius: BorderRadius.circular(24.0)),
                              ),
                              Container(
                                width: 56.0,
                                height: 56.0,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF00695C), borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ],
                          ),
                          const SizedBox(width: 48.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "To-Do",
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF004D40),
                                  fontSize: 48.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.inter(fontSize: 48.0, fontWeight: FontWeight.w700),
                                  children: const [
                                    TextSpan(text: "App", style: TextStyle(color: Color(0xFF00BFA5))),
                                    TextSpan(text: ".", style: TextStyle(color: Color(0xFFC4421A))),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 120.0),
                      RichText(
                        text: TextSpan(
                            style: GoogleFonts.inter(fontSize: 36.0, fontWeight: FontWeight.w700),
                            children: const [
                              TextSpan(text: "S", style: TextStyle(color: Color(0xFFC4421A))),
                              TextSpan(text: "eamless", style: TextStyle(color: Color(0xFF00382E))),
                              TextSpan(text: ".", style: TextStyle(color: Color(0xFFC4421A))),
                            ]),
                      ),
                      const SizedBox(height: 16.0),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(fontSize: 36.0, fontWeight: FontWeight.w700),
                          children: const [
                            TextSpan(text: "G", style: TextStyle(color: Color(0xFFC4421A))),
                            TextSpan(text: "et it done", style: TextStyle(color: Color(0xFF00382E))),
                            TextSpan(text: ".", style: TextStyle(color: Color(0xFFC4421A))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(fontSize: 36.0, fontWeight: FontWeight.w700),
                          children: const [
                            TextSpan(text: "M", style: TextStyle(color: Color(0xFFC4421A))),
                            TextSpan(text: "ore Organize", style: TextStyle(color: Color(0xFF00382E))),
                            TextSpan(text: ".", style: TextStyle(color: Color(0xFFC4421A))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
