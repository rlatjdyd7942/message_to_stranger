import 'package:flutter/material.dart';
import '../Auth.dart';
import '../FirebaseSignManager.dart';
import '../UserManager.dart';
import 'ConversationListPage.dart';

class AuthPage extends StatefulWidget {

  @override

  AuthPageState createState() => new AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  Auth auth = Auth();

  @override
  void initState() {
    super.initState();
    UserManager.instance.signIn().then(
        (result) {
          if (result) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                settings: RouteSettings(name: '/conversations'),
                builder: (BuildContext _context) => ConversationListPage(auth: auth)
              )
            );
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(),
      )
    );
  }
}