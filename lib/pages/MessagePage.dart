import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Message.dart';
import '../MessageManager.dart';

class MessagePage extends StatelessWidget {
  final MessageManager messageManager;
  final String messageListUid;

  MessagePage({this.messageManager, this.messageListUid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: FutureBuilder<void>(
          future: messageManager.loadUser(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return _buildMessages();
              default:
                return Column();
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        tooltip: 'Reply',
        child: Icon(Icons.reply),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> _buildMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: messageManager.getMessages(messageListUid),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          default:
            return new ListView(
              children: snapshot.data.documents.map((document) {
                return GestureDetector(
                  onTap: () {},
                  child: Message(
                    uid: document['uid'],
                    listUid: document['listUid'],
                    userUid: document['userUid'],
                    content: document['content'],
                    createdAt: document['createdAt'].toDate(),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}