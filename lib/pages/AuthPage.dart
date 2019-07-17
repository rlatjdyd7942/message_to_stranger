import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../Auth.dart';
import '../SignManager.dart';

Auth auth = Auth();
SignManager signManager = SignManager(auth);

class AuthPage extends StatefulWidget {

  @override

  AuthPageState createState() => new AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    signManager.init();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButton(
              Buttons.GoogleDark,
              onPressed: () => signManager.signInWithGoogle(),
            ),
            MaterialButton(
              onPressed: () => signManager.signOut(),
              color: Colors.white,
              textColor: Colors.black,
              child: Text('Sign out'),
            )
          ]
        )
      )
    );
  }
}