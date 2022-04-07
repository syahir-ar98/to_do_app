// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  final _userId = ref.watch(authProvider).currentUser!.uid;
  return DatabaseService(uid: _userId);
});

/// Fetching To-Dos By Status [All, Completed, Active]
final todoListByStatusProvider = StreamProvider.family
    .autoDispose<QuerySnapshot<ToDo>, String>((ref, status) {
  return ref.watch(dataServiceProvider).fetchTodoListByStatus(status);
});

///Fetch Todo List By Tag [tagName]
final todoListByTagProvider =
    StreamProvider.autoDispose.family<QuerySnapshot<ToDo>, String>((ref, tag) {
  return ref.watch(dataServiceProvider).fetchTodoListByTag(tag);
});

///Fetch All Tags
final tagsListProvider = StreamProvider<QuerySnapshot<Tag>>((ref) {
  return ref.watch(dataServiceProvider).fetchTagsList();
});

///Fetch Specific Tag
final specificTagProvider =
    StreamProvider.autoDispose.family<DocumentSnapshot<Tag>, String>((ref, id) {
  // List<Tag> listTags = [];
  // ref.watch(tagsListProvider).when(
  //       data: (data) {
  //         for (int i = 0; i < data.docs.length; i++) {
  //           listTags.add(data.docs[i].data());
  //         }
  //       },
  //       error: (e, st) => print('Error $e'),
  //       loading: () => const CircularProgressIndicator(),
  //     );

  // for (int i = 0; i < listTags.length; i++) {
  //   debugPrint('listTags: ${listTags[i]}');
  // }
  return ref.watch(dataServiceProvider).fetchTag(id);
});

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
