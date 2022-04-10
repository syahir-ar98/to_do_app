// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/models/user.dart';
import 'package:to_do_app/services/firebase_authentication.dart';
import 'package:to_do_app/services/firestore_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/models/tag.dart';

// NavMenu Button Provider
final currentMenuProvider = StateProvider<String>((ref) => "Overview");

final stateMenuProvider = Provider.family<bool, String>((ref, navMenu) {
  final currentMenu = ref.watch(currentMenuProvider);
  return currentMenu == navMenu;
});

// Filter Button Provider
final currentFilterProvider = StateProvider<String>((ref) => "All");

final stateFilterProvider = Provider.family<bool, String>((ref, filter) {
  final currentFilter = ref.watch(currentFilterProvider);
  return currentFilter == filter;
});

// Firestore Database Provider
final dataServiceProvider = Provider((ref) {
  ref.watch(authStateProvider);
  final _userId = ref.watch(authProvider).currentUser!.uid;
  return DatabaseService(uid: _userId);
});

/// Fetching All Todos
final todosProvider = StreamProvider<QuerySnapshot<ToDo>>((ref) {
  return ref.watch(dataServiceProvider).fetchTodoList();
});

/// Fetching Filtered Todos
final filteredTodosProvider = FutureProvider.family<List<ToDo>, String>(
  (ref, filter) {
    final asyncTodos = ref.watch(todosProvider);
    final List<ToDo> todos = asyncTodos.when(
      data: (data) {
        List<ToDo> list = [];
        for (int i = 0; i < data.docs.length; i++) {
          list.add(data.docs[i].data());
        }
        return list;
      },
      error: (e, st) => [],
      loading: () => [],
    );

    switch (filter) {
      case "Completed":
        return todos.where((todo) => todo.isCompleted == true).toList();
      case "Active":
        return todos.where((todo) => todo.isCompleted == false).toList();
      default:
        return todos;
    }
  },
);

///Fetch Todo List By Tag [tagName]
final todosByTagProvider =
    FutureProvider.autoDispose.family<List<ToDo>, String>(
  (ref, tag) {
    final asyncTodo = ref.watch(todosProvider);
    final List<ToDo> todos = asyncTodo.when(
      data: (data) {
        List<ToDo> list = [];
        for (int i = 0; i < data.docs.length; i++) {
          list.add(data.docs[i].data());
        }
        return list;
      },
      error: (e, st) => [],
      loading: () => [],
    );

    return todos.where((todo) => todo.tag == tag).toList();
  },
);

/// Fetching All Tags
final tagsProvider = StreamProvider<QuerySnapshot<Tag>>((ref) {
  return ref.watch(dataServiceProvider).fetchTagList();
});

/// Fetching Single Tag
final specificTagProvider = FutureProvider.autoDispose.family<Tag, String>(
  (ref, name) {
    List<Tag> tags = [];
    final asyncTags = ref.watch(tagsProvider);
    asyncTags.when(
      data: (data) {
        for (int i = 0; i < data.docs.length; i++) {
          tags.add(data.docs[i].data());
        }
      },
      error: (e, st) => print('Error $e'),
      loading: () => const CircularProgressIndicator(),
    );
    return tags.singleWhere((tag) => tag.tagName == name);
  },
);

// FirebaseAuth Providers
final authProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(ref.read(authProvider));
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final userProvider = FutureProvider<DocumentSnapshot<UserData>>((ref) {
  return ref.watch(dataServiceProvider).fetchUser();
});
