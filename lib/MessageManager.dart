import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Auth.dart';
import 'Message.dart';

class MessageManager {
  Auth _auth;
  FirebaseUser _user;

  MessageManager(this._auth);

  void loadUser() async {
    _user = await _auth.currentUser;
  }

  List<MessageList> getReceivedMessageListList() {
    final Firestore db = Firestore.instance;
    var docs = db.collection('message_lists').where('receiverUid', isEqualTo: _user.uid).snapshots();

    return List<MessageList>();
  }

  MessageList _makeMessageList(doc) {

  }

  void reply(Message message, String content) {

  }

  void sendToRandom(String content) {

  }
}