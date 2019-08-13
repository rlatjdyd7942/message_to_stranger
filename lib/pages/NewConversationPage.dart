import 'package:flutter/material.dart';
import '../MessageManager.dart';

class NewConversationPage extends StatelessWidget {
  final MessageManager messageManager = MessageManager.instance;
  final TextEditingController textEditingController = TextEditingController();

  NewConversationPage();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('NewMessage'),
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
            await messageManager.newConversation(textEditingController.text.trim()).then(
              (result) {
                Navigator.pop(context);
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