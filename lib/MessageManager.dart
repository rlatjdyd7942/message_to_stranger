import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import 'Server.dart';
import 'UserManager.dart';
import 'Conversation.dart';
import 'Message.dart';

class MessageManager {
  static final MessageManager _messageManager = MessageManager();
  static MessageManager get instance => _messageManager;

  final UserManager _userManager = UserManager.instance;
  final Uuid uuid = new Uuid();

  Future<List<Conversation>> conversationList() async {
    var response = await http.get(
        Server.url + '/v1/users/${_userManager.uid}/conversations');
    var bodyJson = json.decode(response.body);
    List<Conversation> cList;
    if (bodyJson['conversations'] != null && bodyJson['conversations'].length != 0) {
      cList = bodyJson['conversations'].map((conversationJson) {
        return Conversation.fromJson(conversationJson);
      }).toList().cast<Conversation>();
    } else {
      cList = List<Conversation>();
    }
    return cList;
  }

  Future<List<Message>> messageList(conversationUid) async {
    var response = await http.get(
      Server.url + '/v1/conversations/$conversationUid?user_uid=${_userManager.uid}',
    );
    var bodyJson = json.decode(response.body);
    List<Message> mList;
    if (bodyJson['messages'] != null && bodyJson['messages'].length != 0) {
      mList = bodyJson['messages'].map((messageJson) {
        return Message.fromJson(messageJson);
      }).toList().cast<Message>();
    } else {
      mList = List<Message>();
    }
    return mList;
  }

  Future<void> newConversation(String message) async {
    print(_userManager.uid);
    var response = await http.post(
      Server.url + '/v1/conversations/new',
      body: { 'user_uid': _userManager.uid, 'message': message }
    );
    var bodyJson = json.decode(response.body);
    print(response.statusCode);
    print(bodyJson.toString());
  }

  Future<void> reply(String conversationUid, String message) async {
    var response = await http.post(
      Server.url + '/v1/conversations/$conversationUid/reply',
      body: { 'user_uid': _userManager.uid, 'message': message }
    );
    var bodyJson = json.decode(response.body);
    print(response.statusCode);
    print(bodyJson.toString());
  }
}