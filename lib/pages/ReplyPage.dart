import 'package:flutter/material.dart';
import '../MessageManager.dart';

class ReplyPage extends StatelessWidget {
  final MessageManager messageManager = MessageManager.instance;
  final TextEditingController textEditingController = TextEditingController();
  final String conversationUid;

  ReplyPage({this.conversationUid});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('ReplyMessage'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: textEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (textEditingController.text.trim() != '') {
            await messageManager.reply(conversationUid, textEditingController.text.trim()).then(
              (result) {
                Navigator.popUntil(context, ModalRoute.withName('/conversations'));
              }
            );
          }
        },
        tooltip: 'Send Message',
        child: Icon(Icons.send),
      ),
    );
  }
}