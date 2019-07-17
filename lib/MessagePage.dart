import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  MessagePage({this.title});

  final String title;
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type your message!'
                )
              ),
            ),

          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'SendMessage',
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    textEditingController.text = "";
  }
}