import 'dart:async';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

class LoginService {
  FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  UserModel user;

  UserModel getCurrentUser(){
    _firebaseAuth = FirebaseAuth.instance;
    User currentUser = _firebaseAuth.currentUser;
    if(currentUser != null){
      user = UserModel.fromUser(currentUser);
    }else{
      user = null;
    }
    
    return user;
  }

  Future<UserModel> loginWithFacebook() async {
     _firebaseAuth = FirebaseAuth.instance;
    final FacebookLoginResult result = await _facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (result.status) {
      case FacebookLoginStatus.Cancel:
        break;
      case FacebookLoginStatus.Error:
        print(result.error);
        break;
      case FacebookLoginStatus.Success:
        try {
          final FacebookAccessToken accessToken = result.accessToken;
          AuthCredential credential =
              FacebookAuthProvider.credential(accessToken.token);
                       print('********************');
                       print(credential);
          var authResult = await _firebaseAuth.signInWithCredential(credential);
 
              print(authResult.user);
          user = UserModel.fromUser(authResult.user);
          return user;
        } catch (e) {
          print(e);
        }
        break;
    }
  }

  Future<UserModel> loginInWithGoogle() async {
     _firebaseAuth = FirebaseAuth.instance;
    GoogleSignInAccount userAccount = await _googleSignIn.signIn();
    if (userAccount == null) {
      return null;
    } else {
      try {
        GoogleSignInAuthentication googleAuth =
            await userAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        var authResult = await _firebaseAuth.signInWithCredential(credential);
        authResult.user;
        user = UserModel.fromUser(authResult.user);
        return user;
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> logout(providerId) async {
    _firebaseAuth = FirebaseAuth.instance;
    if (providerId == 'facebook.com') {
      await _facebookLogin.logOut();
    } else if (providerId == 'google.com') {
      await _googleSignIn.disconnect();
    }
    await _firebaseAuth.signOut();
  }
}
