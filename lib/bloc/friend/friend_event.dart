part of 'friend_bloc.dart';

class FriendEvent {
}

class FetchFriend extends FriendEvent {
  final String userId;
  final List<AppUser> friends;
  FetchFriend(this.userId, this.friends);
}




