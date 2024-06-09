import 'package:cloud_firestore/cloud_firestore.dart';

class Conservation{
  final List<String> participants;
  final String type;

  Conservation(this.participants, this.type);

  Map<String, dynamic> toFirestore() {
    return {
      'participants': participants,
      'type': type,
    };
  }

  factory Conservation.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Conservation(
      data['participants'],
      data['type'],
    );
  }
}