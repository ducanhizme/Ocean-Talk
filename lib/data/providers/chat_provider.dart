import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_talk/data/models/message.dart';

class ChatProvider{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String conservationId,Message message) async {
    await _firestore.collection('conservation').doc(conservationId).collection('message').doc(DateTime.timestamp().toString()).set({
      'content': message.content,
      'senderId': message.senderId,
      'timestamp': message.timestamp,
      'type': message.type,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String conservationId) {
    return _firestore
        .collection('conservation')
        .doc(conservationId)
        .collection('message').orderBy('timestamp',descending: false)
        .snapshots();
  }

}