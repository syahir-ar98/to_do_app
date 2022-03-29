import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/services/providers.dart';

class TagsContent extends ConsumerWidget {
  const TagsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagListAsyncValue = ref.watch(tagsListProvider);

    return tagListAsyncValue.when(
      data: (data) {
        return DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text("Tag")),
            DataColumn(label: Text("Count")),
          ],
          rows: List<DataRow>.generate(data.docs.length, (index) {
            final tag = data.docs[index].data();

            final todoListByTag = ref.watch(todoListByTagProvider(tag.tagName));
            return DataRow(cells: <DataCell>[
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: tag.getBgColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    tag.tagName,
                    style: GoogleFonts.inter(
                      color: tag.getTextColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              todoListByTag.when(
                  data: (data) {
                    return DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Text(
                          data.docs.length.toString(),
                          style: GoogleFonts.inter(
                            color: const Color(0xFF000000),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  },
                  error: (e, st) => DataCell(Text("Error $e")),
                  loading: () => const DataCell(CircularProgressIndicator()))
            ]);
          }),
        );
      },
      error: (e, st) => Text("Error: $e"),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
