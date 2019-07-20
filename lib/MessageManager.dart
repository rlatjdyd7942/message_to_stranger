import 'dart:math';
import 'package:uuid/uuid.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Auth.dart';
import 'Message.dart';

class MessageManager {
  Auth _auth;
  FirebaseUser _user;
  final Firestore _db = Firestore.instance;
  final Uuid uuid = new Uuid();

  MessageManager(this._auth);

  Future<void> loadUser() async {
    _user = await _auth.currentUser;
    print('load user ${_user.toString()}');
  }

  Stream<QuerySnapshot> getMessages(String messageListUid) {
    return _db.collection('messages').where('listUid', isEqualTo: messageListUid).snapshots();
  }

  Stream<QuerySnapshot> getReceivedMessageListList() {
    return _db.collection('messageLists').where('receiverUid', isEqualTo: _user.uid).snapshots();
  }

  MessageList _makeMessageList(doc) {

  }

  void reply(Message message, String content) {

  }

  void sendToRandom(String content) async {
    final String messageListUid = uuid.v4();
    final String messageUid = uuid.v4();
    final targetUid = await _getTargetUserUid();
    await Firestore.instance.runTransaction((Transaction tx) async {
      var now = DateTime.now();
      final DocumentSnapshot messageListSnapshot = await tx.get(_db.collection('messageLists').document(messageListUid));
      messageListSnapshot.reference.setData({
        'uid': messageListUid,
        'userUids': [_user.uid, targetUid],
        'receiverUid': targetUid,
        'lastMessage': content,
        'createdAt': now,
        'updatedAt': now
      }, merge: true);
      final DocumentSnapshot messageSnapshot = await tx.get(_db.collection('messages').document(messageUid));
      messageSnapshot.reference.setData({
        'uid': messageUid,
        'listUid': messageListUid,
        'userUid': _user.uid,
        'content': content,
        'createdAt': now
      }, merge: true);
    });
  }

  Future<String> _getTargetUserUid() async {
    final usersDocs = await _db.collection('users').orderBy('id', descending: true).limit(1).getDocuments();
    final int userCount = usersDocs.documents[0].data['id'];
    final int targetUserId = new Random().nextInt(userCount) + 1;

    final targetDocs = await _db.collection('users').where('id', isEqualTo: targetUserId).limit(1).getDocuments();
    var list = targetDocs.documents;
    return list[new Random().nextInt(list.length)].data['uid'];
  }
}