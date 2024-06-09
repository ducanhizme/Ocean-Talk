import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String content;
  final String senderId;
  final String timestamp;
  final String type;

  Message({this.content="", this.senderId="", this.timestamp="", this.type=""});

  Message copyWith({
    String? content,
    String? senderId,
    String? timestamp,
    String? type,
  }) {
    return Message(
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'content': content,
      'senderId': senderId,
      'timestamp': timestamp,
      'type': type,
    };
  }

  factory Message.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Message(
      content: data['content'],
      senderId: data['senderId'],
      timestamp: data['timestamp'],
      type: data['type'],
    );
  }
}