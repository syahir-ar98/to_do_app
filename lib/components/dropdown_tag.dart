import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/services/controller.dart';
import 'package:to_do_app/services/providers.dart';

final formKey = GlobalKey<FormState>();

class DropdownTag extends ConsumerStatefulWidget {
  const DropdownTag({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DropdownTagState();
}

class _DropdownTagState extends ConsumerState<DropdownTag> {
  @override
  Widget build(BuildContext context) {
    final tagListAsyncValue = ref.watch(tagsListProvider);
    return Form(
      key: formKey,
      child: tagListAsyncValue.when(
        data: (data) {
          final list = List<String>.generate(data.docs.length, (index) {
            final tag = data.docs[index].data();
            return tag.tagName;
          });
          String? _selectedValue;
          return DropdownButtonFormField<String>(
            icon: const Icon(EvaIcons.chevronDownOutline, size: 24.0),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFDCDCDC)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF00897B), width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            hint: Text(
              "Select a tag",
              style: GoogleFonts.inter(
                color: const Color(0xFFA9A9A9),
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            value: _selectedValue,
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
                tagController.text = _selectedValue ?? "Important";
              });
            },
            validator: (value) {
              if (value == null) {
                return "Please choose a tag";
              }
              return null;
            },
          );
        },
        error: (e, st) => Text("Error $e"),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
