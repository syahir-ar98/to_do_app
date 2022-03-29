import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/components/dropdown_tag.dart';
import 'package:to_do_app/services/controller.dart';
import 'package:to_do_app/services/providers.dart';

class AddTodo extends ConsumerWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 600.0,
          height: 550.0,
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: Text(
                  "Create new Task",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF031C17),
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: titleController,
                  cursorColor: const Color(0xFF00897B),
                  cursorWidth: 2.0,
                  cursorHeight: 22.0,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFDCDCDC)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: "Title",
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
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: descController,
                  cursorColor: const Color(0xFF00897B),
                  cursorWidth: 2.0,
                  cursorHeight: 22.0,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFDCDCDC)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: "Description",
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
              ),
              const DropdownTag(),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.0,
                      child: TextButton(
                        onPressed: () {
                          titleController.clear();
                          descController.clear();
                          tagController.clear();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "CANCEL",
                          style: GoogleFonts.inter(
                            color: const Color(0xFF00897B),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(color: Color(0xFF00897B)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  Expanded(
                    child: SizedBox(
                      height: 48.0,
                      child: Consumer(
                        builder: (context, ref, child) {
                          return TextButton(
                            child: Text(
                              "ADD TASK",
                              style: GoogleFonts.inter(
                                color: const Color(0xFFFFFFFF),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ref.read(firestoreServiceProvider).addTodo(
                                      titleController.text,
                                      descController.text,
                                      tagController.text,
                                    );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    width: 400.0,
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
                                          "New Task Added Successfully!",
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
                                );
                                titleController.clear();
                                descController.clear();
                                tagController.clear();
                                Navigator.of(context).pop();
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0xFF00897B)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
