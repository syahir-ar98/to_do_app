import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/components/editdropdown_tag.dart';
import 'package:to_do_app/services/controller.dart';
import 'package:to_do_app/services/firestore_database.dart';
import 'package:to_do_app/services/providers.dart';

class EditTodo extends ConsumerWidget {
  const EditTodo({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
  }) : super(key: key);

  final String id;
  final String title;
  final String description;
  final String tag;

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
                  "Edit Task",
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
                  controller: titleController..text = title,
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
                      borderSide: const BorderSide(
                          color: Color(0xFF00897B), width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  style: GoogleFonts.inter(
                      fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: descController..text = description,
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
                      borderSide: const BorderSide(
                          color: Color(0xFF00897B), width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  style: GoogleFonts.inter(
                      fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ),
              EditDropdownTag(tag: tag),
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
                      child: TextButton(
                        onPressed: () {
                          ref.watch(dataServiceProvider).updateTodo(id, false);
                          titleController.clear();
                          descController.clear();
                          tagController.clear();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "UPDATE TASK",
                          style: GoogleFonts.inter(
                            color: const Color(0xFFFFFFFF),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF00897B)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                        ),
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
