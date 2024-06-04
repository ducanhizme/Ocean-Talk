import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/app_user.dart';
import '../models/request_friend.dart';

class UserProvider {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserByID(
      String userID) async {
    return await _firebaseFirestore.collection('users').doc(userID).get();
  }

  Future<AppUser> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    return await _firebaseFirestore
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) => AppUser.fromFirestore(value));
  }

  Future<void> addUser(AppUser user) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(user.toFirestore());
  }

  Future<List<AppUser>> getUsers() async {
    return await _firebaseFirestore
        .collection('users')
        .get()
        .then((querySnapshot) {
      List<AppUser> users = [];
      for (var element in querySnapshot.docs) {
        users.add(AppUser.fromFirestore(element));
      }
      return users;
    });
  }

  Future<List<AppUser>> searchUsers(String query) async {
    return await _firebaseFirestore
        .collection('users')
        .get()
        .then((querySnapshot) {
      List<AppUser> users = [];
      for (var element in querySnapshot.docs) {
        if (element
            .data()['fullName']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          users.add(AppUser.fromFirestore(element));
        }
      }
      return users;
    });
  }

  Future<void> addRequestFriend(
      AppUser currentUser, AppUser userStranger) async {
    final FriendRequest requestReceiver = FriendRequest(requestUser: userStranger, requestStatus: 'requested', requestUserRole: 'receiver');
    final FriendRequest requestSender = FriendRequest(requestUser: currentUser, requestStatus: 'requested', requestUserRole: 'sender');
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('requests')
        .doc('${currentUser.uid}_${userStranger.uid}')
        .set(requestReceiver.toFirestore());
    await _firebaseFirestore
        .collection('users')
        .doc(userStranger.uid)
        .collection('requests')
        .doc('${userStranger.uid}_${currentUser.uid}')
        .set(requestSender.toFirestore());
  }

  Future<void> removeRequestFriend(
      AppUser currentUser, AppUser userStranger) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('requests')
        .doc('${currentUser.uid}_${userStranger.uid}')
        .delete();
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('requests')
        .doc('${userStranger.uid}_${currentUser.uid}')
        .delete();
  }

  Future<void> acceptFriend(AppUser currentUser, AppUser userStranger) async {
    await _firebaseFirestore.collection('users').doc(userStranger.uid).update({
      'friends': FieldValue.arrayUnion([currentUser.toFirestore()])
    });
    await _firebaseFirestore.collection('users').doc(currentUser.uid).update({
      'friends': FieldValue.arrayUnion([userStranger.toFirestore()])
    });
  }

  Future<void> rejectFriend(AppUser currentUser, AppUser userStranger) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('requests')
        .doc('${currentUser.uid}_${userStranger.uid}')
        .delete();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> checkRequestFriend(AppUser currentUser, AppUser userStranger)  {
    return _firebaseFirestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('requests')
        .doc('${currentUser.uid}_${userStranger.uid}').snapshots();
  }
}
