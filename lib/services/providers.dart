import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
final firestoreServiceProvider = Provider((ref) {
  return DatabaseService();
});

// Fetching To-Dos Provider
final todoListByStatusProvider = StreamProvider.family.autoDispose<QuerySnapshot<ToDo>, String>(
  (ref, status) {
    switch (status) {
      case "Completed":
        return ref.watch(firestoreServiceProvider).fetchTodoListByStatus(status);
      case "Active":
        return ref.watch(firestoreServiceProvider).fetchTodoListByStatus(status);
      default:
        return ref.watch(firestoreServiceProvider).fetchTodoListByStatus(status);
    }
  },
);

final todoListByTagProvider = StreamProvider.family.autoDispose<QuerySnapshot<ToDo>, String>((ref, tag) {
  return ref.watch(firestoreServiceProvider).fetchTodoListByTag(tag);
});

//Fetching Tags Providers
final tagsListProvider = StreamProvider<QuerySnapshot<Tag>>((ref) {
  return ref.watch(firestoreServiceProvider).fetchTagsList();
});

final specificTagProvider = StreamProvider.family.autoDispose<DocumentSnapshot<Tag>, String>((ref, id) {
  return ref.watch(firestoreServiceProvider).fetchTag(id);
});

// FirebaseAuth Providers
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseAuthServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(ref.read(firebaseAuthProvider));
});

final firebaseAuthStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthServiceProvider).authStateChanges;
});
