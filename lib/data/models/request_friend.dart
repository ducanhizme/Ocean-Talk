import 'app_user.dart';

class FriendRequest{
  final AppUser requestUser;
  final String requestUserRole;

  FriendRequest({required this.requestUser, required this.requestUserRole});

  Map<String, dynamic> toFirestore() {
    return {
      "requestUser": requestUser.toFirestore(),
      "requestUserRole": requestUserRole,
    };
  }

  factory FriendRequest.fromFirestore(Map<String, dynamic> data) {
    return FriendRequest(
      requestUser: AppUser.fromFirestore(data['sender']),
      requestUserRole: data['requestUserRole'],
    );
  }
}