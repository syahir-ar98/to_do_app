import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/models/tag.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/services/controller.dart';
import 'package:to_do_app/services/utils.dart';

final _firestore = FirebaseFirestore.instance;

class DatabaseService {
  static final _todosRef = _firestore.collection("todos").withConverter(
        fromFirestore: (snapshot, _) => ToDo.fromJson(snapshot.data()!),
        toFirestore: (todo, _) => todo.toJson(),
      );

  static final _tagRef = _firestore.collection("tags").withConverter(
        fromFirestore: (snapshot, _) => Tag.fromJson(snapshot.data()!),
        toFirestore: (tag, _) => tag.toJson(),
      );

  Future<void> addTodo(String title, String desc, String tag) async {
    final _todoId = _todosRef.doc().id;
    await _todosRef
        .doc(_todoId)
        .set(ToDo(
          id: _todoId,
          title: title,
          description: desc,
          tag: tag,
          isCompleted: false,
          createdOn: DateTime.now().toLocal(),
        ))
        .then((value) => debugPrint("New task added."))
        .catchError(
          (error) => debugPrint("Failed to add new task."),
        );
  }

  Future<void> deleteTodo(String id) async {
    _todosRef
        .doc(id)
        .delete()
        .then((value) => debugPrint("Task deleted."))
        .catchError((error) => debugPrint("Failed to delete task."));
  }

  Future<void> updateTodo(String id, bool isUpdatingStatus, {bool? isCompleted}) async {
    isUpdatingStatus
        ? _todosRef
            .doc(id)
            .update({"isCompleted": isCompleted})
            .then((value) => debugPrint("Task status updated."))
            .catchError((error) => debugPrint("Fail to update task status."))
        : _todosRef
            .doc(id)
            .update({
              "title": titleController.text,
              "description": descController.text,
              "tag": tagController.text,
            })
            .then((value) => debugPrint("Task updated."))
            .catchError((error) => debugPrint("Fail update status."));
  }

  Stream<QuerySnapshot<ToDo>> fetchTodoListByStatus(String status) {
    switch (status) {
      case "Completed":
        return _todosRef.where("isCompleted", isEqualTo: true).orderBy("createdOn").snapshots();
      case "Active":
        return _todosRef.where("isCompleted", isEqualTo: false).orderBy("createdOn").snapshots();
      default:
        return _todosRef.orderBy("createdOn").snapshots();
    }
  }

  Stream<QuerySnapshot<ToDo>> fetchTodoListByTag(String tag) {
    return _todosRef.where("tag", isEqualTo: tag).snapshots();
  }

  Stream<QuerySnapshot<Tag>> fetchTagsList() {
    return _tagRef.snapshots();
  }

  Stream<DocumentSnapshot<Tag>> fetchTag(String id) {
    return _tagRef.doc(id).snapshots();
  }
}
