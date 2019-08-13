import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Auth.dart';
import '../Message.dart';
import '../Conversation.dart';
import '../MessageManager.dart';
import 'NewConversationPage.dart';
import 'ConversationPage.dart';

class ConversationListPage extends StatefulWidget {
  final Auth auth;
  final MessageManager messageManager;

  ConversationListPage({this.auth}) : messageManager = new MessageManager();

  @override
  _ConversationListPageState createState() => _ConversationListPageState();
}

class _ConversationListPageState extends State<ConversationListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message List'),
      ),
      body: FutureBuilder<List<Conversation>>(
        future: widget.messageManager.conversationList(),
        builder: (BuildContext context, AsyncSnapshot<List<Conversation>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: snapshot.data.map((conversation) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ConversationPage(conversationUid: conversation.uid),
                        ),
                      );
                    },
                    child: conversation,
                  );
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
              builder: (BuildContext context) =>
                NewConversationPage(),
            ),
          );
        },
        tooltip: 'New Message',
        child: Icon(Icons.add),
      ),
    );
  }
}