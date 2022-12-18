import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? userCheck) {
      user = (userCheck == null) ? null : userCheck;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  register(String _email, String _password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
      _getUser();
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      }
    }
  }

  login(String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      _getUser();
    } on FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta, Tente novamente');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
