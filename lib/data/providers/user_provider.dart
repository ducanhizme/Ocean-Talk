import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

class UserProvider {
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<AppUser?> getUserByID(String userID) async {
    final user = await _firebaseFirestore.collection('users').doc(userID).get();
    if (user.exists) {
      return AppUser.fromFirestore(user);
    } else {
      return null;
    }
  }

  Future<void> addUser(AppUser user) async {
      await _firebaseFirestore.collection('users').doc(user.uid).set(user.toFirestore());
  }
}
