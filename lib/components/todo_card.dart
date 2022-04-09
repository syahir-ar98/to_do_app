import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/components/checkbox.dart';
import 'package:to_do_app/components/edit_todo.dart';
import 'package:to_do_app/services/providers.dart';

class ToDoCard extends ConsumerWidget {
  const ToDoCard({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.tagName,
    required this.isCompleted,
    required this.createdOn,
  }) : super(key: key);

  final String id;
  final String title;
  final String description;
  final String tagName;
  final bool isCompleted;
  final DateTime createdOn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: CustomCheckBox(
                isCompleted: isCompleted,
                id: id,
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF2C4F44),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF696969),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            // Created On
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Created on",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF808080),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    dateFormatter(createdOn),
                    style: GoogleFonts.inter(
                      color: const Color(0xFF13A97D),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            // Tag
            _buildTag(),
            // More Actions [Edit, Delete]
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Edit Task Button
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Tooltip(
                      message: "Edit Task",
                      preferBelow: false,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            alignment: Alignment.center,
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFB8FFC4),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Icon(
                              EvaIcons.editOutline,
                              color: Color(0xFF40C297),
                              size: 24.0,
                            ),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return EditTodo(
                                      id: id,
                                      title: title,
                                      description: description,
                                      tag: tagName);
                                });
                            debugPrint("Edit task clicked.");
                          },
                        ),
                      ),
                    ),
                  ),
                  // Delete Task Button
                  Tooltip(
                    message: "Delete Task",
                    preferBelow: false,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          alignment: Alignment.center,
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFB8B8),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Icon(
                            EvaIcons.trash2Outline,
                            color: Color(0xFFC24040),
                            size: 24.0,
                          ),
                        ),
                        onTap: () {
                          ref.read(dataServiceProvider).deleteTodo(id);
                          debugPrint("Task $title deleted.");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTag() {
    return Consumer(
      builder: (_, ref, __) {
        final asyncTag = ref.watch(specificTagProvider(tagName));
        return asyncTag.when(
          data: (tag) {
            return Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: tag.getBgColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      tag.getTagName,
                      style: GoogleFonts.inter(
                        color: tag.getTextColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          error: (e, st) => Text("Error: $e"),
          loading: () => Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 100.0,
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    "",
                    style: GoogleFonts.inter(
                      color: Colors.transparent,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

String dateFormatter(DateTime createdOn) {
  return DateFormat("dd-MM-yyyy").format(createdOn);
}
