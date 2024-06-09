import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_talk/data/providers/chat_provider.dart';

import '../models/message.dart';

class ChatRepository {
  final ChatProvider chatProvider = ChatProvider();

  Future<void> sendMessage(
      List<String> receiversId, String senderId, Message message) async {
    String conservationId = getConservationId(receiversId, senderId);
    await chatProvider.sendMessage(conservationId, message);
  }

  String getConservationId(List<String> receiversId, String senderId) {
    String conservationId = "unknown";
    if (receiversId.length == 1) {
      receiversId[0].hashCode < senderId.hashCode
          ? conservationId = "${receiversId[0]}_$senderId"
          : conservationId = "${senderId}_${receiversId[0]}";
    } else {
      receiversId.add(senderId);
      List<int> receiversIdHashCode =
          receiversId.map((e) => e.hashCode).toList();
      receiversIdHashCode.sort();
      conservationId = receiversIdHashCode.join("_");
    }
    return conservationId;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      List<String> receiversId, String senderId) {
    return chatProvider.getMessages(getConservationId(receiversId, senderId));
  }
}
