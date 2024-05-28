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

  Future<List<AppUser>> getUsers() async {
    return await _firebaseFirestore.collection('users').get().then((querySnapshot) {
      List<AppUser> users = [];
      for (var element in querySnapshot.docs) {
        users.add(AppUser.fromFirestore(element));
      }
      return users;
    });
  }

  Future<List<AppUser>> searchUsers(String query) async {
    return await _firebaseFirestore.collection('users').where('fullName', isGreaterThanOrEqualTo: query).get().then((querySnapshot) {
      List<AppUser> users = [];
      for (var element in querySnapshot.docs) {
        users.add(AppUser.fromFirestore(element));
      }
      return users;
    });
  }
}
