import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  String uid;
  String listUid;
  String userUid;
  String content;
  DateTime createdAt;

  Message({this.uid, this.listUid, this.userUid, this.content, this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(),
          )
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(content),
          ),
          Text(
            new DateFormat('yyyy-MM-dd').add_jm().format(createdAt)
          ),
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  final String uid;
  final List<dynamic> userUids;
  final String receiverUid;
  final String lastMessage;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessageList({this.uid, this.userUids, this.receiverUid, this.lastMessage, this.createdAt, this.updatedAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        )
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(lastMessage),
          ),
          Text(
            new DateFormat('yyyy-MM-dd').add_jm().format(updatedAt)
          ),
        ],
      ),
    );
  }
}