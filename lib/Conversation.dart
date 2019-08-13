import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class Conversation extends StatelessWidget {
  final String uid;
  final String lastMessage;
  final DateTime updatedAt;

  Conversation({this.uid, this.lastMessage, this.updatedAt});

  factory Conversation.fromJson(Map<String, dynamic> map) {
    return Conversation(
      uid: map['uid'],
      lastMessage: map['last_message'],
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(lastMessage),
        ),
        Text(
            new DateFormat('yyyy-MM-dd HH:mm').format(updatedAt)
        ),
      ],
    );
  }
}