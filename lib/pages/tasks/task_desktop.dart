import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/components/add_todo.dart';
import 'package:to_do_app/components/todo_card.dart';
import 'package:to_do_app/pages/home/home.dart';
import 'package:to_do_app/services/providers.dart';

///Task 2: Todo List

class TaskDesktop extends ConsumerWidget {
  const TaskDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('Tasks - Desktop build');
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return const AddTodo();
              },
            );
          },
          backgroundColor: const Color(0xFFC4421A),
          label: Text(
            "ADD TASK",
            style: GoogleFonts.inter(
              color: const Color(0xFFFFFFFF),
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          icon: const Icon(
            EvaIcons.plus,
            size: 24.0,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(40.0),
        color: const Color(0xFFF5F5F5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tasks",
              style: GoogleFonts.inter(
                color: const Color(0xFF031C17),
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              width: double.maxFinite,
              height: 1.0,
              color: const Color(0xFFDCDCDC),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24.0, right: 8.0),
                  child: Icon(
                    EvaIcons.funnelOutline,
                    size: 24.0,
                    color: Color(0xFF00695C),
                  ),
                ),
                Text(
                  "Filter:",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF00695C),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 16.0),
                Row(
                  children: List.generate(listStatus.length, (index) {
                    return Consumer(
                      builder: (_, ref, __) {
                        final _state = ref.watch(stateFilterProvider(listStatus[index]));
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                ref.read(currentFilterProvider.state).state = listStatus[index];
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: _state ? const Color(0xFFA7FFEB) : const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(25.0),
                                  border: Border.all(color: _state ? Colors.transparent : const Color(0xFF808080)),
                                ),
                                child: Text(
                                  listStatus[index],
                                  style: GoogleFonts.inter(
                                    color: _state ? const Color(0xFF13A97D) : const Color(0xFF808080),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                )
              ],
            ),
            const SizedBox(height: 24.0),
            // List of ToDo
            Consumer(
              builder: (_, ref, __) {
                final filter = ref.watch(currentFilterProvider);
                final asyncValue = ref.watch(todoListByStatusProvider(filter));
                return asyncValue.when(
                  data: (data) => ListView.builder(
                    controller: ScrollController(),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      final document = data.docs[index];
                      final todo = document.data();
                      return ToDoCard(
                        id: document.id,
                        title: todo.title,
                        description: todo.description,
                        tagName: todo.tag,
                        isCompleted: todo.isCompleted,
                        createdOn: todo.createdOn,
                      );
                    },
                  ),
                  error: (e, st) {
                    debugPrint("Error: $e");
                    return Text("Error: $e");
                  },
                  loading: () => const Expanded(child: Center(child: CircularProgressIndicator())),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
