import 'package:flutter/material.dart';
import 'pages/ConversationListPage.dart';
import 'pages/AuthPage.dart';

void main() {
  runApp(MessageToStrangerApp());
}

class MessageToStrangerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MessageToStranger',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthPage(),
      routes: {
        '/conversations': (BuildContext context) => ConversationListPage()
      }
    );
  }
}