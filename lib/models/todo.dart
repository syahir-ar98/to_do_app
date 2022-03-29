import 'package:to_do_app/services/utils.dart';

class ToDo {
  String id;
  String title;
  String description;
  String tag;
  bool isCompleted;
  DateTime createdOn;

  ToDo({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.isCompleted,
    required this.createdOn,
  });

  ToDo.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          description: json['description'] as String,
          tag: json['tag'] as String,
          isCompleted: json['isCompleted'] as bool,
          createdOn: Utils.toDateTime(json['createdOn']),
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'tag': tag,
      'isCompleted': isCompleted,
      'createdOn': Utils.fromDateTimetoJson(createdOn),
    };
  }
}
