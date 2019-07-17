import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Auth.dart';

enum SignProvider {
  Unsigned, Google
}

class SignManager {
  final providerKey = 'sign_provider';

  Auth _auth;
  SharedPreferences _prefs;

  SignManager(this._auth);

  void init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void autoSignIn() {
    switch (signProvider) {
      case SignProvider.Unsigned:
        break;
      case SignProvider.Google:
        signInWithGoogle();
        break;
    }
    print('auth sign in success!');
  }

  void signInWithGoogle() async {
    var user = await _auth.googleSignIn();
    _prefs.setInt(providerKey, SignProvider.Google.index);
    print('google sign in');

    _updateInfo(user);
  }

  void signOut() {
    _auth.signOut();
    print('sign out');
  }

  SignProvider get signProvider {
    return SignProvider.values[_prefs.getInt(providerKey) ?? SignProvider.Unsigned.index];
  }

  void _updateInfo(user) {
    final Firestore db = Firestore.instance;
    DocumentReference ref = db.collection('users').document(user.uid);
    var now = DateTime.now();
    ref.get().then((snapshot) {
      if (snapshot.exists) {
        ref.setData({
          'uid': user.uid,
          'email': user.email,
          'displayName': user.displayName,
          'lastSeen': now,
        }, merge: true);
      } else {
        ref.setData({
          'uid': user.uid,
          'email': user.email,
          'displayName': user.displayName,
          'random':  new Random().nextInt(100000000),
          'lastSeen': now,
          'signedUpAt': now,
        });
      }
    });
  }
}