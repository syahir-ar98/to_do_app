import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/models/tag.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/models/user.dart';
import 'package:to_do_app/services/controller.dart';

///Task 2: Todo List (CRUD)
///Task 5: Database

final _firestore = FirebaseFirestore.instance;

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final _todosRef = _firestore.collection("todos").withConverter(
        fromFirestore: (snapshot, _) => ToDo.fromJson(snapshot.data()!),
        toFirestore: (todo, _) => todo.toJson(),
      );

  final _tagRef = _firestore.collection("tags").withConverter(
        fromFirestore: (snapshot, _) => Tag.fromJson(snapshot.data()!),
        toFirestore: (tag, _) => tag.toJson(),
      );

  final _userRef = _firestore.collection("users").withConverter(
        fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
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
          uid: uid,
        ))
        .then((value) => debugPrint("New task added."))
        .catchError(
          (error) => debugPrint("Failed to add new task."),
        );
  }

  Future<void> deleteTodo(String id) async {
    await _todosRef
        .doc(id)
        .delete()
        .then((value) => debugPrint("Task deleted."))
        .catchError((error) => debugPrint("Failed to delete task."));
  }

  Future<void> updateTodo(String id, bool isUpdatingStatus,
      {bool? isCompleted}) async {
    isUpdatingStatus
        ? await _todosRef
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

  Stream<QuerySnapshot<ToDo>> fetchTodoList() {
    return _todosRef
        .where("uid", isEqualTo: uid)
        .orderBy("createdOn")
        .snapshots();
  }

  Future<void> addTag() async {
    final _tagId = _tagRef.doc().id;
    await _tagRef
        .doc(_tagId)
        .set(Tag(
          tagName: tagController.text,
          bgColor: tagBgColorController.text,
          textColor: tagTextColorController.text,
          uid: uid,
        ))
        .then((value) => print("Tag [${tagController.text}] Added"))
        .catchError((error) => print("Fail adding tag"));
  }

  Stream<QuerySnapshot<Tag>> fetchTagList() {
    return _tagRef.snapshots();
  }

  Future<void> addUser(String name, String occupation) async {
    await _userRef
        .doc(uid)
        .set(UserData(
          name: name,
          uid: uid,
          occupation: occupation,
        ))
        .then((value) => debugPrint("New User Added"))
        .catchError((error) => debugPrint("Fail to add new user."));
  }

  Future<DocumentSnapshot<UserData>> fetchUser() {
    return _userRef.doc(uid).get();
  }
}
