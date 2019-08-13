import 'package:flutter/material.dart';

import 'ReplyPage.dart';
import '../Message.dart';
import '../MessageManager.dart';

class ConversationPage extends StatelessWidget {
  final MessageManager messageManager = MessageManager.instance;
  final String conversationUid;

  ConversationPage({this.conversationUid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: FutureBuilder<List<Message>>(
          future: messageManager.messageList(conversationUid),
          builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: snapshot.data.map((message) {
                    return message;
                  }).toList(),
                );
              default:
                return Column();
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) => ReplyPage(conversationUid: conversationUid),
            ),
          );
        },
        tooltip: 'Reply',
        child: Icon(Icons.reply),
      ),
    );
  }
}