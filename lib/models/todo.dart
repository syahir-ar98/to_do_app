import 'package:to_do_app/services/utils.dart';

class ToDo {
  String id;
  String title;
  String description;
  String tag;
  bool isCompleted;
  DateTime createdOn;
  String uid;

  ToDo({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.isCompleted,
    required this.createdOn,
    required this.uid,
  });

  ToDo.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          description: json['description'] as String,
          tag: json['tag'] as String,
          isCompleted: json['isCompleted'] as bool,
          createdOn: Utils.toDateTime(json['createdOn']),
          uid: json['uid'] as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'tag': tag,
      'isCompleted': isCompleted,
      'createdOn': Utils.fromDateTimetoJson(createdOn),
      'uid': uid,
    };
  }
}
