import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';
import '../providers/user_provider.dart';

class UserRepository{
    final UserProvider _userProvider = UserProvider();

    Future<void> addUser(AppUser user) async {
        await _userProvider.addUser(user);
    }

    Future<List<AppUser>>getUsers() async {
       return await _userProvider.getUsers();
    }

    Future<AppUser> getCurrentUser() async {
        return await _userProvider.getCurrentUser();
    }

    Future<List<AppUser>>searchUsers(String query) async {
        return await _userProvider.searchUsers(query);
    }

    Future<DocumentSnapshot<Map<String, dynamic>>> getUserByID(String userID) async {
        return await _userProvider.getUserByID(userID);
    }

    Future<void> addRequestFriend(AppUser currentUser, AppUser userStranger) async {
        await _userProvider.addRequestFriend(currentUser, userStranger);
    }

    Future<void> removeRequestFriend(AppUser currentUser, AppUser userStranger) async {
        await _userProvider.removeRequestFriend(currentUser, userStranger);
    }

    Future<bool> checkRequestFriend(AppUser currentUser, AppUser userStranger) async {
        return await _userProvider.checkRequestFriend(currentUser, userStranger);
    }

}