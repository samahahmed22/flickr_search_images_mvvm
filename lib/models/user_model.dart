import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String providerId;

  UserModel(
      {@required this.id,
      @required this.name,
      @required this.email,
      @required this.photoUrl,
      @required this.providerId});

  factory UserModel.fromUser(User user) {
    return UserModel(
      id: user.uid,
      name: user.displayName,
      email: user.email,
      photoUrl: user.photoURL,
      providerId: user.providerData[0].providerId,
    );
  }
}
