import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class User {
  User({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  User _userFromFirebase(FirebaseUser user) {
    if (user == null) return null;
    return User(uid: user.uid);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> signInAnonymously() async {
    var result = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(result.user);
  }

  @override
  Future signOut() async {
    await _firebaseAuth.signOut();
  }
}
