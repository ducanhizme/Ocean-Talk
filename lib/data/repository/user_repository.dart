import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';
import '../providers/user_provider.dart';

class UserRepository{
    final UserProvider _userProvider = UserProvider();

    Future<void> addUser(AppUser user) async {
        await _userProvider.addUser(user);
    }

    Future<DocumentSnapshot<Map<String, dynamic>>> getUserByID(String userID) async {
        return await _userProvider.getUserByID(userID);
    }
}