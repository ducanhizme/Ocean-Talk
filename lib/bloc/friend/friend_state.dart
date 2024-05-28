part of 'friend_bloc.dart';

class FriendState {}

class FriendFetched extends FriendState {
  final List<AppUser> listFriend;
  FriendFetched(this.listFriend);
}

class FriendError extends FriendState {
  final String message;
  FriendError(this.message);
}

class FriendLoading extends FriendState {}

class FriendOperationSuccess extends FriendState {
  final String message;
  FriendOperationSuccess(this.message);
}


