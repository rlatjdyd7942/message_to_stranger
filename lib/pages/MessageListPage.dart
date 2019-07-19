import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Auth.dart';
import '../Message.dart';
import '../MessageManager.dart';
import 'NewMessagePage.dart';
import 'MessagePage.dart';

class MessageListPage extends StatefulWidget {
  final Auth auth;
  final MessageManager messageManager;

  MessageListPage({this.auth}) : messageManager = new MessageManager(auth);

  @override
  _MessageListPageState createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message List'),
      ),
      body: FutureBuilder<void>(
        future: widget.messageManager.loadUser(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return _buildMessageLists();
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
                NewMessagePage(messageManager: widget.messageManager),
            ),
          );
        },
        tooltip: 'New Message',
        child: Icon(Icons.add),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> _buildMessageLists() {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.messageManager.getReceivedMessageListList(),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MessagePage(messageManager: widget.messageManager, messageListUid: document['uid']),
                      ),
                    );
                  },
                  child: MessageList(
                    uid: document['uid'],
                    userUids: document['userUids'],
                    receiverUid: document['receiverUid'],
                    lastMessage: document['lastMessage'],
                    createdAt: document['createdAt'].toDate(),
                    updatedAt: document['updatedAt'].toDate(),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}