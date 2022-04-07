import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/components/dropdown_tag.dart';
import 'package:to_do_app/pages/home/home.dart';
import 'package:to_do_app/services/controller.dart';
import 'package:to_do_app/services/providers.dart';

final dropdownOccupationKey = GlobalKey<FormState>();

class SignUp extends ConsumerStatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  @override
  Widget build(BuildContext context) {
    String? occupationValue;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 120.0),
      color: const Color(0xFFFFFFFF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sign Up",
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
            "Already have an account?",
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
                navigateToSignInPage(0);
              },
              child: Text(
                "Sign In here",
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
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextFormField(
              controller: nameController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: const Color(0xFF00897B),
              cursorWidth: 2.0,
              cursorHeight: 22.0,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFDCDCDC)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                labelText: "Name",
                labelStyle: GoogleFonts.inter(
                  color: const Color(0xFFA9A9A9),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF00897B), width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              style: GoogleFonts.inter(
                  fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
          ),
          Form(
            key: dropdownOccupationKey,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: DropdownButtonFormField<String>(
                icon: const Icon(EvaIcons.chevronDownOutline, size: 24.0),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFDCDCDC)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFF00897B), width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                hint: Text(
                  "Select an occupation",
                  style: GoogleFonts.inter(
                    color: const Color(0xFFA9A9A9),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: occupationValue,
                items: <String>['Student', 'Teacher', 'Developer']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    occupationValue = value;
                    occupationController.text = occupationValue!;
                    debugPrint("occupationValue:$occupationValue");
                    debugPrint(
                        "occupationController:${occupationController.text}");
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Please choose a tag";
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
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
                  borderSide:
                      const BorderSide(color: Color(0xFF00897B), width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              style: GoogleFonts.inter(
                  fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
          ),
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
                borderSide:
                    const BorderSide(color: Color(0xFF00897B), width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            style:
                GoogleFonts.inter(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30.0),
          SizedBox(
            height: 48.0,
            width: double.maxFinite,
            child: TextButton(
              onPressed: () {
                if (dropdownOccupationKey.currentState!.validate()) {
                  debugPrint("name:${nameController.text}");
                  debugPrint("occ:${occupationController.text}");
                  debugPrint("email:${emailController.text}");
                  debugPrint("pass:${passwordController.text}");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Creating Account.')),
                  );
                  ref.watch(authServiceProvider).signUp(
                        nameController.text,
                        occupationController.text,
                        emailController.text,
                        passwordController.text,
                      );
                }
              },
              child: Text(
                "SIGN UP",
                style: GoogleFonts.inter(
                  color: const Color(0xFFFFFFFF),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF00897B)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
