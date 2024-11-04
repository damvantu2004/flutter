import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/data/models/user_profile.dart';
import 'package:furniture_app/data/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;


class AuthService {
  static final _instance = FirebaseAuth.instance;

  static String? get userId {
    return _instance.currentUser?.uid;
  }

  static Stream<User?> get authChanges {
    return _instance.authStateChanges();
  }

  static Future<UserCredential> signInAnonymous() async {
    return _instance.signInAnonymously();
  }

  static Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential? firebaseUser;
    try {
      firebaseUser = await _instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // return firebaseUser;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    }
    return firebaseUser;
  }

  // register wit email & pw
  static Future<UserCredential?> signUp(
      String name, String email, String password) async {
    UserCredential? newUserCredential;
    UserRepository _userRepository = UserRepository();
    try {
      newUserCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _userRepository.createUser(newUserCredential.user?.uid ?? "",
          UserProfile(name: name, email: email));
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    }
    return newUserCredential;
  }

  // sign out
  static Future<void> signOut() async {
    try {
      return await _instance.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    }
  }

  static void _handleAuthError(FirebaseAuthException e) {
    // String msg = FirebaseAuthHelper.getToastMessage(e.code);
    // Fluttertoast.showToast(msg: msg);
    // debugPrint(msg);
  }
}
