part of 'profile_user_bloc.dart';

abstract class ProfileUserEvent {}

class FetchProfileUser extends ProfileUserEvent {
  final AppUser user;
  FetchProfileUser(this.user);
}

class AddRequestFriendEvent extends ProfileUserEvent {
  final AppUser userStranger;
  AddRequestFriendEvent(this.userStranger);
}

class RemoveRequestFriendEvent extends ProfileUserEvent {
  final AppUser userStranger;
  RemoveRequestFriendEvent(this.userStranger);
}

class AcceptRequestFriendEvent extends ProfileUserEvent {
  final AppUser userStranger;
  AcceptRequestFriendEvent(this.userStranger);
}

class RejectRequestFriendEvent extends ProfileUserEvent {
  final AppUser userStranger;
  RejectRequestFriendEvent(this.userStranger);
}
