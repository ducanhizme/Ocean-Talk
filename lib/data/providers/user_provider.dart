import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

class UserProvider {
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>>getUserByID(String userID) async {
    //this only returns a snapshot of the user @chien we need to convert it to an AppUser object by using the AppUser.fromFirestore method
    return await _firebaseFirestore.collection('users').doc(userID).get();
  }

  Future<void> addUser(AppUser user) async {
      await _firebaseFirestore.collection('users').doc(user.uid).set(user.toFirestore());
  }
}
