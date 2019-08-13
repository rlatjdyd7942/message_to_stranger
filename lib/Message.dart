import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String userUid;
  final String content;
  final DateTime createdAt;

  Message({this.userUid, this.content, this.createdAt});

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      userUid: map['user_uid'],
      content: map['content'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
    );
  }

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
            new DateFormat('yyyy-MM-dd HH:mm').add_jm().format(createdAt)
          ),
        ],
      ),
    );
  }
}