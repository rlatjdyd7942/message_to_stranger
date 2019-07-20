import 'package:flutter/material.dart';
import '../MessageManager.dart';

class NewMessagePage extends StatelessWidget {
  final MessageManager messageManager;
  final TextEditingController textEditingController = TextEditingController();

  NewMessagePage({this.messageManager});

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
          await messageManager.sendToRandom(textEditingController.text);
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text ("Message sent Successfully!"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                  )
                ]
              );
            }
          ).then((v) {
            Navigator.pop(context);
          });
        },
        tooltip: 'Send Message',
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    messageManager.sendToRandom(textEditingController.text);
  }
}