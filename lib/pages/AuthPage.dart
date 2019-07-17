import 'package:flutter/material.dart';
import '../Auth.dart';


class AuthPage extends StatefulWidget {

  @override

  AuthPageState createState() => new AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () => authService.googleSignIn(),
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Login with Google'),
            ),
            MaterialButton(
              onPressed: () => authService.signOut(),
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