import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/pages/home/home.dart';
import 'package:to_do_app/services/controller.dart';
import 'package:to_do_app/services/providers.dart';

class SignIn extends ConsumerWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 120.0),
      color: const Color(0xFFFFFFFF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sign In",
            style: GoogleFonts.inter(
              color: const Color(0xFF004D40),
              fontSize: 36.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 40.0),
          Container(
            width: 60.0,
            height: 5.0,
            decoration: BoxDecoration(
              color: const Color(0xFFC4421A),
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          const SizedBox(height: 40.0),
          Text(
            "Don't have an account?",
            style: GoogleFonts.inter(
              color: const Color(0xFF808080),
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                navigateToSignInPage(1);
              },
              child: Text(
                "Sign Up here",
                style: GoogleFonts.inter(
                  color: const Color(0xFF00BFA5),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          TextFormField(
            controller: emailController,
            cursorColor: const Color(0xFF00897B),
            cursorWidth: 2.0,
            cursorHeight: 22.0,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFDCDCDC)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              labelText: "Email Address",
              labelStyle: GoogleFonts.inter(
                color: const Color(0xFFA9A9A9),
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF00897B), width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            style: GoogleFonts.inter(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: passwordController,
            cursorColor: const Color(0xFF00897B),
            cursorWidth: 2.0,
            cursorHeight: 22.0,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFDCDCDC)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              labelText: "Password",
              labelStyle: GoogleFonts.inter(
                color: const Color(0xFFA9A9A9),
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF00897B), width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            style: GoogleFonts.inter(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30.0),
          SizedBox(
            height: 48.0,
            width: double.maxFinite,
            child: TextButton(
              onPressed: () {
                ref.read(firebaseAuthServiceProvider).signIn(emailController.text, passwordController.text).then(
                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          width: 300.0,
                          backgroundColor: const Color(0xFFA7FFEB),
                          behavior: SnackBarBehavior.floating,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 16.0),
                                child: Icon(
                                  EvaIcons.checkmarkCircle2Outline,
                                  size: 24.0,
                                  color: Color(0xFF009688),
                                ),
                              ),
                              Text(
                                value,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF009688),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          duration: const Duration(milliseconds: 2000),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                    );
              },
              child: Text(
                "SIGN IN",
                style: GoogleFonts.inter(
                  color: const Color(0xFFFFFFFF),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF00897B)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
