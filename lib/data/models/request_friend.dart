import 'app_user.dart';

class FriendRequest{
  final AppUser requestUser;
  final String requestStatus;
  final String requestUserRole;

  FriendRequest({required this.requestUser, required this.requestStatus, required this.requestUserRole});

  Map<String, dynamic> toFirestore() {
    return {
      "requestUser": requestUser.toFirestore(),
      "requestStatus": requestStatus,
      "requestUserRole": requestUserRole,
    };
  }

  factory FriendRequest.fromFirestore(Map<String, dynamic> data) {
    return FriendRequest(
      requestUser: AppUser.fromFirestore(data['sender']),
      requestStatus: data['requestStatus'],
      requestUserRole: data['requestUserRole'],
    );
  }
}