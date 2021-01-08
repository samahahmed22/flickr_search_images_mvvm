import 'dart:async';

import 'package:flutter/widgets.dart';

import '../services/login_service.dart';
import '../models/user_model.dart';

enum AuthStatus { unAuthenticated, authentecating, authenticated }

class AuthViewModel with ChangeNotifier {
  UserModel _user;
  AuthStatus _authStatus = AuthStatus.unAuthenticated;

  AuthViewModel() {
    _user = LoginService().getCurrentUser();
    
    if (_user == null) {
      _authStatus = AuthStatus.unAuthenticated;
    } else {
      _authStatus = AuthStatus.authenticated;
    }
    notifyListeners();
  }

  UserModel get user => _user;
  AuthStatus get authStatus => _authStatus;

  Future<void> loginWithFacebook() async {
    
    _authStatus = AuthStatus.authentecating;
    notifyListeners();
    _user = await LoginService().loginWithFacebook();
    if (_user == null) {
      _authStatus = AuthStatus.unAuthenticated;
    } else {
      _authStatus = AuthStatus.authenticated;
    }
    notifyListeners();
  }

  Future<void> loginInWithGoogle() async {
    _authStatus = AuthStatus.authentecating;
    notifyListeners();
    _user = await LoginService().loginInWithGoogle();
    if (_user == null) {
      _authStatus = AuthStatus.unAuthenticated;
    } else {
      _authStatus = AuthStatus.authenticated;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _authStatus = AuthStatus.unAuthenticated;
    notifyListeners();
    await LoginService().logout(_user.providerId);
    _user = null;
  }
}
