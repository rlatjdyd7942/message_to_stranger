class Message {
  String uid;
  String listUid;
  String userUid;
  String content;
  DateTime createdAt;
}

class MessageList {
  String uid;
  String user1Uid;
  String user2Uid;
  String receiverUid;
  List<Message> list;
}