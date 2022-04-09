import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/components/nav_rail_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:to_do_app/pages/home/home.dart';
import 'package:to_do_app/services/controller.dart';
import 'package:to_do_app/services/providers.dart';

class CustomNavigationRail extends ConsumerStatefulWidget {
  const CustomNavigationRail({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomNavigationRailState();
}

List<String> listMenu = [
  "Overview",
  "Tasks",
];

List<IconData> listIconNavRail = const [
  EvaIcons.homeOutline,
  EvaIcons.gridOutline,
];

class _CustomNavigationRailState extends ConsumerState<CustomNavigationRail> {
  @override
  Widget build(BuildContext context) {
    debugPrint("NavRail build");
    return Container(
      padding: const EdgeInsets.only(
          top: 32.0, bottom: 32.0, right: 8.0, left: 24.0),
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Color(0xFFF5F5F5))),
        color: Color(0xFFFFFFFF),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: 256, maxHeight: MediaQuery.of(context).size.height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 48.0),
              child: Row(
                children: [
                  // Add your logo here
                  // Image.asset(
                  //   "assets/images/logo-toDoApp.png",
                  //   width: 32.0,
                  //   height: 32.0,
                  // ),
                  Container(
                    width: 32.0,
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF80CBC4),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 16.0,
                      height: 16.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00695C),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w800, fontSize: 18.0),
                      children: const [
                        TextSpan(
                            text: "To-Do ",
                            style: TextStyle(color: Color(0xFF004D40))),
                        TextSpan(
                            text: "App",
                            style: TextStyle(color: Color(0xFF00BFA5))),
                        TextSpan(
                            text: ".",
                            style: TextStyle(color: Color(0xFFC4421A))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Text(
                "MENU",
                style: GoogleFonts.inter(
                  color: const Color(0xFFA9A9A9),
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Column(
              children: List.generate(
                listMenu.length,
                (index) => NavigationRailButton(
                  text: listMenu[index],
                  icon: listIconNavRail[index],
                  logic: () {
                    ref.read(currentMenuProvider.state).state = listMenu[index];
                    navigateToPage(index);
                  },
                ),
              ),
            ),
            const Spacer(),
            NavigationRailButton(
              text: "Sign Out",
              icon: EvaIcons.logOutOutline,
              logic: () {
                ref.read(currentMenuProvider.state).state = "Overview";
                ref.read(authServiceProvider).signOut();
                emailController.clear();
                passwordController.clear();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                width: double.maxFinite,
                height: 1.0,
                color: const Color(0xFFEEEEEE),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 80.0,
              padding: const EdgeInsets.only(left: 24.0, right: 8.0, top: 16.0),
              child: Row(
                children: [
                  Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: const Color(0xFFE0F2F1),
                    ),
                    child: const Center(
                      child: Icon(
                        EvaIcons.personOutline,
                        color: Color(0xFF00BFA5),
                        size: 24.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Consumer(
                      builder: (_, ref, __) {
                        final _user = ref.watch(userProvider);
                        return _user.when(
                          data: (data) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.data()!.name,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF696969),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  data.data()!.occupation,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF00695C),
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            );
                          },
                          error: (e, st) => Text("Error: $e"),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  ),
                  // const Spacer(),
                  // Container(
                  //   width: 40.0,
                  //   height: 40.0,
                  //   alignment: Alignment.center,
                  //   child: const Icon(
                  //     EvaIcons.moreVertical,
                  //     color: Color(0xFF00695C),
                  //     size: 24.0,
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
