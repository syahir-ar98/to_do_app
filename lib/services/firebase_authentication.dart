import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        debugPrint("No user found for that email");
        return e.message ?? "Error: Wrong Email";
      } else if (e.code == 'wrong-password') {
        debugPrint("Wrong password provided for that user.");
        return e.message ?? "Error: Wrong Password";
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return "Empty";
  }

  Future<String> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Successfully Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('Password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exist for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return "Empty";
  }

  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    return "Sign Out Successfully";
  }
}
