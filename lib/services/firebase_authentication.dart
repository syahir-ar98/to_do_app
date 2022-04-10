import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/services/firestore_database.dart';

/// Task 3: Login
class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Signed In Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return "Invalid";
  }

  Future<String> signUp(
      String name, String occupation, String email, String password) async {
    try {
      final _result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      DatabaseService(uid: _result.user!.uid).addUser(name, occupation);
      return "Successfully Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exist for that email.';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return "Invalid";
  }

  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    return "Sign Out Successfully";
  }
}
