import 'app_user.dart';

class FriendRequest{
  final AppUser sender;
  final AppUser receiver;
  final String status;

  FriendRequest({required this.sender, required this.receiver, required this.status});


  Map<String, dynamic> toFirestore() {
    return {
      "sender": sender.toFirestore(),
      "receiver": receiver.toFirestore(),
      "status": status,
    };
  }

  factory FriendRequest.fromFirestore(Map<String, dynamic> data) {
    return FriendRequest(
      sender: AppUser.fromFirestore(data['sender']),
      receiver: AppUser.fromFirestore(data['receiver']),
      status: data['status'],
    );
  }
}