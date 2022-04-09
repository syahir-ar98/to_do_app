import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/components/add_todo.dart';
import 'package:to_do_app/components/summary_content.dart';
import 'package:to_do_app/components/tags_content.dart';
import 'package:to_do_app/services/providers.dart';

class OverviewDesktop extends ConsumerWidget {
  const OverviewDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('Overview - Desktop build');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(
              left: 32.0, right: 32.0, top: 32.0, bottom: 24.0),
          color: const Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Overview",
                style: GoogleFonts.inter(
                  color: const Color(0xFF031C17),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        // Content
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
                left: 32.0, right: 32.0, top: 24.0, bottom: 32.0),
            color: const Color(0xFFF5F5F5),
            child: Row(
              children: [
                // Column 1
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Summary
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: const EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 48.0,
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE0F2F1),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: const Icon(
                                      EvaIcons.calendarOutline,
                                      color: Color(0xFF00BFA5),
                                      size: 24.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      "Summary",
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF00382E),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        height: 48.0,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFDC59F),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              EvaIcons.plus,
                                              size: 24.0,
                                              color: Color(0xFFC4421A),
                                            ),
                                            const SizedBox(width: 8.0),
                                            Text(
                                              "TASK",
                                              style: GoogleFonts.inter(
                                                color: const Color(0xFFC4421A),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const AddTodo();
                                          },
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 24.0),
                              const SummaryContent(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      // Tags
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: const EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 48.0,
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE0F2F1),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: const Icon(
                                      EvaIcons.bookmarkOutline,
                                      color: Color(0xFF00BFA5),
                                      size: 24.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      "Tags",
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF00382E),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  // MouseRegion(
                                  //   cursor: SystemMouseCursors.click,
                                  //   child: GestureDetector(
                                  //     behavior: HitTestBehavior.translucent,
                                  //     child: Container(
                                  //       height: 48.0,
                                  //       padding: const EdgeInsets.symmetric(
                                  //           horizontal: 16.0),
                                  //       decoration: BoxDecoration(
                                  //         color: const Color(0xFFFDC59F),
                                  //         borderRadius:
                                  //             BorderRadius.circular(8.0),
                                  //       ),
                                  //       child: Row(
                                  //         children: [
                                  //           const Icon(
                                  //             EvaIcons.editOutline,
                                  //             size: 24.0,
                                  //             color: Color(0xFFC4421A),
                                  //           ),
                                  //           const SizedBox(width: 8.0),
                                  //           Text(
                                  //             "EDIT",
                                  //             style: GoogleFonts.inter(
                                  //               color: const Color(0xFFC4421A),
                                  //               fontSize: 16.0,
                                  //               fontWeight: FontWeight.w700,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     onTap: () {},
                                  //   ),
                                  // )
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              const Expanded(child: TagsContent()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24.0),
                Expanded(
                  child: Container(
                    height: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 56.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            "WELCOME BACK",
                            style: GoogleFonts.inter(
                              color: const Color(0xFF696969),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 48.0),
                          child: Consumer(
                            builder: (_, ref, __) {
                              final _userAsync = ref.watch(userProvider);
                              return _userAsync.when(
                                data: (data) {
                                  final _user = data.data()!;
                                  return Text(
                                    _user.name,
                                    style: GoogleFonts.inter(
                                      fontSize: 36.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                                },
                                error: (e, st) => Text("Error: $e"),
                                loading: () => const Center(
                                    child: CircularProgressIndicator()),
                              );
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 48.0),
                        //   child: Container(
                        //     height: 2.0,
                        //     decoration:
                        //         const BoxDecoration(color: Color(0xFFDCDCDC)),
                        //   ),
                        // ),
                        // MouseRegion(
                        //   cursor: SystemMouseCursors.click,
                        //   child: GestureDetector(
                        //     behavior: HitTestBehavior.translucent,
                        //     child: Container(
                        //       height: 48.0,
                        //       padding:
                        //           const EdgeInsets.symmetric(horizontal: 16.0),
                        //       decoration: BoxDecoration(
                        //         color: const Color(0xFFFDC59F),
                        //         borderRadius: BorderRadius.circular(8.0),
                        //       ),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           const Icon(
                        //             EvaIcons.plus,
                        //             size: 24.0,
                        //             color: Color(0xFFC4421A),
                        //           ),
                        //           const SizedBox(width: 8.0),
                        //           Text(
                        //             "ADD NEW TASK",
                        //             style: GoogleFonts.inter(
                        //               color: const Color(0xFFC4421A),
                        //               fontSize: 16.0,
                        //               fontWeight: FontWeight.w700,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     onTap: () {
                        //       showDialog(
                        //         barrierDismissible: false,
                        //         context: context,
                        //         builder: (BuildContext context) {
                        //           return const AddTodo();
                        //         },
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
