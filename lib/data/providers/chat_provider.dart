import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ocean_talk/data/models/message.dart';

class ChatProvider{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  Future<String> uploadImage(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = _storage.ref().child('images/$fileName').putFile(image);
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      print('Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
    });
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }
}