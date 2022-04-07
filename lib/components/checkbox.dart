import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/services/providers.dart';

class CustomCheckBox extends ConsumerStatefulWidget {
  const CustomCheckBox({
    Key? key,
    required this.isCompleted,
    required this.id,
  }) : super(key: key);

  final bool isCompleted;
  final String id;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends ConsumerState<CustomCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    debugPrint("isChecked: $isChecked");
    debugPrint("isCompleted: ${widget.isCompleted}");
    return Transform.scale(
      scale: 1.2,
      child: Checkbox(
        value: isChecked = widget.isCompleted,
        shape: const CircleBorder(),
        hoverColor: Colors.transparent,
        activeColor: const Color(0xFF13A97D),
        onChanged: (value) {
          setState(() {
            isChecked = value!;
          });
          ref
              .read(dataServiceProvider)
              .updateTodo(widget.id, true, isCompleted: value);
          debugPrint("Value: $value.");
        },
      ),
    );
  }
}
