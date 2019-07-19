import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../Auth.dart';
import '../SignManager.dart';
import 'MessageListPage.dart';

class AuthPage extends StatefulWidget {

  @override

  AuthPageState createState() => new AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  Auth auth = Auth();
  SignManager signManager;

  @override
  Widget build(BuildContext context) {
    signManager = SignManager(auth);
    signManager.init();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButton(
              Buttons.GoogleDark,
              onPressed: () {
                signManager.signInWithGoogle();
                Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext _context) => MessageListPage(auth: auth)));
              },
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