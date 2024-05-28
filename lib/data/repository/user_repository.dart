import '../models/app_user.dart';
import '../providers/user_provider.dart';

class UserRepository{
    final UserProvider _userProvider = UserProvider();

    Future<void> addUser(AppUser user) async {
        await _userProvider.addUser(user);
    }

    Future<AppUser?> getUserByID(String userID) async {
        return await _userProvider.getUserByID(userID);
    }
}